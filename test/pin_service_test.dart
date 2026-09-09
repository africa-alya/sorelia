import 'package:flutter_test/flutter_test.dart';
import 'package:sorelia/core/security/pin_service.dart';

void main() {
  // Coût volontairement dérisoire : ces tests valident le protocole, pas la
  // résistance au calcul. Le coût réel est `iterationsParDefaut`.
  const iterationsTest = 100;

  group('PinService.hacher', () {
    test('ne laisse jamais apparaître le PIN en clair', () async {
      final empreinte = await PinService.hacher(
        '1234',
        iterations: iterationsTest,
      );
      expect(empreinte.contains('1234'), isFalse);
    });

    test('produit deux empreintes différentes pour le même PIN', () async {
      final a = await PinService.hacher('1234', iterations: iterationsTest);
      final b = await PinService.hacher('1234', iterations: iterationsTest);
      expect(
        a,
        isNot(equals(b)),
        reason: 'le sel doit être tiré à chaque fois',
      );
    });

    test('inscrit l\'algorithme et le coût dans l\'empreinte', () async {
      final empreinte = await PinService.hacher(
        '1234',
        iterations: iterationsTest,
      );
      final parties = empreinte.split(r'$');
      expect(parties, hasLength(4));
      expect(parties[0], PinService.algorithme);
      expect(parties[1], '$iterationsTest');
    });
  });

  group('PinService.verifier', () {
    test('accepte le bon PIN', () async {
      final empreinte = await PinService.hacher(
        '1234',
        iterations: iterationsTest,
      );
      expect(await PinService.verifier('1234', empreinte), isTrue);
    });

    test('refuse un PIN erroné', () async {
      final empreinte = await PinService.hacher(
        '1234',
        iterations: iterationsTest,
      );
      expect(await PinService.verifier('1235', empreinte), isFalse);
    });

    test('refuse un PIN vide', () async {
      final empreinte = await PinService.hacher(
        '1234',
        iterations: iterationsTest,
      );
      expect(await PinService.verifier('', empreinte), isFalse);
    });

    test('vérifie une empreinte produite avec un autre coût', () async {
      // Garantit qu'on pourra relever `iterationsParDefaut` sans invalider
      // les comptes déjà créés.
      final empreinte = await PinService.hacher('1234', iterations: 250);
      expect(await PinService.verifier('1234', empreinte), isTrue);
    });

    test('refuse un PIN stocké en clair, sans lever d\'exception', () async {
      // Cas des comptes créés avant ce service : on ne retombe jamais sur une
      // comparaison en clair, l'élève doit recréer son compte.
      expect(await PinService.verifier('1234', '1234'), isFalse);
    });

    test('refuse une empreinte malformée', () async {
      const malformees = [
        '',
        'pbkdf2_sha256',
        r'pbkdf2_sha256$150000$sel',
        r'pbkdf2_sha256$zero$c2Vs$aGFzaA==',
        r'pbkdf2_sha256$0$c2Vs$aGFzaA==',
        r'bcrypt$150000$c2Vs$aGFzaA==',
        r'pbkdf2_sha256$150000$!!!$!!!',
        r'pbkdf2_sha256$150000$c2Vs$dHJvcC1jb3VydA==',
      ];
      for (final empreinte in malformees) {
        expect(
          await PinService.verifier('1234', empreinte),
          isFalse,
          reason: 'empreinte rejetée : "$empreinte"',
        );
      }
    });
  });
}
