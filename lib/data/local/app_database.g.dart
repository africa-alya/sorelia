// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ElevesTable extends Eleves with TableInfo<$ElevesTable, Eleve> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ElevesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _pseudonymeMeta = const VerificationMeta(
    'pseudonyme',
  );
  @override
  late final GeneratedColumn<String> pseudonyme = GeneratedColumn<String>(
    'pseudonyme',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codePinMeta = const VerificationMeta(
    'codePin',
  );
  @override
  late final GeneratedColumn<String> codePin = GeneratedColumn<String>(
    'code_pin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _telephoneMeta = const VerificationMeta(
    'telephone',
  );
  @override
  late final GeneratedColumn<String> telephone = GeneratedColumn<String>(
    'telephone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _niveauMeta = const VerificationMeta('niveau');
  @override
  late final GeneratedColumn<String> niveau = GeneratedColumn<String>(
    'niveau',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeEnseignementMeta = const VerificationMeta(
    'typeEnseignement',
  );
  @override
  late final GeneratedColumn<String> typeEnseignement = GeneratedColumn<String>(
    'type_enseignement',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serieMeta = const VerificationMeta('serie');
  @override
  late final GeneratedColumn<String> serie = GeneratedColumn<String>(
    'serie',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateCreationMeta = const VerificationMeta(
    'dateCreation',
  );
  @override
  late final GeneratedColumn<String> dateCreation = GeneratedColumn<String>(
    'date_creation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pseudonyme,
    codePin,
    telephone,
    niveau,
    typeEnseignement,
    serie,
    dateCreation,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'eleve';
  @override
  VerificationContext validateIntegrity(
    Insertable<Eleve> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pseudonyme')) {
      context.handle(
        _pseudonymeMeta,
        pseudonyme.isAcceptableOrUnknown(data['pseudonyme']!, _pseudonymeMeta),
      );
    } else if (isInserting) {
      context.missing(_pseudonymeMeta);
    }
    if (data.containsKey('code_pin')) {
      context.handle(
        _codePinMeta,
        codePin.isAcceptableOrUnknown(data['code_pin']!, _codePinMeta),
      );
    } else if (isInserting) {
      context.missing(_codePinMeta);
    }
    if (data.containsKey('telephone')) {
      context.handle(
        _telephoneMeta,
        telephone.isAcceptableOrUnknown(data['telephone']!, _telephoneMeta),
      );
    }
    if (data.containsKey('niveau')) {
      context.handle(
        _niveauMeta,
        niveau.isAcceptableOrUnknown(data['niveau']!, _niveauMeta),
      );
    } else if (isInserting) {
      context.missing(_niveauMeta);
    }
    if (data.containsKey('type_enseignement')) {
      context.handle(
        _typeEnseignementMeta,
        typeEnseignement.isAcceptableOrUnknown(
          data['type_enseignement']!,
          _typeEnseignementMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_typeEnseignementMeta);
    }
    if (data.containsKey('serie')) {
      context.handle(
        _serieMeta,
        serie.isAcceptableOrUnknown(data['serie']!, _serieMeta),
      );
    }
    if (data.containsKey('date_creation')) {
      context.handle(
        _dateCreationMeta,
        dateCreation.isAcceptableOrUnknown(
          data['date_creation']!,
          _dateCreationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateCreationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Eleve map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Eleve(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pseudonyme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pseudonyme'],
      )!,
      codePin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code_pin'],
      )!,
      telephone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telephone'],
      ),
      niveau: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}niveau'],
      )!,
      typeEnseignement: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_enseignement'],
      )!,
      serie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serie'],
      ),
      dateCreation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_creation'],
      )!,
    );
  }

  @override
  $ElevesTable createAlias(String alias) {
    return $ElevesTable(attachedDatabase, alias);
  }
}

