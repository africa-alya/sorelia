import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sorelia/data/local/app_database.dart';

/// Tests du socle local-first (US-002).
///
/// Chaque test ouvre une base neuve en mémoire : pas de fichier sur le disque,
/// pas de plugin natif à simuler, aucun état partagé d'un test à l'autre.
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.enMemoire(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('le jeu illustratif de coefficients est chargé à la création', () async {
    final coefs =
        await (db.select(db.coefficientRefs)..where(
              (t) => t.niveau.equals('3e') & t.serie.equals('TRONC_COMMUN'),
            ))
            .get();

    expect(coefs, isNotEmpty);
    expect(
      coefs.every((c) => c.versionSource!.contains('Illustratif')),
      isTrue,
      reason: 'les valeurs provisoires doivent rester explicitement marquées',
    );
  });

  test('les clés étrangères sont actives : supprimer un élève supprime ses '
      'matières et ses notes (US-033)', () async {
    final eleveId = await db
        .into(db.eleves)
        .insert(
          ElevesCompanion.insert(
            pseudonyme: 'Amina',
            codePin: 'empreinte-fictive',
            niveau: '3e',
            typeEnseignement: 'GENERAL',
            dateCreation: DateTime(2026, 8, 26).toIso8601String(),
          ),
        );

    final matiereId = await db
        .into(db.matieres)
        .insert(
          MatieresCompanion.insert(
            eleveId: eleveId,
            nom: 'Mathématiques',
            serie: 'TRONC_COMMUN',
            coefficient: 4.0,
          ),
        );

    await db
        .into(db.notes)
        .insert(
          NotesCompanion.insert(
            matiereId: matiereId,
            typeEval: 'DEVOIR',
            valeur: 14.0,
            periode: 'trimestre1',
            date: '2026-08-26',
          ),
        );

    expect(await db.select(db.notes).get(), hasLength(1));

    await (db.delete(db.eleves)..where((t) => t.id.equals(eleveId))).go();

    // Sans `PRAGMA foreign_keys = ON`, ces deux attentes échouent : les
    // cascades déclarées dans le schéma resteraient purement décoratives.
    expect(await db.select(db.matieres).get(), isEmpty);
    expect(await db.select(db.notes).get(), isEmpty);
  });

  test('une note hors barème est refusée (CCT §6.3)', () async {
    final eleveId = await db
        .into(db.eleves)
        .insert(
          ElevesCompanion.insert(
            pseudonyme: 'Kossi',
            codePin: 'empreinte-fictive',
            niveau: 'Tle',
            typeEnseignement: 'GENERAL',
            dateCreation: DateTime(2026, 8, 26).toIso8601String(),
          ),
        );

    final matiereId = await db
        .into(db.matieres)
        .insert(
          MatieresCompanion.insert(
            eleveId: eleveId,
            nom: 'Physique-Chimie',
            serie: 'D',
            coefficient: 4.0,
          ),
        );

    Future<void> insererNote(double valeur) => db
        .into(db.notes)
        .insert(
          NotesCompanion.insert(
            matiereId: matiereId,
            typeEval: 'COMPOSITION',
            valeur: valeur,
            periode: 'trimestre1',
            date: '2026-08-26',
          ),
        );

    await expectLater(insererNote(21), throwsA(isA<SqliteException>()));
    await expectLater(insererNote(-1), throwsA(isA<SqliteException>()));

    // La borne haute est le barème, pas 20 : une note sur 40 reste valide.
    await db
        .into(db.notes)
        .insert(
          NotesCompanion.insert(
            matiereId: matiereId,
            typeEval: 'COMPOSITION',
            valeur: 32,
            bareme: const Value(40),
            periode: 'trimestre1',
            date: '2026-08-26',
          ),
        );

    expect(await db.select(db.notes).get(), hasLength(1));
  });

  test(
    'la montée de schéma échoue tant qu\'aucune migration n\'est écrite',
    () async {
      expect(
        () => db.migration.onUpgrade(Migrator(db), 1, 2),
        throwsA(isA<UnimplementedError>()),
      );
    },
  );
}
