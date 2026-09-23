class MatiereReference {
  final String niveau;
  final String serie;
  final String matiere;
  final int coefficient;

  MatiereReference({
    required this.niveau,
    required this.serie,
    required this.matiere,
    required this.coefficient,
    
  });

  factory MatiereReference.fromJson(Map<String, dynamic> json) {
    return MatiereReference(
      niveau: json['niveau'] as String,
      serie: json['serie'] as String,
      matiere: json['matiere'] as String,
      coefficient: json['coefficient'] as int,
    );
  }
}