class Eleve extends DataClass implements Insertable<Eleve> {
  final int id;
  final String pseudonyme;
  final String codePin;
  final String? telephone;
  final String niveau;
  final String typeEnseignement;
  final String? serie;
  final String dateCreation;
  const Eleve({
    required this.id,
    required this.pseudonyme,
    required this.codePin,
    this.telephone,
    required this.niveau,
    required this.typeEnseignement,
    this.serie,
    required this.dateCreation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pseudonyme'] = Variable<String>(pseudonyme);
    map['code_pin'] = Variable<String>(codePin);
    if (!nullToAbsent || telephone != null) {
      map['telephone'] = Variable<String>(telephone);
    }
    map['niveau'] = Variable<String>(niveau);
    map['type_enseignement'] = Variable<String>(typeEnseignement);
    if (!nullToAbsent || serie != null) {
      map['serie'] = Variable<String>(serie);
    }
    map['date_creation'] = Variable<String>(dateCreation);
    return map;
  }

  ElevesCompanion toCompanion(bool nullToAbsent) {
    return ElevesCompanion(
      id: Value(id),
      pseudonyme: Value(pseudonyme),
      codePin: Value(codePin),
      telephone: telephone == null && nullToAbsent
          ? const Value.absent()
          : Value(telephone),
      niveau: Value(niveau),
      typeEnseignement: Value(typeEnseignement),
      serie: serie == null && nullToAbsent
          ? const Value.absent()
          : Value(serie),
      dateCreation: Value(dateCreation),
    );
  }

  factory Eleve.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Eleve(
      id: serializer.fromJson<int>(json['id']),
      pseudonyme: serializer.fromJson<String>(json['pseudonyme']),
      codePin: serializer.fromJson<String>(json['codePin']),
      telephone: serializer.fromJson<String?>(json['telephone']),
      niveau: serializer.fromJson<String>(json['niveau']),
      typeEnseignement: serializer.fromJson<String>(json['typeEnseignement']),
      serie: serializer.fromJson<String?>(json['serie']),
      dateCreation: serializer.fromJson<String>(json['dateCreation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pseudonyme': serializer.toJson<String>(pseudonyme),
      'codePin': serializer.toJson<String>(codePin),
      'telephone': serializer.toJson<String?>(telephone),
      'niveau': serializer.toJson<String>(niveau),
      'typeEnseignement': serializer.toJson<String>(typeEnseignement),
      'serie': serializer.toJson<String?>(serie),
      'dateCreation': serializer.toJson<String>(dateCreation),
    };
  }

  Eleve copyWith({
    int? id,
    String? pseudonyme,
    String? codePin,
    Value<String?> telephone = const Value.absent(),
    String? niveau,
    String? typeEnseignement,
    Value<String?> serie = const Value.absent(),
    String? dateCreation,
  }) => Eleve(
    id: id ?? this.id,
    pseudonyme: pseudonyme ?? this.pseudonyme,
    codePin: codePin ?? this.codePin,
    telephone: telephone.present ? telephone.value : this.telephone,
    niveau: niveau ?? this.niveau,
    typeEnseignement: typeEnseignement ?? this.typeEnseignement,
    serie: serie.present ? serie.value : this.serie,
    dateCreation: dateCreation ?? this.dateCreation,
  );
  Eleve copyWithCompanion(ElevesCompanion data) {
    return Eleve(
      id: data.id.present ? data.id.value : this.id,
      pseudonyme: data.pseudonyme.present
          ? data.pseudonyme.value
          : this.pseudonyme,
      codePin: data.codePin.present ? data.codePin.value : this.codePin,
      telephone: data.telephone.present ? data.telephone.value : this.telephone,
      niveau: data.niveau.present ? data.niveau.value : this.niveau,
      typeEnseignement: data.typeEnseignement.present
          ? data.typeEnseignement.value
          : this.typeEnseignement,
      serie: data.serie.present ? data.serie.value : this.serie,
      dateCreation: data.dateCreation.present
          ? data.dateCreation.value
          : this.dateCreation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Eleve(')
          ..write('id: $id, ')
          ..write('pseudonyme: $pseudonyme, ')
          ..write('codePin: $codePin, ')
          ..write('telephone: $telephone, ')
          ..write('niveau: $niveau, ')
          ..write('typeEnseignement: $typeEnseignement, ')
          ..write('serie: $serie, ')
          ..write('dateCreation: $dateCreation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pseudonyme,
    codePin,
    telephone,
    niveau,
    typeEnseignement,
    serie,
    dateCreation,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Eleve &&
          other.id == this.id &&
          other.pseudonyme == this.pseudonyme &&
          other.codePin == this.codePin &&
          other.telephone == this.telephone &&
          other.niveau == this.niveau &&
          other.typeEnseignement == this.typeEnseignement &&
          other.serie == this.serie &&
          other.dateCreation == this.dateCreation);
}

class ElevesCompanion extends UpdateCompanion<Eleve> {
  final Value<int> id;
  final Value<String> pseudonyme;
  final Value<String> codePin;
  final Value<String?> telephone;
  final Value<String> niveau;
  final Value<String> typeEnseignement;
  final Value<String?> serie;
  final Value<String> dateCreation;
  const ElevesCompanion({
    this.id = const Value.absent(),
    this.pseudonyme = const Value.absent(),
    this.codePin = const Value.absent(),
    this.telephone = const Value.absent(),
    this.niveau = const Value.absent(),
    this.typeEnseignement = const Value.absent(),
    this.serie = const Value.absent(),
    this.dateCreation = const Value.absent(),
  });
  ElevesCompanion.insert({
    this.id = const Value.absent(),
    required String pseudonyme,
    required String codePin,
    this.telephone = const Value.absent(),
    required String niveau,
    required String typeEnseignement,
    this.serie = const Value.absent(),
    required String dateCreation,
  }) : pseudonyme = Value(pseudonyme),
       codePin = Value(codePin),
       niveau = Value(niveau),
       typeEnseignement = Value(typeEnseignement),
       dateCreation = Value(dateCreation);
  static Insertable<Eleve> custom({
    Expression<int>? id,
    Expression<String>? pseudonyme,
    Expression<String>? codePin,
    Expression<String>? telephone,
    Expression<String>? niveau,
    Expression<String>? typeEnseignement,
    Expression<String>? serie,
    Expression<String>? dateCreation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pseudonyme != null) 'pseudonyme': pseudonyme,
      if (codePin != null) 'code_pin': codePin,
      if (telephone != null) 'telephone': telephone,
      if (niveau != null) 'niveau': niveau,
      if (typeEnseignement != null) 'type_enseignement': typeEnseignement,
      if (serie != null) 'serie': serie,
      if (dateCreation != null) 'date_creation': dateCreation,
    });
  }

  ElevesCompanion copyWith({
    Value<int>? id,
    Value<String>? pseudonyme,
    Value<String>? codePin,
    Value<String?>? telephone,
    Value<String>? niveau,
    Value<String>? typeEnseignement,
    Value<String?>? serie,
    Value<String>? dateCreation,
  }) {
    return ElevesCompanion(
      id: id ?? this.id,
      pseudonyme: pseudonyme ?? this.pseudonyme,
      codePin: codePin ?? this.codePin,
      telephone: telephone ?? this.telephone,
      niveau: niveau ?? this.niveau,
      typeEnseignement: typeEnseignement ?? this.typeEnseignement,
      serie: serie ?? this.serie,
      dateCreation: dateCreation ?? this.dateCreation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pseudonyme.present) {
      map['pseudonyme'] = Variable<String>(pseudonyme.value);
    }
    if (codePin.present) {
      map['code_pin'] = Variable<String>(codePin.value);
    }
    if (telephone.present) {
      map['telephone'] = Variable<String>(telephone.value);
    }
    if (niveau.present) {
      map['niveau'] = Variable<String>(niveau.value);
    }
    if (typeEnseignement.present) {
      map['type_enseignement'] = Variable<String>(typeEnseignement.value);
    }
    if (serie.present) {
      map['serie'] = Variable<String>(serie.value);
    }
    if (dateCreation.present) {
      map['date_creation'] = Variable<String>(dateCreation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ElevesCompanion(')
          ..write('id: $id, ')
          ..write('pseudonyme: $pseudonyme, ')
          ..write('codePin: $codePin, ')
          ..write('telephone: $telephone, ')
          ..write('niveau: $niveau, ')
          ..write('typeEnseignement: $typeEnseignement, ')
          ..write('serie: $serie, ')
          ..write('dateCreation: $dateCreation')
          ..write(')'))
        .toString();
  }
}

class $CoefficientRefsTable extends CoefficientRefs
    with TableInfo<$CoefficientRefsTable, CoefficientRef> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoefficientRefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _niveauMeta = const VerificationMeta('niveau');
  @override
  late final GeneratedColumn<String> niveau = GeneratedColumn<String>(
    'niveau',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serieMeta = const VerificationMeta('serie');
  @override
  late final GeneratedColumn<String> serie = GeneratedColumn<String>(
    'serie',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _matiereMeta = const VerificationMeta(
    'matiere',
  );
  @override
  late final GeneratedColumn<String> matiere = GeneratedColumn<String>(
    'matiere',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coefficientMeta = const VerificationMeta(
    'coefficient',
  );
  @override
  late final GeneratedColumn<double> coefficient = GeneratedColumn<double>(
    'coefficient',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionSourceMeta = const VerificationMeta(
    'versionSource',
  );
  @override
  late final GeneratedColumn<String> versionSource = GeneratedColumn<String>(
    'version_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    niveau,
    serie,
    matiere,
    coefficient,
    versionSource,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coefficient_ref';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoefficientRef> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('niveau')) {
      context.handle(
        _niveauMeta,
        niveau.isAcceptableOrUnknown(data['niveau']!, _niveauMeta),
      );
    } else if (isInserting) {
      context.missing(_niveauMeta);
    }
    if (data.containsKey('serie')) {
      context.handle(
        _serieMeta,
        serie.isAcceptableOrUnknown(data['serie']!, _serieMeta),
      );
    } else if (isInserting) {
      context.missing(_serieMeta);
    }
    if (data.containsKey('matiere')) {
      context.handle(
        _matiereMeta,
        matiere.isAcceptableOrUnknown(data['matiere']!, _matiereMeta),
      );
    } else if (isInserting) {
      context.missing(_matiereMeta);
    }
    if (data.containsKey('coefficient')) {
      context.handle(
        _coefficientMeta,
        coefficient.isAcceptableOrUnknown(
          data['coefficient']!,
          _coefficientMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coefficientMeta);
    }
    if (data.containsKey('version_source')) {
      context.handle(
        _versionSourceMeta,
        versionSource.isAcceptableOrUnknown(
          data['version_source']!,
          _versionSourceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CoefficientRef map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoefficientRef(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      niveau: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}niveau'],
      )!,
      serie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serie'],
      )!,
      matiere: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matiere'],
      )!,
      coefficient: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}coefficient'],
      )!,
      versionSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version_source'],
      ),
    );
  }

  @override
  $CoefficientRefsTable createAlias(String alias) {
    return $CoefficientRefsTable(attachedDatabase, alias);
  }
}

class CoefficientRef extends DataClass implements Insertable<CoefficientRef> {
  final int id;
  final String niveau;
  final String serie;
  final String matiere;
  final double coefficient;
  final String? versionSource;
  const CoefficientRef({
    required this.id,
    required this.niveau,
    required this.serie,
    required this.matiere,
    required this.coefficient,
    this.versionSource,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['niveau'] = Variable<String>(niveau);
    map['serie'] = Variable<String>(serie);
    map['matiere'] = Variable<String>(matiere);
    map['coefficient'] = Variable<double>(coefficient);
    if (!nullToAbsent || versionSource != null) {
      map['version_source'] = Variable<String>(versionSource);
    }
    return map;
  }

  CoefficientRefsCompanion toCompanion(bool nullToAbsent) {
    return CoefficientRefsCompanion(
      id: Value(id),
      niveau: Value(niveau),
      serie: Value(serie),
      matiere: Value(matiere),
      coefficient: Value(coefficient),
      versionSource: versionSource == null && nullToAbsent
          ? const Value.absent()
          : Value(versionSource),
    );
  }

  factory CoefficientRef.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoefficientRef(
      id: serializer.fromJson<int>(json['id']),
      niveau: serializer.fromJson<String>(json['niveau']),
      serie: serializer.fromJson<String>(json['serie']),
      matiere: serializer.fromJson<String>(json['matiere']),
      coefficient: serializer.fromJson<double>(json['coefficient']),
      versionSource: serializer.fromJson<String?>(json['versionSource']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'niveau': serializer.toJson<String>(niveau),
      'serie': serializer.toJson<String>(serie),
      'matiere': serializer.toJson<String>(matiere),
      'coefficient': serializer.toJson<double>(coefficient),
      'versionSource': serializer.toJson<String?>(versionSource),
    };
  }

  CoefficientRef copyWith({
    int? id,
    String? niveau,
    String? serie,
    String? matiere,
    double? coefficient,
    Value<String?> versionSource = const Value.absent(),
  }) => CoefficientRef(
    id: id ?? this.id,
    niveau: niveau ?? this.niveau,
    serie: serie ?? this.serie,
    matiere: matiere ?? this.matiere,
    coefficient: coefficient ?? this.coefficient,
    versionSource: versionSource.present
        ? versionSource.value
        : this.versionSource,
  );
  CoefficientRef copyWithCompanion(CoefficientRefsCompanion data) {
    return CoefficientRef(
      id: data.id.present ? data.id.value : this.id,
      niveau: data.niveau.present ? data.niveau.value : this.niveau,
      serie: data.serie.present ? data.serie.value : this.serie,
      matiere: data.matiere.present ? data.matiere.value : this.matiere,
      coefficient: data.coefficient.present
          ? data.coefficient.value
          : this.coefficient,
      versionSource: data.versionSource.present
          ? data.versionSource.value
          : this.versionSource,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoefficientRef(')
          ..write('id: $id, ')
          ..write('niveau: $niveau, ')
          ..write('serie: $serie, ')
          ..write('matiere: $matiere, ')
          ..write('coefficient: $coefficient, ')
          ..write('versionSource: $versionSource')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, niveau, serie, matiere, coefficient, versionSource);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoefficientRef &&
          other.id == this.id &&
          other.niveau == this.niveau &&
          other.serie == this.serie &&
          other.matiere == this.matiere &&
          other.coefficient == this.coefficient &&
          other.versionSource == this.versionSource);
}

class CoefficientRefsCompanion extends UpdateCompanion<CoefficientRef> {
  final Value<int> id;
  final Value<String> niveau;
  final Value<String> serie;
  final Value<String> matiere;
  final Value<double> coefficient;
  final Value<String?> versionSource;
  const CoefficientRefsCompanion({
    this.id = const Value.absent(),
    this.niveau = const Value.absent(),
    this.serie = const Value.absent(),
    this.matiere = const Value.absent(),
    this.coefficient = const Value.absent(),
    this.versionSource = const Value.absent(),
  });
  CoefficientRefsCompanion.insert({
    this.id = const Value.absent(),
    required String niveau,
    required String serie,
    required String matiere,
    required double coefficient,
    this.versionSource = const Value.absent(),
  }) : niveau = Value(niveau),
       serie = Value(serie),
       matiere = Value(matiere),
       coefficient = Value(coefficient);
  static Insertable<CoefficientRef> custom({
    Expression<int>? id,
    Expression<String>? niveau,
    Expression<String>? serie,
    Expression<String>? matiere,
    Expression<double>? coefficient,
    Expression<String>? versionSource,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (niveau != null) 'niveau': niveau,
      if (serie != null) 'serie': serie,
      if (matiere != null) 'matiere': matiere,
      if (coefficient != null) 'coefficient': coefficient,
      if (versionSource != null) 'version_source': versionSource,
    });
  }

  CoefficientRefsCompanion copyWith({
    Value<int>? id,
    Value<String>? niveau,
    Value<String>? serie,
    Value<String>? matiere,
    Value<double>? coefficient,
    Value<String?>? versionSource,
  }) {
    return CoefficientRefsCompanion(
      id: id ?? this.id,
      niveau: niveau ?? this.niveau,
      serie: serie ?? this.serie,
      matiere: matiere ?? this.matiere,
      coefficient: coefficient ?? this.coefficient,
      versionSource: versionSource ?? this.versionSource,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (niveau.present) {
      map['niveau'] = Variable<String>(niveau.value);
    }
    if (serie.present) {
      map['serie'] = Variable<String>(serie.value);
    }
    if (matiere.present) {
      map['matiere'] = Variable<String>(matiere.value);
    }
    if (coefficient.present) {
      map['coefficient'] = Variable<double>(coefficient.value);
    }
    if (versionSource.present) {
      map['version_source'] = Variable<String>(versionSource.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoefficientRefsCompanion(')
          ..write('id: $id, ')
          ..write('niveau: $niveau, ')
          ..write('serie: $serie, ')
          ..write('matiere: $matiere, ')
          ..write('coefficient: $coefficient, ')
          ..write('versionSource: $versionSource')
          ..write(')'))
        .toString();
  }
}

class $MatieresTable extends Matieres with TableInfo<$MatieresTable, Matiere> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatieresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _eleveIdMeta = const VerificationMeta(
    'eleveId',
  );
  @override
  late final GeneratedColumn<int> eleveId = GeneratedColumn<int>(
    'eleve_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES eleve (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serieMeta = const VerificationMeta('serie');
  @override
  late final GeneratedColumn<String> serie = GeneratedColumn<String>(
    'serie',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coefficientMeta = const VerificationMeta(
    'coefficient',
  );
  @override
  late final GeneratedColumn<double> coefficient = GeneratedColumn<double>(
    'coefficient',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, eleveId, nom, serie, coefficient];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'matiere';
  @override
  VerificationContext validateIntegrity(
    Insertable<Matiere> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('eleve_id')) {
      context.handle(
        _eleveIdMeta,
        eleveId.isAcceptableOrUnknown(data['eleve_id']!, _eleveIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eleveIdMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('serie')) {
      context.handle(
        _serieMeta,
        serie.isAcceptableOrUnknown(data['serie']!, _serieMeta),
      );
    } else if (isInserting) {
      context.missing(_serieMeta);
    }
    if (data.containsKey('coefficient')) {
      context.handle(
        _coefficientMeta,
        coefficient.isAcceptableOrUnknown(
          data['coefficient']!,
          _coefficientMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coefficientMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Matiere map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Matiere(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eleveId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}eleve_id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      serie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serie'],
      )!,
      coefficient: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}coefficient'],
      )!,
    );
  }

  @override
  $MatieresTable createAlias(String alias) {
    return $MatieresTable(attachedDatabase, alias);
  }
}

class Matiere extends DataClass implements Insertable<Matiere> {
  final int id;
  final int eleveId;
  final String nom;
  final String serie;
  final double coefficient;
  const Matiere({
    required this.id,
    required this.eleveId,
    required this.nom,
    required this.serie,
    required this.coefficient,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['eleve_id'] = Variable<int>(eleveId);
    map['nom'] = Variable<String>(nom);
    map['serie'] = Variable<String>(serie);
    map['coefficient'] = Variable<double>(coefficient);
    return map;
  }

  MatieresCompanion toCompanion(bool nullToAbsent) {
    return MatieresCompanion(
      id: Value(id),
      eleveId: Value(eleveId),
      nom: Value(nom),
      serie: Value(serie),
      coefficient: Value(coefficient),
    );
  }

  factory Matiere.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Matiere(
      id: serializer.fromJson<int>(json['id']),
      eleveId: serializer.fromJson<int>(json['eleveId']),
      nom: serializer.fromJson<String>(json['nom']),
      serie: serializer.fromJson<String>(json['serie']),
      coefficient: serializer.fromJson<double>(json['coefficient']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eleveId': serializer.toJson<int>(eleveId),
      'nom': serializer.toJson<String>(nom),
      'serie': serializer.toJson<String>(serie),
      'coefficient': serializer.toJson<double>(coefficient),
    };
  }

  Matiere copyWith({
    int? id,
    int? eleveId,
    String? nom,
    String? serie,
    double? coefficient,
  }) => Matiere(
    id: id ?? this.id,
    eleveId: eleveId ?? this.eleveId,
    nom: nom ?? this.nom,
    serie: serie ?? this.serie,
    coefficient: coefficient ?? this.coefficient,
  );
  Matiere copyWithCompanion(MatieresCompanion data) {
    return Matiere(
      id: data.id.present ? data.id.value : this.id,
      eleveId: data.eleveId.present ? data.eleveId.value : this.eleveId,
      nom: data.nom.present ? data.nom.value : this.nom,
      serie: data.serie.present ? data.serie.value : this.serie,
      coefficient: data.coefficient.present
          ? data.coefficient.value
          : this.coefficient,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Matiere(')
          ..write('id: $id, ')
          ..write('eleveId: $eleveId, ')
          ..write('nom: $nom, ')
          ..write('serie: $serie, ')
          ..write('coefficient: $coefficient')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eleveId, nom, serie, coefficient);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Matiere &&
          other.id == this.id &&
          other.eleveId == this.eleveId &&
          other.nom == this.nom &&
          other.serie == this.serie &&
          other.coefficient == this.coefficient);
}

class MatieresCompanion extends UpdateCompanion<Matiere> {
  final Value<int> id;
  final Value<int> eleveId;
  final Value<String> nom;
  final Value<String> serie;
  final Value<double> coefficient;
  const MatieresCompanion({
    this.id = const Value.absent(),
    this.eleveId = const Value.absent(),
    this.nom = const Value.absent(),
    this.serie = const Value.absent(),
    this.coefficient = const Value.absent(),
  });
  MatieresCompanion.insert({
    this.id = const Value.absent(),
    required int eleveId,
    required String nom,
    required String serie,
    required double coefficient,
  }) : eleveId = Value(eleveId),
       nom = Value(nom),
       serie = Value(serie),
       coefficient = Value(coefficient);
  static Insertable<Matiere> custom({
    Expression<int>? id,
    Expression<int>? eleveId,
    Expression<String>? nom,
    Expression<String>? serie,
    Expression<double>? coefficient,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eleveId != null) 'eleve_id': eleveId,
      if (nom != null) 'nom': nom,
      if (serie != null) 'serie': serie,
      if (coefficient != null) 'coefficient': coefficient,
    });
  }

  MatieresCompanion copyWith({
    Value<int>? id,
    Value<int>? eleveId,
    Value<String>? nom,
    Value<String>? serie,
    Value<double>? coefficient,
  }) {
    return MatieresCompanion(
      id: id ?? this.id,
      eleveId: eleveId ?? this.eleveId,
      nom: nom ?? this.nom,
      serie: serie ?? this.serie,
      coefficient: coefficient ?? this.coefficient,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eleveId.present) {
      map['eleve_id'] = Variable<int>(eleveId.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (serie.present) {
      map['serie'] = Variable<String>(serie.value);
    }
    if (coefficient.present) {
      map['coefficient'] = Variable<double>(coefficient.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatieresCompanion(')
          ..write('id: $id, ')
          ..write('eleveId: $eleveId, ')
          ..write('nom: $nom, ')
          ..write('serie: $serie, ')
          ..write('coefficient: $coefficient')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _matiereIdMeta = const VerificationMeta(
    'matiereId',
  );
  @override
  late final GeneratedColumn<int> matiereId = GeneratedColumn<int>(
    'matiere_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES matiere (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeEvalMeta = const VerificationMeta(
    'typeEval',
  );
  @override
  late final GeneratedColumn<String> typeEval = GeneratedColumn<String>(
    'type_eval',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valeurMeta = const VerificationMeta('valeur');
  @override
  late final GeneratedColumn<double> valeur = GeneratedColumn<double>(
    'valeur',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baremeMeta = const VerificationMeta('bareme');
  @override
  late final GeneratedColumn<double> bareme = GeneratedColumn<double>(
    'bareme',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(20.0),
  );
  static const VerificationMeta _periodeMeta = const VerificationMeta(
    'periode',
  );
  @override
  late final GeneratedColumn<String> periode = GeneratedColumn<String>(
    'periode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    matiereId,
    typeEval,
    valeur,
    bareme,
    periode,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'note';
  @override
  VerificationContext validateIntegrity(
    Insertable<Note> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('matiere_id')) {
      context.handle(
        _matiereIdMeta,
        matiereId.isAcceptableOrUnknown(data['matiere_id']!, _matiereIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matiereIdMeta);
    }
    if (data.containsKey('type_eval')) {
      context.handle(
        _typeEvalMeta,
        typeEval.isAcceptableOrUnknown(data['type_eval']!, _typeEvalMeta),
      );
    } else if (isInserting) {
      context.missing(_typeEvalMeta);
    }
    if (data.containsKey('valeur')) {
      context.handle(
        _valeurMeta,
        valeur.isAcceptableOrUnknown(data['valeur']!, _valeurMeta),
      );
    } else if (isInserting) {
      context.missing(_valeurMeta);
    }
    if (data.containsKey('bareme')) {
      context.handle(
        _baremeMeta,
        bareme.isAcceptableOrUnknown(data['bareme']!, _baremeMeta),
      );
    }
    if (data.containsKey('periode')) {
      context.handle(
        _periodeMeta,
        periode.isAcceptableOrUnknown(data['periode']!, _periodeMeta),
      );
    } else if (isInserting) {
      context.missing(_periodeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      matiereId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}matiere_id'],
      )!,
      typeEval: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_eval'],
      )!,
      valeur: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}valeur'],
      )!,
      bareme: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bareme'],
      )!,
      periode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}periode'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final int id;
  final int matiereId;
  final String typeEval;
  final double valeur;
  final double bareme;
  final String periode;
  final String date;
  const Note({
    required this.id,
    required this.matiereId,
    required this.typeEval,
    required this.valeur,
    required this.bareme,
    required this.periode,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['matiere_id'] = Variable<int>(matiereId);
    map['type_eval'] = Variable<String>(typeEval);
    map['valeur'] = Variable<double>(valeur);
    map['bareme'] = Variable<double>(bareme);
    map['periode'] = Variable<String>(periode);
    map['date'] = Variable<String>(date);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      matiereId: Value(matiereId),
      typeEval: Value(typeEval),
      valeur: Value(valeur),
      bareme: Value(bareme),
      periode: Value(periode),
      date: Value(date),
    );
  }

  factory Note.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      matiereId: serializer.fromJson<int>(json['matiereId']),
      typeEval: serializer.fromJson<String>(json['typeEval']),
      valeur: serializer.fromJson<double>(json['valeur']),
      bareme: serializer.fromJson<double>(json['bareme']),
      periode: serializer.fromJson<String>(json['periode']),
      date: serializer.fromJson<String>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matiereId': serializer.toJson<int>(matiereId),
      'typeEval': serializer.toJson<String>(typeEval),
      'valeur': serializer.toJson<double>(valeur),
      'bareme': serializer.toJson<double>(bareme),
      'periode': serializer.toJson<String>(periode),
      'date': serializer.toJson<String>(date),
    };
  }

  Note copyWith({
    int? id,
    int? matiereId,
    String? typeEval,
    double? valeur,
    double? bareme,
    String? periode,
    String? date,
  }) => Note(
    id: id ?? this.id,
    matiereId: matiereId ?? this.matiereId,
    typeEval: typeEval ?? this.typeEval,
    valeur: valeur ?? this.valeur,
    bareme: bareme ?? this.bareme,
    periode: periode ?? this.periode,
    date: date ?? this.date,
  );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      matiereId: data.matiereId.present ? data.matiereId.value : this.matiereId,
      typeEval: data.typeEval.present ? data.typeEval.value : this.typeEval,
      valeur: data.valeur.present ? data.valeur.value : this.valeur,
      bareme: data.bareme.present ? data.bareme.value : this.bareme,
      periode: data.periode.present ? data.periode.value : this.periode,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('matiereId: $matiereId, ')
          ..write('typeEval: $typeEval, ')
          ..write('valeur: $valeur, ')
          ..write('bareme: $bareme, ')
          ..write('periode: $periode, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, matiereId, typeEval, valeur, bareme, periode, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.matiereId == this.matiereId &&
          other.typeEval == this.typeEval &&
          other.valeur == this.valeur &&
          other.bareme == this.bareme &&
          other.periode == this.periode &&
          other.date == this.date);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<int> matiereId;
  final Value<String> typeEval;
  final Value<double> valeur;
  final Value<double> bareme;
  final Value<String> periode;
  final Value<String> date;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.matiereId = const Value.absent(),
    this.typeEval = const Value.absent(),
    this.valeur = const Value.absent(),
    this.bareme = const Value.absent(),
    this.periode = const Value.absent(),
    this.date = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    required int matiereId,
    required String typeEval,
    required double valeur,
    this.bareme = const Value.absent(),
    required String periode,
    required String date,
  }) : matiereId = Value(matiereId),
       typeEval = Value(typeEval),
       valeur = Value(valeur),
       periode = Value(periode),
       date = Value(date);
  static Insertable<Note> custom({
    Expression<int>? id,
    Expression<int>? matiereId,
    Expression<String>? typeEval,
    Expression<double>? valeur,
    Expression<double>? bareme,
    Expression<String>? periode,
    Expression<String>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matiereId != null) 'matiere_id': matiereId,
      if (typeEval != null) 'type_eval': typeEval,
      if (valeur != null) 'valeur': valeur,
      if (bareme != null) 'bareme': bareme,
      if (periode != null) 'periode': periode,
      if (date != null) 'date': date,
    });
  }

  NotesCompanion copyWith({
    Value<int>? id,
    Value<int>? matiereId,
    Value<String>? typeEval,
    Value<double>? valeur,
    Value<double>? bareme,
    Value<String>? periode,
    Value<String>? date,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      matiereId: matiereId ?? this.matiereId,
      typeEval: typeEval ?? this.typeEval,
      valeur: valeur ?? this.valeur,
      bareme: bareme ?? this.bareme,
      periode: periode ?? this.periode,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matiereId.present) {
      map['matiere_id'] = Variable<int>(matiereId.value);
    }
    if (typeEval.present) {
      map['type_eval'] = Variable<String>(typeEval.value);
    }
    if (valeur.present) {
      map['valeur'] = Variable<double>(valeur.value);
    }
    if (bareme.present) {
      map['bareme'] = Variable<double>(bareme.value);
    }
    if (periode.present) {
      map['periode'] = Variable<String>(periode.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('matiereId: $matiereId, ')
          ..write('typeEval: $typeEval, ')
          ..write('valeur: $valeur, ')
          ..write('bareme: $bareme, ')
          ..write('periode: $periode, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $CoursEdtsTable extends CoursEdts
    with TableInfo<$CoursEdtsTable, CoursEdt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursEdtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _eleveIdMeta = const VerificationMeta(
    'eleveId',
  );
  @override
  late final GeneratedColumn<int> eleveId = GeneratedColumn<int>(
    'eleve_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES eleve (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _jourMeta = const VerificationMeta('jour');
  @override
  late final GeneratedColumn<String> jour = GeneratedColumn<String>(
    'jour',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creneauDebutMeta = const VerificationMeta(
    'creneauDebut',
  );
  @override
  late final GeneratedColumn<String> creneauDebut = GeneratedColumn<String>(
    'creneau_debut',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creneauFinMeta = const VerificationMeta(
    'creneauFin',
  );
  @override
  late final GeneratedColumn<String> creneauFin = GeneratedColumn<String>(
    'creneau_fin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _matiereMeta = const VerificationMeta(
    'matiere',
  );
  @override
  late final GeneratedColumn<String> matiere = GeneratedColumn<String>(
    'matiere',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _salleMeta = const VerificationMeta('salle');
  @override
  late final GeneratedColumn<String> salle = GeneratedColumn<String>(
    'salle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eleveId,
    jour,
    creneauDebut,
    creneauFin,
    matiere,
    salle,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cours_edt';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoursEdt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('eleve_id')) {
      context.handle(
        _eleveIdMeta,
        eleveId.isAcceptableOrUnknown(data['eleve_id']!, _eleveIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eleveIdMeta);
    }
    if (data.containsKey('jour')) {
      context.handle(
        _jourMeta,
        jour.isAcceptableOrUnknown(data['jour']!, _jourMeta),
      );
    } else if (isInserting) {
      context.missing(_jourMeta);
    }
    if (data.containsKey('creneau_debut')) {
      context.handle(
        _creneauDebutMeta,
        creneauDebut.isAcceptableOrUnknown(
          data['creneau_debut']!,
          _creneauDebutMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creneauDebutMeta);
    }
    if (data.containsKey('creneau_fin')) {
      context.handle(
        _creneauFinMeta,
        creneauFin.isAcceptableOrUnknown(data['creneau_fin']!, _creneauFinMeta),
      );
    } else if (isInserting) {
      context.missing(_creneauFinMeta);
    }
    if (data.containsKey('matiere')) {
      context.handle(
        _matiereMeta,
        matiere.isAcceptableOrUnknown(data['matiere']!, _matiereMeta),
      );
    } else if (isInserting) {
      context.missing(_matiereMeta);
    }
    if (data.containsKey('salle')) {
      context.handle(
        _salleMeta,
        salle.isAcceptableOrUnknown(data['salle']!, _salleMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CoursEdt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoursEdt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eleveId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}eleve_id'],
      )!,
      jour: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jour'],
      )!,
      creneauDebut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creneau_debut'],
      )!,
      creneauFin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creneau_fin'],
      )!,
      matiere: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matiere'],
      )!,
      salle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}salle'],
      ),
    );
  }

  @override
  $CoursEdtsTable createAlias(String alias) {
    return $CoursEdtsTable(attachedDatabase, alias);
  }
}

class CoursEdt extends DataClass implements Insertable<CoursEdt> {
  final int id;
  final int eleveId;
  final String jour;
  final String creneauDebut;
  final String creneauFin;
  final String matiere;
  final String? salle;
  const CoursEdt({
    required this.id,
    required this.eleveId,
    required this.jour,
    required this.creneauDebut,
    required this.creneauFin,
    required this.matiere,
    this.salle,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['eleve_id'] = Variable<int>(eleveId);
    map['jour'] = Variable<String>(jour);
    map['creneau_debut'] = Variable<String>(creneauDebut);
    map['creneau_fin'] = Variable<String>(creneauFin);
    map['matiere'] = Variable<String>(matiere);
    if (!nullToAbsent || salle != null) {
      map['salle'] = Variable<String>(salle);
    }
    return map;
  }

  CoursEdtsCompanion toCompanion(bool nullToAbsent) {
    return CoursEdtsCompanion(
      id: Value(id),
      eleveId: Value(eleveId),
      jour: Value(jour),
      creneauDebut: Value(creneauDebut),
      creneauFin: Value(creneauFin),
      matiere: Value(matiere),
      salle: salle == null && nullToAbsent
          ? const Value.absent()
          : Value(salle),
    );
  }

  factory CoursEdt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoursEdt(
      id: serializer.fromJson<int>(json['id']),
      eleveId: serializer.fromJson<int>(json['eleveId']),
      jour: serializer.fromJson<String>(json['jour']),
      creneauDebut: serializer.fromJson<String>(json['creneauDebut']),
      creneauFin: serializer.fromJson<String>(json['creneauFin']),
      matiere: serializer.fromJson<String>(json['matiere']),
      salle: serializer.fromJson<String?>(json['salle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eleveId': serializer.toJson<int>(eleveId),
      'jour': serializer.toJson<String>(jour),
      'creneauDebut': serializer.toJson<String>(creneauDebut),
      'creneauFin': serializer.toJson<String>(creneauFin),
      'matiere': serializer.toJson<String>(matiere),
      'salle': serializer.toJson<String?>(salle),
    };
  }

  CoursEdt copyWith({
    int? id,
    int? eleveId,
    String? jour,
    String? creneauDebut,
    String? creneauFin,
    String? matiere,
    Value<String?> salle = const Value.absent(),
  }) => CoursEdt(
    id: id ?? this.id,
    eleveId: eleveId ?? this.eleveId,
    jour: jour ?? this.jour,
    creneauDebut: creneauDebut ?? this.creneauDebut,
    creneauFin: creneauFin ?? this.creneauFin,
    matiere: matiere ?? this.matiere,
    salle: salle.present ? salle.value : this.salle,
  );
  CoursEdt copyWithCompanion(CoursEdtsCompanion data) {
    return CoursEdt(
      id: data.id.present ? data.id.value : this.id,
      eleveId: data.eleveId.present ? data.eleveId.value : this.eleveId,
      jour: data.jour.present ? data.jour.value : this.jour,
      creneauDebut: data.creneauDebut.present
          ? data.creneauDebut.value
          : this.creneauDebut,
      creneauFin: data.creneauFin.present
          ? data.creneauFin.value
          : this.creneauFin,
      matiere: data.matiere.present ? data.matiere.value : this.matiere,
      salle: data.salle.present ? data.salle.value : this.salle,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoursEdt(')
          ..write('id: $id, ')
          ..write('eleveId: $eleveId, ')
          ..write('jour: $jour, ')
          ..write('creneauDebut: $creneauDebut, ')
          ..write('creneauFin: $creneauFin, ')
          ..write('matiere: $matiere, ')
          ..write('salle: $salle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, eleveId, jour, creneauDebut, creneauFin, matiere, salle);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoursEdt &&
          other.id == this.id &&
          other.eleveId == this.eleveId &&
          other.jour == this.jour &&
          other.creneauDebut == this.creneauDebut &&
          other.creneauFin == this.creneauFin &&
          other.matiere == this.matiere &&
          other.salle == this.salle);
}

class CoursEdtsCompanion extends UpdateCompanion<CoursEdt> {
  final Value<int> id;
  final Value<int> eleveId;
  final Value<String> jour;
  final Value<String> creneauDebut;
  final Value<String> creneauFin;
  final Value<String> matiere;
  final Value<String?> salle;
  const CoursEdtsCompanion({
    this.id = const Value.absent(),
    this.eleveId = const Value.absent(),
    this.jour = const Value.absent(),
    this.creneauDebut = const Value.absent(),
    this.creneauFin = const Value.absent(),
    this.matiere = const Value.absent(),
    this.salle = const Value.absent(),
  });
  CoursEdtsCompanion.insert({
    this.id = const Value.absent(),
    required int eleveId,
    required String jour,
    required String creneauDebut,
    required String creneauFin,
    required String matiere,
    this.salle = const Value.absent(),
  }) : eleveId = Value(eleveId),
       jour = Value(jour),
       creneauDebut = Value(creneauDebut),
       creneauFin = Value(creneauFin),
       matiere = Value(matiere);
  static Insertable<CoursEdt> custom({
    Expression<int>? id,
    Expression<int>? eleveId,
    Expression<String>? jour,
    Expression<String>? creneauDebut,
    Expression<String>? creneauFin,
    Expression<String>? matiere,
    Expression<String>? salle,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eleveId != null) 'eleve_id': eleveId,
      if (jour != null) 'jour': jour,
      if (creneauDebut != null) 'creneau_debut': creneauDebut,
      if (creneauFin != null) 'creneau_fin': creneauFin,
      if (matiere != null) 'matiere': matiere,
      if (salle != null) 'salle': salle,
    });
  }

  CoursEdtsCompanion copyWith({
    Value<int>? id,
    Value<int>? eleveId,
    Value<String>? jour,
    Value<String>? creneauDebut,
    Value<String>? creneauFin,
    Value<String>? matiere,
    Value<String?>? salle,
  }) {
    return CoursEdtsCompanion(
      id: id ?? this.id,
      eleveId: eleveId ?? this.eleveId,
      jour: jour ?? this.jour,
      creneauDebut: creneauDebut ?? this.creneauDebut,
      creneauFin: creneauFin ?? this.creneauFin,
      matiere: matiere ?? this.matiere,
      salle: salle ?? this.salle,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eleveId.present) {
      map['eleve_id'] = Variable<int>(eleveId.value);
    }
    if (jour.present) {
      map['jour'] = Variable<String>(jour.value);
    }
    if (creneauDebut.present) {
      map['creneau_debut'] = Variable<String>(creneauDebut.value);
    }
    if (creneauFin.present) {
      map['creneau_fin'] = Variable<String>(creneauFin.value);
    }
    if (matiere.present) {
      map['matiere'] = Variable<String>(matiere.value);
    }
    if (salle.present) {
      map['salle'] = Variable<String>(salle.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursEdtsCompanion(')
          ..write('id: $id, ')
          ..write('eleveId: $eleveId, ')
          ..write('jour: $jour, ')
          ..write('creneauDebut: $creneauDebut, ')
          ..write('creneauFin: $creneauFin, ')
          ..write('matiere: $matiere, ')
          ..write('salle: $salle')
          ..write(')'))
        .toString();
  }
}

class $SeanceEtudesTable extends SeanceEtudes
    with TableInfo<$SeanceEtudesTable, SeanceEtude> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeanceEtudesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _eleveIdMeta = const VerificationMeta(
    'eleveId',
  );
  @override
  late final GeneratedColumn<int> eleveId = GeneratedColumn<int>(
    'eleve_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES eleve (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _matiereMeta = const VerificationMeta(
    'matiere',
  );
  @override
  late final GeneratedColumn<String> matiere = GeneratedColumn<String>(
    'matiere',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heureDebutMeta = const VerificationMeta(
    'heureDebut',
  );
  @override
  late final GeneratedColumn<String> heureDebut = GeneratedColumn<String>(
    'heure_debut',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dureeMinMeta = const VerificationMeta(
    'dureeMin',
  );
  @override
  late final GeneratedColumn<int> dureeMin = GeneratedColumn<int>(
    'duree_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _objectifMeta = const VerificationMeta(
    'objectif',
  );
  @override
  late final GeneratedColumn<String> objectif = GeneratedColumn<String>(
    'objectif',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recurrenceMeta = const VerificationMeta(
    'recurrence',
  );
  @override
  late final GeneratedColumn<String> recurrence = GeneratedColumn<String>(
    'recurrence',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pausesMeta = const VerificationMeta('pauses');
  @override
  late final GeneratedColumn<int> pauses = GeneratedColumn<int>(
    'pauses',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _termineMeta = const VerificationMeta(
    'termine',
  );
  @override
  late final GeneratedColumn<bool> termine = GeneratedColumn<bool>(
    'termine',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("termine" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eleveId,
    matiere,
    date,
    heureDebut,
    dureeMin,
    objectif,
    recurrence,
    pauses,
    termine,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'seance_etude';
  @override
  VerificationContext validateIntegrity(
    Insertable<SeanceEtude> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('eleve_id')) {
      context.handle(
        _eleveIdMeta,
        eleveId.isAcceptableOrUnknown(data['eleve_id']!, _eleveIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eleveIdMeta);
    }
    if (data.containsKey('matiere')) {
      context.handle(
        _matiereMeta,
        matiere.isAcceptableOrUnknown(data['matiere']!, _matiereMeta),
      );
    } else if (isInserting) {
      context.missing(_matiereMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('heure_debut')) {
      context.handle(
        _heureDebutMeta,
        heureDebut.isAcceptableOrUnknown(data['heure_debut']!, _heureDebutMeta),
      );
    } else if (isInserting) {
      context.missing(_heureDebutMeta);
    }
    if (data.containsKey('duree_min')) {
      context.handle(
        _dureeMinMeta,
        dureeMin.isAcceptableOrUnknown(data['duree_min']!, _dureeMinMeta),
      );
    } else if (isInserting) {
      context.missing(_dureeMinMeta);
    }
    if (data.containsKey('objectif')) {
      context.handle(
        _objectifMeta,
        objectif.isAcceptableOrUnknown(data['objectif']!, _objectifMeta),
      );
    }
    if (data.containsKey('recurrence')) {
      context.handle(
        _recurrenceMeta,
        recurrence.isAcceptableOrUnknown(data['recurrence']!, _recurrenceMeta),
      );
    }
    if (data.containsKey('pauses')) {
      context.handle(
        _pausesMeta,
        pauses.isAcceptableOrUnknown(data['pauses']!, _pausesMeta),
      );
    }
    if (data.containsKey('termine')) {
      context.handle(
        _termineMeta,
        termine.isAcceptableOrUnknown(data['termine']!, _termineMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SeanceEtude map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SeanceEtude(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eleveId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}eleve_id'],
      )!,
      matiere: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matiere'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      heureDebut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}heure_debut'],
      )!,
      dureeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duree_min'],
      )!,
      objectif: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}objectif'],
      ),
      recurrence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence'],
      ),
      pauses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pauses'],
      )!,
      termine: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}termine'],
      )!,
    );
  }

  @override
  $SeanceEtudesTable createAlias(String alias) {
    return $SeanceEtudesTable(attachedDatabase, alias);
  }
}

class SeanceEtude extends DataClass implements Insertable<SeanceEtude> {
  final int id;
  final int eleveId;
  final String matiere;
  final String date;
  final String heureDebut;
  final int dureeMin;
  final String? objectif;
  final String? recurrence;
  final int pauses;
  final bool termine;
  const SeanceEtude({
    required this.id,
    required this.eleveId,
    required this.matiere,
    required this.date,
    required this.heureDebut,
    required this.dureeMin,
    this.objectif,
    this.recurrence,
    required this.pauses,
    required this.termine,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['eleve_id'] = Variable<int>(eleveId);
    map['matiere'] = Variable<String>(matiere);
    map['date'] = Variable<String>(date);
    map['heure_debut'] = Variable<String>(heureDebut);
    map['duree_min'] = Variable<int>(dureeMin);
    if (!nullToAbsent || objectif != null) {
      map['objectif'] = Variable<String>(objectif);
    }
    if (!nullToAbsent || recurrence != null) {
      map['recurrence'] = Variable<String>(recurrence);
    }
    map['pauses'] = Variable<int>(pauses);
    map['termine'] = Variable<bool>(termine);
    return map;
  }

  SeanceEtudesCompanion toCompanion(bool nullToAbsent) {
    return SeanceEtudesCompanion(
      id: Value(id),
      eleveId: Value(eleveId),
      matiere: Value(matiere),
      date: Value(date),
      heureDebut: Value(heureDebut),
      dureeMin: Value(dureeMin),
      objectif: objectif == null && nullToAbsent
          ? const Value.absent()
          : Value(objectif),
      recurrence: recurrence == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrence),
      pauses: Value(pauses),
      termine: Value(termine),
    );
  }

  factory SeanceEtude.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SeanceEtude(
      id: serializer.fromJson<int>(json['id']),
      eleveId: serializer.fromJson<int>(json['eleveId']),
      matiere: serializer.fromJson<String>(json['matiere']),
      date: serializer.fromJson<String>(json['date']),
      heureDebut: serializer.fromJson<String>(json['heureDebut']),
      dureeMin: serializer.fromJson<int>(json['dureeMin']),
      objectif: serializer.fromJson<String?>(json['objectif']),
      recurrence: serializer.fromJson<String?>(json['recurrence']),
      pauses: serializer.fromJson<int>(json['pauses']),
      termine: serializer.fromJson<bool>(json['termine']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eleveId': serializer.toJson<int>(eleveId),
      'matiere': serializer.toJson<String>(matiere),
      'date': serializer.toJson<String>(date),
      'heureDebut': serializer.toJson<String>(heureDebut),
      'dureeMin': serializer.toJson<int>(dureeMin),
      'objectif': serializer.toJson<String?>(objectif),
      'recurrence': serializer.toJson<String?>(recurrence),
      'pauses': serializer.toJson<int>(pauses),
      'termine': serializer.toJson<bool>(termine),
    };
  }

  SeanceEtude copyWith({
    int? id,
    int? eleveId,
    String? matiere,
    String? date,
    String? heureDebut,
    int? dureeMin,
    Value<String?> objectif = const Value.absent(),
    Value<String?> recurrence = const Value.absent(),
    int? pauses,
    bool? termine,
  }) => SeanceEtude(
    id: id ?? this.id,
    eleveId: eleveId ?? this.eleveId,
    matiere: matiere ?? this.matiere,
    date: date ?? this.date,
    heureDebut: heureDebut ?? this.heureDebut,
    dureeMin: dureeMin ?? this.dureeMin,
    objectif: objectif.present ? objectif.value : this.objectif,
    recurrence: recurrence.present ? recurrence.value : this.recurrence,
    pauses: pauses ?? this.pauses,
    termine: termine ?? this.termine,
  );
  SeanceEtude copyWithCompanion(SeanceEtudesCompanion data) {
    return SeanceEtude(
      id: data.id.present ? data.id.value : this.id,
      eleveId: data.eleveId.present ? data.eleveId.value : this.eleveId,
      matiere: data.matiere.present ? data.matiere.value : this.matiere,
      date: data.date.present ? data.date.value : this.date,
      heureDebut: data.heureDebut.present
          ? data.heureDebut.value
          : this.heureDebut,
      dureeMin: data.dureeMin.present ? data.dureeMin.value : this.dureeMin,
      objectif: data.objectif.present ? data.objectif.value : this.objectif,
      recurrence: data.recurrence.present
          ? data.recurrence.value
          : this.recurrence,
      pauses: data.pauses.present ? data.pauses.value : this.pauses,
      termine: data.termine.present ? data.termine.value : this.termine,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SeanceEtude(')
          ..write('id: $id, ')
          ..write('eleveId: $eleveId, ')
          ..write('matiere: $matiere, ')
          ..write('date: $date, ')
          ..write('heureDebut: $heureDebut, ')
          ..write('dureeMin: $dureeMin, ')
          ..write('objectif: $objectif, ')
          ..write('recurrence: $recurrence, ')
          ..write('pauses: $pauses, ')
          ..write('termine: $termine')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eleveId,
    matiere,
    date,
    heureDebut,
    dureeMin,
    objectif,
    recurrence,
    pauses,
    termine,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SeanceEtude &&
          other.id == this.id &&
          other.eleveId == this.eleveId &&
          other.matiere == this.matiere &&
          other.date == this.date &&
          other.heureDebut == this.heureDebut &&
          other.dureeMin == this.dureeMin &&
          other.objectif == this.objectif &&
          other.recurrence == this.recurrence &&
          other.pauses == this.pauses &&
          other.termine == this.termine);
}

class SeanceEtudesCompanion extends UpdateCompanion<SeanceEtude> {
  final Value<int> id;
  final Value<int> eleveId;
  final Value<String> matiere;
  final Value<String> date;
  final Value<String> heureDebut;
  final Value<int> dureeMin;
  final Value<String?> objectif;
  final Value<String?> recurrence;
  final Value<int> pauses;
  final Value<bool> termine;
  const SeanceEtudesCompanion({
    this.id = const Value.absent(),
    this.eleveId = const Value.absent(),
    this.matiere = const Value.absent(),
    this.date = const Value.absent(),
    this.heureDebut = const Value.absent(),
    this.dureeMin = const Value.absent(),
    this.objectif = const Value.absent(),
    this.recurrence = const Value.absent(),
    this.pauses = const Value.absent(),
    this.termine = const Value.absent(),
  });
  SeanceEtudesCompanion.insert({
    this.id = const Value.absent(),
    required int eleveId,
    required String matiere,
    required String date,
    required String heureDebut,
    required int dureeMin,
    this.objectif = const Value.absent(),
    this.recurrence = const Value.absent(),
    this.pauses = const Value.absent(),
    this.termine = const Value.absent(),
  }) : eleveId = Value(eleveId),
       matiere = Value(matiere),
       date = Value(date),
       heureDebut = Value(heureDebut),
       dureeMin = Value(dureeMin);
  static Insertable<SeanceEtude> custom({
    Expression<int>? id,
    Expression<int>? eleveId,
    Expression<String>? matiere,
    Expression<String>? date,
    Expression<String>? heureDebut,
    Expression<int>? dureeMin,
    Expression<String>? objectif,
    Expression<String>? recurrence,
    Expression<int>? pauses,
    Expression<bool>? termine,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eleveId != null) 'eleve_id': eleveId,
      if (matiere != null) 'matiere': matiere,
      if (date != null) 'date': date,
      if (heureDebut != null) 'heure_debut': heureDebut,
      if (dureeMin != null) 'duree_min': dureeMin,
      if (objectif != null) 'objectif': objectif,
      if (recurrence != null) 'recurrence': recurrence,
      if (pauses != null) 'pauses': pauses,
      if (termine != null) 'termine': termine,
    });
  }

  SeanceEtudesCompanion copyWith({
    Value<int>? id,
    Value<int>? eleveId,
    Value<String>? matiere,
    Value<String>? date,
    Value<String>? heureDebut,
    Value<int>? dureeMin,
    Value<String?>? objectif,
    Value<String?>? recurrence,
    Value<int>? pauses,
    Value<bool>? termine,
  }) {
    return SeanceEtudesCompanion(
      id: id ?? this.id,
      eleveId: eleveId ?? this.eleveId,
      matiere: matiere ?? this.matiere,
      date: date ?? this.date,
      heureDebut: heureDebut ?? this.heureDebut,
      dureeMin: dureeMin ?? this.dureeMin,
      objectif: objectif ?? this.objectif,
      recurrence: recurrence ?? this.recurrence,
      pauses: pauses ?? this.pauses,
      termine: termine ?? this.termine,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eleveId.present) {
      map['eleve_id'] = Variable<int>(eleveId.value);
    }
    if (matiere.present) {
      map['matiere'] = Variable<String>(matiere.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (heureDebut.present) {
      map['heure_debut'] = Variable<String>(heureDebut.value);
    }
    if (dureeMin.present) {
      map['duree_min'] = Variable<int>(dureeMin.value);
    }
    if (objectif.present) {
      map['objectif'] = Variable<String>(objectif.value);
    }
    if (recurrence.present) {
      map['recurrence'] = Variable<String>(recurrence.value);
    }
    if (pauses.present) {
      map['pauses'] = Variable<int>(pauses.value);
    }
    if (termine.present) {
      map['termine'] = Variable<bool>(termine.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeanceEtudesCompanion(')
          ..write('id: $id, ')
          ..write('eleveId: $eleveId, ')
          ..write('matiere: $matiere, ')
          ..write('date: $date, ')
          ..write('heureDebut: $heureDebut, ')
          ..write('dureeMin: $dureeMin, ')
          ..write('objectif: $objectif, ')
          ..write('recurrence: $recurrence, ')
          ..write('pauses: $pauses, ')
          ..write('termine: $termine')
          ..write(')'))
        .toString();
  }
}

class $NotificationConfigsTable extends NotificationConfigs
    with TableInfo<$NotificationConfigsTable, NotificationConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cibleTypeMeta = const VerificationMeta(
    'cibleType',
  );
  @override
  late final GeneratedColumn<String> cibleType = GeneratedColumn<String>(
    'cible_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cibleIdMeta = const VerificationMeta(
    'cibleId',
  );
  @override
  late final GeneratedColumn<int> cibleId = GeneratedColumn<int>(
    'cible_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _delaiMinMeta = const VerificationMeta(
    'delaiMin',
  );
  @override
  late final GeneratedColumn<int> delaiMin = GeneratedColumn<int>(
    'delai_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _heuresSilenceMeta = const VerificationMeta(
    'heuresSilence',
  );
  @override
  late final GeneratedColumn<String> heuresSilence = GeneratedColumn<String>(
    'heures_silence',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cibleType,
    cibleId,
    type,
    delaiMin,
    active,
    heuresSilence,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cible_type')) {
      context.handle(
        _cibleTypeMeta,
        cibleType.isAcceptableOrUnknown(data['cible_type']!, _cibleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_cibleTypeMeta);
    }
    if (data.containsKey('cible_id')) {
      context.handle(
        _cibleIdMeta,
        cibleId.isAcceptableOrUnknown(data['cible_id']!, _cibleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cibleIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('delai_min')) {
      context.handle(
        _delaiMinMeta,
        delaiMin.isAcceptableOrUnknown(data['delai_min']!, _delaiMinMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('heures_silence')) {
      context.handle(
        _heuresSilenceMeta,
        heuresSilence.isAcceptableOrUnknown(
          data['heures_silence']!,
          _heuresSilenceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cibleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cible_type'],
      )!,
      cibleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cible_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      delaiMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}delai_min'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      heuresSilence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}heures_silence'],
      ),
    );
  }

  @override
  $NotificationConfigsTable createAlias(String alias) {
    return $NotificationConfigsTable(attachedDatabase, alias);
  }
}

class NotificationConfig extends DataClass
    implements Insertable<NotificationConfig> {
  final int id;
  final String cibleType;
  final int cibleId;
  final String type;
  final int delaiMin;
  final bool active;
  final String? heuresSilence;
  const NotificationConfig({
    required this.id,
    required this.cibleType,
    required this.cibleId,
    required this.type,
    required this.delaiMin,
    required this.active,
    this.heuresSilence,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cible_type'] = Variable<String>(cibleType);
    map['cible_id'] = Variable<int>(cibleId);
    map['type'] = Variable<String>(type);
    map['delai_min'] = Variable<int>(delaiMin);
    map['active'] = Variable<bool>(active);
    if (!nullToAbsent || heuresSilence != null) {
      map['heures_silence'] = Variable<String>(heuresSilence);
    }
    return map;
  }

  NotificationConfigsCompanion toCompanion(bool nullToAbsent) {
    return NotificationConfigsCompanion(
      id: Value(id),
      cibleType: Value(cibleType),
      cibleId: Value(cibleId),
      type: Value(type),
      delaiMin: Value(delaiMin),
      active: Value(active),
      heuresSilence: heuresSilence == null && nullToAbsent
          ? const Value.absent()
          : Value(heuresSilence),
    );
  }

  factory NotificationConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationConfig(
      id: serializer.fromJson<int>(json['id']),
      cibleType: serializer.fromJson<String>(json['cibleType']),
      cibleId: serializer.fromJson<int>(json['cibleId']),
      type: serializer.fromJson<String>(json['type']),
      delaiMin: serializer.fromJson<int>(json['delaiMin']),
      active: serializer.fromJson<bool>(json['active']),
      heuresSilence: serializer.fromJson<String?>(json['heuresSilence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cibleType': serializer.toJson<String>(cibleType),
      'cibleId': serializer.toJson<int>(cibleId),
      'type': serializer.toJson<String>(type),
      'delaiMin': serializer.toJson<int>(delaiMin),
      'active': serializer.toJson<bool>(active),
      'heuresSilence': serializer.toJson<String?>(heuresSilence),
    };
  }

  NotificationConfig copyWith({
    int? id,
    String? cibleType,
    int? cibleId,
    String? type,
    int? delaiMin,
    bool? active,
    Value<String?> heuresSilence = const Value.absent(),
  }) => NotificationConfig(
    id: id ?? this.id,
    cibleType: cibleType ?? this.cibleType,
    cibleId: cibleId ?? this.cibleId,
    type: type ?? this.type,
    delaiMin: delaiMin ?? this.delaiMin,
    active: active ?? this.active,
    heuresSilence: heuresSilence.present
        ? heuresSilence.value
        : this.heuresSilence,
  );
  NotificationConfig copyWithCompanion(NotificationConfigsCompanion data) {
    return NotificationConfig(
      id: data.id.present ? data.id.value : this.id,
      cibleType: data.cibleType.present ? data.cibleType.value : this.cibleType,
      cibleId: data.cibleId.present ? data.cibleId.value : this.cibleId,
      type: data.type.present ? data.type.value : this.type,
      delaiMin: data.delaiMin.present ? data.delaiMin.value : this.delaiMin,
      active: data.active.present ? data.active.value : this.active,
      heuresSilence: data.heuresSilence.present
          ? data.heuresSilence.value
          : this.heuresSilence,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationConfig(')
          ..write('id: $id, ')
          ..write('cibleType: $cibleType, ')
          ..write('cibleId: $cibleId, ')
          ..write('type: $type, ')
          ..write('delaiMin: $delaiMin, ')
          ..write('active: $active, ')
          ..write('heuresSilence: $heuresSilence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cibleType,
    cibleId,
    type,
    delaiMin,
    active,
    heuresSilence,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationConfig &&
          other.id == this.id &&
          other.cibleType == this.cibleType &&
          other.cibleId == this.cibleId &&
          other.type == this.type &&
          other.delaiMin == this.delaiMin &&
          other.active == this.active &&
          other.heuresSilence == this.heuresSilence);
}

class NotificationConfigsCompanion extends UpdateCompanion<NotificationConfig> {
  final Value<int> id;
  final Value<String> cibleType;
  final Value<int> cibleId;
  final Value<String> type;
  final Value<int> delaiMin;
  final Value<bool> active;
  final Value<String?> heuresSilence;
  const NotificationConfigsCompanion({
    this.id = const Value.absent(),
    this.cibleType = const Value.absent(),
    this.cibleId = const Value.absent(),
    this.type = const Value.absent(),
    this.delaiMin = const Value.absent(),
    this.active = const Value.absent(),
    this.heuresSilence = const Value.absent(),
  });
  NotificationConfigsCompanion.insert({
    this.id = const Value.absent(),
    required String cibleType,
    required int cibleId,
    required String type,
    this.delaiMin = const Value.absent(),
    this.active = const Value.absent(),
    this.heuresSilence = const Value.absent(),
  }) : cibleType = Value(cibleType),
       cibleId = Value(cibleId),
       type = Value(type);
  static Insertable<NotificationConfig> custom({
    Expression<int>? id,
    Expression<String>? cibleType,
    Expression<int>? cibleId,
    Expression<String>? type,
    Expression<int>? delaiMin,
    Expression<bool>? active,
    Expression<String>? heuresSilence,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cibleType != null) 'cible_type': cibleType,
      if (cibleId != null) 'cible_id': cibleId,
      if (type != null) 'type': type,
      if (delaiMin != null) 'delai_min': delaiMin,
      if (active != null) 'active': active,
      if (heuresSilence != null) 'heures_silence': heuresSilence,
    });
  }

  NotificationConfigsCompanion copyWith({
    Value<int>? id,
    Value<String>? cibleType,
    Value<int>? cibleId,
    Value<String>? type,
    Value<int>? delaiMin,
    Value<bool>? active,
    Value<String?>? heuresSilence,
  }) {
    return NotificationConfigsCompanion(
      id: id ?? this.id,
      cibleType: cibleType ?? this.cibleType,
      cibleId: cibleId ?? this.cibleId,
      type: type ?? this.type,
      delaiMin: delaiMin ?? this.delaiMin,
      active: active ?? this.active,
      heuresSilence: heuresSilence ?? this.heuresSilence,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cibleType.present) {
      map['cible_type'] = Variable<String>(cibleType.value);
    }
    if (cibleId.present) {
      map['cible_id'] = Variable<int>(cibleId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (delaiMin.present) {
      map['delai_min'] = Variable<int>(delaiMin.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (heuresSilence.present) {
      map['heures_silence'] = Variable<String>(heuresSilence.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationConfigsCompanion(')
          ..write('id: $id, ')
          ..write('cibleType: $cibleType, ')
          ..write('cibleId: $cibleId, ')
          ..write('type: $type, ')
          ..write('delaiMin: $delaiMin, ')
          ..write('active: $active, ')
          ..write('heuresSilence: $heuresSilence')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ElevesTable eleves = $ElevesTable(this);
  late final $CoefficientRefsTable coefficientRefs = $CoefficientRefsTable(
    this,
  );
  late final $MatieresTable matieres = $MatieresTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $CoursEdtsTable coursEdts = $CoursEdtsTable(this);
  late final $SeanceEtudesTable seanceEtudes = $SeanceEtudesTable(this);
  late final $NotificationConfigsTable notificationConfigs =
      $NotificationConfigsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    eleves,
    coefficientRefs,
    matieres,
    notes,
    coursEdts,
    seanceEtudes,
    notificationConfigs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'eleve',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('matiere', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'matiere',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('note', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'eleve',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cours_edt', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'eleve',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('seance_etude', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ElevesTableCreateCompanionBuilder = ElevesCompanion Function({
  Value<int> id,
  required String pseudonyme,
  required String codePin,
  Value<String?> telephone,
  required String niveau,
  required String typeEnseignement,
  Value<String?> serie,
  required String dateCreation,
});
typedef $$ElevesTableUpdateCompanionBuilder = ElevesCompanion Function({
  Value<int> id,
  Value<String> pseudonyme,
  Value<String> codePin,
  Value<String?> telephone,
  Value<String> niveau,
  Value<String> typeEnseignement,
  Value<String?> serie,
  Value<String> dateCreation,
});

final class $$ElevesTableReferences
    extends BaseReferences<_$AppDatabase, $ElevesTable, Eleve> {
  $$ElevesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MatieresTable, List<Matiere>> _matieresRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.matieres,
    aliasName: 'eleve__id__matiere__eleve_id',
  );

  $$MatieresTableProcessedTableManager get matieresRefs {
    final manager = $$MatieresTableTableManager(
      $_db,
      $_db.matieres,
    ).filter((f) => f.eleveId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_matieresRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CoursEdtsTable, List<CoursEdt>>
  _coursEdtsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.coursEdts,
    aliasName: 'eleve__id__cours_edt__eleve_id',
  );

  $$CoursEdtsTableProcessedTableManager get coursEdtsRefs {
    final manager = $$CoursEdtsTableTableManager(
      $_db,
      $_db.coursEdts,
    ).filter((f) => f.eleveId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_coursEdtsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SeanceEtudesTable, List<SeanceEtude>>
  _seanceEtudesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.seanceEtudes,
    aliasName: 'eleve__id__seance_etude__eleve_id',
  );

  $$SeanceEtudesTableProcessedTableManager get seanceEtudesRefs {
    final manager = $$SeanceEtudesTableTableManager(
      $_db,
      $_db.seanceEtudes,
    ).filter((f) => f.eleveId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_seanceEtudesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ElevesTableFilterComposer
    extends Composer<_$AppDatabase, $ElevesTable> {
  $$ElevesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pseudonyme => $composableBuilder(
    column: $table.pseudonyme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codePin => $composableBuilder(
    column: $table.codePin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telephone => $composableBuilder(
    column: $table.telephone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get niveau => $composableBuilder(
    column: $table.niveau,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeEnseignement => $composableBuilder(
    column: $table.typeEnseignement,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serie => $composableBuilder(
    column: $table.serie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateCreation => $composableBuilder(
    column: $table.dateCreation,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> matieresRefs(
    Expression<bool> Function($$MatieresTableFilterComposer f) f,
  ) {
    final $$MatieresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.eleveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableFilterComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> coursEdtsRefs(
    Expression<bool> Function($$CoursEdtsTableFilterComposer f) f,
  ) {
    final $$CoursEdtsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coursEdts,
      getReferencedColumn: (t) => t.eleveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursEdtsTableFilterComposer(
            $db: $db,
            $table: $db.coursEdts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> seanceEtudesRefs(
    Expression<bool> Function($$SeanceEtudesTableFilterComposer f) f,
  ) {
    final $$SeanceEtudesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.seanceEtudes,
      getReferencedColumn: (t) => t.eleveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeanceEtudesTableFilterComposer(
            $db: $db,
            $table: $db.seanceEtudes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ElevesTableOrderingComposer
    extends Composer<_$AppDatabase, $ElevesTable> {
  $$ElevesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pseudonyme => $composableBuilder(
    column: $table.pseudonyme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codePin => $composableBuilder(
    column: $table.codePin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telephone => $composableBuilder(
    column: $table.telephone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get niveau => $composableBuilder(
    column: $table.niveau,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeEnseignement => $composableBuilder(
    column: $table.typeEnseignement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serie => $composableBuilder(
    column: $table.serie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateCreation => $composableBuilder(
    column: $table.dateCreation,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ElevesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ElevesTable> {
  $$ElevesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pseudonyme => $composableBuilder(
    column: $table.pseudonyme,
    builder: (column) => column,
  );

  GeneratedColumn<String> get codePin =>
      $composableBuilder(column: $table.codePin, builder: (column) => column);

  GeneratedColumn<String> get telephone =>
      $composableBuilder(column: $table.telephone, builder: (column) => column);

  GeneratedColumn<String> get niveau =>
      $composableBuilder(column: $table.niveau, builder: (column) => column);

  GeneratedColumn<String> get typeEnseignement => $composableBuilder(
    column: $table.typeEnseignement,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serie =>
      $composableBuilder(column: $table.serie, builder: (column) => column);

  GeneratedColumn<String> get dateCreation => $composableBuilder(
    column: $table.dateCreation,
    builder: (column) => column,
  );

  Expression<T> matieresRefs<T extends Object>(
    Expression<T> Function($$MatieresTableAnnotationComposer a) f,
  ) {
    final $$MatieresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.eleveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableAnnotationComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> coursEdtsRefs<T extends Object>(
    Expression<T> Function($$CoursEdtsTableAnnotationComposer a) f,
  ) {
    final $$CoursEdtsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coursEdts,
      getReferencedColumn: (t) => t.eleveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursEdtsTableAnnotationComposer(
            $db: $db,
            $table: $db.coursEdts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> seanceEtudesRefs<T extends Object>(
    Expression<T> Function($$SeanceEtudesTableAnnotationComposer a) f,
  ) {
    final $$SeanceEtudesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.seanceEtudes,
      getReferencedColumn: (t) => t.eleveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeanceEtudesTableAnnotationComposer(
            $db: $db,
            $table: $db.seanceEtudes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ElevesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ElevesTable,
          Eleve,
          $$ElevesTableFilterComposer,
          $$ElevesTableOrderingComposer,
          $$ElevesTableAnnotationComposer,
          $$ElevesTableCreateCompanionBuilder,
          $$ElevesTableUpdateCompanionBuilder,
          (Eleve, $$ElevesTableReferences),
          Eleve,
          PrefetchHooks Function({
            bool matieresRefs,
            bool coursEdtsRefs,
            bool seanceEtudesRefs,
          })
        > {
  $$ElevesTableTableManager(_$AppDatabase db, $ElevesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ElevesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ElevesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ElevesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> pseudonyme = const Value.absent(),
                Value<String> codePin = const Value.absent(),
                Value<String?> telephone = const Value.absent(),
                Value<String> niveau = const Value.absent(),
                Value<String> typeEnseignement = const Value.absent(),
                Value<String?> serie = const Value.absent(),
                Value<String> dateCreation = const Value.absent(),
              }) => ElevesCompanion(
                id: id,
                pseudonyme: pseudonyme,
                codePin: codePin,
                telephone: telephone,
                niveau: niveau,
                typeEnseignement: typeEnseignement,
                serie: serie,
                dateCreation: dateCreation,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String pseudonyme,
                required String codePin,
                Value<String?> telephone = const Value.absent(),
                required String niveau,
                required String typeEnseignement,
                Value<String?> serie = const Value.absent(),
                required String dateCreation,
              }) => ElevesCompanion.insert(
                id: id,
                pseudonyme: pseudonyme,
                codePin: codePin,
                telephone: telephone,
                niveau: niveau,
                typeEnseignement: typeEnseignement,
                serie: serie,
                dateCreation: dateCreation,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ElevesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                matieresRefs = false,
                coursEdtsRefs = false,
                seanceEtudesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (matieresRefs) db.matieres,
                    if (coursEdtsRefs) db.coursEdts,
                    if (seanceEtudesRefs) db.seanceEtudes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (matieresRefs)
                        await $_getPrefetchedData<Eleve, $ElevesTable, Matiere>(
                          currentTable: table,
                          referencedTable: $$ElevesTableReferences
                              ._matieresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ElevesTableReferences(
                                db,
                                table,
                                p0,
                              ).matieresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eleveId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coursEdtsRefs)
                        await $_getPrefetchedData<
                          Eleve,
                          $ElevesTable,
                          CoursEdt
                        >(
                          currentTable: table,
                          referencedTable: $$ElevesTableReferences
                              ._coursEdtsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ElevesTableReferences(
                                db,
                                table,
                                p0,
                              ).coursEdtsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eleveId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (seanceEtudesRefs)
                        await $_getPrefetchedData<
                          Eleve,
                          $ElevesTable,
                          SeanceEtude
                        >(
                          currentTable: table,
                          referencedTable: $$ElevesTableReferences
                              ._seanceEtudesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ElevesTableReferences(
                                db,
                                table,
                                p0,
                              ).seanceEtudesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eleveId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ElevesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ElevesTable,
      Eleve,
      $$ElevesTableFilterComposer,
      $$ElevesTableOrderingComposer,
      $$ElevesTableAnnotationComposer,
      $$ElevesTableCreateCompanionBuilder,
      $$ElevesTableUpdateCompanionBuilder,
      (Eleve, $$ElevesTableReferences),
      Eleve,
      PrefetchHooks Function({
        bool matieresRefs,
        bool coursEdtsRefs,
        bool seanceEtudesRefs,
      })
    >;
typedef $$CoefficientRefsTableCreateCompanionBuilder =
    CoefficientRefsCompanion Function({
      Value<int> id,
      required String niveau,
      required String serie,
      required String matiere,
      required double coefficient,
      Value<String?> versionSource,
    });
typedef $$CoefficientRefsTableUpdateCompanionBuilder =
    CoefficientRefsCompanion Function({
      Value<int> id,
      Value<String> niveau,
      Value<String> serie,
      Value<String> matiere,
      Value<double> coefficient,
      Value<String?> versionSource,
    });

class $$CoefficientRefsTableFilterComposer
    extends Composer<_$AppDatabase, $CoefficientRefsTable> {
  $$CoefficientRefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get niveau => $composableBuilder(
    column: $table.niveau,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serie => $composableBuilder(
    column: $table.serie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matiere => $composableBuilder(
    column: $table.matiere,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get coefficient => $composableBuilder(
    column: $table.coefficient,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get versionSource => $composableBuilder(
    column: $table.versionSource,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CoefficientRefsTableOrderingComposer
    extends Composer<_$AppDatabase, $CoefficientRefsTable> {
  $$CoefficientRefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get niveau => $composableBuilder(
    column: $table.niveau,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serie => $composableBuilder(
    column: $table.serie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matiere => $composableBuilder(
    column: $table.matiere,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get coefficient => $composableBuilder(
    column: $table.coefficient,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get versionSource => $composableBuilder(
    column: $table.versionSource,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoefficientRefsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoefficientRefsTable> {
  $$CoefficientRefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get niveau =>
      $composableBuilder(column: $table.niveau, builder: (column) => column);

  GeneratedColumn<String> get serie =>
      $composableBuilder(column: $table.serie, builder: (column) => column);

  GeneratedColumn<String> get matiere =>
      $composableBuilder(column: $table.matiere, builder: (column) => column);

  GeneratedColumn<double> get coefficient => $composableBuilder(
    column: $table.coefficient,
    builder: (column) => column,
  );

  GeneratedColumn<String> get versionSource => $composableBuilder(
    column: $table.versionSource,
    builder: (column) => column,
  );
}

class $$CoefficientRefsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoefficientRefsTable,
          CoefficientRef,
          $$CoefficientRefsTableFilterComposer,
          $$CoefficientRefsTableOrderingComposer,
          $$CoefficientRefsTableAnnotationComposer,
          $$CoefficientRefsTableCreateCompanionBuilder,
          $$CoefficientRefsTableUpdateCompanionBuilder,
          (
            CoefficientRef,
            BaseReferences<
              _$AppDatabase,
              $CoefficientRefsTable,
              CoefficientRef
            >,
          ),
          CoefficientRef,
          PrefetchHooks Function()
        > {
  $$CoefficientRefsTableTableManager(
    _$AppDatabase db,
    $CoefficientRefsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoefficientRefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoefficientRefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoefficientRefsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> niveau = const Value.absent(),
                Value<String> serie = const Value.absent(),
                Value<String> matiere = const Value.absent(),
                Value<double> coefficient = const Value.absent(),
                Value<String?> versionSource = const Value.absent(),
              }) => CoefficientRefsCompanion(
                id: id,
                niveau: niveau,
                serie: serie,
                matiere: matiere,
                coefficient: coefficient,
                versionSource: versionSource,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String niveau,
                required String serie,
                required String matiere,
                required double coefficient,
                Value<String?> versionSource = const Value.absent(),
              }) => CoefficientRefsCompanion.insert(
                id: id,
                niveau: niveau,
                serie: serie,
                matiere: matiere,
                coefficient: coefficient,
                versionSource: versionSource,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CoefficientRefsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoefficientRefsTable,
      CoefficientRef,
      $$CoefficientRefsTableFilterComposer,
      $$CoefficientRefsTableOrderingComposer,
      $$CoefficientRefsTableAnnotationComposer,
      $$CoefficientRefsTableCreateCompanionBuilder,
      $$CoefficientRefsTableUpdateCompanionBuilder,
      (
        CoefficientRef,
        BaseReferences<_$AppDatabase, $CoefficientRefsTable, CoefficientRef>,
      ),
      CoefficientRef,
      PrefetchHooks Function()
    >;
typedef $$MatieresTableCreateCompanionBuilder = MatieresCompanion Function({
  Value<int> id,
  required int eleveId,
  required String nom,
  required String serie,
  required double coefficient,
});
typedef $$MatieresTableUpdateCompanionBuilder = MatieresCompanion Function({
  Value<int> id,
  Value<int> eleveId,
  Value<String> nom,
  Value<String> serie,
  Value<double> coefficient,
});

final class $$MatieresTableReferences
    extends BaseReferences<_$AppDatabase, $MatieresTable, Matiere> {
  $$MatieresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ElevesTable _eleveIdTable(_$AppDatabase db) =>
      db.eleves.createAlias('matiere__eleve_id__eleve__id');

  $$ElevesTableProcessedTableManager get eleveId {
    final $_column = $_itemColumn<int>('eleve_id')!;

    final manager = $$ElevesTableTableManager(
      $_db,
      $_db.eleves,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eleveIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$NotesTable, List<Note>> _notesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.notes,
    aliasName: 'matiere__id__note__matiere_id',
  );

  $$NotesTableProcessedTableManager get notesRefs {
    final manager = $$NotesTableTableManager(
      $_db,
      $_db.notes,
    ).filter((f) => f.matiereId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_notesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MatieresTableFilterComposer
    extends Composer<_$AppDatabase, $MatieresTable> {
  $$MatieresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serie => $composableBuilder(
    column: $table.serie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get coefficient => $composableBuilder(
    column: $table.coefficient,
    builder: (column) => ColumnFilters(column),
  );

  $$ElevesTableFilterComposer get eleveId {
    final $$ElevesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eleveId,
      referencedTable: $db.eleves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevesTableFilterComposer(
            $db: $db,
            $table: $db.eleves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> notesRefs(
    Expression<bool> Function($$NotesTableFilterComposer f) f,
  ) {
    final $$NotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.matiereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableFilterComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatieresTableOrderingComposer
    extends Composer<_$AppDatabase, $MatieresTable> {
  $$MatieresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serie => $composableBuilder(
    column: $table.serie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get coefficient => $composableBuilder(
    column: $table.coefficient,
    builder: (column) => ColumnOrderings(column),
  );

  $$ElevesTableOrderingComposer get eleveId {
    final $$ElevesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eleveId,
      referencedTable: $db.eleves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevesTableOrderingComposer(
            $db: $db,
            $table: $db.eleves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatieresTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatieresTable> {
  $$MatieresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get serie =>
      $composableBuilder(column: $table.serie, builder: (column) => column);

  GeneratedColumn<double> get coefficient => $composableBuilder(
    column: $table.coefficient,
    builder: (column) => column,
  );

  $$ElevesTableAnnotationComposer get eleveId {
    final $$ElevesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eleveId,
      referencedTable: $db.eleves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevesTableAnnotationComposer(
            $db: $db,
            $table: $db.eleves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> notesRefs<T extends Object>(
    Expression<T> Function($$NotesTableAnnotationComposer a) f,
  ) {
    final $$NotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.matiereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableAnnotationComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatieresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatieresTable,
          Matiere,
          $$MatieresTableFilterComposer,
          $$MatieresTableOrderingComposer,
          $$MatieresTableAnnotationComposer,
          $$MatieresTableCreateCompanionBuilder,
          $$MatieresTableUpdateCompanionBuilder,
          (Matiere, $$MatieresTableReferences),
          Matiere,
          PrefetchHooks Function({bool eleveId, bool notesRefs})
        > {
  $$MatieresTableTableManager(_$AppDatabase db, $MatieresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatieresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatieresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatieresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eleveId = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String> serie = const Value.absent(),
                Value<double> coefficient = const Value.absent(),
              }) => MatieresCompanion(
                id: id,
                eleveId: eleveId,
                nom: nom,
                serie: serie,
                coefficient: coefficient,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eleveId,
                required String nom,
                required String serie,
                required double coefficient,
              }) => MatieresCompanion.insert(
                id: id,
                eleveId: eleveId,
                nom: nom,
                serie: serie,
                coefficient: coefficient,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MatieresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eleveId = false, notesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (notesRefs) db.notes],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eleveId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eleveId,
                        referencedTable: $$MatieresTableReferences
                            ._eleveIdTable(db),
                        referencedColumn: $$MatieresTableReferences
                            ._eleveIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (notesRefs)
                    await $_getPrefetchedData<Matiere, $MatieresTable, Note>(
                      currentTable: table,
                      referencedTable: $$MatieresTableReferences
                          ._notesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MatieresTableReferences(db, table, p0).notesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.matiereId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MatieresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatieresTable,
      Matiere,
      $$MatieresTableFilterComposer,
      $$MatieresTableOrderingComposer,
      $$MatieresTableAnnotationComposer,
      $$MatieresTableCreateCompanionBuilder,
      $$MatieresTableUpdateCompanionBuilder,
      (Matiere, $$MatieresTableReferences),
      Matiere,
      PrefetchHooks Function({bool eleveId, bool notesRefs})
    >;
typedef $$NotesTableCreateCompanionBuilder = NotesCompanion Function({
  Value<int> id,
  required int matiereId,
  required String typeEval,
  required double valeur,
  Value<double> bareme,
  required String periode,
  required String date,
});
typedef $$NotesTableUpdateCompanionBuilder = NotesCompanion Function({
  Value<int> id,
  Value<int> matiereId,
  Value<String> typeEval,
  Value<double> valeur,
  Value<double> bareme,
  Value<String> periode,
  Value<String> date,
});

final class $$NotesTableReferences
    extends BaseReferences<_$AppDatabase, $NotesTable, Note> {
  $$NotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MatieresTable _matiereIdTable(_$AppDatabase db) =>
      db.matieres.createAlias('note__matiere_id__matiere__id');

  $$MatieresTableProcessedTableManager get matiereId {
    final $_column = $_itemColumn<int>('matiere_id')!;

    final manager = $$MatieresTableTableManager(
      $_db,
      $_db.matieres,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_matiereIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeEval => $composableBuilder(
    column: $table.typeEval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get valeur => $composableBuilder(
    column: $table.valeur,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bareme => $composableBuilder(
    column: $table.bareme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get periode => $composableBuilder(
    column: $table.periode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$MatieresTableFilterComposer get matiereId {
    final $$MatieresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matiereId,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableFilterComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeEval => $composableBuilder(
    column: $table.typeEval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get valeur => $composableBuilder(
    column: $table.valeur,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bareme => $composableBuilder(
    column: $table.bareme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periode => $composableBuilder(
    column: $table.periode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$MatieresTableOrderingComposer get matiereId {
    final $$MatieresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matiereId,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableOrderingComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get typeEval =>
      $composableBuilder(column: $table.typeEval, builder: (column) => column);

  GeneratedColumn<double> get valeur =>
      $composableBuilder(column: $table.valeur, builder: (column) => column);

  GeneratedColumn<double> get bareme =>
      $composableBuilder(column: $table.bareme, builder: (column) => column);

  GeneratedColumn<String> get periode =>
      $composableBuilder(column: $table.periode, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$MatieresTableAnnotationComposer get matiereId {
    final $$MatieresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matiereId,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableAnnotationComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTable,
          Note,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (Note, $$NotesTableReferences),
          Note,
          PrefetchHooks Function({bool matiereId})
        > {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> matiereId = const Value.absent(),
                Value<String> typeEval = const Value.absent(),
                Value<double> valeur = const Value.absent(),
                Value<double> bareme = const Value.absent(),
                Value<String> periode = const Value.absent(),
                Value<String> date = const Value.absent(),
              }) => NotesCompanion(
                id: id,
                matiereId: matiereId,
                typeEval: typeEval,
                valeur: valeur,
                bareme: bareme,
                periode: periode,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int matiereId,
                required String typeEval,
                required double valeur,
                Value<double> bareme = const Value.absent(),
                required String periode,
                required String date,
              }) => NotesCompanion.insert(
                id: id,
                matiereId: matiereId,
                typeEval: typeEval,
                valeur: valeur,
                bareme: bareme,
                periode: periode,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$NotesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({matiereId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (matiereId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.matiereId,
                        referencedTable: $$NotesTableReferences._matiereIdTable(
                          db,
                        ),
                        referencedColumn: $$NotesTableReferences
                            ._matiereIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTable,
      Note,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (Note, $$NotesTableReferences),
      Note,
      PrefetchHooks Function({bool matiereId})
    >;
typedef $$CoursEdtsTableCreateCompanionBuilder = CoursEdtsCompanion Function({
  Value<int> id,
  required int eleveId,
  required String jour,
  required String creneauDebut,
  required String creneauFin,
  required String matiere,
  Value<String?> salle,
});
typedef $$CoursEdtsTableUpdateCompanionBuilder = CoursEdtsCompanion Function({
  Value<int> id,
  Value<int> eleveId,
  Value<String> jour,
  Value<String> creneauDebut,
  Value<String> creneauFin,
  Value<String> matiere,
  Value<String?> salle,
});

final class $$CoursEdtsTableReferences
    extends BaseReferences<_$AppDatabase, $CoursEdtsTable, CoursEdt> {
  $$CoursEdtsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ElevesTable _eleveIdTable(_$AppDatabase db) =>
      db.eleves.createAlias('cours_edt__eleve_id__eleve__id');

  $$ElevesTableProcessedTableManager get eleveId {
    final $_column = $_itemColumn<int>('eleve_id')!;

    final manager = $$ElevesTableTableManager(
      $_db,
      $_db.eleves,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eleveIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CoursEdtsTableFilterComposer
    extends Composer<_$AppDatabase, $CoursEdtsTable> {
  $$CoursEdtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jour => $composableBuilder(
    column: $table.jour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creneauDebut => $composableBuilder(
    column: $table.creneauDebut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creneauFin => $composableBuilder(
    column: $table.creneauFin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matiere => $composableBuilder(
    column: $table.matiere,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get salle => $composableBuilder(
    column: $table.salle,
    builder: (column) => ColumnFilters(column),
  );

  $$ElevesTableFilterComposer get eleveId {
    final $$ElevesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eleveId,
      referencedTable: $db.eleves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevesTableFilterComposer(
            $db: $db,
            $table: $db.eleves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoursEdtsTableOrderingComposer
    extends Composer<_$AppDatabase, $CoursEdtsTable> {
  $$CoursEdtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jour => $composableBuilder(
    column: $table.jour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creneauDebut => $composableBuilder(
    column: $table.creneauDebut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creneauFin => $composableBuilder(
    column: $table.creneauFin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matiere => $composableBuilder(
    column: $table.matiere,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get salle => $composableBuilder(
    column: $table.salle,
    builder: (column) => ColumnOrderings(column),
  );

  $$ElevesTableOrderingComposer get eleveId {
    final $$ElevesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eleveId,
      referencedTable: $db.eleves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevesTableOrderingComposer(
            $db: $db,
            $table: $db.eleves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoursEdtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoursEdtsTable> {
  $$CoursEdtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get jour =>
      $composableBuilder(column: $table.jour, builder: (column) => column);

  GeneratedColumn<String> get creneauDebut => $composableBuilder(
    column: $table.creneauDebut,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creneauFin => $composableBuilder(
    column: $table.creneauFin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get matiere =>
      $composableBuilder(column: $table.matiere, builder: (column) => column);

  GeneratedColumn<String> get salle =>
      $composableBuilder(column: $table.salle, builder: (column) => column);

  $$ElevesTableAnnotationComposer get eleveId {
    final $$ElevesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eleveId,
      referencedTable: $db.eleves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevesTableAnnotationComposer(
            $db: $db,
            $table: $db.eleves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoursEdtsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoursEdtsTable,
          CoursEdt,
          $$CoursEdtsTableFilterComposer,
          $$CoursEdtsTableOrderingComposer,
          $$CoursEdtsTableAnnotationComposer,
          $$CoursEdtsTableCreateCompanionBuilder,
          $$CoursEdtsTableUpdateCompanionBuilder,
          (CoursEdt, $$CoursEdtsTableReferences),
          CoursEdt,
          PrefetchHooks Function({bool eleveId})
        > {
  $$CoursEdtsTableTableManager(_$AppDatabase db, $CoursEdtsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoursEdtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoursEdtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoursEdtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eleveId = const Value.absent(),
                Value<String> jour = const Value.absent(),
                Value<String> creneauDebut = const Value.absent(),
                Value<String> creneauFin = const Value.absent(),
                Value<String> matiere = const Value.absent(),
                Value<String?> salle = const Value.absent(),
              }) => CoursEdtsCompanion(
                id: id,
                eleveId: eleveId,
                jour: jour,
                creneauDebut: creneauDebut,
                creneauFin: creneauFin,
                matiere: matiere,
                salle: salle,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eleveId,
                required String jour,
                required String creneauDebut,
                required String creneauFin,
                required String matiere,
                Value<String?> salle = const Value.absent(),
              }) => CoursEdtsCompanion.insert(
                id: id,
                eleveId: eleveId,
                jour: jour,
                creneauDebut: creneauDebut,
                creneauFin: creneauFin,
                matiere: matiere,
                salle: salle,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CoursEdtsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eleveId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eleveId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eleveId,
                        referencedTable: $$CoursEdtsTableReferences
                            ._eleveIdTable(db),
                        referencedColumn: $$CoursEdtsTableReferences
                            ._eleveIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CoursEdtsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoursEdtsTable,
      CoursEdt,
      $$CoursEdtsTableFilterComposer,
      $$CoursEdtsTableOrderingComposer,
      $$CoursEdtsTableAnnotationComposer,
      $$CoursEdtsTableCreateCompanionBuilder,
      $$CoursEdtsTableUpdateCompanionBuilder,
      (CoursEdt, $$CoursEdtsTableReferences),
      CoursEdt,
      PrefetchHooks Function({bool eleveId})
    >;
typedef $$SeanceEtudesTableCreateCompanionBuilder =
    SeanceEtudesCompanion Function({
      Value<int> id,
      required int eleveId,
      required String matiere,
      required String date,
      required String heureDebut,
      required int dureeMin,
      Value<String?> objectif,
      Value<String?> recurrence,
      Value<int> pauses,
      Value<bool> termine,
    });
typedef $$SeanceEtudesTableUpdateCompanionBuilder =
    SeanceEtudesCompanion Function({
      Value<int> id,
      Value<int> eleveId,
      Value<String> matiere,
      Value<String> date,
      Value<String> heureDebut,
      Value<int> dureeMin,
      Value<String?> objectif,
      Value<String?> recurrence,
      Value<int> pauses,
      Value<bool> termine,
    });

final class $$SeanceEtudesTableReferences
    extends BaseReferences<_$AppDatabase, $SeanceEtudesTable, SeanceEtude> {
  $$SeanceEtudesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ElevesTable _eleveIdTable(_$AppDatabase db) =>
      db.eleves.createAlias('seance_etude__eleve_id__eleve__id');

  $$ElevesTableProcessedTableManager get eleveId {
    final $_column = $_itemColumn<int>('eleve_id')!;

    final manager = $$ElevesTableTableManager(
      $_db,
      $_db.eleves,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eleveIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SeanceEtudesTableFilterComposer
    extends Composer<_$AppDatabase, $SeanceEtudesTable> {
  $$SeanceEtudesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matiere => $composableBuilder(
    column: $table.matiere,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get heureDebut => $composableBuilder(
    column: $table.heureDebut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dureeMin => $composableBuilder(
    column: $table.dureeMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get objectif => $composableBuilder(
    column: $table.objectif,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrence => $composableBuilder(
    column: $table.recurrence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pauses => $composableBuilder(
    column: $table.pauses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get termine => $composableBuilder(
    column: $table.termine,
    builder: (column) => ColumnFilters(column),
  );

  $$ElevesTableFilterComposer get eleveId {
    final $$ElevesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eleveId,
      referencedTable: $db.eleves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevesTableFilterComposer(
            $db: $db,
            $table: $db.eleves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeanceEtudesTableOrderingComposer
    extends Composer<_$AppDatabase, $SeanceEtudesTable> {
  $$SeanceEtudesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matiere => $composableBuilder(
    column: $table.matiere,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get heureDebut => $composableBuilder(
    column: $table.heureDebut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dureeMin => $composableBuilder(
    column: $table.dureeMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get objectif => $composableBuilder(
    column: $table.objectif,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrence => $composableBuilder(
    column: $table.recurrence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pauses => $composableBuilder(
    column: $table.pauses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get termine => $composableBuilder(
    column: $table.termine,
    builder: (column) => ColumnOrderings(column),
  );

  $$ElevesTableOrderingComposer get eleveId {
    final $$ElevesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eleveId,
      referencedTable: $db.eleves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevesTableOrderingComposer(
            $db: $db,
            $table: $db.eleves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeanceEtudesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SeanceEtudesTable> {
  $$SeanceEtudesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get matiere =>
      $composableBuilder(column: $table.matiere, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get heureDebut => $composableBuilder(
    column: $table.heureDebut,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dureeMin =>
      $composableBuilder(column: $table.dureeMin, builder: (column) => column);

  GeneratedColumn<String> get objectif =>
      $composableBuilder(column: $table.objectif, builder: (column) => column);

  GeneratedColumn<String> get recurrence => $composableBuilder(
    column: $table.recurrence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pauses =>
      $composableBuilder(column: $table.pauses, builder: (column) => column);

  GeneratedColumn<bool> get termine =>
      $composableBuilder(column: $table.termine, builder: (column) => column);

  $$ElevesTableAnnotationComposer get eleveId {
    final $$ElevesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eleveId,
      referencedTable: $db.eleves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevesTableAnnotationComposer(
            $db: $db,
            $table: $db.eleves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeanceEtudesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SeanceEtudesTable,
          SeanceEtude,
          $$SeanceEtudesTableFilterComposer,
          $$SeanceEtudesTableOrderingComposer,
          $$SeanceEtudesTableAnnotationComposer,
          $$SeanceEtudesTableCreateCompanionBuilder,
          $$SeanceEtudesTableUpdateCompanionBuilder,
          (SeanceEtude, $$SeanceEtudesTableReferences),
          SeanceEtude,
          PrefetchHooks Function({bool eleveId})
        > {
  $$SeanceEtudesTableTableManager(_$AppDatabase db, $SeanceEtudesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SeanceEtudesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SeanceEtudesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SeanceEtudesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eleveId = const Value.absent(),
                Value<String> matiere = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> heureDebut = const Value.absent(),
                Value<int> dureeMin = const Value.absent(),
                Value<String?> objectif = const Value.absent(),
                Value<String?> recurrence = const Value.absent(),
                Value<int> pauses = const Value.absent(),
                Value<bool> termine = const Value.absent(),
              }) => SeanceEtudesCompanion(
                id: id,
                eleveId: eleveId,
                matiere: matiere,
                date: date,
                heureDebut: heureDebut,
                dureeMin: dureeMin,
                objectif: objectif,
                recurrence: recurrence,
                pauses: pauses,
                termine: termine,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eleveId,
                required String matiere,
                required String date,
                required String heureDebut,
                required int dureeMin,
                Value<String?> objectif = const Value.absent(),
                Value<String?> recurrence = const Value.absent(),
                Value<int> pauses = const Value.absent(),
                Value<bool> termine = const Value.absent(),
              }) => SeanceEtudesCompanion.insert(
                id: id,
                eleveId: eleveId,
                matiere: matiere,
                date: date,
                heureDebut: heureDebut,
                dureeMin: dureeMin,
                objectif: objectif,
                recurrence: recurrence,
                pauses: pauses,
                termine: termine,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SeanceEtudesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eleveId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eleveId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eleveId,
                        referencedTable: $$SeanceEtudesTableReferences
                            ._eleveIdTable(db),
                        referencedColumn: $$SeanceEtudesTableReferences
                            ._eleveIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SeanceEtudesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SeanceEtudesTable,
      SeanceEtude,
      $$SeanceEtudesTableFilterComposer,
      $$SeanceEtudesTableOrderingComposer,
      $$SeanceEtudesTableAnnotationComposer,
      $$SeanceEtudesTableCreateCompanionBuilder,
      $$SeanceEtudesTableUpdateCompanionBuilder,
      (SeanceEtude, $$SeanceEtudesTableReferences),
      SeanceEtude,
      PrefetchHooks Function({bool eleveId})
    >;
typedef $$NotificationConfigsTableCreateCompanionBuilder =
    NotificationConfigsCompanion Function({
      Value<int> id,
      required String cibleType,
      required int cibleId,
      required String type,
      Value<int> delaiMin,
      Value<bool> active,
      Value<String?> heuresSilence,
    });
typedef $$NotificationConfigsTableUpdateCompanionBuilder =
    NotificationConfigsCompanion Function({
      Value<int> id,
      Value<String> cibleType,
      Value<int> cibleId,
      Value<String> type,
      Value<int> delaiMin,
      Value<bool> active,
      Value<String?> heuresSilence,
    });

class $$NotificationConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationConfigsTable> {
  $$NotificationConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cibleType => $composableBuilder(
    column: $table.cibleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cibleId => $composableBuilder(
    column: $table.cibleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get delaiMin => $composableBuilder(
    column: $table.delaiMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get heuresSilence => $composableBuilder(
    column: $table.heuresSilence,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationConfigsTable> {
  $$NotificationConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cibleType => $composableBuilder(
    column: $table.cibleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cibleId => $composableBuilder(
    column: $table.cibleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get delaiMin => $composableBuilder(
    column: $table.delaiMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get heuresSilence => $composableBuilder(
    column: $table.heuresSilence,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationConfigsTable> {
  $$NotificationConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cibleType =>
      $composableBuilder(column: $table.cibleType, builder: (column) => column);

  GeneratedColumn<int> get cibleId =>
      $composableBuilder(column: $table.cibleId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get delaiMin =>
      $composableBuilder(column: $table.delaiMin, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<String> get heuresSilence => $composableBuilder(
    column: $table.heuresSilence,
    builder: (column) => column,
  );
}

class $$NotificationConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationConfigsTable,
          NotificationConfig,
          $$NotificationConfigsTableFilterComposer,
          $$NotificationConfigsTableOrderingComposer,
          $$NotificationConfigsTableAnnotationComposer,
          $$NotificationConfigsTableCreateCompanionBuilder,
          $$NotificationConfigsTableUpdateCompanionBuilder,
          (
            NotificationConfig,
            BaseReferences<
              _$AppDatabase,
              $NotificationConfigsTable,
              NotificationConfig
            >,
          ),
          NotificationConfig,
          PrefetchHooks Function()
        > {
  $$NotificationConfigsTableTableManager(
    _$AppDatabase db,
    $NotificationConfigsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationConfigsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NotificationConfigsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> cibleType = const Value.absent(),
                Value<int> cibleId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> delaiMin = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String?> heuresSilence = const Value.absent(),
              }) => NotificationConfigsCompanion(
                id: id,
                cibleType: cibleType,
                cibleId: cibleId,
                type: type,
                delaiMin: delaiMin,
                active: active,
                heuresSilence: heuresSilence,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String cibleType,
                required int cibleId,
                required String type,
                Value<int> delaiMin = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String?> heuresSilence = const Value.absent(),
              }) => NotificationConfigsCompanion.insert(
                id: id,
                cibleType: cibleType,
                cibleId: cibleId,
                type: type,
                delaiMin: delaiMin,
                active: active,
                heuresSilence: heuresSilence,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationConfigsTable,
      NotificationConfig,
      $$NotificationConfigsTableFilterComposer,
      $$NotificationConfigsTableOrderingComposer,
      $$NotificationConfigsTableAnnotationComposer,
      $$NotificationConfigsTableCreateCompanionBuilder,
      $$NotificationConfigsTableUpdateCompanionBuilder,
      (
        NotificationConfig,
        BaseReferences<
          _$AppDatabase,
          $NotificationConfigsTable,
          NotificationConfig
        >,
      ),
      NotificationConfig,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ElevesTableTableManager get eleves =>
      $$ElevesTableTableManager(_db, _db.eleves);
  $$CoefficientRefsTableTableManager get coefficientRefs =>
      $$CoefficientRefsTableTableManager(_db, _db.coefficientRefs);
  $$MatieresTableTableManager get matieres =>
      $$MatieresTableTableManager(_db, _db.matieres);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$CoursEdtsTableTableManager get coursEdts =>
      $$CoursEdtsTableTableManager(_db, _db.coursEdts);
  $$SeanceEtudesTableTableManager get seanceEtudes =>
      $$SeanceEtudesTableTableManager(_db, _db.seanceEtudes);
  $$NotificationConfigsTableTableManager get notificationConfigs =>
      $$NotificationConfigsTableTableManager(_db, _db.notificationConfigs);
}
