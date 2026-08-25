import 'package:drift/drift.dart';
import '../../models/eleves.dart';
import '../../models/coefficient_ref.dart';
import '../../services/security_pin.dart';
import '../../models/note.dart';
import '../../models/matiere.dart';
import '../../models/seance_etude.dart';
import '../../models/cours_edt.dart';
import '../../models/notification_rappel.dart';
import 'app_database.dart' as drift;
import 'package:drift/drift.dart' show Value;



// Import préfixé : Drift génère une classe `Eleve`, `Matiere`, `Note`...
// à partir des tables `Eleves`, `Matieres`, `Notes`... qui entreraient en
// collision directe avec nos classes métier du même nom (models/eleve.dart,
// etc.) si on les importait sans préfixe.




/// Façade au-dessus d'AppDatabase (Drift) : garde la même API publique
/// que l'ancienne version SQL brut, pour qu'aucun écran n'ait à changer.
class DatabaseHelper {
  DatabaseHelper._internal() : db = drift.AppDatabase();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  final drift.AppDatabase db;

  // ---------- Conversions Row Drift -> modèles applicatifs ----------

  Student _eleveFromRow(drift.Eleve r) => Student(
        id: r.id,
        pseudonyme: r.pseudonyme,
        codePin: r.codePin,
        telephone: r.telephone,
        niveau: r.niveau,
        typeEnseignement: r.typeEnseignement,
        serie: r.serie,
        dateCreation: DateTime.parse(r.dateCreation),
      );

  Matter _matiereFromRow(drift.Matiere r) => Matter(
        id: r.id,
        eleveId: r.eleveId,
        nom: r.nom,
        serie: r.serie,
        coefficient: r.coefficient,
      );

  Score _noteFromRow(drift.Note r) => Score(
        id: r.id,
        matiereId: r.matiereId,
        typeEval: r.typeEval,
        valeur: r.valeur,
        bareme: r.bareme,
        periode: r.periode,
        date: DateTime.parse(r.date),
      );

  Cours _coursFromRow(drift.CoursEdt r) => Cours(
        id: r.id,
        eleveId: r.eleveId,
        jour: r.jour,
        creneauDebut: r.creneauDebut,
        creneauFin: r.creneauFin,
        matiere: r.matiere,
        salle: r.salle,
      );

  Etude _seanceFromRow(drift.SeanceEtude r) => Etude(
        id: r.id,
        eleveId: r.eleveId,
        matiere: r.matiere,
        date: DateTime.parse(r.date),
        heureDebut: r.heureDebut,
        dureeMin: r.dureeMin,
        objectif: r.objectif,
        recurrence: r.recurrence,
        pauses: r.pauses,
        termine: r.termine,
      );

  NotificationRappel _notifFromRow(drift.NotificationConfig r) => NotificationRappel(
        id: r.id,
        cibleType: r.cibleType,
        cibleId: r.cibleId,
        type: r.type,
        delaiMin: r.delaiMin,
        active: r.active,
        heuresSilence: r.heuresSilence,
      );

  // ---------- ELEVE ----------

  Future<int> createEleve(Student e) async {
    return await db.into(db.eleves).insert(drift.ElevesCompanion.insert(
          pseudonyme: e.pseudonyme,
          codePin: e.codePin,
          telephone:Value(e.telephone),
          niveau: e.niveau,
          typeEnseignement: e.typeEnseignement,
          serie: Value(e.serie),
          dateCreation: e.dateCreation.toIso8601String(),
        ));
  }

  /// Authentifie par pseudonyme + PIN. Le PIN est haché avant comparaison
  /// (CCT §6.2) : jamais de comparaison en clair.
  Future<Student?> authentifier(String pseudonyme, String pinClair) async {
    final hashed = PinSecurity.hashPin(pinClair);
    final query = db.select(db.eleves)
      ..where((t) => t.pseudonyme.equals(pseudonyme) & t.codePin.equals(hashed));
    final row = await query.getSingleOrNull();
    return row == null ? null : _eleveFromRow(row);
  }

  Future<Student?> getEleveById(int id) async {
    final query = db.select(db.eleves)..where((t) => t.id.equals(id));
    final row = await query.getSingleOrNull();
    return row == null ? null : _eleveFromRow(row);
  }

  Future<bool> pseudonymeExiste(String pseudonyme) async {
    final query = db.select(db.eleves)..where((t) => t.pseudonyme.equals(pseudonyme));
    return (await query.get()).isNotEmpty;
  }

  // ---------- COEFFICIENT_REF ----------

  Future<List<CoefficientRef>> getCoefficientsRef({required String niveau, required String serie}) async {
    final query = db.select(db.coefficientRefs)
      ..where((t) => t.niveau.equals(niveau) & t.serie.equals(serie));
    final rows = await query.get();
    return rows
        .map((r) => CoefficientRef(id: r.id, niveau: r.niveau, serie: r.serie, matiere: r.matiere, coefficient: r.coefficient, versionSource: r.versionSource))
        .toList();
  }

  /// Cherche le coefficient officiel d'une matière pour un niveau/série
  /// donnés ; retourne 1.0 par défaut si absent de la table de référence.
  Future<double> getCoefficientPourMatiere({required String niveau, required String serie, required String nomMatiere}) async {
    final query = db.select(db.coefficientRefs)
      ..where((t) => t.niveau.equals(niveau) & t.serie.equals(serie) & t.matiere.equals(nomMatiere));
    final row = await query.getSingleOrNull();
    return row?.coefficient ?? 1.0;
  }

