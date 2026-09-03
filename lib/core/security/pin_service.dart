import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// Hachage et vérification du code PIN d'un élève (CCT §6.3).
///
/// Le PIN n'est **jamais** stocké en clair : la colonne `eleve.code_pin`
/// contient l'empreinte produite ici, dans un format auto-descriptif :
///
/// ```text
/// pbkdf2_sha256$150000$<sel base64>$<empreinte base64>
/// ```
///
/// Le nombre d'itérations voyage avec l'empreinte : on peut le relever plus
/// tard sans invalider les comptes existants, chaque empreinte se vérifiant
/// avec le coût qui a servi à la produire.
///
/// **Limite assumée** — le PIN fait 4 chiffres, soit 10 000 possibilités.
/// Quiconque met la main sur le fichier `sorelia.sqlite` les épuise en
/// quelques minutes, quel que soit le réglage ci-dessous. Ce hachage protège
/// contre la lecture opportuniste du fichier et contre la fuite d'un PIN que
/// l'élève réutilise ailleurs — pas contre un vol de la base. La protection
/// qui compte réellement est la **limitation des tentatives** (US-007).
/// Voir `docs/adr/0005-hachage-du-code-pin.md`.
abstract final class PinService {
  PinService._();

  /// Identifiant d'algorithme préfixant chaque empreinte.
  static const String algorithme = 'pbkdf2_sha256';

  /// Coût par défaut. Relevable : les anciennes empreintes restent valides.
  static const int iterationsParDefaut = 150000;

  /// 16 octets, la taille recommandée pour un sel PBKDF2 (RFC 8018 §4.1).
  static const int longueurSelOctets = 16;

  /// 32 octets : la taille naturelle de sortie de SHA-256.
  static const int longueurEmpreinteOctets = 32;

  static final Random _aleatoire = Random.secure();

  /// Produit l'empreinte à stocker pour [pin].
  ///
  /// Deux appels avec le même PIN donnent deux empreintes différentes : le sel
  /// est tiré au hasard à chaque fois. Ne jamais comparer deux empreintes
  /// entre elles, toujours passer par [verifier].
  ///
  /// [iterations] n'est là que pour les tests, qui n'ont pas à payer le coût
  /// réel. Le code applicatif laisse la valeur par défaut.
  static Future<String> hacher(
    String pin, {
    int iterations = iterationsParDefaut,
  }) async {
    final sel = Uint8List.fromList(
      List<int>.generate(longueurSelOctets, (_) => _aleatoire.nextInt(256)),
    );
    final empreinte = await _deriver(pin, sel, iterations);
    return '$algorithme\$$iterations\$'
        '${base64.encode(sel)}\$${base64.encode(empreinte)}';
  }

  /// Vérifie que [pin] correspond à [empreinteStockee].
  ///
  /// Retourne `false` — sans lever d'exception — si l'empreinte est illisible :
  /// un compte créé avant ce service contient un PIN en clair, qui ne suit pas
  /// le format ci-dessus. L'élève doit alors recréer son compte, ce qui est le
  /// comportement voulu : on ne retombe jamais sur une comparaison en clair.
  static Future<bool> verifier(String pin, String empreinteStockee) async {
    final parties = empreinteStockee.split(r'$');
    if (parties.length != 4 || parties[0] != algorithme) return false;

    final iterations = int.tryParse(parties[1]);
    if (iterations == null || iterations < 1) return false;

    final Uint8List sel;
    final Uint8List attendue;
    try {
      sel = base64.decode(parties[2]);
      attendue = base64.decode(parties[3]);
    } on FormatException {
      return false;
    }
    if (sel.isEmpty || attendue.length != longueurEmpreinteOctets) return false;

    final candidate = await _deriver(pin, sel, iterations);
    return _egaliteATempsConstant(candidate, attendue);
  }

  /// PBKDF2 en Dart pur coûte plusieurs centaines de millisecondes sur un
  /// Android d'entrée de gamme : le faire sur l'isolate principal figerait
  /// l'écran au moment précis où l'élève appuie sur « Se connecter ».
  static Future<Uint8List> _deriver(String pin, Uint8List sel, int iterations) {
    return Isolate.run(() => _deriverSync(pin, sel, iterations));
  }

  static Uint8List _deriverSync(String pin, Uint8List sel, int iterations) {
    // 64 = taille de bloc de SHA-256, exigée par HMac.
    final derivateur = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))
      ..init(Pbkdf2Parameters(sel, iterations, longueurEmpreinteOctets));
    return derivateur.process(Uint8List.fromList(utf8.encode(pin)));
  }

  /// Comparaison sans court-circuit : la durée ne dépend pas de l'endroit où
  /// les deux empreintes divergent, et ne renseigne donc pas un attaquant.
  static bool _egaliteATempsConstant(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    var difference = 0;
    for (var i = 0; i < a.length; i++) {
      difference |= a[i] ^ b[i];
    }
    return difference == 0;
  }
}
