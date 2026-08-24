class CoefficientRef {
  final int? id;
  final String niveau;
  final String serie;
  final String matiere;
  final double coefficient;
  final String? versionSource;

  CoefficientRef({
    this.id,
    required this.niveau,
    required this.serie,
    required this.matiere,
    required this.coefficient,
    this.versionSource,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'niveau': niveau,
      'serie': serie,
      'matiere': matiere,
      'coefficient': coefficient,
      'version_source': versionSource,
    };
  }

  factory CoefficientRef.fromMap(Map<String, dynamic> map) {
    return CoefficientRef(
      id: map['id'] as int?,
      niveau: map['niveau'] as String,
      serie: map['serie'] as String,
      matiere: map['matiere'] as String,
      coefficient: (map['coefficient'] as num).toDouble(),
      versionSource: map['version_source'] as String?,
    );
  }
}