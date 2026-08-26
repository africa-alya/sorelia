class Matter {
  final int? id;
  final int eleveId; // non présent explicitement dans le CCT (table mono-élève
  // sur l'appareil) mais conservé pour cohérence relationnelle locale.
  final String nom;
  final String serie;
  final double coefficient;

  Matter({
    this.id,
    required this.eleveId,
    required this.nom,
    required this.serie,
    required this.coefficient,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eleve_id': eleveId,
      'nom': nom,
      'serie': serie,
      'coefficient': coefficient,
    };
  }

  factory Matter.fromMap(Map<String, dynamic> map) {
    return Matter(
      id: map['id'] as int?,
      eleveId: map['eleve_id'] as int,
      nom: map['nom'] as String,
      serie: map['serie'] as String,
      coefficient: (map['coefficient'] as num).toDouble(),
    );
  }
}
