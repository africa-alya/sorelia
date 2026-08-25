class Etude {
  final int? id;
  final int eleveId;
  final String matiere;
  final DateTime date;
  final String heureDebut; 
  final int dureeMin;
  final String? objectif;
  final String? recurrence;
  final int pauses; 
  final bool termine;

  Etude({
    this.id,
    required this.eleveId,
    required this.matiere,
    required this.date,
    required this.heureDebut,
    required this.dureeMin,
    this.objectif,
    this.recurrence,
    this.pauses = 0,
    this.termine = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eleve_id': eleveId,
      'matiere': matiere,
      'date': date.toIso8601String(),
      'heure_debut': heureDebut,
      'duree_min': dureeMin,
      'objectif': objectif,
      'recurrence': recurrence,
      'pauses': pauses,
      'termine': termine ? 1 : 0,
    };
  }

  factory Etude.fromMap(Map<String, dynamic> map) {
    return Etude(
      id: map['id'] as int?,
      eleveId: map['eleve_id'] as int,
      matiere: map['matiere'] as String,
      date: DateTime.parse(map['date'] as String),
      heureDebut: map['heure_debut'] as String,
      dureeMin: map['duree_min'] as int,
      objectif: map['objectif'] as String?,
      recurrence: map['recurrence'] as String?,
      pauses: map['pauses'] as int,
      termine: (map['termine'] as int) == 1,
    );
  }

  // Combine la date et l'heure de début en un DateTime unique,
  //  pour programmer la notification locale correspondante.
  DateTime get dateTimeDebut {
    final parts = heureDebut.split(':');
    return DateTime(date.year, date.month, date.day, int.parse(parts[0]), int.parse(parts[1]));
  }
}
