class NotificationRappel {
  final int? id;
  final String cibleType; 
  final int cibleId; 
  final String type; // DEBUT, FIN ou PAUSE
  final int delaiMin; // anticipation en minutes (5, 10, 15...)
  final bool active;
  final String? heuresSilence; // ex: "22:00-06:00"

  NotificationRappel({
    this.id,
    required this.cibleType,
    required this.cibleId,
    required this.type,
    this.delaiMin = 10,
    this.active = true,
    this.heuresSilence,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cible_type': cibleType,
      'cible_id': cibleId,
      'type': type,
      'delai_min': delaiMin,
      'active': active ? 1 : 0,
      'heures_silence': heuresSilence,
    };
  }

  factory NotificationRappel.fromMap(Map<String, dynamic> map) {
    return NotificationRappel(
      id: map['id'] as int?,
      cibleType: map['cible_type'] as String,
      cibleId: map['cible_id'] as int,
      type: map['type'] as String,
      delaiMin: map['delai_min'] as int,
      active: (map['active'] as int) == 1,
      heuresSilence: map['heures_silence'] as String?,
    );
  }
}

class CibleType {
  static const seance = 'SEANCE';
  static const cours = 'COURS';
}

class TypeRappel {
  static const debut = 'DEBUT';
  static const fin = 'FIN';
  static const pause = 'PAUSE';
  static const values = [debut, fin, pause];
}