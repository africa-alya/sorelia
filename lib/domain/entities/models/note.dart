class Score {
  final int? id;
  final int matiereId;
  final String typeEval; 
  final double valeur; 
  final double bareme; 
  final String periode; 
  final DateTime date;

  Score({
    this.id,
    required this.matiereId,
    required this.typeEval,
    required this.valeur,
    this.bareme = 20.0,
    required this.periode,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  // Score ramenée sur 20 pour comparaison uniforme entre matières.
  double get valeurNormalisee => (valeur / bareme) * 20;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'matiere_id': matiereId,
      'type_eval': typeEval,
      'valeur': valeur,
      'bareme': bareme,
      'periode': periode,
      'date': date.toIso8601String(),
    };
  }

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      id: map['id'] as int?,
      matiereId: map['matiere_id'] as int,
      typeEval: map['type_eval'] as String,
      valeur: (map['valeur'] as num).toDouble(),
      bareme: (map['bareme'] as num).toDouble(),
      periode: map['periode'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }
}

// Valeurs autorisées pour typeEval
class TypeEval {
  static const devoir = 'DEVOIR';
  static const interro = 'INTERRO';
  static const composition = 'COMPOSITION';
  static const values = [devoir, interro, composition];
}