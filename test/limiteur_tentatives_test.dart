import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorelia/core/security/limiteur_tentatives.dart';

void main() {
  const eleveId = 1;

  setUp(() => SharedPreferences.setMockInitialValues({}));

  Future<void> echouer(int fois) async {
    for (var i = 0; i < fois; i++) {
      await LimiteurTentatives.enregistrerEchec(eleveId);
    }
  }

  test('un compte neuf n\'est pas bloqué', () async {
    expect(await LimiteurTentatives.blocageRestant(eleveId), isNull);
    expect(
      await LimiteurTentatives.essaisAvantBlocage(eleveId),
      LimiteurTentatives.tentativesParPalier,
    );
  });

  test('les échecs sous le palier ne bloquent pas', () async {
    await echouer(LimiteurTentatives.tentativesParPalier - 1);
    expect(await LimiteurTentatives.blocageRestant(eleveId), isNull);
    expect(await LimiteurTentatives.essaisAvantBlocage(eleveId), 1);
  });

  test('le palier atteint déclenche le premier blocage', () async {
    await echouer(LimiteurTentatives.tentativesParPalier - 1);
    final blocage = await LimiteurTentatives.enregistrerEchec(eleveId);
    expect(blocage, LimiteurTentatives.paliers.first);
    expect(await LimiteurTentatives.blocageRestant(eleveId), isNotNull);
  });

  test('les blocages successifs s\'allongent', () async {
    final durees = <Duration>[];
    for (var palier = 0; palier < LimiteurTentatives.paliers.length; palier++) {
      await echouer(LimiteurTentatives.tentativesParPalier - 1);
      durees.add((await LimiteurTentatives.enregistrerEchec(eleveId))!);
    }
    expect(durees, LimiteurTentatives.paliers);
  });

  test('au-delà du dernier palier, la plus longue durée s\'applique', () async {
    final total =
        (LimiteurTentatives.paliers.length + 2) *
        LimiteurTentatives.tentativesParPalier;
    await echouer(total - 1);
    final blocage = await LimiteurTentatives.enregistrerEchec(eleveId);
    expect(blocage, LimiteurTentatives.paliers.last);
  });

  test('attendre la fin d\'un blocage ne rend pas les tentatives', () async {
    // Le compteur d'échecs ne redescend jamais seul : le palier suivant est
    // atteint dès 5 nouveaux échecs, pas 10.
    await echouer(LimiteurTentatives.tentativesParPalier);
    await echouer(LimiteurTentatives.tentativesParPalier - 1);
    final blocage = await LimiteurTentatives.enregistrerEchec(eleveId);
    expect(blocage, LimiteurTentatives.paliers[1]);
  });

  test('une connexion réussie remet tout à zéro', () async {
    await echouer(LimiteurTentatives.tentativesParPalier);
    await LimiteurTentatives.reinitialiser(eleveId);
    expect(await LimiteurTentatives.blocageRestant(eleveId), isNull);
    expect(
      await LimiteurTentatives.essaisAvantBlocage(eleveId),
      LimiteurTentatives.tentativesParPalier,
    );
  });

  test('les comptes sont limités indépendamment', () async {
    await echouer(LimiteurTentatives.tentativesParPalier);
    expect(await LimiteurTentatives.blocageRestant(eleveId), isNotNull);
    expect(await LimiteurTentatives.blocageRestant(2), isNull);
  });

  test('une horloge reculée ne bloque pas indéfiniment', () async {
    // Blocage daté dans dix ans, comme si l'élève avait reculé la date.
    SharedPreferences.setMockInitialValues({
      'pin_blocage_jusqua_$eleveId': DateTime.now()
          .add(const Duration(days: 3650))
          .millisecondsSinceEpoch,
    });
    final restant = await LimiteurTentatives.blocageRestant(eleveId);
    expect(restant, LimiteurTentatives.paliers.last);
  });

  group('enClair', () {
    test('exprime les courtes durées en secondes', () {
      expect(
        LimiteurTentatives.enClair(const Duration(seconds: 30)),
        '30 secondes',
      );
      expect(
        LimiteurTentatives.enClair(const Duration(seconds: 1)),
        '1 seconde',
      );
    });

    test('exprime les longues durées en minutes, arrondies au-dessus', () {
      expect(
        LimiteurTentatives.enClair(const Duration(minutes: 2)),
        '2 minutes',
      );
      expect(
        LimiteurTentatives.enClair(const Duration(seconds: 90)),
        '2 minutes',
      );
      expect(
        LimiteurTentatives.enClair(const Duration(minutes: 1)),
        '1 minute',
      );
    });
  });
}
