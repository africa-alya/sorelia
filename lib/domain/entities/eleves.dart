class Student {
  final int? id;
  final String pseudonyme;
  final String codePin;
  final String? telephone;
  final String niveau;
  final String typeEnseignement;
  final String? serie;
  final DateTime dateCreation;

  Student({
    this.id,
    required this.pseudonyme,
    required this.codePin,
    this.telephone,
    required this.niveau,
    required this.typeEnseignement,
    this.serie,
    DateTime? dateCreation,
  }) : dateCreation = dateCreation ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pseudonyme': pseudonyme,
      'code_pin': codePin,
      'telephone': telephone,
      'niveau': niveau,
      'type_enseignement': typeEnseignement,
      'serie': serie,
      'date_creation': dateCreation.toIso8601String(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as int?,
      pseudonyme: map['pseudonyme'] as String,
      codePin: map['code_pin'] as String,
      telephone: map['telephone'] as String?,
      niveau: map['niveau'] as String,
      typeEnseignement: map['type_enseignement'] as String,
      serie: map['serie'] as String?,
      dateCreation: DateTime.parse(map['date_creation'] as String),
    );
  }
}

// Valeurs autorisées pour `type_enseignement` (
class TypeEnseignement {
  static const general = 'GENERAL';
  static const technique = 'TECHNIQUE';
  static const values = [general, technique];
}
