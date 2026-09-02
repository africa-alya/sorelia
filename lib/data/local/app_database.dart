import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;  
part 'app_database.g.dart';


// --- DÉFINITIONS DES TABLES DRIFT ---
// Chaque `tableName` est forcé explicitement pour rester identique,
// caractère pour caractère, au dictionnaire de données du CCT
// (sinon Drift utiliserait le nom de classe tel quel, ici au pluriel).

class Eleves extends Table {
  @override
  String get tableName => 'eleve';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get pseudonyme => text().withLength(min: 1, max: 50)();

  /// Empreinte **hachée** du PIN, jamais le PIN en clair (CCT §6.3).
  /// Le hachage relève de la couche appelante : US-005 (création de compte)
  /// et US-007 (déverrouillage). Cette couche ne fait que persister.
  TextColumn get codePin => text()();
  TextColumn get telephone => text().nullable()();
  TextColumn get niveau => text()();
  TextColumn get typeEnseignement => text()();
  TextColumn get serie => text().nullable()();
  TextColumn get dateCreation => text()();
}

class CoefficientRefs extends Table {
  @override
  String get tableName => 'coefficient_ref';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get niveau => text()();
  TextColumn get serie => text()();
  TextColumn get matiere => text()();
  RealColumn get coefficient => real()();
  TextColumn get versionSource => text().nullable()();
}

class Matieres extends Table {
  @override
  String get tableName => 'matiere';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get eleveId =>
      integer().references(Eleves, #id, onDelete: KeyAction.cascade)();
  TextColumn get nom => text()();
  TextColumn get serie => text()();
  RealColumn get coefficient => real()();
}

class Notes extends Table {
  @override
  String get tableName => 'note';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get matiereId =>
      integer().references(Matieres, #id, onDelete: KeyAction.cascade)();
  TextColumn get typeEval => text()();

  /// CCT §6.3 : la note est comprise entre 0 et le barème.
  /// Exprimé en SQL brut plutôt qu'avec `check()`, dont la forme auto-
  /// référente déclenche la règle d'analyse `recursive_getters`.
  /// `customConstraint` remplaçant toutes les contraintes, le NOT NULL
  /// doit être répété ici.
  RealColumn get valeur => real().customConstraint(
    'NOT NULL CHECK (valeur >= 0 AND valeur <= bareme)',
  )();
  RealColumn get bareme => real().withDefault(const Constant(20.0))();
  TextColumn get periode => text()();
  TextColumn get date => text()();
}

class CoursEdts extends Table {
  @override
  String get tableName => 'cours_edt';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get eleveId =>
      integer().references(Eleves, #id, onDelete: KeyAction.cascade)();
  TextColumn get jour => text()();
  TextColumn get creneauDebut => text()();
  TextColumn get creneauFin => text()();
  TextColumn get matiere => text()();
  TextColumn get salle => text().nullable()();
}

class SeanceEtudes extends Table {
  @override
  String get tableName => 'seance_etude';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get eleveId =>
      integer().references(Eleves, #id, onDelete: KeyAction.cascade)();
  TextColumn get matiere => text()();
  TextColumn get date => text()();
  TextColumn get heureDebut => text()();
  IntColumn get dureeMin => integer()();
  TextColumn get objectif => text().nullable()();
  TextColumn get recurrence => text().nullable()();
  IntColumn get pauses => integer().withDefault(const Constant(0))();

  // Typé booléen (au lieu d'un IntColumn 0/1) pour profiter du typage
  // Drift côté Dart, conformément au CCT §5 ("requêtes typées").
  BoolColumn get termine => boolean().withDefault(const Constant(false))();
}

class NotificationConfigs extends Table {
  //  On garde ici le nom
  // de classe NotificationConfigs (pour éviter toute confusion avec la
  // classe Flutter Notification),
  @override
  String get tableName => 'notification';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get cibleType => text()();
  IntColumn get cibleId => integer()();
  TextColumn get type => text()();
  IntColumn get delaiMin => integer().withDefault(const Constant(10))();

  // Typé booléen (au lieu d'un IntColumn 0/1) pour profiter du typage
  // Drift côté Dart.
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  TextColumn get heuresSilence => text().nullable()();
}

// --- BASE DE DONNÉES DRIFT ---

@DriftDatabase(
  tables: [
    Eleves,
    CoefficientRefs,
    Matieres,
    Notes,
    CoursEdts,
    SeanceEtudes,
    NotificationConfigs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Base éphémère en mémoire, pour les tests : pas de fichier, pas de
  /// `path_provider` à simuler, et un état neuf à chaque test.
  AppDatabase.enMemoire(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedCoefficientRef();
      },
      // Aucune migration n'existe encore. Échouer bruyamment vaut mieux que
      // laisser la base d'un élève dans un état incohérent : à la première
      // montée de schemaVersion, il faudra écrire la migration ici.
      onUpgrade: (Migrator m, int from, int to) async {
        throw UnimplementedError(
          'Migration $from -> $to non implémentée. '
          'Voir docs/adr/ avant de faire évoluer le schéma.',
        );
      },
      // SQLite n'applique PAS les clés étrangères par défaut, Drift non plus.
      // Sans ce PRAGMA, les `onDelete: KeyAction.cascade` ci-dessus sont
      // inertes et supprimer un élève laisserait ses notes orphelines
      // (US-033, droit à l'effacement).
      beforeOpen: (OpeningDetails details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _seedCoefficientRef() async {
    final jsonString = await rootBundle.loadString('assets/coefficients/coefficientref.json');
    final List<dynamic> lignes = jsonDecode(jsonString);
 
    final seeds = lignes.map((ligne) {
      final l = ligne as Map<String, dynamic>;
      return CoefficientRefsCompanion.insert(
        niveau: l['niveau'] as String,
        serie: l['serie'] as String,
        matiere: l['matiere'] as String,
        coefficient: (l['coefficient'] as num).toDouble(),
        versionSource: Value(l['version_source'] as String?),
      );
    }).toList();

    await batch((b) {
      b.insertAll(coefficientRefs, seeds);
    });
  }
}

/// Ouvre `sorelia.sqlite` dans le dossier de données de l'application.
/// `driftDatabase` embarque la bibliothèque SQLite native et résout
/// l'emplacement du fichier lui-même, sur toutes les plateformes.
QueryExecutor _openConnection() => driftDatabase(name: 'sorelia');
