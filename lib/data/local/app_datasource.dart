import 'app_database.dart';
import '../../../models/eleves.dart';
import '../../../models/coefficient_ref.dart';
import '../../services/security_pin.dart';
import '../../../models/note.dart';
import '../../../models/matiere.dart';
import '../../../models/seance_etude.dart';
import '../../../models/cours_edt.dart';
import '../../../models/notification_rappel.dart';

class LocalDataSource {
  // ------------- ELEVE ----------------

  // Crée un eleve
  Future<int> insertEleve(Eleves e) async {
    final db = await AppDatabase.instance.database;
    return await db.insert('eleve', e.toMap()..remove('id'));
  }

  // Authentification avec pseudonyme + PIN. Le PIN est haché avant comparaison
  Future<Map<String, dynamic>?> authentifier(
    String pseudonyme,
    String pinClair,
  ) async {
    final db = await AppDatabase.instance.database;
    final hashedPin = PinSecurity.hashPin(pinClair);
    final res = await db.query(
      'eleve',
      where: 'pseudonyme = ? AND code_pin = ?',
      whereArgs: [pseudonyme, hashedPin],
      limit: 1,
    );
    return res.isNotEmpty ? res.first : null;
  }

  Future<Map<String, dynamic>?> getEleveById(int id) async {
    final db = await AppDatabase.instance.database;
    final res = await db.query(
      'eleve',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return res.isNotEmpty ? res.first : null;
  }

  Future<bool> pseudonymeExiste(String pseudonyme) async {
    final db = await AppDatabase.instance.database;
    final res = await db.query(
      'eleve',
      where: 'pseudonyme = ?',
      whereArgs: [pseudonyme],
    );
    return res.isNotEmpty;
  }

  // ----------- COEFFICIENT REF -----------------

  //Cherche les coefficient officiel pour une série
  Future<List<CoefficientRef>> getCoefficientsRef({
    required String niveau,
    required String serie,
  }) async {
    final db = await AppDatabase.instance.database;
    final res = await db.query(
      'coefficient_ref',
      where: 'niveau = ? AND serie = ?',
      whereArgs: [niveau, serie],
    );
    return res.map((m) => CoefficientRef.fromMap(m)).toList();
  }

  // Cherche le coefficient officiel d'une matière pour un niveau
  // donnés ; retourne 1.0 par défaut si absent de la table de référence.
  Future<double> getCoefficientPourMatiere({
    required String niveau,
    required String serie,
    required String nomMatiere,
  }) async {
    final db = await AppDatabase.instance.database;
    final res = await db.query(
      'coefficient_ref',
      where: 'niveau = ? AND serie = ? AND matiere = ?',
      whereArgs: [niveau, serie, nomMatiere],
      limit: 1,
    );
    if (res.isEmpty) return 1.0;
    return (res.first['coefficient'] as num).toDouble();
  }

  // ---------- MATIERE ----------

  Future<int> createMatiere(Matiere m) async {
    final db = await AppDatabase.instance.database;
    return await db.insert('matiere', m.toMap()..remove('id'));
  }

  Future<List<Matiere>> getMatieres(int eleveId) async {
    final db = await AppDatabase.instance.database;
    final res = await db.query(
      'matiere',
      where: 'eleve_id = ?',
      whereArgs: [eleveId],
      orderBy: 'nom',
    );

    final List<Matiere> matieres = [];
    for (final map in res) {
      // On convertit le dictionnaire en objet Matiere et on l'ajoute à la liste
      matieres.add(Matiere.fromMap(map));
    }
    return matieres;

    //return res.map((m) => Matiere.fromMap(m)).toList();
  }

  Future<void> deleteMatiere(int id) async {
    final db = await AppDatabase.instance.database;
    await db.delete('matiere', where: 'id = ?', whereArgs: [id]);
  }

  // ---------- NOTE ----------

  Future<int> createNote(Note n) async {
    final db = await AppDatabase.instance.database;
    return await db.insert('note', n.toMap()..remove('id'));
  }

  Future<List<Note>> getNotesPourMatiere(int matiereId) async {
    final db = await AppDatabase.instance.database;
    final res = await db.query(
      'note',
      where: 'matiere_id = ?',
      whereArgs: [matiereId],
      orderBy: 'date DESC',
    );
    return res.map((m) => Note.fromMap(m)).toList();
  }

  Future<void> deleteNote(int id) async {
    final db = await AppDatabase.instance.database;
    await db.delete('note', where: 'id = ?', whereArgs: [id]);
  }

  // Moyenne de matière = moyenne simple des notes ramenées sur 20.

  Future<double?> getMoyenneMatiere(int matiereId) async {
    final notes = await getNotesPourMatiere(matiereId);
    if (notes.isEmpty) return null;
    final somme = notes.fold<double>(0, (acc, n) => acc + n.valeurNormalisee);
    return somme / notes.length;
  }

  /// Moyenne générale pondérée par les coefficients des matières.
  Future<double?> getMoyenneGenerale(int eleveId) async {
    final matieres = await getMatieres(eleveId);
    double sommePonderee = 0;
    double totalCoef = 0;
    for (final m in matieres) {
      final moyenne = await getMoyenneMatiere(m.id!);
      if (moyenne != null) {
        sommePonderee += moyenne * m.coefficient;
        totalCoef += m.coefficient;
      }
    }
    if (totalCoef == 0) return null;
    return sommePonderee / totalCoef;
  }

  // ---------- COURS_EDT (emploi du temps) ----------

  Future<int> createCoursEDT(CoursEDT c) async {
    final db = await AppDatabase.instance.database;
    return await db.insert('cours_edt', c.toMap()..remove('id'));
  }
  
  // Récupérer l'emploie du temps de l'élève et de trier par jour et par heure 
  Future<List<CoursEDT>> getCoursEDT(int eleveId) async {
  final db = await AppDatabase.instance.database;
  final res = await db.query(
    'cours_edt',
    where: 'eleve_id = ?',
    whereArgs: [eleveId],
  );

  //  Conversion avec boucle for
  final List<CoursEDT> list = [];
  for (final map in res) {
    list.add(CoursEDT.fromMap(map));
  }

  //  Tri par jour puis par heure
  const ordreJours = ['LUNDI', 'MARDI', 'MERCREDI', 'JEUDI', 'VENDREDI', 'SAMEDI'];
  
  list.sort((a, b) {
    final indexA = ordreJours.indexOf(a.jour);
    final indexB = ordreJours.indexOf(b.jour);
    
    final comparaisonJour = indexA.compareTo(indexB);
    
    // Si c'est deux jours différents, on trie par jour
    if (comparaisonJour != 0) {
      return comparaisonJour;
    }
    
    // Si c'est le même jour, on trie par heure de début
    return a.creneauDebut.compareTo(b.creneauDebut);
  });

  return list;
}
  Future<void> deleteCoursEDT(int id) async {
    final db = await AppDatabase.instance.database;
    await db.delete('cours_edt', where: 'id = ?', whereArgs: [id]);
  }


  // ---------- SEANCE_ETUDE (planificateur) ----------

  Future<int> createSeanceEtude(SeanceEtude s) async {
    final db = await AppDatabase.instance.database;
    return await db.insert('seance_etude', s.toMap()..remove('id'));
  }

  Future<List<SeanceEtude>> getSeancesEtude(int eleveId) async {
    final db = await AppDatabase.instance.database;
    final res = await db.query(
      'seance_etude',
      where: 'eleve_id = ?',
      whereArgs: [eleveId],
      orderBy: 'date ASC, heure_debut ASC',
    );
    return res.map((m) => SeanceEtude.fromMap(m)).toList();
  }

  Future<void> seanceTerminee(int id, bool termine) async {
    final db = await AppDatabase.instance.database;
    await db.update(
      'seance_etude',
      {'termine': termine ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteSeanceEtude(int id) async {
    final db = await AppDatabase.instance.database;
    await db.delete('seance_etude', where: 'id = ?', whereArgs: [id]);
  }


  // ---------- NOTIFICATION  ----------

  Future<int> createNotificationRappel(NotificationRappel n) async {
    final db = await AppDatabase.instance.database;
    return await db.insert('notification', n.toMap()..remove('id'));
  }

  Future<NotificationRappel?> getNotificationPourCible({required String cibleType, required int cibleId}) async {
    final db = await AppDatabase.instance.database;
    final res = await db.query(
      'notification',
      where: 'cible_type = ? AND cible_id = ?',
      whereArgs: [cibleType, cibleId],
      limit: 1,
    );
    if (res.isEmpty) return null;
    return NotificationRappel.fromMap(res.first);
  }

  Future<void> updateNotificationActive(int id, bool active) async {
    final db = await AppDatabase.instance.database;
    await db.update('notification', {'active': active ? 1 : 0}, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteNotificationPourCible({required String cibleType, required int cibleId}) async {
    final db = await AppDatabase.instance.database;
    await db.delete('notification', where: 'cible_type = ? AND cible_id = ?', whereArgs: [cibleType, cibleId]);
  }
}
