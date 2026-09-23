class Student {
  final int? id;
  final String pseudonyme;

  /// Empreinte produite par `PinService.hacher`, **jamais le PIN en clair**
  /// (CCT §6.3). Le champ porte ce nom pour que le compilateur refuse tout
  /// point d'appel qui y glisserait la saisie brute de l'élève.
  final String empreintePin;

  final String? telephone;
  final String niveau;
  final String typeEnseignement;
  final String? serie;
  final DateTime dateCreation;

  /// TRIMESTRE ou SEMESTRE (voir SystemeAcademique). Null tant que
  /// l'élève n'a pas encore répondu au dialogue de choix.
  final String? systemeAcademique;

  Student({
    this.id,
    required this.pseudonyme,
    required this.empreintePin,
    this.telephone,
    required this.niveau,
    required this.typeEnseignement,
    this.serie,
    DateTime? dateCreation,
    this.systemeAcademique,
  }) : dateCreation = dateCreation ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pseudonyme': pseudonyme,
      // La colonne SQL garde le nom du dictionnaire de données du CCT.
      'code_pin': empreintePin,
      'telephone': telephone,
      'niveau': niveau,
      'type_enseignement': typeEnseignement,
      'serie': serie,
      'date_creation': dateCreation.toIso8601String(),
      'systeme_academique': systemeAcademique,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as int?,
      pseudonyme: map['pseudonyme'] as String,
      empreintePin: map['code_pin'] as String,
      telephone: map['telephone'] as String?,
      niveau: map['niveau'] as String,
      typeEnseignement: map['type_enseignement'] as String,
      serie: map['serie'] as String?,
      dateCreation: DateTime.parse(map['date_creation'] as String),
      systemeAcademique: map['systeme_academique'] as String?,
    );
  }

  /// Copie l'élève avec un ou plusieurs champs modifiés, sans avoir à
  /// tout retaper. Pratique après le choix trimestre/semestre.
  Student copyWith({String? systemeAcademique}) {
    return Student(
      id: id,
      pseudonyme: pseudonyme,
      empreintePin: empreintePin,
      telephone: telephone,
      niveau: niveau,
      typeEnseignement: typeEnseignement,
      serie: serie,
      dateCreation: dateCreation,
      systemeAcademique: systemeAcademique ?? this.systemeAcademique,
    );
  }
}

// Valeurs autorisées pour `type_enseignement` (
class TypeEnseignement {
  static const general = 'GENERAL';
  static const technique = 'TECHNIQUE';
  static const values = [general, technique];
}

/// Valeurs autorisées pour `systeme_academique`.
class SystemeAcademique {
  static const trimestre = 'TRIMESTRE';
  static const semestre = 'SEMESTRE';
  static const values = [trimestre, semestre];
}