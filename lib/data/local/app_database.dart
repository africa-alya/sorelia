import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._internal();
  static final AppDatabase instance = AppDatabase._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sorelia.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );

  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE eleve (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pseudonyme TEXT NOT NULL,
        code_pin TEXT NOT NULL,
        telephone TEXT,
        niveau TEXT NOT NULL,
        type_enseignement TEXT NOT NULL,
        serie TEXT,
        date_creation TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE coefficient_ref (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        niveau TEXT NOT NULL,
        serie TEXT NOT NULL,
        matiere TEXT NOT NULL,
        coefficient REAL NOT NULL,
        version_source TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE matiere (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        eleve_id INTEGER NOT NULL,
        nom TEXT NOT NULL,
        serie TEXT NOT NULL,
        coefficient REAL NOT NULL,
        FOREIGN KEY (eleve_id) REFERENCES eleve (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE note (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        matiere_id INTEGER NOT NULL,
        type_eval TEXT NOT NULL,
        valeur REAL NOT NULL,
        bareme REAL NOT NULL DEFAULT 20,
        periode TEXT NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY (matiere_id) REFERENCES matiere (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE cours_edt (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        eleve_id INTEGER NOT NULL,
        jour TEXT NOT NULL,
        creneau_debut TEXT NOT NULL,
        creneau_fin TEXT NOT NULL,
        matiere TEXT NOT NULL,
        salle TEXT,
        FOREIGN KEY (eleve_id) REFERENCES eleve (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE seance_etude (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        eleve_id INTEGER NOT NULL,
        matiere TEXT NOT NULL,
        date TEXT NOT NULL,
        heure_debut TEXT NOT NULL,
        duree_min INTEGER NOT NULL,
        objectif TEXT,
        recurrence TEXT,
        pauses INTEGER NOT NULL DEFAULT 0,
        termine INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (eleve_id) REFERENCES eleve (id) ON DELETE CASCADE
      )
    ''');
    await db.execute('''
    CREATE TABLE notification_config (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cible_type TEXT NOT NULL,
    cible_id INTEGER NOT NULL,
    type TEXT NOT NULL,
    delai_min INTEGER DEFAULT 10,
    active INTEGER DEFAULT 1,
    heures_silence TEXT
  )
''');

    await _seedCoefficientRef(db);
  }

  Future<void> _seedCoefficientRef(Database db) async {
    final seed = <Map<String, dynamic>>[
      
      {'niveau': '3e', 'serie': 'TRONC_COMMUN', 'matiere': 'Mathématiques', 'coefficient': 4.0, 'version_source': 'Illustratif - à valider MEMP'},
      {'niveau': '3e', 'serie': 'TRONC_COMMUN', 'matiere': 'Français', 'coefficient': 4.0, 'version_source': 'Illustratif - à valider MEMP'},
      {'niveau': '3e', 'serie': 'TRONC_COMMUN', 'matiere': 'Physique-Chimie', 'coefficient': 2.0, 'version_source': 'Illustratif - à valider MEMP'},
      {'niveau': '3e', 'serie': 'TRONC_COMMUN', 'matiere': 'SVT', 'coefficient': 2.0, 'version_source': 'Illustratif - à valider MEMP'},
      {'niveau': '3e', 'serie': 'TRONC_COMMUN', 'matiere': 'Anglais', 'coefficient': 2.0, 'version_source': 'Illustratif - à valider MEMP'},
      {'niveau': '3e', 'serie': 'TRONC_COMMUN', 'matiere': 'Histoire-Géographie', 'coefficient': 2.0, 'version_source': 'Illustratif - à valider MEMP'},
      {'niveau': 'Tle', 'serie': 'D', 'matiere': 'Mathématiques', 'coefficient': 4.0, 'version_source': 'Illustratif - à valider MESTFP'},
      {'niveau': 'Tle', 'serie': 'D', 'matiere': 'SVT', 'coefficient': 4.0, 'version_source': 'Illustratif - à valider MESTFP'},
      {'niveau': 'Tle', 'serie': 'D', 'matiere': 'Physique-Chimie', 'coefficient': 4.0, 'version_source': 'Illustratif - à valider MESTFP'},
      {'niveau': 'Tle', 'serie': 'D', 'matiere': 'Français', 'coefficient': 2.0, 'version_source': 'Illustratif - à valider MESTFP'},
      {'niveau': 'Tle', 'serie': 'C', 'matiere': 'Mathématiques', 'coefficient': 6.0, 'version_source': 'Illustratif - à valider MESTFP'},
      {'niveau': 'Tle', 'serie': 'C', 'matiere': 'Physique-Chimie', 'coefficient': 5.0, 'version_source': 'Illustratif - à valider MESTFP'},
      {'niveau': 'Tle', 'serie': 'A', 'matiere': 'Français', 'coefficient': 4.0, 'version_source': 'Illustratif - à valider MESTFP'},
      {'niveau': 'Tle', 'serie': 'A', 'matiere': 'Philosophie', 'coefficient': 4.0, 'version_source': 'Illustratif - à valider MESTFP'},
    ];
    for (final row in seed) {
      await db.insert('coefficient_ref', row);
    }
  }
}