class Cours {
  final int? id;
  final int eleveId;
  final String jour; 
  final String creneauDebut; 
  final String creneauFin; 
  final String matiere;
  final String? salle;

  Cours({
    this.id,
    required this.eleveId,
    required this.jour,
    required this.creneauDebut,
    required this.creneauFin,
    required this.matiere,
    this.salle,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eleve_id': eleveId,
      'jour': jour,
      'creneau_debut': creneauDebut,
      'creneau_fin': creneauFin,
      'matiere': matiere,
      'salle': salle,
    };
  }

  factory Cours.fromMap(Map<String, dynamic> map) {
    return Cours(
      id: map['id'] as int?,
      eleveId: map['eleve_id'] as int,
      jour: map['jour'] as String,
      creneauDebut: map['creneau_debut'] as String,
      creneauFin: map['creneau_fin'] as String,
      matiere: map['matiere'] as String,
      salle: map['salle'] as String?,
    );
  }
}

class JourSemaine {
  static const values = ['LUNDI', 'MARDI', 'MERCREDI', 'JEUDI', 'VENDREDI', 'SAMEDI'];
}
