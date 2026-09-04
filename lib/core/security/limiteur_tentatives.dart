import 'package:shared_preferences/shared_preferences.dart';

/// Limitation des tentatives de saisie du code PIN (US-007).
///
/// L'ADR-0005 le dit sans détour : hacher un PIN de 4 chiffres ne protège pas
/// contre quelqu'un qui possède le fichier de base. L'attaque réaliste est
/// donc *en ligne* — quelqu'un qui essaie des codes sur l'écran de connexion —
/// et c'est ce module, pas le hachage, qui la rend impraticable.
///
/// Le compteur d'échecs ne redescend **jamais** tout seul : seule une
/// connexion réussie le remet à zéro. Attendre la fin d'un blocage ne rend
/// donc pas ses tentatives à l'attaquant, il repart au palier suivant.
///
/// **Limite assumée** — l'appareil est hors ligne et l'horloge appartient à
/// son porteur. Avancer la date du téléphone lève un blocage en cours ; c'est
/// irréductible sans serveur de temps. Le compteur d'échecs, lui, survit :
/// reculer l'horloge n'annule rien, et le palier atteint reste acquis.
abstract final class LimiteurTentatives {
  LimiteurTentatives._();

  /// Nombre d'échecs consécutifs qui déclenche un nouveau blocage.
  static const int tentativesParPalier = 5;

  /// Durées de blocage successives. Au-delà du dernier palier, la plus longue
  /// s'applique indéfiniment.
  static const List<Duration> paliers = [
    Duration(seconds: 30),
    Duration(minutes: 2),
    Duration(minutes: 5),
    Duration(minutes: 15),
  ];

  static String _cleTentatives(int eleveId) => 'pin_tentatives_$eleveId';
  static String _cleBlocage(int eleveId) => 'pin_blocage_jusqua_$eleveId';

  /// Temps restant avant de pouvoir réessayer, ou `null` si le compte est
  /// libre. La valeur est plafonnée à la durée du plus long palier : une
  /// horloge reculée ne doit pas bloquer l'élève pendant des années.
  static Future<Duration?> blocageRestant(int eleveId) async {
    final prefs = await SharedPreferences.getInstance();
    final jusqua = prefs.getInt(_cleBlocage(eleveId));
    if (jusqua == null) return null;

    final restant = jusqua - DateTime.now().millisecondsSinceEpoch;
    if (restant <= 0) return null;

    final plafond = paliers.last;
    final duree = Duration(milliseconds: restant);
    return duree > plafond ? plafond : duree;
  }

  /// Enregistre un échec. Retourne la durée du blocage si cet échec vient de
  /// le déclencher, `null` s'il reste des essais avant le prochain palier.
  static Future<Duration?> enregistrerEchec(int eleveId) async {
    final prefs = await SharedPreferences.getInstance();
    final tentatives = (prefs.getInt(_cleTentatives(eleveId)) ?? 0) + 1;
    await prefs.setInt(_cleTentatives(eleveId), tentatives);

    if (tentatives % tentativesParPalier != 0) return null;

    final rang = (tentatives ~/ tentativesParPalier) - 1;
    final duree = paliers[rang < paliers.length ? rang : paliers.length - 1];
    await prefs.setInt(
      _cleBlocage(eleveId),
      DateTime.now().add(duree).millisecondsSinceEpoch,
    );
    return duree;
  }

  /// Essais restants avant le prochain blocage.
  static Future<int> essaisAvantBlocage(int eleveId) async {
    final prefs = await SharedPreferences.getInstance();
    final tentatives = prefs.getInt(_cleTentatives(eleveId)) ?? 0;
    return tentativesParPalier - (tentatives % tentativesParPalier);
  }

  /// À appeler après une connexion réussie, et seulement dans ce cas.
  static Future<void> reinitialiser(int eleveId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cleTentatives(eleveId));
    await prefs.remove(_cleBlocage(eleveId));
  }

  /// Rend une durée lisible par un élève : « 30 secondes », « 2 minutes ».
  static String enClair(Duration duree) {
    if (duree.inMinutes < 1) {
      final s = duree.inSeconds < 1 ? 1 : duree.inSeconds;
      return '$s seconde${s > 1 ? 's' : ''}';
    }
    final m = duree.inMinutes + (duree.inSeconds % 60 > 0 ? 1 : 0);
    return '$m minute${m > 1 ? 's' : ''}';
  }
}