  // ---------- MATIERE ----------

  Future<int> createMatiere(Matter m) async {
    return await db.into(db.matieres).insert(drift.MatieresCompanion.insert(
          eleveId: m.eleveId,
          nom: m.nom,
          serie: m.serie,
          coefficient: m.coefficient,
        ));
  }

  Future<List<Matter>> getMatieres(int eleveId) async {
    final query = db.select(db.matieres)
      ..where((t) => t.eleveId.equals(eleveId))
      ..orderBy([(t) => OrderingTerm(expression: t.nom)]);
    final rows = await query.get();
    return rows.map(_matiereFromRow).toList();
  }

  Future<void> deleteMatiere(int id) async {
    await (db.delete(db.matieres)..where((t) => t.id.equals(id))).go();
  }

  // ---------- NOTE ----------

  Future<int> createNote(Score n) async {
    return await db.into(db.notes).insert(drift.NotesCompanion.insert(
          matiereId: n.matiereId,
          typeEval: n.typeEval,
          valeur: n.valeur,
          bareme: Value(n.bareme),
          periode: n.periode,
          date: n.date.toIso8601String(),
        ));
  }

  Future<List<Score>> getNotesPourMatiere(int matiereId) async {
    final query = db.select(db.notes)
      ..where((t) => t.matiereId.equals(matiereId))
      ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]);
    final rows = await query.get();
    return rows.map(_noteFromRow).toList();
  }

  Future<void> deleteNote(int id) async {
    await (db.delete(db.notes)..where((t) => t.id.equals(id))).go();
  }

  /// Moyenne de matière = moyenne simple des notes ramenées sur 20.
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

  Future<int> createCoursEDT(Cours c) async {
    return await db.into(db.coursEdts).insert(drift.CoursEdtsCompanion.insert(
          eleveId: c.eleveId,
          jour: c.jour,
          creneauDebut: c.creneauDebut,
          creneauFin: c.creneauFin,
          matiere: c.matiere,
          salle: Value(c.salle),
        ));
  }

  Future<List<Cours>> getCoursEDT(int eleveId) async {
    final query = db.select(db.coursEdts)..where((t) => t.eleveId.equals(eleveId));
    final rows = await query.get();
    final list = rows.map(_coursFromRow).toList();
    const ordreJours = ['LUNDI', 'MARDI', 'MERCREDI', 'JEUDI', 'VENDREDI', 'SAMEDI'];
    list.sort((a, b) {
      final j = ordreJours.indexOf(a.jour).compareTo(ordreJours.indexOf(b.jour));
      if (j != 0) return j;
      return a.creneauDebut.compareTo(b.creneauDebut);
    });
    return list;
  }

  Future<void> deleteCoursEDT(int id) async {
    await (db.delete(db.coursEdts)..where((t) => t.id.equals(id))).go();
  }

  // ---------- SEANCE_ETUDE (planificateur) ----------

  Future<int> createSeanceEtude(Etude s) async {
    return await db.into(db.seanceEtudes).insert(drift.SeanceEtudesCompanion.insert(
          eleveId: s.eleveId,
          matiere: s.matiere,
          date: s.date.toIso8601String(),
          heureDebut: s.heureDebut,
          dureeMin: s.dureeMin,
          objectif: Value(s.objectif),
          recurrence: Value(s.recurrence),
          pauses: Value(s.pauses),
          termine: Value(s.termine),
        ));
  }

  Future<List<Etude>> getSeancesEtude(int eleveId) async {
    final query = db.select(db.seanceEtudes)
      ..where((t) => t.eleveId.equals(eleveId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.date),
        (t) => OrderingTerm(expression: t.heureDebut),
      ]);
    final rows = await query.get();
    return rows.map(_seanceFromRow).toList();
  }

  Future<void> toggleSeanceTerminee(int id, bool termine) async {
    await (db.update(db.seanceEtudes)..where((t) => t.id.equals(id)))
        .write(drift.SeanceEtudesCompanion(termine: Value(termine)));
  }

  Future<void> deleteSeanceEtude(int id) async {
    await (db.delete(db.seanceEtudes)..where((t) => t.id.equals(id))).go();
  }

  // ---------- NOTIFICATION (rappels — CCT §6.3) ----------

  Future<int> createNotificationRappel(NotificationRappel n) async {
    return await db.into(db.notificationConfigs).insert(drift.NotificationConfigsCompanion.insert(
          cibleType: n.cibleType,
          cibleId: n.cibleId,
          type: n.type,
          delaiMin: Value(n.delaiMin),
          active: Value(n.active),
          heuresSilence: Value(n.heuresSilence),
        ));
  }

  Future<NotificationRappel?> getNotificationPourCible({required String cibleType, required int cibleId}) async {
    final query = db.select(db.notificationConfigs)
      ..where((t) => t.cibleType.equals(cibleType) & t.cibleId.equals(cibleId));
    final row = await query.getSingleOrNull();
    return row == null ? null : _notifFromRow(row);
  }

  Future<void> updateNotificationActive(int id, bool active) async {
    await (db.update(db.notificationConfigs)..where((t) => t.id.equals(id)))
        .write(drift.NotificationConfigsCompanion(active: Value(active)));
  }

  Future<void> deleteNotificationPourCible({required String cibleType, required int cibleId}) async {
    await (db.delete(db.notificationConfigs)..where((t) => t.cibleType.equals(cibleType) & t.cibleId.equals(cibleId))).go();
  }
}