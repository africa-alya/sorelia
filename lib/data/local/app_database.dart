import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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
  IntColumn get eleveId => integer().references(Eleves, #id, onDelete: KeyAction.cascade)();
  TextColumn get nom => text()();
  TextColumn get serie => text()();
  RealColumn get coefficient => real()();
}

class Notes extends Table {
  @override
  String get tableName => 'note';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get matiereId => integer().references(Matieres, #id, onDelete: KeyAction.cascade)();
  TextColumn get typeEval => text()();
  RealColumn get valeur => real()();
  RealColumn get bareme => real().withDefault(const Constant(20.0))();
  TextColumn get periode => text()();
  TextColumn get date => text()();
}

class CoursEdts extends Table {
  @override
  String get tableName => 'cours_edt';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get eleveId => integer().references(Eleves, #id, onDelete: KeyAction.cascade)();
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
  IntColumn get eleveId => integer().references(Eleves, #id, onDelete: KeyAction.cascade)();
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

@DriftDatabase(tables: [
  Eleves,
  CoefficientRefs,
  Matieres,
  Notes,
  CoursEdts,
  SeanceEtudes,
  NotificationConfigs,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedCoefficientRef();
      },
    );
  }


  Future<void> _seedCoefficientRef() async {
    final seeds = [
      CoefficientRefsCompanion.insert(niveau: '3e', serie: 'TRONC_COMMUN', matiere: 'Mathématiques', coefficient: 4.0, versionSource: const Value('Illustratif - à valider MEMP')),
      CoefficientRefsCompanion.insert(niveau: '3e', serie: 'TRONC_COMMUN', matiere: 'Français', coefficient: 4.0, versionSource: const Value('Illustratif - à valider MEMP')),
      CoefficientRefsCompanion.insert(niveau: '3e', serie: 'TRONC_COMMUN', matiere: 'Physique-Chimie', coefficient: 2.0, versionSource: const Value('Illustratif - à valider MEMP')),
      CoefficientRefsCompanion.insert(niveau: '3e', serie: 'TRONC_COMMUN', matiere: 'SVT', coefficient: 2.0, versionSource: const Value('Illustratif - à valider MEMP')),
      CoefficientRefsCompanion.insert(niveau: '3e', serie: 'TRONC_COMMUN', matiere: 'Anglais', coefficient: 2.0, versionSource: const Value('Illustratif - à valider MEMP')),
      CoefficientRefsCompanion.insert(niveau: '3e', serie: 'TRONC_COMMUN', matiere: 'Histoire-Géographie', coefficient: 2.0, versionSource: const Value('Illustratif - à valider MEMP')),
      CoefficientRefsCompanion.insert(niveau: 'Tle', serie: 'D', matiere: 'Mathématiques', coefficient: 4.0, versionSource: const Value('Illustratif - à valider MESTFP')),
      CoefficientRefsCompanion.insert(niveau: 'Tle', serie: 'D', matiere: 'SVT', coefficient: 4.0, versionSource: const Value('Illustratif - à valider MESTFP')),
      CoefficientRefsCompanion.insert(niveau: 'Tle', serie: 'D', matiere: 'Physique-Chimie', coefficient: 4.0, versionSource: const Value('Illustratif - à valider MESTFP')),
      CoefficientRefsCompanion.insert(niveau: 'Tle', serie: 'D', matiere: 'Français', coefficient: 2.0, versionSource: const Value('Illustratif - à valider MESTFP')),
      CoefficientRefsCompanion.insert(niveau: 'Tle', serie: 'C', matiere: 'Mathématiques', coefficient: 6.0, versionSource: const Value('Illustratif - à valider MESTFP')),
      CoefficientRefsCompanion.insert(niveau: 'Tle', serie: 'C', matiere: 'Physique-Chimie', coefficient: 5.0, versionSource: const Value('Illustratif - à valider MESTFP')),
      CoefficientRefsCompanion.insert(niveau: 'Tle', serie: 'A', matiere: 'Français', coefficient: 4.0, versionSource: const Value('Illustratif - à valider MESTFP')),
      CoefficientRefsCompanion.insert(niveau: 'Tle', serie: 'A', matiere: 'Philosophie', coefficient: 4.0, versionSource: const Value('Illustratif - à valider MESTFP')),
    ];

    await batch((b) {
      b.insertAll(coefficientRefs, seeds);
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sorelia.db'));
    return NativeDatabase.createInBackground(file);
  });
}