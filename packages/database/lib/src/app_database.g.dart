// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StoreProfilesTable extends StoreProfiles
    with TableInfo<$StoreProfilesTable, StoreProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoreProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _storeNameMeta =
      const VerificationMeta('storeName');
  @override
  late final GeneratedColumn<String> storeName = GeneratedColumn<String>(
      'store_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Simple Cashier Store'));
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _headerMessageMeta =
      const VerificationMeta('headerMessage');
  @override
  late final GeneratedColumn<String> headerMessage = GeneratedColumn<String>(
      'header_message', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Terima kasih atas kunjungan Anda'));
  static const VerificationMeta _footerMessageMeta =
      const VerificationMeta('footerMessage');
  @override
  late final GeneratedColumn<String> footerMessage = GeneratedColumn<String>(
      'footer_message', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue:
          const Constant('Barang yang sudah dibeli tidak dapat ditukar'));
  static const VerificationMeta _logoPathMeta =
      const VerificationMeta('logoPath');
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
      'logo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        storeName,
        phone,
        address,
        headerMessage,
        footerMessage,
        logoPath,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'store_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<StoreProfileData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_name')) {
      context.handle(_storeNameMeta,
          storeName.isAcceptableOrUnknown(data['store_name']!, _storeNameMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('header_message')) {
      context.handle(
          _headerMessageMeta,
          headerMessage.isAcceptableOrUnknown(
              data['header_message']!, _headerMessageMeta));
    }
    if (data.containsKey('footer_message')) {
      context.handle(
          _footerMessageMeta,
          footerMessage.isAcceptableOrUnknown(
              data['footer_message']!, _footerMessageMeta));
    }
    if (data.containsKey('logo_path')) {
      context.handle(_logoPathMeta,
          logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoreProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoreProfileData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      storeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      headerMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}header_message'])!,
      footerMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}footer_message'])!,
      logoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_path']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $StoreProfilesTable createAlias(String alias) {
    return $StoreProfilesTable(attachedDatabase, alias);
  }
}

class StoreProfileData extends DataClass
    implements Insertable<StoreProfileData> {
  final int id;
  final String storeName;
  final String phone;
  final String address;
  final String headerMessage;
  final String footerMessage;
  final String? logoPath;
  final DateTime updatedAt;
  const StoreProfileData(
      {required this.id,
      required this.storeName,
      required this.phone,
      required this.address,
      required this.headerMessage,
      required this.footerMessage,
      this.logoPath,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['store_name'] = Variable<String>(storeName);
    map['phone'] = Variable<String>(phone);
    map['address'] = Variable<String>(address);
    map['header_message'] = Variable<String>(headerMessage);
    map['footer_message'] = Variable<String>(footerMessage);
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StoreProfilesCompanion toCompanion(bool nullToAbsent) {
    return StoreProfilesCompanion(
      id: Value(id),
      storeName: Value(storeName),
      phone: Value(phone),
      address: Value(address),
      headerMessage: Value(headerMessage),
      footerMessage: Value(footerMessage),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      updatedAt: Value(updatedAt),
    );
  }

  factory StoreProfileData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoreProfileData(
      id: serializer.fromJson<int>(json['id']),
      storeName: serializer.fromJson<String>(json['storeName']),
      phone: serializer.fromJson<String>(json['phone']),
      address: serializer.fromJson<String>(json['address']),
      headerMessage: serializer.fromJson<String>(json['headerMessage']),
      footerMessage: serializer.fromJson<String>(json['footerMessage']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeName': serializer.toJson<String>(storeName),
      'phone': serializer.toJson<String>(phone),
      'address': serializer.toJson<String>(address),
      'headerMessage': serializer.toJson<String>(headerMessage),
      'footerMessage': serializer.toJson<String>(footerMessage),
      'logoPath': serializer.toJson<String?>(logoPath),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StoreProfileData copyWith(
          {int? id,
          String? storeName,
          String? phone,
          String? address,
          String? headerMessage,
          String? footerMessage,
          Value<String?> logoPath = const Value.absent(),
          DateTime? updatedAt}) =>
      StoreProfileData(
        id: id ?? this.id,
        storeName: storeName ?? this.storeName,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        headerMessage: headerMessage ?? this.headerMessage,
        footerMessage: footerMessage ?? this.footerMessage,
        logoPath: logoPath.present ? logoPath.value : this.logoPath,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  StoreProfileData copyWithCompanion(StoreProfilesCompanion data) {
    return StoreProfileData(
      id: data.id.present ? data.id.value : this.id,
      storeName: data.storeName.present ? data.storeName.value : this.storeName,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      headerMessage: data.headerMessage.present
          ? data.headerMessage.value
          : this.headerMessage,
      footerMessage: data.footerMessage.present
          ? data.footerMessage.value
          : this.footerMessage,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoreProfileData(')
          ..write('id: $id, ')
          ..write('storeName: $storeName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('headerMessage: $headerMessage, ')
          ..write('footerMessage: $footerMessage, ')
          ..write('logoPath: $logoPath, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, storeName, phone, address, headerMessage,
      footerMessage, logoPath, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoreProfileData &&
          other.id == this.id &&
          other.storeName == this.storeName &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.headerMessage == this.headerMessage &&
          other.footerMessage == this.footerMessage &&
          other.logoPath == this.logoPath &&
          other.updatedAt == this.updatedAt);
}

class StoreProfilesCompanion extends UpdateCompanion<StoreProfileData> {
  final Value<int> id;
  final Value<String> storeName;
  final Value<String> phone;
  final Value<String> address;
  final Value<String> headerMessage;
  final Value<String> footerMessage;
  final Value<String?> logoPath;
  final Value<DateTime> updatedAt;
  const StoreProfilesCompanion({
    this.id = const Value.absent(),
    this.storeName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.headerMessage = const Value.absent(),
    this.footerMessage = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StoreProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.storeName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.headerMessage = const Value.absent(),
    this.footerMessage = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<StoreProfileData> custom({
    Expression<int>? id,
    Expression<String>? storeName,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? headerMessage,
    Expression<String>? footerMessage,
    Expression<String>? logoPath,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeName != null) 'store_name': storeName,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (headerMessage != null) 'header_message': headerMessage,
      if (footerMessage != null) 'footer_message': footerMessage,
      if (logoPath != null) 'logo_path': logoPath,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StoreProfilesCompanion copyWith(
      {Value<int>? id,
      Value<String>? storeName,
      Value<String>? phone,
      Value<String>? address,
      Value<String>? headerMessage,
      Value<String>? footerMessage,
      Value<String?>? logoPath,
      Value<DateTime>? updatedAt}) {
    return StoreProfilesCompanion(
      id: id ?? this.id,
      storeName: storeName ?? this.storeName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      headerMessage: headerMessage ?? this.headerMessage,
      footerMessage: footerMessage ?? this.footerMessage,
      logoPath: logoPath ?? this.logoPath,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeName.present) {
      map['store_name'] = Variable<String>(storeName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (headerMessage.present) {
      map['header_message'] = Variable<String>(headerMessage.value);
    }
    if (footerMessage.present) {
      map['footer_message'] = Variable<String>(footerMessage.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoreProfilesCompanion(')
          ..write('id: $id, ')
          ..write('storeName: $storeName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('headerMessage: $headerMessage, ')
          ..write('footerMessage: $footerMessage, ')
          ..write('logoPath: $logoPath, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StoresTable extends Stores with TableInfo<$StoresTable, StoreData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _storeNameMeta =
      const VerificationMeta('storeName');
  @override
  late final GeneratedColumn<String> storeName = GeneratedColumn<String>(
      'store_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownerNameMeta =
      const VerificationMeta('ownerName');
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
      'owner_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _headerMessageMeta =
      const VerificationMeta('headerMessage');
  @override
  late final GeneratedColumn<String> headerMessage = GeneratedColumn<String>(
      'header_message', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Terima kasih atas kunjungan Anda'));
  static const VerificationMeta _footerMessageMeta =
      const VerificationMeta('footerMessage');
  @override
  late final GeneratedColumn<String> footerMessage = GeneratedColumn<String>(
      'footer_message', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue:
          const Constant('Barang yang sudah dibeli tidak dapat ditukar'));
  static const VerificationMeta _logoPathMeta =
      const VerificationMeta('logoPath');
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
      'logo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pinHashMeta =
      const VerificationMeta('pinHash');
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
      'pin_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pinSaltMeta =
      const VerificationMeta('pinSalt');
  @override
  late final GeneratedColumn<String> pinSalt = GeneratedColumn<String>(
      'pin_salt', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _securityQuestionMeta =
      const VerificationMeta('securityQuestion');
  @override
  late final GeneratedColumn<String> securityQuestion = GeneratedColumn<String>(
      'security_question', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _securityAnswerHashMeta =
      const VerificationMeta('securityAnswerHash');
  @override
  late final GeneratedColumn<String> securityAnswerHash =
      GeneratedColumn<String>('security_answer_hash', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _securityAnswerSaltMeta =
      const VerificationMeta('securityAnswerSalt');
  @override
  late final GeneratedColumn<String> securityAnswerSalt =
      GeneratedColumn<String>('security_answer_salt', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        storeName,
        ownerName,
        phone,
        address,
        headerMessage,
        footerMessage,
        logoPath,
        pinHash,
        pinSalt,
        securityQuestion,
        securityAnswerHash,
        securityAnswerSalt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stores';
  @override
  VerificationContext validateIntegrity(Insertable<StoreData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_name')) {
      context.handle(_storeNameMeta,
          storeName.isAcceptableOrUnknown(data['store_name']!, _storeNameMeta));
    } else if (isInserting) {
      context.missing(_storeNameMeta);
    }
    if (data.containsKey('owner_name')) {
      context.handle(_ownerNameMeta,
          ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('header_message')) {
      context.handle(
          _headerMessageMeta,
          headerMessage.isAcceptableOrUnknown(
              data['header_message']!, _headerMessageMeta));
    }
    if (data.containsKey('footer_message')) {
      context.handle(
          _footerMessageMeta,
          footerMessage.isAcceptableOrUnknown(
              data['footer_message']!, _footerMessageMeta));
    }
    if (data.containsKey('logo_path')) {
      context.handle(_logoPathMeta,
          logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta));
    }
    if (data.containsKey('pin_hash')) {
      context.handle(_pinHashMeta,
          pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta));
    } else if (isInserting) {
      context.missing(_pinHashMeta);
    }
    if (data.containsKey('pin_salt')) {
      context.handle(_pinSaltMeta,
          pinSalt.isAcceptableOrUnknown(data['pin_salt']!, _pinSaltMeta));
    } else if (isInserting) {
      context.missing(_pinSaltMeta);
    }
    if (data.containsKey('security_question')) {
      context.handle(
          _securityQuestionMeta,
          securityQuestion.isAcceptableOrUnknown(
              data['security_question']!, _securityQuestionMeta));
    } else if (isInserting) {
      context.missing(_securityQuestionMeta);
    }
    if (data.containsKey('security_answer_hash')) {
      context.handle(
          _securityAnswerHashMeta,
          securityAnswerHash.isAcceptableOrUnknown(
              data['security_answer_hash']!, _securityAnswerHashMeta));
    } else if (isInserting) {
      context.missing(_securityAnswerHashMeta);
    }
    if (data.containsKey('security_answer_salt')) {
      context.handle(
          _securityAnswerSaltMeta,
          securityAnswerSalt.isAcceptableOrUnknown(
              data['security_answer_salt']!, _securityAnswerSaltMeta));
    } else if (isInserting) {
      context.missing(_securityAnswerSaltMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoreData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoreData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      storeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_name'])!,
      ownerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      headerMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}header_message'])!,
      footerMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}footer_message'])!,
      logoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_path']),
      pinHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pin_hash'])!,
      pinSalt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pin_salt'])!,
      securityQuestion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}security_question'])!,
      securityAnswerHash: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}security_answer_hash'])!,
      securityAnswerSalt: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}security_answer_salt'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $StoresTable createAlias(String alias) {
    return $StoresTable(attachedDatabase, alias);
  }
}

class StoreData extends DataClass implements Insertable<StoreData> {
  final int id;
  final String storeName;
  final String ownerName;
  final String phone;
  final String address;
  final String headerMessage;
  final String footerMessage;
  final String? logoPath;
  final String pinHash;
  final String pinSalt;
  final String securityQuestion;
  final String securityAnswerHash;
  final String securityAnswerSalt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const StoreData(
      {required this.id,
      required this.storeName,
      required this.ownerName,
      required this.phone,
      required this.address,
      required this.headerMessage,
      required this.footerMessage,
      this.logoPath,
      required this.pinHash,
      required this.pinSalt,
      required this.securityQuestion,
      required this.securityAnswerHash,
      required this.securityAnswerSalt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['store_name'] = Variable<String>(storeName);
    map['owner_name'] = Variable<String>(ownerName);
    map['phone'] = Variable<String>(phone);
    map['address'] = Variable<String>(address);
    map['header_message'] = Variable<String>(headerMessage);
    map['footer_message'] = Variable<String>(footerMessage);
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    map['pin_hash'] = Variable<String>(pinHash);
    map['pin_salt'] = Variable<String>(pinSalt);
    map['security_question'] = Variable<String>(securityQuestion);
    map['security_answer_hash'] = Variable<String>(securityAnswerHash);
    map['security_answer_salt'] = Variable<String>(securityAnswerSalt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StoresCompanion toCompanion(bool nullToAbsent) {
    return StoresCompanion(
      id: Value(id),
      storeName: Value(storeName),
      ownerName: Value(ownerName),
      phone: Value(phone),
      address: Value(address),
      headerMessage: Value(headerMessage),
      footerMessage: Value(footerMessage),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      pinHash: Value(pinHash),
      pinSalt: Value(pinSalt),
      securityQuestion: Value(securityQuestion),
      securityAnswerHash: Value(securityAnswerHash),
      securityAnswerSalt: Value(securityAnswerSalt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StoreData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoreData(
      id: serializer.fromJson<int>(json['id']),
      storeName: serializer.fromJson<String>(json['storeName']),
      ownerName: serializer.fromJson<String>(json['ownerName']),
      phone: serializer.fromJson<String>(json['phone']),
      address: serializer.fromJson<String>(json['address']),
      headerMessage: serializer.fromJson<String>(json['headerMessage']),
      footerMessage: serializer.fromJson<String>(json['footerMessage']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      pinHash: serializer.fromJson<String>(json['pinHash']),
      pinSalt: serializer.fromJson<String>(json['pinSalt']),
      securityQuestion: serializer.fromJson<String>(json['securityQuestion']),
      securityAnswerHash:
          serializer.fromJson<String>(json['securityAnswerHash']),
      securityAnswerSalt:
          serializer.fromJson<String>(json['securityAnswerSalt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeName': serializer.toJson<String>(storeName),
      'ownerName': serializer.toJson<String>(ownerName),
      'phone': serializer.toJson<String>(phone),
      'address': serializer.toJson<String>(address),
      'headerMessage': serializer.toJson<String>(headerMessage),
      'footerMessage': serializer.toJson<String>(footerMessage),
      'logoPath': serializer.toJson<String?>(logoPath),
      'pinHash': serializer.toJson<String>(pinHash),
      'pinSalt': serializer.toJson<String>(pinSalt),
      'securityQuestion': serializer.toJson<String>(securityQuestion),
      'securityAnswerHash': serializer.toJson<String>(securityAnswerHash),
      'securityAnswerSalt': serializer.toJson<String>(securityAnswerSalt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StoreData copyWith(
          {int? id,
          String? storeName,
          String? ownerName,
          String? phone,
          String? address,
          String? headerMessage,
          String? footerMessage,
          Value<String?> logoPath = const Value.absent(),
          String? pinHash,
          String? pinSalt,
          String? securityQuestion,
          String? securityAnswerHash,
          String? securityAnswerSalt,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      StoreData(
        id: id ?? this.id,
        storeName: storeName ?? this.storeName,
        ownerName: ownerName ?? this.ownerName,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        headerMessage: headerMessage ?? this.headerMessage,
        footerMessage: footerMessage ?? this.footerMessage,
        logoPath: logoPath.present ? logoPath.value : this.logoPath,
        pinHash: pinHash ?? this.pinHash,
        pinSalt: pinSalt ?? this.pinSalt,
        securityQuestion: securityQuestion ?? this.securityQuestion,
        securityAnswerHash: securityAnswerHash ?? this.securityAnswerHash,
        securityAnswerSalt: securityAnswerSalt ?? this.securityAnswerSalt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  StoreData copyWithCompanion(StoresCompanion data) {
    return StoreData(
      id: data.id.present ? data.id.value : this.id,
      storeName: data.storeName.present ? data.storeName.value : this.storeName,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      headerMessage: data.headerMessage.present
          ? data.headerMessage.value
          : this.headerMessage,
      footerMessage: data.footerMessage.present
          ? data.footerMessage.value
          : this.footerMessage,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      pinSalt: data.pinSalt.present ? data.pinSalt.value : this.pinSalt,
      securityQuestion: data.securityQuestion.present
          ? data.securityQuestion.value
          : this.securityQuestion,
      securityAnswerHash: data.securityAnswerHash.present
          ? data.securityAnswerHash.value
          : this.securityAnswerHash,
      securityAnswerSalt: data.securityAnswerSalt.present
          ? data.securityAnswerSalt.value
          : this.securityAnswerSalt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoreData(')
          ..write('id: $id, ')
          ..write('storeName: $storeName, ')
          ..write('ownerName: $ownerName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('headerMessage: $headerMessage, ')
          ..write('footerMessage: $footerMessage, ')
          ..write('logoPath: $logoPath, ')
          ..write('pinHash: $pinHash, ')
          ..write('pinSalt: $pinSalt, ')
          ..write('securityQuestion: $securityQuestion, ')
          ..write('securityAnswerHash: $securityAnswerHash, ')
          ..write('securityAnswerSalt: $securityAnswerSalt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      storeName,
      ownerName,
      phone,
      address,
      headerMessage,
      footerMessage,
      logoPath,
      pinHash,
      pinSalt,
      securityQuestion,
      securityAnswerHash,
      securityAnswerSalt,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoreData &&
          other.id == this.id &&
          other.storeName == this.storeName &&
          other.ownerName == this.ownerName &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.headerMessage == this.headerMessage &&
          other.footerMessage == this.footerMessage &&
          other.logoPath == this.logoPath &&
          other.pinHash == this.pinHash &&
          other.pinSalt == this.pinSalt &&
          other.securityQuestion == this.securityQuestion &&
          other.securityAnswerHash == this.securityAnswerHash &&
          other.securityAnswerSalt == this.securityAnswerSalt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StoresCompanion extends UpdateCompanion<StoreData> {
  final Value<int> id;
  final Value<String> storeName;
  final Value<String> ownerName;
  final Value<String> phone;
  final Value<String> address;
  final Value<String> headerMessage;
  final Value<String> footerMessage;
  final Value<String?> logoPath;
  final Value<String> pinHash;
  final Value<String> pinSalt;
  final Value<String> securityQuestion;
  final Value<String> securityAnswerHash;
  final Value<String> securityAnswerSalt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const StoresCompanion({
    this.id = const Value.absent(),
    this.storeName = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.headerMessage = const Value.absent(),
    this.footerMessage = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.pinSalt = const Value.absent(),
    this.securityQuestion = const Value.absent(),
    this.securityAnswerHash = const Value.absent(),
    this.securityAnswerSalt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StoresCompanion.insert({
    this.id = const Value.absent(),
    required String storeName,
    this.ownerName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.headerMessage = const Value.absent(),
    this.footerMessage = const Value.absent(),
    this.logoPath = const Value.absent(),
    required String pinHash,
    required String pinSalt,
    required String securityQuestion,
    required String securityAnswerHash,
    required String securityAnswerSalt,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : storeName = Value(storeName),
        pinHash = Value(pinHash),
        pinSalt = Value(pinSalt),
        securityQuestion = Value(securityQuestion),
        securityAnswerHash = Value(securityAnswerHash),
        securityAnswerSalt = Value(securityAnswerSalt);
  static Insertable<StoreData> custom({
    Expression<int>? id,
    Expression<String>? storeName,
    Expression<String>? ownerName,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? headerMessage,
    Expression<String>? footerMessage,
    Expression<String>? logoPath,
    Expression<String>? pinHash,
    Expression<String>? pinSalt,
    Expression<String>? securityQuestion,
    Expression<String>? securityAnswerHash,
    Expression<String>? securityAnswerSalt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeName != null) 'store_name': storeName,
      if (ownerName != null) 'owner_name': ownerName,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (headerMessage != null) 'header_message': headerMessage,
      if (footerMessage != null) 'footer_message': footerMessage,
      if (logoPath != null) 'logo_path': logoPath,
      if (pinHash != null) 'pin_hash': pinHash,
      if (pinSalt != null) 'pin_salt': pinSalt,
      if (securityQuestion != null) 'security_question': securityQuestion,
      if (securityAnswerHash != null)
        'security_answer_hash': securityAnswerHash,
      if (securityAnswerSalt != null)
        'security_answer_salt': securityAnswerSalt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StoresCompanion copyWith(
      {Value<int>? id,
      Value<String>? storeName,
      Value<String>? ownerName,
      Value<String>? phone,
      Value<String>? address,
      Value<String>? headerMessage,
      Value<String>? footerMessage,
      Value<String?>? logoPath,
      Value<String>? pinHash,
      Value<String>? pinSalt,
      Value<String>? securityQuestion,
      Value<String>? securityAnswerHash,
      Value<String>? securityAnswerSalt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return StoresCompanion(
      id: id ?? this.id,
      storeName: storeName ?? this.storeName,
      ownerName: ownerName ?? this.ownerName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      headerMessage: headerMessage ?? this.headerMessage,
      footerMessage: footerMessage ?? this.footerMessage,
      logoPath: logoPath ?? this.logoPath,
      pinHash: pinHash ?? this.pinHash,
      pinSalt: pinSalt ?? this.pinSalt,
      securityQuestion: securityQuestion ?? this.securityQuestion,
      securityAnswerHash: securityAnswerHash ?? this.securityAnswerHash,
      securityAnswerSalt: securityAnswerSalt ?? this.securityAnswerSalt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeName.present) {
      map['store_name'] = Variable<String>(storeName.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (headerMessage.present) {
      map['header_message'] = Variable<String>(headerMessage.value);
    }
    if (footerMessage.present) {
      map['footer_message'] = Variable<String>(footerMessage.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
    }
    if (pinSalt.present) {
      map['pin_salt'] = Variable<String>(pinSalt.value);
    }
    if (securityQuestion.present) {
      map['security_question'] = Variable<String>(securityQuestion.value);
    }
    if (securityAnswerHash.present) {
      map['security_answer_hash'] = Variable<String>(securityAnswerHash.value);
    }
    if (securityAnswerSalt.present) {
      map['security_answer_salt'] = Variable<String>(securityAnswerSalt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoresCompanion(')
          ..write('id: $id, ')
          ..write('storeName: $storeName, ')
          ..write('ownerName: $ownerName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('headerMessage: $headerMessage, ')
          ..write('footerMessage: $footerMessage, ')
          ..write('logoPath: $logoPath, ')
          ..write('pinHash: $pinHash, ')
          ..write('pinSalt: $pinSalt, ')
          ..write('securityQuestion: $securityQuestion, ')
          ..write('securityAnswerHash: $securityAnswerHash, ')
          ..write('securityAnswerSalt: $securityAnswerSalt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
      'password_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _saltMeta = const VerificationMeta('salt');
  @override
  late final GeneratedColumn<String> salt = GeneratedColumn<String>(
      'salt', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fullnameMeta =
      const VerificationMeta('fullname');
  @override
  late final GeneratedColumn<String> fullname = GeneratedColumn<String>(
      'fullname', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('cashier'));
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        username,
        email,
        passwordHash,
        salt,
        fullname,
        role,
        photoPath,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<UserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('salt')) {
      context.handle(
          _saltMeta, salt.isAcceptableOrUnknown(data['salt']!, _saltMeta));
    } else if (isInserting) {
      context.missing(_saltMeta);
    }
    if (data.containsKey('fullname')) {
      context.handle(_fullnameMeta,
          fullname.isAcceptableOrUnknown(data['fullname']!, _fullnameMeta));
    } else if (isInserting) {
      context.missing(_fullnameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      salt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}salt'])!,
      fullname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fullname'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserData extends DataClass implements Insertable<UserData> {
  final int id;
  final String username;
  final String email;
  final String passwordHash;
  final String salt;
  final String fullname;
  final String role;
  final String? photoPath;
  final DateTime createdAt;
  const UserData(
      {required this.id,
      required this.username,
      required this.email,
      required this.passwordHash,
      required this.salt,
      required this.fullname,
      required this.role,
      this.photoPath,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['email'] = Variable<String>(email);
    map['password_hash'] = Variable<String>(passwordHash);
    map['salt'] = Variable<String>(salt);
    map['fullname'] = Variable<String>(fullname);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      email: Value(email),
      passwordHash: Value(passwordHash),
      salt: Value(salt),
      fullname: Value(fullname),
      role: Value(role),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdAt: Value(createdAt),
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserData(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      salt: serializer.fromJson<String>(json['salt']),
      fullname: serializer.fromJson<String>(json['fullname']),
      role: serializer.fromJson<String>(json['role']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'salt': serializer.toJson<String>(salt),
      'fullname': serializer.toJson<String>(fullname),
      'role': serializer.toJson<String>(role),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserData copyWith(
          {int? id,
          String? username,
          String? email,
          String? passwordHash,
          String? salt,
          String? fullname,
          String? role,
          Value<String?> photoPath = const Value.absent(),
          DateTime? createdAt}) =>
      UserData(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        salt: salt ?? this.salt,
        fullname: fullname ?? this.fullname,
        role: role ?? this.role,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        createdAt: createdAt ?? this.createdAt,
      );
  UserData copyWithCompanion(UsersCompanion data) {
    return UserData(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      salt: data.salt.present ? data.salt.value : this.salt,
      fullname: data.fullname.present ? data.fullname.value : this.fullname,
      role: data.role.present ? data.role.value : this.role,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('salt: $salt, ')
          ..write('fullname: $fullname, ')
          ..write('role: $role, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, email, passwordHash, salt,
      fullname, role, photoPath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.username == this.username &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.salt == this.salt &&
          other.fullname == this.fullname &&
          other.role == this.role &&
          other.photoPath == this.photoPath &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<UserData> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> email;
  final Value<String> passwordHash;
  final Value<String> salt;
  final Value<String> fullname;
  final Value<String> role;
  final Value<String?> photoPath;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.salt = const Value.absent(),
    this.fullname = const Value.absent(),
    this.role = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String email,
    required String passwordHash,
    required String salt,
    required String fullname,
    this.role = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : username = Value(username),
        email = Value(email),
        passwordHash = Value(passwordHash),
        salt = Value(salt),
        fullname = Value(fullname);
  static Insertable<UserData> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<String>? salt,
    Expression<String>? fullname,
    Expression<String>? role,
    Expression<String>? photoPath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (salt != null) 'salt': salt,
      if (fullname != null) 'fullname': fullname,
      if (role != null) 'role': role,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? email,
      Value<String>? passwordHash,
      Value<String>? salt,
      Value<String>? fullname,
      Value<String>? role,
      Value<String?>? photoPath,
      Value<DateTime>? createdAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      salt: salt ?? this.salt,
      fullname: fullname ?? this.fullname,
      role: role ?? this.role,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (salt.present) {
      map['salt'] = Variable<String>(salt.value);
    }
    if (fullname.present) {
      map['fullname'] = Variable<String>(fullname.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('salt: $salt, ')
          ..write('fullname: $fullname, ')
          ..write('role: $role, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
      'store_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES stores (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconNameMeta =
      const VerificationMeta('iconName');
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
      'icon_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, storeId, name, type, iconName, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(_iconNameMeta,
          iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}store_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      iconName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_name']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class CategoryData extends DataClass implements Insertable<CategoryData> {
  final int id;
  final int? storeId;
  final String name;
  final String type;
  final String? iconName;
  final DateTime createdAt;
  const CategoryData(
      {required this.id,
      this.storeId,
      required this.name,
      required this.type,
      this.iconName,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<int>(storeId);
    }
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      name: Value(name),
      type: Value(type),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
      createdAt: Value(createdAt),
    );
  }

  factory CategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryData(
      id: serializer.fromJson<int>(json['id']),
      storeId: serializer.fromJson<int?>(json['storeId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      iconName: serializer.fromJson<String?>(json['iconName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeId': serializer.toJson<int?>(storeId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'iconName': serializer.toJson<String?>(iconName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CategoryData copyWith(
          {int? id,
          Value<int?> storeId = const Value.absent(),
          String? name,
          String? type,
          Value<String?> iconName = const Value.absent(),
          DateTime? createdAt}) =>
      CategoryData(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        name: name ?? this.name,
        type: type ?? this.type,
        iconName: iconName.present ? iconName.value : this.iconName,
        createdAt: createdAt ?? this.createdAt,
      );
  CategoryData copyWithCompanion(CategoriesCompanion data) {
    return CategoryData(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryData(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('iconName: $iconName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, storeId, name, type, iconName, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryData &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.name == this.name &&
          other.type == this.type &&
          other.iconName == this.iconName &&
          other.createdAt == this.createdAt);
}

class CategoriesCompanion extends UpdateCompanion<CategoryData> {
  final Value<int> id;
  final Value<int?> storeId;
  final Value<String> name;
  final Value<String> type;
  final Value<String?> iconName;
  final Value<DateTime> createdAt;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.iconName = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    required String name,
    required String type,
    this.iconName = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        type = Value(type);
  static Insertable<CategoryData> custom({
    Expression<int>? id,
    Expression<int>? storeId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? iconName,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (iconName != null) 'icon_name': iconName,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? storeId,
      Value<String>? name,
      Value<String>? type,
      Value<String?>? iconName,
      Value<DateTime>? createdAt}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      name: name ?? this.name,
      type: type ?? this.type,
      iconName: iconName ?? this.iconName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('iconName: $iconName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products
    with TableInfo<$ProductsTable, ProductData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
      'store_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES stores (id)'));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pcs'));
  static const VerificationMeta _costPriceMeta =
      const VerificationMeta('costPrice');
  @override
  late final GeneratedColumn<int> costPrice = GeneratedColumn<int>(
      'cost_price', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sellingPriceMeta =
      const VerificationMeta('sellingPrice');
  @override
  late final GeneratedColumn<int> sellingPrice = GeneratedColumn<int>(
      'selling_price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _minStockAlertMeta =
      const VerificationMeta('minStockAlert');
  @override
  late final GeneratedColumn<int> minStockAlert = GeneratedColumn<int>(
      'min_stock_alert', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5));
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        storeId,
        sku,
        name,
        categoryId,
        unit,
        costPrice,
        sellingPrice,
        stock,
        minStockAlert,
        photoPath,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<ProductData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('cost_price')) {
      context.handle(_costPriceMeta,
          costPrice.isAcceptableOrUnknown(data['cost_price']!, _costPriceMeta));
    }
    if (data.containsKey('selling_price')) {
      context.handle(
          _sellingPriceMeta,
          sellingPrice.isAcceptableOrUnknown(
              data['selling_price']!, _sellingPriceMeta));
    } else if (isInserting) {
      context.missing(_sellingPriceMeta);
    }
    if (data.containsKey('stock')) {
      context.handle(
          _stockMeta, stock.isAcceptableOrUnknown(data['stock']!, _stockMeta));
    }
    if (data.containsKey('min_stock_alert')) {
      context.handle(
          _minStockAlertMeta,
          minStockAlert.isAcceptableOrUnknown(
              data['min_stock_alert']!, _minStockAlertMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}store_id']),
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      costPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cost_price'])!,
      sellingPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}selling_price'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
      minStockAlert: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_stock_alert'])!,
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductData extends DataClass implements Insertable<ProductData> {
  final int id;
  final int? storeId;
  final String? sku;
  final String name;
  final int? categoryId;
  final String unit;
  final int costPrice;
  final int sellingPrice;
  final int stock;
  final int minStockAlert;
  final String? photoPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ProductData(
      {required this.id,
      this.storeId,
      this.sku,
      required this.name,
      this.categoryId,
      required this.unit,
      required this.costPrice,
      required this.sellingPrice,
      required this.stock,
      required this.minStockAlert,
      this.photoPath,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<int>(storeId);
    }
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['unit'] = Variable<String>(unit);
    map['cost_price'] = Variable<int>(costPrice);
    map['selling_price'] = Variable<int>(sellingPrice);
    map['stock'] = Variable<int>(stock);
    map['min_stock_alert'] = Variable<int>(minStockAlert);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      name: Value(name),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      unit: Value(unit),
      costPrice: Value(costPrice),
      sellingPrice: Value(sellingPrice),
      stock: Value(stock),
      minStockAlert: Value(minStockAlert),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProductData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductData(
      id: serializer.fromJson<int>(json['id']),
      storeId: serializer.fromJson<int?>(json['storeId']),
      sku: serializer.fromJson<String?>(json['sku']),
      name: serializer.fromJson<String>(json['name']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      unit: serializer.fromJson<String>(json['unit']),
      costPrice: serializer.fromJson<int>(json['costPrice']),
      sellingPrice: serializer.fromJson<int>(json['sellingPrice']),
      stock: serializer.fromJson<int>(json['stock']),
      minStockAlert: serializer.fromJson<int>(json['minStockAlert']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeId': serializer.toJson<int?>(storeId),
      'sku': serializer.toJson<String?>(sku),
      'name': serializer.toJson<String>(name),
      'categoryId': serializer.toJson<int?>(categoryId),
      'unit': serializer.toJson<String>(unit),
      'costPrice': serializer.toJson<int>(costPrice),
      'sellingPrice': serializer.toJson<int>(sellingPrice),
      'stock': serializer.toJson<int>(stock),
      'minStockAlert': serializer.toJson<int>(minStockAlert),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProductData copyWith(
          {int? id,
          Value<int?> storeId = const Value.absent(),
          Value<String?> sku = const Value.absent(),
          String? name,
          Value<int?> categoryId = const Value.absent(),
          String? unit,
          int? costPrice,
          int? sellingPrice,
          int? stock,
          int? minStockAlert,
          Value<String?> photoPath = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ProductData(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        sku: sku.present ? sku.value : this.sku,
        name: name ?? this.name,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        unit: unit ?? this.unit,
        costPrice: costPrice ?? this.costPrice,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        stock: stock ?? this.stock,
        minStockAlert: minStockAlert ?? this.minStockAlert,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ProductData copyWithCompanion(ProductsCompanion data) {
    return ProductData(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      sku: data.sku.present ? data.sku.value : this.sku,
      name: data.name.present ? data.name.value : this.name,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      unit: data.unit.present ? data.unit.value : this.unit,
      costPrice: data.costPrice.present ? data.costPrice.value : this.costPrice,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      stock: data.stock.present ? data.stock.value : this.stock,
      minStockAlert: data.minStockAlert.present
          ? data.minStockAlert.value
          : this.minStockAlert,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductData(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('sku: $sku, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('unit: $unit, ')
          ..write('costPrice: $costPrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('stock: $stock, ')
          ..write('minStockAlert: $minStockAlert, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      storeId,
      sku,
      name,
      categoryId,
      unit,
      costPrice,
      sellingPrice,
      stock,
      minStockAlert,
      photoPath,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductData &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.sku == this.sku &&
          other.name == this.name &&
          other.categoryId == this.categoryId &&
          other.unit == this.unit &&
          other.costPrice == this.costPrice &&
          other.sellingPrice == this.sellingPrice &&
          other.stock == this.stock &&
          other.minStockAlert == this.minStockAlert &&
          other.photoPath == this.photoPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<ProductData> {
  final Value<int> id;
  final Value<int?> storeId;
  final Value<String?> sku;
  final Value<String> name;
  final Value<int?> categoryId;
  final Value<String> unit;
  final Value<int> costPrice;
  final Value<int> sellingPrice;
  final Value<int> stock;
  final Value<int> minStockAlert;
  final Value<String?> photoPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.sku = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.unit = const Value.absent(),
    this.costPrice = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.stock = const Value.absent(),
    this.minStockAlert = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.sku = const Value.absent(),
    required String name,
    this.categoryId = const Value.absent(),
    this.unit = const Value.absent(),
    this.costPrice = const Value.absent(),
    required int sellingPrice,
    this.stock = const Value.absent(),
    this.minStockAlert = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : name = Value(name),
        sellingPrice = Value(sellingPrice);
  static Insertable<ProductData> custom({
    Expression<int>? id,
    Expression<int>? storeId,
    Expression<String>? sku,
    Expression<String>? name,
    Expression<int>? categoryId,
    Expression<String>? unit,
    Expression<int>? costPrice,
    Expression<int>? sellingPrice,
    Expression<int>? stock,
    Expression<int>? minStockAlert,
    Expression<String>? photoPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (sku != null) 'sku': sku,
      if (name != null) 'name': name,
      if (categoryId != null) 'category_id': categoryId,
      if (unit != null) 'unit': unit,
      if (costPrice != null) 'cost_price': costPrice,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (stock != null) 'stock': stock,
      if (minStockAlert != null) 'min_stock_alert': minStockAlert,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProductsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? storeId,
      Value<String?>? sku,
      Value<String>? name,
      Value<int?>? categoryId,
      Value<String>? unit,
      Value<int>? costPrice,
      Value<int>? sellingPrice,
      Value<int>? stock,
      Value<int>? minStockAlert,
      Value<String?>? photoPath,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ProductsCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      unit: unit ?? this.unit,
      costPrice: costPrice ?? this.costPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      stock: stock ?? this.stock,
      minStockAlert: minStockAlert ?? this.minStockAlert,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (costPrice.present) {
      map['cost_price'] = Variable<int>(costPrice.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<int>(sellingPrice.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (minStockAlert.present) {
      map['min_stock_alert'] = Variable<int>(minStockAlert.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('sku: $sku, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('unit: $unit, ')
          ..write('costPrice: $costPrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('stock: $stock, ')
          ..write('minStockAlert: $minStockAlert, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ServicesTable extends Services
    with TableInfo<$ServicesTable, ServiceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
      'store_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES stores (id)'));
  static const VerificationMeta _serviceNameMeta =
      const VerificationMeta('serviceName');
  @override
  late final GeneratedColumn<String> serviceName = GeneratedColumn<String>(
      'service_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  static const VerificationMeta _materialCostMeta =
      const VerificationMeta('materialCost');
  @override
  late final GeneratedColumn<int> materialCost = GeneratedColumn<int>(
      'material_cost', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _finalPriceMeta =
      const VerificationMeta('finalPrice');
  @override
  late final GeneratedColumn<int> finalPrice = GeneratedColumn<int>(
      'final_price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durationValueMeta =
      const VerificationMeta('durationValue');
  @override
  late final GeneratedColumn<int> durationValue = GeneratedColumn<int>(
      'duration_value', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _durationUnitMeta =
      const VerificationMeta('durationUnit');
  @override
  late final GeneratedColumn<String> durationUnit = GeneratedColumn<String>(
      'duration_unit', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('days'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        storeId,
        serviceName,
        categoryId,
        materialCost,
        finalPrice,
        durationValue,
        durationUnit,
        description,
        photoPath,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'services';
  @override
  VerificationContext validateIntegrity(Insertable<ServiceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('service_name')) {
      context.handle(
          _serviceNameMeta,
          serviceName.isAcceptableOrUnknown(
              data['service_name']!, _serviceNameMeta));
    } else if (isInserting) {
      context.missing(_serviceNameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('material_cost')) {
      context.handle(
          _materialCostMeta,
          materialCost.isAcceptableOrUnknown(
              data['material_cost']!, _materialCostMeta));
    }
    if (data.containsKey('final_price')) {
      context.handle(
          _finalPriceMeta,
          finalPrice.isAcceptableOrUnknown(
              data['final_price']!, _finalPriceMeta));
    } else if (isInserting) {
      context.missing(_finalPriceMeta);
    }
    if (data.containsKey('duration_value')) {
      context.handle(
          _durationValueMeta,
          durationValue.isAcceptableOrUnknown(
              data['duration_value']!, _durationValueMeta));
    }
    if (data.containsKey('duration_unit')) {
      context.handle(
          _durationUnitMeta,
          durationUnit.isAcceptableOrUnknown(
              data['duration_unit']!, _durationUnitMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}store_id']),
      serviceName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_name'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      materialCost: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}material_cost'])!,
      finalPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}final_price'])!,
      durationValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_value'])!,
      durationUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}duration_unit'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ServicesTable createAlias(String alias) {
    return $ServicesTable(attachedDatabase, alias);
  }
}

class ServiceData extends DataClass implements Insertable<ServiceData> {
  final int id;
  final int? storeId;
  final String serviceName;
  final int? categoryId;
  final int materialCost;
  final int finalPrice;
  final int durationValue;
  final String durationUnit;
  final String? description;
  final String? photoPath;
  final DateTime createdAt;
  const ServiceData(
      {required this.id,
      this.storeId,
      required this.serviceName,
      this.categoryId,
      required this.materialCost,
      required this.finalPrice,
      required this.durationValue,
      required this.durationUnit,
      this.description,
      this.photoPath,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<int>(storeId);
    }
    map['service_name'] = Variable<String>(serviceName);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['material_cost'] = Variable<int>(materialCost);
    map['final_price'] = Variable<int>(finalPrice);
    map['duration_value'] = Variable<int>(durationValue);
    map['duration_unit'] = Variable<String>(durationUnit);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ServicesCompanion toCompanion(bool nullToAbsent) {
    return ServicesCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      serviceName: Value(serviceName),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      materialCost: Value(materialCost),
      finalPrice: Value(finalPrice),
      durationValue: Value(durationValue),
      durationUnit: Value(durationUnit),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdAt: Value(createdAt),
    );
  }

  factory ServiceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceData(
      id: serializer.fromJson<int>(json['id']),
      storeId: serializer.fromJson<int?>(json['storeId']),
      serviceName: serializer.fromJson<String>(json['serviceName']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      materialCost: serializer.fromJson<int>(json['materialCost']),
      finalPrice: serializer.fromJson<int>(json['finalPrice']),
      durationValue: serializer.fromJson<int>(json['durationValue']),
      durationUnit: serializer.fromJson<String>(json['durationUnit']),
      description: serializer.fromJson<String?>(json['description']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeId': serializer.toJson<int?>(storeId),
      'serviceName': serializer.toJson<String>(serviceName),
      'categoryId': serializer.toJson<int?>(categoryId),
      'materialCost': serializer.toJson<int>(materialCost),
      'finalPrice': serializer.toJson<int>(finalPrice),
      'durationValue': serializer.toJson<int>(durationValue),
      'durationUnit': serializer.toJson<String>(durationUnit),
      'description': serializer.toJson<String?>(description),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ServiceData copyWith(
          {int? id,
          Value<int?> storeId = const Value.absent(),
          String? serviceName,
          Value<int?> categoryId = const Value.absent(),
          int? materialCost,
          int? finalPrice,
          int? durationValue,
          String? durationUnit,
          Value<String?> description = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          DateTime? createdAt}) =>
      ServiceData(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        serviceName: serviceName ?? this.serviceName,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        materialCost: materialCost ?? this.materialCost,
        finalPrice: finalPrice ?? this.finalPrice,
        durationValue: durationValue ?? this.durationValue,
        durationUnit: durationUnit ?? this.durationUnit,
        description: description.present ? description.value : this.description,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        createdAt: createdAt ?? this.createdAt,
      );
  ServiceData copyWithCompanion(ServicesCompanion data) {
    return ServiceData(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      serviceName:
          data.serviceName.present ? data.serviceName.value : this.serviceName,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      materialCost: data.materialCost.present
          ? data.materialCost.value
          : this.materialCost,
      finalPrice:
          data.finalPrice.present ? data.finalPrice.value : this.finalPrice,
      durationValue: data.durationValue.present
          ? data.durationValue.value
          : this.durationValue,
      durationUnit: data.durationUnit.present
          ? data.durationUnit.value
          : this.durationUnit,
      description:
          data.description.present ? data.description.value : this.description,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceData(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('serviceName: $serviceName, ')
          ..write('categoryId: $categoryId, ')
          ..write('materialCost: $materialCost, ')
          ..write('finalPrice: $finalPrice, ')
          ..write('durationValue: $durationValue, ')
          ..write('durationUnit: $durationUnit, ')
          ..write('description: $description, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      storeId,
      serviceName,
      categoryId,
      materialCost,
      finalPrice,
      durationValue,
      durationUnit,
      description,
      photoPath,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceData &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.serviceName == this.serviceName &&
          other.categoryId == this.categoryId &&
          other.materialCost == this.materialCost &&
          other.finalPrice == this.finalPrice &&
          other.durationValue == this.durationValue &&
          other.durationUnit == this.durationUnit &&
          other.description == this.description &&
          other.photoPath == this.photoPath &&
          other.createdAt == this.createdAt);
}

class ServicesCompanion extends UpdateCompanion<ServiceData> {
  final Value<int> id;
  final Value<int?> storeId;
  final Value<String> serviceName;
  final Value<int?> categoryId;
  final Value<int> materialCost;
  final Value<int> finalPrice;
  final Value<int> durationValue;
  final Value<String> durationUnit;
  final Value<String?> description;
  final Value<String?> photoPath;
  final Value<DateTime> createdAt;
  const ServicesCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.serviceName = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.materialCost = const Value.absent(),
    this.finalPrice = const Value.absent(),
    this.durationValue = const Value.absent(),
    this.durationUnit = const Value.absent(),
    this.description = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ServicesCompanion.insert({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    required String serviceName,
    this.categoryId = const Value.absent(),
    this.materialCost = const Value.absent(),
    required int finalPrice,
    this.durationValue = const Value.absent(),
    this.durationUnit = const Value.absent(),
    this.description = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : serviceName = Value(serviceName),
        finalPrice = Value(finalPrice);
  static Insertable<ServiceData> custom({
    Expression<int>? id,
    Expression<int>? storeId,
    Expression<String>? serviceName,
    Expression<int>? categoryId,
    Expression<int>? materialCost,
    Expression<int>? finalPrice,
    Expression<int>? durationValue,
    Expression<String>? durationUnit,
    Expression<String>? description,
    Expression<String>? photoPath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (serviceName != null) 'service_name': serviceName,
      if (categoryId != null) 'category_id': categoryId,
      if (materialCost != null) 'material_cost': materialCost,
      if (finalPrice != null) 'final_price': finalPrice,
      if (durationValue != null) 'duration_value': durationValue,
      if (durationUnit != null) 'duration_unit': durationUnit,
      if (description != null) 'description': description,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ServicesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? storeId,
      Value<String>? serviceName,
      Value<int?>? categoryId,
      Value<int>? materialCost,
      Value<int>? finalPrice,
      Value<int>? durationValue,
      Value<String>? durationUnit,
      Value<String?>? description,
      Value<String?>? photoPath,
      Value<DateTime>? createdAt}) {
    return ServicesCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      serviceName: serviceName ?? this.serviceName,
      categoryId: categoryId ?? this.categoryId,
      materialCost: materialCost ?? this.materialCost,
      finalPrice: finalPrice ?? this.finalPrice,
      durationValue: durationValue ?? this.durationValue,
      durationUnit: durationUnit ?? this.durationUnit,
      description: description ?? this.description,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (serviceName.present) {
      map['service_name'] = Variable<String>(serviceName.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (materialCost.present) {
      map['material_cost'] = Variable<int>(materialCost.value);
    }
    if (finalPrice.present) {
      map['final_price'] = Variable<int>(finalPrice.value);
    }
    if (durationValue.present) {
      map['duration_value'] = Variable<int>(durationValue.value);
    }
    if (durationUnit.present) {
      map['duration_unit'] = Variable<String>(durationUnit.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicesCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('serviceName: $serviceName, ')
          ..write('categoryId: $categoryId, ')
          ..write('materialCost: $materialCost, ')
          ..write('finalPrice: $finalPrice, ')
          ..write('durationValue: $durationValue, ')
          ..write('durationUnit: $durationUnit, ')
          ..write('description: $description, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
      'store_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES stores (id)'));
  static const VerificationMeta _invoiceNumberMeta =
      const VerificationMeta('invoiceNumber');
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
      'invoice_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _customerNameMeta =
      const VerificationMeta('customerName');
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
      'customer_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customerPhoneMeta =
      const VerificationMeta('customerPhone');
  @override
  late final GeneratedColumn<String> customerPhone = GeneratedColumn<String>(
      'customer_phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<int> subtotal = GeneratedColumn<int>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _discountMeta =
      const VerificationMeta('discount');
  @override
  late final GeneratedColumn<int> discount = GeneratedColumn<int>(
      'discount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<int> totalAmount = GeneratedColumn<int>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _paymentAmountMeta =
      const VerificationMeta('paymentAmount');
  @override
  late final GeneratedColumn<int> paymentAmount = GeneratedColumn<int>(
      'payment_amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _changeAmountMeta =
      const VerificationMeta('changeAmount');
  @override
  late final GeneratedColumn<int> changeAmount = GeneratedColumn<int>(
      'change_amount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('cash'));
  static const VerificationMeta _totalProfitMeta =
      const VerificationMeta('totalProfit');
  @override
  late final GeneratedColumn<int> totalProfit = GeneratedColumn<int>(
      'total_profit', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        storeId,
        invoiceNumber,
        customerName,
        customerPhone,
        subtotal,
        discount,
        totalAmount,
        paymentAmount,
        changeAmount,
        paymentMethod,
        totalProfit,
        userId,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
          _invoiceNumberMeta,
          invoiceNumber.isAcceptableOrUnknown(
              data['invoice_number']!, _invoiceNumberMeta));
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
          _customerNameMeta,
          customerName.isAcceptableOrUnknown(
              data['customer_name']!, _customerNameMeta));
    }
    if (data.containsKey('customer_phone')) {
      context.handle(
          _customerPhoneMeta,
          customerPhone.isAcceptableOrUnknown(
              data['customer_phone']!, _customerPhoneMeta));
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(_discountMeta,
          discount.isAcceptableOrUnknown(data['discount']!, _discountMeta));
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('payment_amount')) {
      context.handle(
          _paymentAmountMeta,
          paymentAmount.isAcceptableOrUnknown(
              data['payment_amount']!, _paymentAmountMeta));
    } else if (isInserting) {
      context.missing(_paymentAmountMeta);
    }
    if (data.containsKey('change_amount')) {
      context.handle(
          _changeAmountMeta,
          changeAmount.isAcceptableOrUnknown(
              data['change_amount']!, _changeAmountMeta));
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    }
    if (data.containsKey('total_profit')) {
      context.handle(
          _totalProfitMeta,
          totalProfit.isAcceptableOrUnknown(
              data['total_profit']!, _totalProfitMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}store_id']),
      invoiceNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invoice_number'])!,
      customerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_name']),
      customerPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_phone']),
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subtotal'])!,
      discount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}discount'])!,
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_amount'])!,
      paymentAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_amount'])!,
      changeAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}change_amount'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method'])!,
      totalProfit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_profit'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class TransactionData extends DataClass implements Insertable<TransactionData> {
  final int id;
  final int? storeId;
  final String invoiceNumber;
  final String? customerName;
  final String? customerPhone;
  final int subtotal;
  final int discount;
  final int totalAmount;
  final int paymentAmount;
  final int changeAmount;
  final String paymentMethod;
  final int totalProfit;
  final int userId;
  final DateTime createdAt;
  const TransactionData(
      {required this.id,
      this.storeId,
      required this.invoiceNumber,
      this.customerName,
      this.customerPhone,
      required this.subtotal,
      required this.discount,
      required this.totalAmount,
      required this.paymentAmount,
      required this.changeAmount,
      required this.paymentMethod,
      required this.totalProfit,
      required this.userId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<int>(storeId);
    }
    map['invoice_number'] = Variable<String>(invoiceNumber);
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    if (!nullToAbsent || customerPhone != null) {
      map['customer_phone'] = Variable<String>(customerPhone);
    }
    map['subtotal'] = Variable<int>(subtotal);
    map['discount'] = Variable<int>(discount);
    map['total_amount'] = Variable<int>(totalAmount);
    map['payment_amount'] = Variable<int>(paymentAmount);
    map['change_amount'] = Variable<int>(changeAmount);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['total_profit'] = Variable<int>(totalProfit);
    map['user_id'] = Variable<int>(userId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      invoiceNumber: Value(invoiceNumber),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      customerPhone: customerPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(customerPhone),
      subtotal: Value(subtotal),
      discount: Value(discount),
      totalAmount: Value(totalAmount),
      paymentAmount: Value(paymentAmount),
      changeAmount: Value(changeAmount),
      paymentMethod: Value(paymentMethod),
      totalProfit: Value(totalProfit),
      userId: Value(userId),
      createdAt: Value(createdAt),
    );
  }

  factory TransactionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionData(
      id: serializer.fromJson<int>(json['id']),
      storeId: serializer.fromJson<int?>(json['storeId']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      customerPhone: serializer.fromJson<String?>(json['customerPhone']),
      subtotal: serializer.fromJson<int>(json['subtotal']),
      discount: serializer.fromJson<int>(json['discount']),
      totalAmount: serializer.fromJson<int>(json['totalAmount']),
      paymentAmount: serializer.fromJson<int>(json['paymentAmount']),
      changeAmount: serializer.fromJson<int>(json['changeAmount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      totalProfit: serializer.fromJson<int>(json['totalProfit']),
      userId: serializer.fromJson<int>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeId': serializer.toJson<int?>(storeId),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'customerName': serializer.toJson<String?>(customerName),
      'customerPhone': serializer.toJson<String?>(customerPhone),
      'subtotal': serializer.toJson<int>(subtotal),
      'discount': serializer.toJson<int>(discount),
      'totalAmount': serializer.toJson<int>(totalAmount),
      'paymentAmount': serializer.toJson<int>(paymentAmount),
      'changeAmount': serializer.toJson<int>(changeAmount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'totalProfit': serializer.toJson<int>(totalProfit),
      'userId': serializer.toJson<int>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TransactionData copyWith(
          {int? id,
          Value<int?> storeId = const Value.absent(),
          String? invoiceNumber,
          Value<String?> customerName = const Value.absent(),
          Value<String?> customerPhone = const Value.absent(),
          int? subtotal,
          int? discount,
          int? totalAmount,
          int? paymentAmount,
          int? changeAmount,
          String? paymentMethod,
          int? totalProfit,
          int? userId,
          DateTime? createdAt}) =>
      TransactionData(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        customerName:
            customerName.present ? customerName.value : this.customerName,
        customerPhone:
            customerPhone.present ? customerPhone.value : this.customerPhone,
        subtotal: subtotal ?? this.subtotal,
        discount: discount ?? this.discount,
        totalAmount: totalAmount ?? this.totalAmount,
        paymentAmount: paymentAmount ?? this.paymentAmount,
        changeAmount: changeAmount ?? this.changeAmount,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        totalProfit: totalProfit ?? this.totalProfit,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
      );
  TransactionData copyWithCompanion(TransactionsCompanion data) {
    return TransactionData(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      customerPhone: data.customerPhone.present
          ? data.customerPhone.value
          : this.customerPhone,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      discount: data.discount.present ? data.discount.value : this.discount,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      paymentAmount: data.paymentAmount.present
          ? data.paymentAmount.value
          : this.paymentAmount,
      changeAmount: data.changeAmount.present
          ? data.changeAmount.value
          : this.changeAmount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      totalProfit:
          data.totalProfit.present ? data.totalProfit.value : this.totalProfit,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionData(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('customerName: $customerName, ')
          ..write('customerPhone: $customerPhone, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('paymentAmount: $paymentAmount, ')
          ..write('changeAmount: $changeAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('totalProfit: $totalProfit, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      storeId,
      invoiceNumber,
      customerName,
      customerPhone,
      subtotal,
      discount,
      totalAmount,
      paymentAmount,
      changeAmount,
      paymentMethod,
      totalProfit,
      userId,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionData &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.invoiceNumber == this.invoiceNumber &&
          other.customerName == this.customerName &&
          other.customerPhone == this.customerPhone &&
          other.subtotal == this.subtotal &&
          other.discount == this.discount &&
          other.totalAmount == this.totalAmount &&
          other.paymentAmount == this.paymentAmount &&
          other.changeAmount == this.changeAmount &&
          other.paymentMethod == this.paymentMethod &&
          other.totalProfit == this.totalProfit &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<TransactionData> {
  final Value<int> id;
  final Value<int?> storeId;
  final Value<String> invoiceNumber;
  final Value<String?> customerName;
  final Value<String?> customerPhone;
  final Value<int> subtotal;
  final Value<int> discount;
  final Value<int> totalAmount;
  final Value<int> paymentAmount;
  final Value<int> changeAmount;
  final Value<String> paymentMethod;
  final Value<int> totalProfit;
  final Value<int> userId;
  final Value<DateTime> createdAt;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.customerName = const Value.absent(),
    this.customerPhone = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discount = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.paymentAmount = const Value.absent(),
    this.changeAmount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.totalProfit = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    required String invoiceNumber,
    this.customerName = const Value.absent(),
    this.customerPhone = const Value.absent(),
    required int subtotal,
    this.discount = const Value.absent(),
    required int totalAmount,
    required int paymentAmount,
    this.changeAmount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.totalProfit = const Value.absent(),
    required int userId,
    this.createdAt = const Value.absent(),
  })  : invoiceNumber = Value(invoiceNumber),
        subtotal = Value(subtotal),
        totalAmount = Value(totalAmount),
        paymentAmount = Value(paymentAmount),
        userId = Value(userId);
  static Insertable<TransactionData> custom({
    Expression<int>? id,
    Expression<int>? storeId,
    Expression<String>? invoiceNumber,
    Expression<String>? customerName,
    Expression<String>? customerPhone,
    Expression<int>? subtotal,
    Expression<int>? discount,
    Expression<int>? totalAmount,
    Expression<int>? paymentAmount,
    Expression<int>? changeAmount,
    Expression<String>? paymentMethod,
    Expression<int>? totalProfit,
    Expression<int>? userId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (customerName != null) 'customer_name': customerName,
      if (customerPhone != null) 'customer_phone': customerPhone,
      if (subtotal != null) 'subtotal': subtotal,
      if (discount != null) 'discount': discount,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (paymentAmount != null) 'payment_amount': paymentAmount,
      if (changeAmount != null) 'change_amount': changeAmount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (totalProfit != null) 'total_profit': totalProfit,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? storeId,
      Value<String>? invoiceNumber,
      Value<String?>? customerName,
      Value<String?>? customerPhone,
      Value<int>? subtotal,
      Value<int>? discount,
      Value<int>? totalAmount,
      Value<int>? paymentAmount,
      Value<int>? changeAmount,
      Value<String>? paymentMethod,
      Value<int>? totalProfit,
      Value<int>? userId,
      Value<DateTime>? createdAt}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      changeAmount: changeAmount ?? this.changeAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalProfit: totalProfit ?? this.totalProfit,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (customerPhone.present) {
      map['customer_phone'] = Variable<String>(customerPhone.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<int>(subtotal.value);
    }
    if (discount.present) {
      map['discount'] = Variable<int>(discount.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<int>(totalAmount.value);
    }
    if (paymentAmount.present) {
      map['payment_amount'] = Variable<int>(paymentAmount.value);
    }
    if (changeAmount.present) {
      map['change_amount'] = Variable<int>(changeAmount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (totalProfit.present) {
      map['total_profit'] = Variable<int>(totalProfit.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('customerName: $customerName, ')
          ..write('customerPhone: $customerPhone, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('paymentAmount: $paymentAmount, ')
          ..write('changeAmount: $changeAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('totalProfit: $totalProfit, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TransactionItemsTable extends TransactionItems
    with TableInfo<$TransactionItemsTable, TransactionItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<int> transactionId = GeneratedColumn<int>(
      'transaction_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES transactions (id) ON DELETE CASCADE'));
  static const VerificationMeta _itemTypeMeta =
      const VerificationMeta('itemType');
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
      'item_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _serviceIdMeta =
      const VerificationMeta('serviceId');
  @override
  late final GeneratedColumn<int> serviceId = GeneratedColumn<int>(
      'service_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES services (id)'));
  static const VerificationMeta _itemNameMeta =
      const VerificationMeta('itemName');
  @override
  late final GeneratedColumn<String> itemName = GeneratedColumn<String>(
      'item_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _costPriceMeta =
      const VerificationMeta('costPrice');
  @override
  late final GeneratedColumn<int> costPrice = GeneratedColumn<int>(
      'cost_price', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sellingPriceMeta =
      const VerificationMeta('sellingPrice');
  @override
  late final GeneratedColumn<int> sellingPrice = GeneratedColumn<int>(
      'selling_price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _subtotalPriceMeta =
      const VerificationMeta('subtotalPrice');
  @override
  late final GeneratedColumn<int> subtotalPrice = GeneratedColumn<int>(
      'subtotal_price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _subtotalProfitMeta =
      const VerificationMeta('subtotalProfit');
  @override
  late final GeneratedColumn<int> subtotalProfit = GeneratedColumn<int>(
      'subtotal_profit', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _serviceStatusMeta =
      const VerificationMeta('serviceStatus');
  @override
  late final GeneratedColumn<String> serviceStatus = GeneratedColumn<String>(
      'service_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('none'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        transactionId,
        itemType,
        productId,
        serviceId,
        itemName,
        costPrice,
        sellingPrice,
        quantity,
        subtotalPrice,
        subtotalProfit,
        serviceStatus,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_items';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionItemData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(_itemTypeMeta,
          itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta));
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('service_id')) {
      context.handle(_serviceIdMeta,
          serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta));
    }
    if (data.containsKey('item_name')) {
      context.handle(_itemNameMeta,
          itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta));
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('cost_price')) {
      context.handle(_costPriceMeta,
          costPrice.isAcceptableOrUnknown(data['cost_price']!, _costPriceMeta));
    }
    if (data.containsKey('selling_price')) {
      context.handle(
          _sellingPriceMeta,
          sellingPrice.isAcceptableOrUnknown(
              data['selling_price']!, _sellingPriceMeta));
    } else if (isInserting) {
      context.missing(_sellingPriceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('subtotal_price')) {
      context.handle(
          _subtotalPriceMeta,
          subtotalPrice.isAcceptableOrUnknown(
              data['subtotal_price']!, _subtotalPriceMeta));
    } else if (isInserting) {
      context.missing(_subtotalPriceMeta);
    }
    if (data.containsKey('subtotal_profit')) {
      context.handle(
          _subtotalProfitMeta,
          subtotalProfit.isAcceptableOrUnknown(
              data['subtotal_profit']!, _subtotalProfitMeta));
    }
    if (data.containsKey('service_status')) {
      context.handle(
          _serviceStatusMeta,
          serviceStatus.isAcceptableOrUnknown(
              data['service_status']!, _serviceStatusMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionItemData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      transactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}transaction_id'])!,
      itemType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_type'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id']),
      serviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}service_id']),
      itemName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_name'])!,
      costPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cost_price'])!,
      sellingPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}selling_price'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      subtotalPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subtotal_price'])!,
      subtotalProfit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subtotal_profit'])!,
      serviceStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_status'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $TransactionItemsTable createAlias(String alias) {
    return $TransactionItemsTable(attachedDatabase, alias);
  }
}

class TransactionItemData extends DataClass
    implements Insertable<TransactionItemData> {
  final int id;
  final int transactionId;
  final String itemType;
  final int? productId;
  final int? serviceId;
  final String itemName;
  final int costPrice;
  final int sellingPrice;
  final int quantity;
  final int subtotalPrice;
  final int subtotalProfit;
  final String serviceStatus;
  final String? notes;
  const TransactionItemData(
      {required this.id,
      required this.transactionId,
      required this.itemType,
      this.productId,
      this.serviceId,
      required this.itemName,
      required this.costPrice,
      required this.sellingPrice,
      required this.quantity,
      required this.subtotalPrice,
      required this.subtotalProfit,
      required this.serviceStatus,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['transaction_id'] = Variable<int>(transactionId);
    map['item_type'] = Variable<String>(itemType);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    if (!nullToAbsent || serviceId != null) {
      map['service_id'] = Variable<int>(serviceId);
    }
    map['item_name'] = Variable<String>(itemName);
    map['cost_price'] = Variable<int>(costPrice);
    map['selling_price'] = Variable<int>(sellingPrice);
    map['quantity'] = Variable<int>(quantity);
    map['subtotal_price'] = Variable<int>(subtotalPrice);
    map['subtotal_profit'] = Variable<int>(subtotalProfit);
    map['service_status'] = Variable<String>(serviceStatus);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  TransactionItemsCompanion toCompanion(bool nullToAbsent) {
    return TransactionItemsCompanion(
      id: Value(id),
      transactionId: Value(transactionId),
      itemType: Value(itemType),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      serviceId: serviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceId),
      itemName: Value(itemName),
      costPrice: Value(costPrice),
      sellingPrice: Value(sellingPrice),
      quantity: Value(quantity),
      subtotalPrice: Value(subtotalPrice),
      subtotalProfit: Value(subtotalProfit),
      serviceStatus: Value(serviceStatus),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory TransactionItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionItemData(
      id: serializer.fromJson<int>(json['id']),
      transactionId: serializer.fromJson<int>(json['transactionId']),
      itemType: serializer.fromJson<String>(json['itemType']),
      productId: serializer.fromJson<int?>(json['productId']),
      serviceId: serializer.fromJson<int?>(json['serviceId']),
      itemName: serializer.fromJson<String>(json['itemName']),
      costPrice: serializer.fromJson<int>(json['costPrice']),
      sellingPrice: serializer.fromJson<int>(json['sellingPrice']),
      quantity: serializer.fromJson<int>(json['quantity']),
      subtotalPrice: serializer.fromJson<int>(json['subtotalPrice']),
      subtotalProfit: serializer.fromJson<int>(json['subtotalProfit']),
      serviceStatus: serializer.fromJson<String>(json['serviceStatus']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'transactionId': serializer.toJson<int>(transactionId),
      'itemType': serializer.toJson<String>(itemType),
      'productId': serializer.toJson<int?>(productId),
      'serviceId': serializer.toJson<int?>(serviceId),
      'itemName': serializer.toJson<String>(itemName),
      'costPrice': serializer.toJson<int>(costPrice),
      'sellingPrice': serializer.toJson<int>(sellingPrice),
      'quantity': serializer.toJson<int>(quantity),
      'subtotalPrice': serializer.toJson<int>(subtotalPrice),
      'subtotalProfit': serializer.toJson<int>(subtotalProfit),
      'serviceStatus': serializer.toJson<String>(serviceStatus),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  TransactionItemData copyWith(
          {int? id,
          int? transactionId,
          String? itemType,
          Value<int?> productId = const Value.absent(),
          Value<int?> serviceId = const Value.absent(),
          String? itemName,
          int? costPrice,
          int? sellingPrice,
          int? quantity,
          int? subtotalPrice,
          int? subtotalProfit,
          String? serviceStatus,
          Value<String?> notes = const Value.absent()}) =>
      TransactionItemData(
        id: id ?? this.id,
        transactionId: transactionId ?? this.transactionId,
        itemType: itemType ?? this.itemType,
        productId: productId.present ? productId.value : this.productId,
        serviceId: serviceId.present ? serviceId.value : this.serviceId,
        itemName: itemName ?? this.itemName,
        costPrice: costPrice ?? this.costPrice,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        quantity: quantity ?? this.quantity,
        subtotalPrice: subtotalPrice ?? this.subtotalPrice,
        subtotalProfit: subtotalProfit ?? this.subtotalProfit,
        serviceStatus: serviceStatus ?? this.serviceStatus,
        notes: notes.present ? notes.value : this.notes,
      );
  TransactionItemData copyWithCompanion(TransactionItemsCompanion data) {
    return TransactionItemData(
      id: data.id.present ? data.id.value : this.id,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      productId: data.productId.present ? data.productId.value : this.productId,
      serviceId: data.serviceId.present ? data.serviceId.value : this.serviceId,
      itemName: data.itemName.present ? data.itemName.value : this.itemName,
      costPrice: data.costPrice.present ? data.costPrice.value : this.costPrice,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      subtotalPrice: data.subtotalPrice.present
          ? data.subtotalPrice.value
          : this.subtotalPrice,
      subtotalProfit: data.subtotalProfit.present
          ? data.subtotalProfit.value
          : this.subtotalProfit,
      serviceStatus: data.serviceStatus.present
          ? data.serviceStatus.value
          : this.serviceStatus,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionItemData(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('itemType: $itemType, ')
          ..write('productId: $productId, ')
          ..write('serviceId: $serviceId, ')
          ..write('itemName: $itemName, ')
          ..write('costPrice: $costPrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('quantity: $quantity, ')
          ..write('subtotalPrice: $subtotalPrice, ')
          ..write('subtotalProfit: $subtotalProfit, ')
          ..write('serviceStatus: $serviceStatus, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      transactionId,
      itemType,
      productId,
      serviceId,
      itemName,
      costPrice,
      sellingPrice,
      quantity,
      subtotalPrice,
      subtotalProfit,
      serviceStatus,
      notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionItemData &&
          other.id == this.id &&
          other.transactionId == this.transactionId &&
          other.itemType == this.itemType &&
          other.productId == this.productId &&
          other.serviceId == this.serviceId &&
          other.itemName == this.itemName &&
          other.costPrice == this.costPrice &&
          other.sellingPrice == this.sellingPrice &&
          other.quantity == this.quantity &&
          other.subtotalPrice == this.subtotalPrice &&
          other.subtotalProfit == this.subtotalProfit &&
          other.serviceStatus == this.serviceStatus &&
          other.notes == this.notes);
}

class TransactionItemsCompanion extends UpdateCompanion<TransactionItemData> {
  final Value<int> id;
  final Value<int> transactionId;
  final Value<String> itemType;
  final Value<int?> productId;
  final Value<int?> serviceId;
  final Value<String> itemName;
  final Value<int> costPrice;
  final Value<int> sellingPrice;
  final Value<int> quantity;
  final Value<int> subtotalPrice;
  final Value<int> subtotalProfit;
  final Value<String> serviceStatus;
  final Value<String?> notes;
  const TransactionItemsCompanion({
    this.id = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.itemType = const Value.absent(),
    this.productId = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.costPrice = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.subtotalPrice = const Value.absent(),
    this.subtotalProfit = const Value.absent(),
    this.serviceStatus = const Value.absent(),
    this.notes = const Value.absent(),
  });
  TransactionItemsCompanion.insert({
    this.id = const Value.absent(),
    required int transactionId,
    required String itemType,
    this.productId = const Value.absent(),
    this.serviceId = const Value.absent(),
    required String itemName,
    this.costPrice = const Value.absent(),
    required int sellingPrice,
    this.quantity = const Value.absent(),
    required int subtotalPrice,
    this.subtotalProfit = const Value.absent(),
    this.serviceStatus = const Value.absent(),
    this.notes = const Value.absent(),
  })  : transactionId = Value(transactionId),
        itemType = Value(itemType),
        itemName = Value(itemName),
        sellingPrice = Value(sellingPrice),
        subtotalPrice = Value(subtotalPrice);
  static Insertable<TransactionItemData> custom({
    Expression<int>? id,
    Expression<int>? transactionId,
    Expression<String>? itemType,
    Expression<int>? productId,
    Expression<int>? serviceId,
    Expression<String>? itemName,
    Expression<int>? costPrice,
    Expression<int>? sellingPrice,
    Expression<int>? quantity,
    Expression<int>? subtotalPrice,
    Expression<int>? subtotalProfit,
    Expression<String>? serviceStatus,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionId != null) 'transaction_id': transactionId,
      if (itemType != null) 'item_type': itemType,
      if (productId != null) 'product_id': productId,
      if (serviceId != null) 'service_id': serviceId,
      if (itemName != null) 'item_name': itemName,
      if (costPrice != null) 'cost_price': costPrice,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (quantity != null) 'quantity': quantity,
      if (subtotalPrice != null) 'subtotal_price': subtotalPrice,
      if (subtotalProfit != null) 'subtotal_profit': subtotalProfit,
      if (serviceStatus != null) 'service_status': serviceStatus,
      if (notes != null) 'notes': notes,
    });
  }

  TransactionItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? transactionId,
      Value<String>? itemType,
      Value<int?>? productId,
      Value<int?>? serviceId,
      Value<String>? itemName,
      Value<int>? costPrice,
      Value<int>? sellingPrice,
      Value<int>? quantity,
      Value<int>? subtotalPrice,
      Value<int>? subtotalProfit,
      Value<String>? serviceStatus,
      Value<String?>? notes}) {
    return TransactionItemsCompanion(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      itemType: itemType ?? this.itemType,
      productId: productId ?? this.productId,
      serviceId: serviceId ?? this.serviceId,
      itemName: itemName ?? this.itemName,
      costPrice: costPrice ?? this.costPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      quantity: quantity ?? this.quantity,
      subtotalPrice: subtotalPrice ?? this.subtotalPrice,
      subtotalProfit: subtotalProfit ?? this.subtotalProfit,
      serviceStatus: serviceStatus ?? this.serviceStatus,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<int>(serviceId.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (costPrice.present) {
      map['cost_price'] = Variable<int>(costPrice.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<int>(sellingPrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (subtotalPrice.present) {
      map['subtotal_price'] = Variable<int>(subtotalPrice.value);
    }
    if (subtotalProfit.present) {
      map['subtotal_profit'] = Variable<int>(subtotalProfit.value);
    }
    if (serviceStatus.present) {
      map['service_status'] = Variable<String>(serviceStatus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionItemsCompanion(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('itemType: $itemType, ')
          ..write('productId: $productId, ')
          ..write('serviceId: $serviceId, ')
          ..write('itemName: $itemName, ')
          ..write('costPrice: $costPrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('quantity: $quantity, ')
          ..write('subtotalPrice: $subtotalPrice, ')
          ..write('subtotalProfit: $subtotalProfit, ')
          ..write('serviceStatus: $serviceStatus, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $RestocksTable extends Restocks
    with TableInfo<$RestocksTable, RestockData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _quantityAddedMeta =
      const VerificationMeta('quantityAdded');
  @override
  late final GeneratedColumn<int> quantityAdded = GeneratedColumn<int>(
      'quantity_added', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalPurchaseCostMeta =
      const VerificationMeta('totalPurchaseCost');
  @override
  late final GeneratedColumn<int> totalPurchaseCost = GeneratedColumn<int>(
      'total_purchase_cost', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _restockDateMeta =
      const VerificationMeta('restockDate');
  @override
  late final GeneratedColumn<DateTime> restockDate = GeneratedColumn<DateTime>(
      'restock_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        productId,
        quantityAdded,
        totalPurchaseCost,
        userId,
        restockDate,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'restocks';
  @override
  VerificationContext validateIntegrity(Insertable<RestockData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity_added')) {
      context.handle(
          _quantityAddedMeta,
          quantityAdded.isAcceptableOrUnknown(
              data['quantity_added']!, _quantityAddedMeta));
    } else if (isInserting) {
      context.missing(_quantityAddedMeta);
    }
    if (data.containsKey('total_purchase_cost')) {
      context.handle(
          _totalPurchaseCostMeta,
          totalPurchaseCost.isAcceptableOrUnknown(
              data['total_purchase_cost']!, _totalPurchaseCostMeta));
    } else if (isInserting) {
      context.missing(_totalPurchaseCostMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('restock_date')) {
      context.handle(
          _restockDateMeta,
          restockDate.isAcceptableOrUnknown(
              data['restock_date']!, _restockDateMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RestockData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RestockData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      quantityAdded: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity_added'])!,
      totalPurchaseCost: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_purchase_cost'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      restockDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}restock_date'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $RestocksTable createAlias(String alias) {
    return $RestocksTable(attachedDatabase, alias);
  }
}

class RestockData extends DataClass implements Insertable<RestockData> {
  final int id;
  final int productId;
  final int quantityAdded;
  final int totalPurchaseCost;
  final int userId;
  final DateTime restockDate;
  final String? notes;
  const RestockData(
      {required this.id,
      required this.productId,
      required this.quantityAdded,
      required this.totalPurchaseCost,
      required this.userId,
      required this.restockDate,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['quantity_added'] = Variable<int>(quantityAdded);
    map['total_purchase_cost'] = Variable<int>(totalPurchaseCost);
    map['user_id'] = Variable<int>(userId);
    map['restock_date'] = Variable<DateTime>(restockDate);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  RestocksCompanion toCompanion(bool nullToAbsent) {
    return RestocksCompanion(
      id: Value(id),
      productId: Value(productId),
      quantityAdded: Value(quantityAdded),
      totalPurchaseCost: Value(totalPurchaseCost),
      userId: Value(userId),
      restockDate: Value(restockDate),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory RestockData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RestockData(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      quantityAdded: serializer.fromJson<int>(json['quantityAdded']),
      totalPurchaseCost: serializer.fromJson<int>(json['totalPurchaseCost']),
      userId: serializer.fromJson<int>(json['userId']),
      restockDate: serializer.fromJson<DateTime>(json['restockDate']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'quantityAdded': serializer.toJson<int>(quantityAdded),
      'totalPurchaseCost': serializer.toJson<int>(totalPurchaseCost),
      'userId': serializer.toJson<int>(userId),
      'restockDate': serializer.toJson<DateTime>(restockDate),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  RestockData copyWith(
          {int? id,
          int? productId,
          int? quantityAdded,
          int? totalPurchaseCost,
          int? userId,
          DateTime? restockDate,
          Value<String?> notes = const Value.absent()}) =>
      RestockData(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        quantityAdded: quantityAdded ?? this.quantityAdded,
        totalPurchaseCost: totalPurchaseCost ?? this.totalPurchaseCost,
        userId: userId ?? this.userId,
        restockDate: restockDate ?? this.restockDate,
        notes: notes.present ? notes.value : this.notes,
      );
  RestockData copyWithCompanion(RestocksCompanion data) {
    return RestockData(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantityAdded: data.quantityAdded.present
          ? data.quantityAdded.value
          : this.quantityAdded,
      totalPurchaseCost: data.totalPurchaseCost.present
          ? data.totalPurchaseCost.value
          : this.totalPurchaseCost,
      userId: data.userId.present ? data.userId.value : this.userId,
      restockDate:
          data.restockDate.present ? data.restockDate.value : this.restockDate,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RestockData(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('quantityAdded: $quantityAdded, ')
          ..write('totalPurchaseCost: $totalPurchaseCost, ')
          ..write('userId: $userId, ')
          ..write('restockDate: $restockDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, quantityAdded,
      totalPurchaseCost, userId, restockDate, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RestockData &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.quantityAdded == this.quantityAdded &&
          other.totalPurchaseCost == this.totalPurchaseCost &&
          other.userId == this.userId &&
          other.restockDate == this.restockDate &&
          other.notes == this.notes);
}

class RestocksCompanion extends UpdateCompanion<RestockData> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> quantityAdded;
  final Value<int> totalPurchaseCost;
  final Value<int> userId;
  final Value<DateTime> restockDate;
  final Value<String?> notes;
  const RestocksCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantityAdded = const Value.absent(),
    this.totalPurchaseCost = const Value.absent(),
    this.userId = const Value.absent(),
    this.restockDate = const Value.absent(),
    this.notes = const Value.absent(),
  });
  RestocksCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int quantityAdded,
    required int totalPurchaseCost,
    required int userId,
    this.restockDate = const Value.absent(),
    this.notes = const Value.absent(),
  })  : productId = Value(productId),
        quantityAdded = Value(quantityAdded),
        totalPurchaseCost = Value(totalPurchaseCost),
        userId = Value(userId);
  static Insertable<RestockData> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? quantityAdded,
    Expression<int>? totalPurchaseCost,
    Expression<int>? userId,
    Expression<DateTime>? restockDate,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (quantityAdded != null) 'quantity_added': quantityAdded,
      if (totalPurchaseCost != null) 'total_purchase_cost': totalPurchaseCost,
      if (userId != null) 'user_id': userId,
      if (restockDate != null) 'restock_date': restockDate,
      if (notes != null) 'notes': notes,
    });
  }

  RestocksCompanion copyWith(
      {Value<int>? id,
      Value<int>? productId,
      Value<int>? quantityAdded,
      Value<int>? totalPurchaseCost,
      Value<int>? userId,
      Value<DateTime>? restockDate,
      Value<String?>? notes}) {
    return RestocksCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantityAdded: quantityAdded ?? this.quantityAdded,
      totalPurchaseCost: totalPurchaseCost ?? this.totalPurchaseCost,
      userId: userId ?? this.userId,
      restockDate: restockDate ?? this.restockDate,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (quantityAdded.present) {
      map['quantity_added'] = Variable<int>(quantityAdded.value);
    }
    if (totalPurchaseCost.present) {
      map['total_purchase_cost'] = Variable<int>(totalPurchaseCost.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (restockDate.present) {
      map['restock_date'] = Variable<DateTime>(restockDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestocksCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('quantityAdded: $quantityAdded, ')
          ..write('totalPurchaseCost: $totalPurchaseCost, ')
          ..write('userId: $userId, ')
          ..write('restockDate: $restockDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $ReturnsTable extends Returns with TableInfo<$ReturnsTable, ReturnData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReturnsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<int> transactionId = GeneratedColumn<int>(
      'transaction_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES transactions (id)'));
  static const VerificationMeta _invoiceNumberMeta =
      const VerificationMeta('invoiceNumber');
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
      'invoice_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalRefundAmountMeta =
      const VerificationMeta('totalRefundAmount');
  @override
  late final GeneratedColumn<int> totalRefundAmount = GeneratedColumn<int>(
      'total_refund_amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalItemReturnedMeta =
      const VerificationMeta('totalItemReturned');
  @override
  late final GeneratedColumn<int> totalItemReturned = GeneratedColumn<int>(
      'total_item_returned', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _returnDateMeta =
      const VerificationMeta('returnDate');
  @override
  late final GeneratedColumn<DateTime> returnDate = GeneratedColumn<DateTime>(
      'return_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        transactionId,
        invoiceNumber,
        totalRefundAmount,
        totalItemReturned,
        reason,
        userId,
        returnDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'returns';
  @override
  VerificationContext validateIntegrity(Insertable<ReturnData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
          _invoiceNumberMeta,
          invoiceNumber.isAcceptableOrUnknown(
              data['invoice_number']!, _invoiceNumberMeta));
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('total_refund_amount')) {
      context.handle(
          _totalRefundAmountMeta,
          totalRefundAmount.isAcceptableOrUnknown(
              data['total_refund_amount']!, _totalRefundAmountMeta));
    } else if (isInserting) {
      context.missing(_totalRefundAmountMeta);
    }
    if (data.containsKey('total_item_returned')) {
      context.handle(
          _totalItemReturnedMeta,
          totalItemReturned.isAcceptableOrUnknown(
              data['total_item_returned']!, _totalItemReturnedMeta));
    } else if (isInserting) {
      context.missing(_totalItemReturnedMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('return_date')) {
      context.handle(
          _returnDateMeta,
          returnDate.isAcceptableOrUnknown(
              data['return_date']!, _returnDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReturnData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReturnData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      transactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}transaction_id'])!,
      invoiceNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invoice_number'])!,
      totalRefundAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_refund_amount'])!,
      totalItemReturned: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_item_returned'])!,
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      returnDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}return_date'])!,
    );
  }

  @override
  $ReturnsTable createAlias(String alias) {
    return $ReturnsTable(attachedDatabase, alias);
  }
}

class ReturnData extends DataClass implements Insertable<ReturnData> {
  final int id;
  final int transactionId;
  final String invoiceNumber;
  final int totalRefundAmount;
  final int totalItemReturned;
  final String? reason;
  final int userId;
  final DateTime returnDate;
  const ReturnData(
      {required this.id,
      required this.transactionId,
      required this.invoiceNumber,
      required this.totalRefundAmount,
      required this.totalItemReturned,
      this.reason,
      required this.userId,
      required this.returnDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['transaction_id'] = Variable<int>(transactionId);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['total_refund_amount'] = Variable<int>(totalRefundAmount);
    map['total_item_returned'] = Variable<int>(totalItemReturned);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['user_id'] = Variable<int>(userId);
    map['return_date'] = Variable<DateTime>(returnDate);
    return map;
  }

  ReturnsCompanion toCompanion(bool nullToAbsent) {
    return ReturnsCompanion(
      id: Value(id),
      transactionId: Value(transactionId),
      invoiceNumber: Value(invoiceNumber),
      totalRefundAmount: Value(totalRefundAmount),
      totalItemReturned: Value(totalItemReturned),
      reason:
          reason == null && nullToAbsent ? const Value.absent() : Value(reason),
      userId: Value(userId),
      returnDate: Value(returnDate),
    );
  }

  factory ReturnData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReturnData(
      id: serializer.fromJson<int>(json['id']),
      transactionId: serializer.fromJson<int>(json['transactionId']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      totalRefundAmount: serializer.fromJson<int>(json['totalRefundAmount']),
      totalItemReturned: serializer.fromJson<int>(json['totalItemReturned']),
      reason: serializer.fromJson<String?>(json['reason']),
      userId: serializer.fromJson<int>(json['userId']),
      returnDate: serializer.fromJson<DateTime>(json['returnDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'transactionId': serializer.toJson<int>(transactionId),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'totalRefundAmount': serializer.toJson<int>(totalRefundAmount),
      'totalItemReturned': serializer.toJson<int>(totalItemReturned),
      'reason': serializer.toJson<String?>(reason),
      'userId': serializer.toJson<int>(userId),
      'returnDate': serializer.toJson<DateTime>(returnDate),
    };
  }

  ReturnData copyWith(
          {int? id,
          int? transactionId,
          String? invoiceNumber,
          int? totalRefundAmount,
          int? totalItemReturned,
          Value<String?> reason = const Value.absent(),
          int? userId,
          DateTime? returnDate}) =>
      ReturnData(
        id: id ?? this.id,
        transactionId: transactionId ?? this.transactionId,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        totalRefundAmount: totalRefundAmount ?? this.totalRefundAmount,
        totalItemReturned: totalItemReturned ?? this.totalItemReturned,
        reason: reason.present ? reason.value : this.reason,
        userId: userId ?? this.userId,
        returnDate: returnDate ?? this.returnDate,
      );
  ReturnData copyWithCompanion(ReturnsCompanion data) {
    return ReturnData(
      id: data.id.present ? data.id.value : this.id,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      totalRefundAmount: data.totalRefundAmount.present
          ? data.totalRefundAmount.value
          : this.totalRefundAmount,
      totalItemReturned: data.totalItemReturned.present
          ? data.totalItemReturned.value
          : this.totalItemReturned,
      reason: data.reason.present ? data.reason.value : this.reason,
      userId: data.userId.present ? data.userId.value : this.userId,
      returnDate:
          data.returnDate.present ? data.returnDate.value : this.returnDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReturnData(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('totalRefundAmount: $totalRefundAmount, ')
          ..write('totalItemReturned: $totalItemReturned, ')
          ..write('reason: $reason, ')
          ..write('userId: $userId, ')
          ..write('returnDate: $returnDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, transactionId, invoiceNumber,
      totalRefundAmount, totalItemReturned, reason, userId, returnDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReturnData &&
          other.id == this.id &&
          other.transactionId == this.transactionId &&
          other.invoiceNumber == this.invoiceNumber &&
          other.totalRefundAmount == this.totalRefundAmount &&
          other.totalItemReturned == this.totalItemReturned &&
          other.reason == this.reason &&
          other.userId == this.userId &&
          other.returnDate == this.returnDate);
}

class ReturnsCompanion extends UpdateCompanion<ReturnData> {
  final Value<int> id;
  final Value<int> transactionId;
  final Value<String> invoiceNumber;
  final Value<int> totalRefundAmount;
  final Value<int> totalItemReturned;
  final Value<String?> reason;
  final Value<int> userId;
  final Value<DateTime> returnDate;
  const ReturnsCompanion({
    this.id = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.totalRefundAmount = const Value.absent(),
    this.totalItemReturned = const Value.absent(),
    this.reason = const Value.absent(),
    this.userId = const Value.absent(),
    this.returnDate = const Value.absent(),
  });
  ReturnsCompanion.insert({
    this.id = const Value.absent(),
    required int transactionId,
    required String invoiceNumber,
    required int totalRefundAmount,
    required int totalItemReturned,
    this.reason = const Value.absent(),
    required int userId,
    this.returnDate = const Value.absent(),
  })  : transactionId = Value(transactionId),
        invoiceNumber = Value(invoiceNumber),
        totalRefundAmount = Value(totalRefundAmount),
        totalItemReturned = Value(totalItemReturned),
        userId = Value(userId);
  static Insertable<ReturnData> custom({
    Expression<int>? id,
    Expression<int>? transactionId,
    Expression<String>? invoiceNumber,
    Expression<int>? totalRefundAmount,
    Expression<int>? totalItemReturned,
    Expression<String>? reason,
    Expression<int>? userId,
    Expression<DateTime>? returnDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionId != null) 'transaction_id': transactionId,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (totalRefundAmount != null) 'total_refund_amount': totalRefundAmount,
      if (totalItemReturned != null) 'total_item_returned': totalItemReturned,
      if (reason != null) 'reason': reason,
      if (userId != null) 'user_id': userId,
      if (returnDate != null) 'return_date': returnDate,
    });
  }

  ReturnsCompanion copyWith(
      {Value<int>? id,
      Value<int>? transactionId,
      Value<String>? invoiceNumber,
      Value<int>? totalRefundAmount,
      Value<int>? totalItemReturned,
      Value<String?>? reason,
      Value<int>? userId,
      Value<DateTime>? returnDate}) {
    return ReturnsCompanion(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      totalRefundAmount: totalRefundAmount ?? this.totalRefundAmount,
      totalItemReturned: totalItemReturned ?? this.totalItemReturned,
      reason: reason ?? this.reason,
      userId: userId ?? this.userId,
      returnDate: returnDate ?? this.returnDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (totalRefundAmount.present) {
      map['total_refund_amount'] = Variable<int>(totalRefundAmount.value);
    }
    if (totalItemReturned.present) {
      map['total_item_returned'] = Variable<int>(totalItemReturned.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (returnDate.present) {
      map['return_date'] = Variable<DateTime>(returnDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReturnsCompanion(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('totalRefundAmount: $totalRefundAmount, ')
          ..write('totalItemReturned: $totalItemReturned, ')
          ..write('reason: $reason, ')
          ..write('userId: $userId, ')
          ..write('returnDate: $returnDate')
          ..write(')'))
        .toString();
  }
}

class $BalanceLogsTable extends BalanceLogs
    with TableInfo<$BalanceLogsTable, BalanceLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BalanceLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
      'store_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES stores (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _flowTypeMeta =
      const VerificationMeta('flowType');
  @override
  late final GeneratedColumn<String> flowType = GeneratedColumn<String>(
      'flow_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentTypeMeta =
      const VerificationMeta('paymentType');
  @override
  late final GeneratedColumn<String> paymentType = GeneratedColumn<String>(
      'payment_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('cash'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        storeId,
        amount,
        flowType,
        category,
        paymentType,
        notes,
        userId,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'balance_logs';
  @override
  VerificationContext validateIntegrity(Insertable<BalanceLogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('flow_type')) {
      context.handle(_flowTypeMeta,
          flowType.isAcceptableOrUnknown(data['flow_type']!, _flowTypeMeta));
    } else if (isInserting) {
      context.missing(_flowTypeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('payment_type')) {
      context.handle(
          _paymentTypeMeta,
          paymentType.isAcceptableOrUnknown(
              data['payment_type']!, _paymentTypeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BalanceLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BalanceLogData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}store_id']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      flowType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}flow_type'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      paymentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_type'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BalanceLogsTable createAlias(String alias) {
    return $BalanceLogsTable(attachedDatabase, alias);
  }
}

class BalanceLogData extends DataClass implements Insertable<BalanceLogData> {
  final int id;
  final int? storeId;
  final int amount;
  final String flowType;
  final String category;
  final String paymentType;
  final String? notes;
  final int userId;
  final DateTime createdAt;
  const BalanceLogData(
      {required this.id,
      this.storeId,
      required this.amount,
      required this.flowType,
      required this.category,
      required this.paymentType,
      this.notes,
      required this.userId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<int>(storeId);
    }
    map['amount'] = Variable<int>(amount);
    map['flow_type'] = Variable<String>(flowType);
    map['category'] = Variable<String>(category);
    map['payment_type'] = Variable<String>(paymentType);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['user_id'] = Variable<int>(userId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BalanceLogsCompanion toCompanion(bool nullToAbsent) {
    return BalanceLogsCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      amount: Value(amount),
      flowType: Value(flowType),
      category: Value(category),
      paymentType: Value(paymentType),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      userId: Value(userId),
      createdAt: Value(createdAt),
    );
  }

  factory BalanceLogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BalanceLogData(
      id: serializer.fromJson<int>(json['id']),
      storeId: serializer.fromJson<int?>(json['storeId']),
      amount: serializer.fromJson<int>(json['amount']),
      flowType: serializer.fromJson<String>(json['flowType']),
      category: serializer.fromJson<String>(json['category']),
      paymentType: serializer.fromJson<String>(json['paymentType']),
      notes: serializer.fromJson<String?>(json['notes']),
      userId: serializer.fromJson<int>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeId': serializer.toJson<int?>(storeId),
      'amount': serializer.toJson<int>(amount),
      'flowType': serializer.toJson<String>(flowType),
      'category': serializer.toJson<String>(category),
      'paymentType': serializer.toJson<String>(paymentType),
      'notes': serializer.toJson<String?>(notes),
      'userId': serializer.toJson<int>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BalanceLogData copyWith(
          {int? id,
          Value<int?> storeId = const Value.absent(),
          int? amount,
          String? flowType,
          String? category,
          String? paymentType,
          Value<String?> notes = const Value.absent(),
          int? userId,
          DateTime? createdAt}) =>
      BalanceLogData(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        amount: amount ?? this.amount,
        flowType: flowType ?? this.flowType,
        category: category ?? this.category,
        paymentType: paymentType ?? this.paymentType,
        notes: notes.present ? notes.value : this.notes,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
      );
  BalanceLogData copyWithCompanion(BalanceLogsCompanion data) {
    return BalanceLogData(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      amount: data.amount.present ? data.amount.value : this.amount,
      flowType: data.flowType.present ? data.flowType.value : this.flowType,
      category: data.category.present ? data.category.value : this.category,
      paymentType:
          data.paymentType.present ? data.paymentType.value : this.paymentType,
      notes: data.notes.present ? data.notes.value : this.notes,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BalanceLogData(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('amount: $amount, ')
          ..write('flowType: $flowType, ')
          ..write('category: $category, ')
          ..write('paymentType: $paymentType, ')
          ..write('notes: $notes, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, storeId, amount, flowType, category,
      paymentType, notes, userId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BalanceLogData &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.amount == this.amount &&
          other.flowType == this.flowType &&
          other.category == this.category &&
          other.paymentType == this.paymentType &&
          other.notes == this.notes &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt);
}

class BalanceLogsCompanion extends UpdateCompanion<BalanceLogData> {
  final Value<int> id;
  final Value<int?> storeId;
  final Value<int> amount;
  final Value<String> flowType;
  final Value<String> category;
  final Value<String> paymentType;
  final Value<String?> notes;
  final Value<int> userId;
  final Value<DateTime> createdAt;
  const BalanceLogsCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.amount = const Value.absent(),
    this.flowType = const Value.absent(),
    this.category = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.notes = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BalanceLogsCompanion.insert({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    required int amount,
    required String flowType,
    required String category,
    this.paymentType = const Value.absent(),
    this.notes = const Value.absent(),
    required int userId,
    this.createdAt = const Value.absent(),
  })  : amount = Value(amount),
        flowType = Value(flowType),
        category = Value(category),
        userId = Value(userId);
  static Insertable<BalanceLogData> custom({
    Expression<int>? id,
    Expression<int>? storeId,
    Expression<int>? amount,
    Expression<String>? flowType,
    Expression<String>? category,
    Expression<String>? paymentType,
    Expression<String>? notes,
    Expression<int>? userId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (amount != null) 'amount': amount,
      if (flowType != null) 'flow_type': flowType,
      if (category != null) 'category': category,
      if (paymentType != null) 'payment_type': paymentType,
      if (notes != null) 'notes': notes,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BalanceLogsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? storeId,
      Value<int>? amount,
      Value<String>? flowType,
      Value<String>? category,
      Value<String>? paymentType,
      Value<String?>? notes,
      Value<int>? userId,
      Value<DateTime>? createdAt}) {
    return BalanceLogsCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      amount: amount ?? this.amount,
      flowType: flowType ?? this.flowType,
      category: category ?? this.category,
      paymentType: paymentType ?? this.paymentType,
      notes: notes ?? this.notes,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (flowType.present) {
      map['flow_type'] = Variable<String>(flowType.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (paymentType.present) {
      map['payment_type'] = Variable<String>(paymentType.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BalanceLogsCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('amount: $amount, ')
          ..write('flowType: $flowType, ')
          ..write('category: $category, ')
          ..write('paymentType: $paymentType, ')
          ..write('notes: $notes, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MonthlyAccountingTable extends MonthlyAccounting
    with TableInfo<$MonthlyAccountingTable, MonthlyAccountingData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyAccountingTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
      'store_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES stores (id)'));
  static const VerificationMeta _periodMonthYearMeta =
      const VerificationMeta('periodMonthYear');
  @override
  late final GeneratedColumn<String> periodMonthYear = GeneratedColumn<String>(
      'period_month_year', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _initialCashMeta =
      const VerificationMeta('initialCash');
  @override
  late final GeneratedColumn<int> initialCash = GeneratedColumn<int>(
      'initial_cash', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _initialDigitalMeta =
      const VerificationMeta('initialDigital');
  @override
  late final GeneratedColumn<int> initialDigital = GeneratedColumn<int>(
      'initial_digital', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _initialStockValueMeta =
      const VerificationMeta('initialStockValue');
  @override
  late final GeneratedColumn<int> initialStockValue = GeneratedColumn<int>(
      'initial_stock_value', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _incomeGoodsMeta =
      const VerificationMeta('incomeGoods');
  @override
  late final GeneratedColumn<int> incomeGoods = GeneratedColumn<int>(
      'income_goods', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _incomeServicesMeta =
      const VerificationMeta('incomeServices');
  @override
  late final GeneratedColumn<int> incomeServices = GeneratedColumn<int>(
      'income_services', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalExpenseMeta =
      const VerificationMeta('totalExpense');
  @override
  late final GeneratedColumn<int> totalExpense = GeneratedColumn<int>(
      'total_expense', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _netProfitMeta =
      const VerificationMeta('netProfit');
  @override
  late final GeneratedColumn<int> netProfit = GeneratedColumn<int>(
      'net_profit', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _finalCashMeta =
      const VerificationMeta('finalCash');
  @override
  late final GeneratedColumn<int> finalCash = GeneratedColumn<int>(
      'final_cash', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _finalDigitalMeta =
      const VerificationMeta('finalDigital');
  @override
  late final GeneratedColumn<int> finalDigital = GeneratedColumn<int>(
      'final_digital', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _finalStockValueMeta =
      const VerificationMeta('finalStockValue');
  @override
  late final GeneratedColumn<int> finalStockValue = GeneratedColumn<int>(
      'final_stock_value', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('on_progress'));
  static const VerificationMeta _closedByUserIdMeta =
      const VerificationMeta('closedByUserId');
  @override
  late final GeneratedColumn<int> closedByUserId = GeneratedColumn<int>(
      'closed_by_user_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _closedAtMeta =
      const VerificationMeta('closedAt');
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
      'closed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        storeId,
        periodMonthYear,
        initialCash,
        initialDigital,
        initialStockValue,
        incomeGoods,
        incomeServices,
        totalExpense,
        netProfit,
        finalCash,
        finalDigital,
        finalStockValue,
        status,
        closedByUserId,
        closedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_accounting';
  @override
  VerificationContext validateIntegrity(
      Insertable<MonthlyAccountingData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('period_month_year')) {
      context.handle(
          _periodMonthYearMeta,
          periodMonthYear.isAcceptableOrUnknown(
              data['period_month_year']!, _periodMonthYearMeta));
    } else if (isInserting) {
      context.missing(_periodMonthYearMeta);
    }
    if (data.containsKey('initial_cash')) {
      context.handle(
          _initialCashMeta,
          initialCash.isAcceptableOrUnknown(
              data['initial_cash']!, _initialCashMeta));
    }
    if (data.containsKey('initial_digital')) {
      context.handle(
          _initialDigitalMeta,
          initialDigital.isAcceptableOrUnknown(
              data['initial_digital']!, _initialDigitalMeta));
    }
    if (data.containsKey('initial_stock_value')) {
      context.handle(
          _initialStockValueMeta,
          initialStockValue.isAcceptableOrUnknown(
              data['initial_stock_value']!, _initialStockValueMeta));
    }
    if (data.containsKey('income_goods')) {
      context.handle(
          _incomeGoodsMeta,
          incomeGoods.isAcceptableOrUnknown(
              data['income_goods']!, _incomeGoodsMeta));
    }
    if (data.containsKey('income_services')) {
      context.handle(
          _incomeServicesMeta,
          incomeServices.isAcceptableOrUnknown(
              data['income_services']!, _incomeServicesMeta));
    }
    if (data.containsKey('total_expense')) {
      context.handle(
          _totalExpenseMeta,
          totalExpense.isAcceptableOrUnknown(
              data['total_expense']!, _totalExpenseMeta));
    }
    if (data.containsKey('net_profit')) {
      context.handle(_netProfitMeta,
          netProfit.isAcceptableOrUnknown(data['net_profit']!, _netProfitMeta));
    }
    if (data.containsKey('final_cash')) {
      context.handle(_finalCashMeta,
          finalCash.isAcceptableOrUnknown(data['final_cash']!, _finalCashMeta));
    }
    if (data.containsKey('final_digital')) {
      context.handle(
          _finalDigitalMeta,
          finalDigital.isAcceptableOrUnknown(
              data['final_digital']!, _finalDigitalMeta));
    }
    if (data.containsKey('final_stock_value')) {
      context.handle(
          _finalStockValueMeta,
          finalStockValue.isAcceptableOrUnknown(
              data['final_stock_value']!, _finalStockValueMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('closed_by_user_id')) {
      context.handle(
          _closedByUserIdMeta,
          closedByUserId.isAcceptableOrUnknown(
              data['closed_by_user_id']!, _closedByUserIdMeta));
    }
    if (data.containsKey('closed_at')) {
      context.handle(_closedAtMeta,
          closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {storeId, periodMonthYear},
      ];
  @override
  MonthlyAccountingData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyAccountingData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}store_id']),
      periodMonthYear: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}period_month_year'])!,
      initialCash: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}initial_cash'])!,
      initialDigital: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}initial_digital'])!,
      initialStockValue: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}initial_stock_value'])!,
      incomeGoods: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}income_goods'])!,
      incomeServices: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}income_services'])!,
      totalExpense: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_expense'])!,
      netProfit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}net_profit'])!,
      finalCash: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}final_cash'])!,
      finalDigital: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}final_digital'])!,
      finalStockValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}final_stock_value'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      closedByUserId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}closed_by_user_id']),
      closedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}closed_at']),
    );
  }

  @override
  $MonthlyAccountingTable createAlias(String alias) {
    return $MonthlyAccountingTable(attachedDatabase, alias);
  }
}

class MonthlyAccountingData extends DataClass
    implements Insertable<MonthlyAccountingData> {
  final int id;
  final int? storeId;
  final String periodMonthYear;
  final int initialCash;
  final int initialDigital;
  final int initialStockValue;
  final int incomeGoods;
  final int incomeServices;
  final int totalExpense;
  final int netProfit;
  final int finalCash;
  final int finalDigital;
  final int finalStockValue;
  final String status;
  final int? closedByUserId;
  final DateTime? closedAt;
  const MonthlyAccountingData(
      {required this.id,
      this.storeId,
      required this.periodMonthYear,
      required this.initialCash,
      required this.initialDigital,
      required this.initialStockValue,
      required this.incomeGoods,
      required this.incomeServices,
      required this.totalExpense,
      required this.netProfit,
      required this.finalCash,
      required this.finalDigital,
      required this.finalStockValue,
      required this.status,
      this.closedByUserId,
      this.closedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<int>(storeId);
    }
    map['period_month_year'] = Variable<String>(periodMonthYear);
    map['initial_cash'] = Variable<int>(initialCash);
    map['initial_digital'] = Variable<int>(initialDigital);
    map['initial_stock_value'] = Variable<int>(initialStockValue);
    map['income_goods'] = Variable<int>(incomeGoods);
    map['income_services'] = Variable<int>(incomeServices);
    map['total_expense'] = Variable<int>(totalExpense);
    map['net_profit'] = Variable<int>(netProfit);
    map['final_cash'] = Variable<int>(finalCash);
    map['final_digital'] = Variable<int>(finalDigital);
    map['final_stock_value'] = Variable<int>(finalStockValue);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || closedByUserId != null) {
      map['closed_by_user_id'] = Variable<int>(closedByUserId);
    }
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    return map;
  }

  MonthlyAccountingCompanion toCompanion(bool nullToAbsent) {
    return MonthlyAccountingCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      periodMonthYear: Value(periodMonthYear),
      initialCash: Value(initialCash),
      initialDigital: Value(initialDigital),
      initialStockValue: Value(initialStockValue),
      incomeGoods: Value(incomeGoods),
      incomeServices: Value(incomeServices),
      totalExpense: Value(totalExpense),
      netProfit: Value(netProfit),
      finalCash: Value(finalCash),
      finalDigital: Value(finalDigital),
      finalStockValue: Value(finalStockValue),
      status: Value(status),
      closedByUserId: closedByUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(closedByUserId),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
    );
  }

  factory MonthlyAccountingData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyAccountingData(
      id: serializer.fromJson<int>(json['id']),
      storeId: serializer.fromJson<int?>(json['storeId']),
      periodMonthYear: serializer.fromJson<String>(json['periodMonthYear']),
      initialCash: serializer.fromJson<int>(json['initialCash']),
      initialDigital: serializer.fromJson<int>(json['initialDigital']),
      initialStockValue: serializer.fromJson<int>(json['initialStockValue']),
      incomeGoods: serializer.fromJson<int>(json['incomeGoods']),
      incomeServices: serializer.fromJson<int>(json['incomeServices']),
      totalExpense: serializer.fromJson<int>(json['totalExpense']),
      netProfit: serializer.fromJson<int>(json['netProfit']),
      finalCash: serializer.fromJson<int>(json['finalCash']),
      finalDigital: serializer.fromJson<int>(json['finalDigital']),
      finalStockValue: serializer.fromJson<int>(json['finalStockValue']),
      status: serializer.fromJson<String>(json['status']),
      closedByUserId: serializer.fromJson<int?>(json['closedByUserId']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeId': serializer.toJson<int?>(storeId),
      'periodMonthYear': serializer.toJson<String>(periodMonthYear),
      'initialCash': serializer.toJson<int>(initialCash),
      'initialDigital': serializer.toJson<int>(initialDigital),
      'initialStockValue': serializer.toJson<int>(initialStockValue),
      'incomeGoods': serializer.toJson<int>(incomeGoods),
      'incomeServices': serializer.toJson<int>(incomeServices),
      'totalExpense': serializer.toJson<int>(totalExpense),
      'netProfit': serializer.toJson<int>(netProfit),
      'finalCash': serializer.toJson<int>(finalCash),
      'finalDigital': serializer.toJson<int>(finalDigital),
      'finalStockValue': serializer.toJson<int>(finalStockValue),
      'status': serializer.toJson<String>(status),
      'closedByUserId': serializer.toJson<int?>(closedByUserId),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
    };
  }

  MonthlyAccountingData copyWith(
          {int? id,
          Value<int?> storeId = const Value.absent(),
          String? periodMonthYear,
          int? initialCash,
          int? initialDigital,
          int? initialStockValue,
          int? incomeGoods,
          int? incomeServices,
          int? totalExpense,
          int? netProfit,
          int? finalCash,
          int? finalDigital,
          int? finalStockValue,
          String? status,
          Value<int?> closedByUserId = const Value.absent(),
          Value<DateTime?> closedAt = const Value.absent()}) =>
      MonthlyAccountingData(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        periodMonthYear: periodMonthYear ?? this.periodMonthYear,
        initialCash: initialCash ?? this.initialCash,
        initialDigital: initialDigital ?? this.initialDigital,
        initialStockValue: initialStockValue ?? this.initialStockValue,
        incomeGoods: incomeGoods ?? this.incomeGoods,
        incomeServices: incomeServices ?? this.incomeServices,
        totalExpense: totalExpense ?? this.totalExpense,
        netProfit: netProfit ?? this.netProfit,
        finalCash: finalCash ?? this.finalCash,
        finalDigital: finalDigital ?? this.finalDigital,
        finalStockValue: finalStockValue ?? this.finalStockValue,
        status: status ?? this.status,
        closedByUserId:
            closedByUserId.present ? closedByUserId.value : this.closedByUserId,
        closedAt: closedAt.present ? closedAt.value : this.closedAt,
      );
  MonthlyAccountingData copyWithCompanion(MonthlyAccountingCompanion data) {
    return MonthlyAccountingData(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      periodMonthYear: data.periodMonthYear.present
          ? data.periodMonthYear.value
          : this.periodMonthYear,
      initialCash:
          data.initialCash.present ? data.initialCash.value : this.initialCash,
      initialDigital: data.initialDigital.present
          ? data.initialDigital.value
          : this.initialDigital,
      initialStockValue: data.initialStockValue.present
          ? data.initialStockValue.value
          : this.initialStockValue,
      incomeGoods:
          data.incomeGoods.present ? data.incomeGoods.value : this.incomeGoods,
      incomeServices: data.incomeServices.present
          ? data.incomeServices.value
          : this.incomeServices,
      totalExpense: data.totalExpense.present
          ? data.totalExpense.value
          : this.totalExpense,
      netProfit: data.netProfit.present ? data.netProfit.value : this.netProfit,
      finalCash: data.finalCash.present ? data.finalCash.value : this.finalCash,
      finalDigital: data.finalDigital.present
          ? data.finalDigital.value
          : this.finalDigital,
      finalStockValue: data.finalStockValue.present
          ? data.finalStockValue.value
          : this.finalStockValue,
      status: data.status.present ? data.status.value : this.status,
      closedByUserId: data.closedByUserId.present
          ? data.closedByUserId.value
          : this.closedByUserId,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyAccountingData(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('periodMonthYear: $periodMonthYear, ')
          ..write('initialCash: $initialCash, ')
          ..write('initialDigital: $initialDigital, ')
          ..write('initialStockValue: $initialStockValue, ')
          ..write('incomeGoods: $incomeGoods, ')
          ..write('incomeServices: $incomeServices, ')
          ..write('totalExpense: $totalExpense, ')
          ..write('netProfit: $netProfit, ')
          ..write('finalCash: $finalCash, ')
          ..write('finalDigital: $finalDigital, ')
          ..write('finalStockValue: $finalStockValue, ')
          ..write('status: $status, ')
          ..write('closedByUserId: $closedByUserId, ')
          ..write('closedAt: $closedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      storeId,
      periodMonthYear,
      initialCash,
      initialDigital,
      initialStockValue,
      incomeGoods,
      incomeServices,
      totalExpense,
      netProfit,
      finalCash,
      finalDigital,
      finalStockValue,
      status,
      closedByUserId,
      closedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyAccountingData &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.periodMonthYear == this.periodMonthYear &&
          other.initialCash == this.initialCash &&
          other.initialDigital == this.initialDigital &&
          other.initialStockValue == this.initialStockValue &&
          other.incomeGoods == this.incomeGoods &&
          other.incomeServices == this.incomeServices &&
          other.totalExpense == this.totalExpense &&
          other.netProfit == this.netProfit &&
          other.finalCash == this.finalCash &&
          other.finalDigital == this.finalDigital &&
          other.finalStockValue == this.finalStockValue &&
          other.status == this.status &&
          other.closedByUserId == this.closedByUserId &&
          other.closedAt == this.closedAt);
}

class MonthlyAccountingCompanion
    extends UpdateCompanion<MonthlyAccountingData> {
  final Value<int> id;
  final Value<int?> storeId;
  final Value<String> periodMonthYear;
  final Value<int> initialCash;
  final Value<int> initialDigital;
  final Value<int> initialStockValue;
  final Value<int> incomeGoods;
  final Value<int> incomeServices;
  final Value<int> totalExpense;
  final Value<int> netProfit;
  final Value<int> finalCash;
  final Value<int> finalDigital;
  final Value<int> finalStockValue;
  final Value<String> status;
  final Value<int?> closedByUserId;
  final Value<DateTime?> closedAt;
  const MonthlyAccountingCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.periodMonthYear = const Value.absent(),
    this.initialCash = const Value.absent(),
    this.initialDigital = const Value.absent(),
    this.initialStockValue = const Value.absent(),
    this.incomeGoods = const Value.absent(),
    this.incomeServices = const Value.absent(),
    this.totalExpense = const Value.absent(),
    this.netProfit = const Value.absent(),
    this.finalCash = const Value.absent(),
    this.finalDigital = const Value.absent(),
    this.finalStockValue = const Value.absent(),
    this.status = const Value.absent(),
    this.closedByUserId = const Value.absent(),
    this.closedAt = const Value.absent(),
  });
  MonthlyAccountingCompanion.insert({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    required String periodMonthYear,
    this.initialCash = const Value.absent(),
    this.initialDigital = const Value.absent(),
    this.initialStockValue = const Value.absent(),
    this.incomeGoods = const Value.absent(),
    this.incomeServices = const Value.absent(),
    this.totalExpense = const Value.absent(),
    this.netProfit = const Value.absent(),
    this.finalCash = const Value.absent(),
    this.finalDigital = const Value.absent(),
    this.finalStockValue = const Value.absent(),
    this.status = const Value.absent(),
    this.closedByUserId = const Value.absent(),
    this.closedAt = const Value.absent(),
  }) : periodMonthYear = Value(periodMonthYear);
  static Insertable<MonthlyAccountingData> custom({
    Expression<int>? id,
    Expression<int>? storeId,
    Expression<String>? periodMonthYear,
    Expression<int>? initialCash,
    Expression<int>? initialDigital,
    Expression<int>? initialStockValue,
    Expression<int>? incomeGoods,
    Expression<int>? incomeServices,
    Expression<int>? totalExpense,
    Expression<int>? netProfit,
    Expression<int>? finalCash,
    Expression<int>? finalDigital,
    Expression<int>? finalStockValue,
    Expression<String>? status,
    Expression<int>? closedByUserId,
    Expression<DateTime>? closedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (periodMonthYear != null) 'period_month_year': periodMonthYear,
      if (initialCash != null) 'initial_cash': initialCash,
      if (initialDigital != null) 'initial_digital': initialDigital,
      if (initialStockValue != null) 'initial_stock_value': initialStockValue,
      if (incomeGoods != null) 'income_goods': incomeGoods,
      if (incomeServices != null) 'income_services': incomeServices,
      if (totalExpense != null) 'total_expense': totalExpense,
      if (netProfit != null) 'net_profit': netProfit,
      if (finalCash != null) 'final_cash': finalCash,
      if (finalDigital != null) 'final_digital': finalDigital,
      if (finalStockValue != null) 'final_stock_value': finalStockValue,
      if (status != null) 'status': status,
      if (closedByUserId != null) 'closed_by_user_id': closedByUserId,
      if (closedAt != null) 'closed_at': closedAt,
    });
  }

  MonthlyAccountingCompanion copyWith(
      {Value<int>? id,
      Value<int?>? storeId,
      Value<String>? periodMonthYear,
      Value<int>? initialCash,
      Value<int>? initialDigital,
      Value<int>? initialStockValue,
      Value<int>? incomeGoods,
      Value<int>? incomeServices,
      Value<int>? totalExpense,
      Value<int>? netProfit,
      Value<int>? finalCash,
      Value<int>? finalDigital,
      Value<int>? finalStockValue,
      Value<String>? status,
      Value<int?>? closedByUserId,
      Value<DateTime?>? closedAt}) {
    return MonthlyAccountingCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      periodMonthYear: periodMonthYear ?? this.periodMonthYear,
      initialCash: initialCash ?? this.initialCash,
      initialDigital: initialDigital ?? this.initialDigital,
      initialStockValue: initialStockValue ?? this.initialStockValue,
      incomeGoods: incomeGoods ?? this.incomeGoods,
      incomeServices: incomeServices ?? this.incomeServices,
      totalExpense: totalExpense ?? this.totalExpense,
      netProfit: netProfit ?? this.netProfit,
      finalCash: finalCash ?? this.finalCash,
      finalDigital: finalDigital ?? this.finalDigital,
      finalStockValue: finalStockValue ?? this.finalStockValue,
      status: status ?? this.status,
      closedByUserId: closedByUserId ?? this.closedByUserId,
      closedAt: closedAt ?? this.closedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (periodMonthYear.present) {
      map['period_month_year'] = Variable<String>(periodMonthYear.value);
    }
    if (initialCash.present) {
      map['initial_cash'] = Variable<int>(initialCash.value);
    }
    if (initialDigital.present) {
      map['initial_digital'] = Variable<int>(initialDigital.value);
    }
    if (initialStockValue.present) {
      map['initial_stock_value'] = Variable<int>(initialStockValue.value);
    }
    if (incomeGoods.present) {
      map['income_goods'] = Variable<int>(incomeGoods.value);
    }
    if (incomeServices.present) {
      map['income_services'] = Variable<int>(incomeServices.value);
    }
    if (totalExpense.present) {
      map['total_expense'] = Variable<int>(totalExpense.value);
    }
    if (netProfit.present) {
      map['net_profit'] = Variable<int>(netProfit.value);
    }
    if (finalCash.present) {
      map['final_cash'] = Variable<int>(finalCash.value);
    }
    if (finalDigital.present) {
      map['final_digital'] = Variable<int>(finalDigital.value);
    }
    if (finalStockValue.present) {
      map['final_stock_value'] = Variable<int>(finalStockValue.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (closedByUserId.present) {
      map['closed_by_user_id'] = Variable<int>(closedByUserId.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyAccountingCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('periodMonthYear: $periodMonthYear, ')
          ..write('initialCash: $initialCash, ')
          ..write('initialDigital: $initialDigital, ')
          ..write('initialStockValue: $initialStockValue, ')
          ..write('incomeGoods: $incomeGoods, ')
          ..write('incomeServices: $incomeServices, ')
          ..write('totalExpense: $totalExpense, ')
          ..write('netProfit: $netProfit, ')
          ..write('finalCash: $finalCash, ')
          ..write('finalDigital: $finalDigital, ')
          ..write('finalStockValue: $finalStockValue, ')
          ..write('status: $status, ')
          ..write('closedByUserId: $closedByUserId, ')
          ..write('closedAt: $closedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StoreProfilesTable storeProfiles = $StoreProfilesTable(this);
  late final $StoresTable stores = $StoresTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ServicesTable services = $ServicesTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $TransactionItemsTable transactionItems =
      $TransactionItemsTable(this);
  late final $RestocksTable restocks = $RestocksTable(this);
  late final $ReturnsTable returns = $ReturnsTable(this);
  late final $BalanceLogsTable balanceLogs = $BalanceLogsTable(this);
  late final $MonthlyAccountingTable monthlyAccounting =
      $MonthlyAccountingTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final StoreProfileDao storeProfileDao =
      StoreProfileDao(this as AppDatabase);
  late final StoreDao storeDao = StoreDao(this as AppDatabase);
  late final CategoryDao categoryDao = CategoryDao(this as AppDatabase);
  late final ProductDao productDao = ProductDao(this as AppDatabase);
  late final ServiceDao serviceDao = ServiceDao(this as AppDatabase);
  late final TransactionDao transactionDao =
      TransactionDao(this as AppDatabase);
  late final BalanceDao balanceDao = BalanceDao(this as AppDatabase);
  late final AccountingDao accountingDao = AccountingDao(this as AppDatabase);
  late final BackupDao backupDao = BackupDao(this as AppDatabase);
  late final AnalyticsDao analyticsDao = AnalyticsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        storeProfiles,
        stores,
        users,
        categories,
        products,
        services,
        transactions,
        transactionItems,
        restocks,
        returns,
        balanceLogs,
        monthlyAccounting
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('transactions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('transaction_items', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$StoreProfilesTableCreateCompanionBuilder = StoreProfilesCompanion
    Function({
  Value<int> id,
  Value<String> storeName,
  Value<String> phone,
  Value<String> address,
  Value<String> headerMessage,
  Value<String> footerMessage,
  Value<String?> logoPath,
  Value<DateTime> updatedAt,
});
typedef $$StoreProfilesTableUpdateCompanionBuilder = StoreProfilesCompanion
    Function({
  Value<int> id,
  Value<String> storeName,
  Value<String> phone,
  Value<String> address,
  Value<String> headerMessage,
  Value<String> footerMessage,
  Value<String?> logoPath,
  Value<DateTime> updatedAt,
});

class $$StoreProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $StoreProfilesTable> {
  $$StoreProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storeName => $composableBuilder(
      column: $table.storeName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get headerMessage => $composableBuilder(
      column: $table.headerMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get footerMessage => $composableBuilder(
      column: $table.footerMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logoPath => $composableBuilder(
      column: $table.logoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$StoreProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $StoreProfilesTable> {
  $$StoreProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storeName => $composableBuilder(
      column: $table.storeName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get headerMessage => $composableBuilder(
      column: $table.headerMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get footerMessage => $composableBuilder(
      column: $table.footerMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logoPath => $composableBuilder(
      column: $table.logoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$StoreProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoreProfilesTable> {
  $$StoreProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storeName =>
      $composableBuilder(column: $table.storeName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get headerMessage => $composableBuilder(
      column: $table.headerMessage, builder: (column) => column);

  GeneratedColumn<String> get footerMessage => $composableBuilder(
      column: $table.footerMessage, builder: (column) => column);

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StoreProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StoreProfilesTable,
    StoreProfileData,
    $$StoreProfilesTableFilterComposer,
    $$StoreProfilesTableOrderingComposer,
    $$StoreProfilesTableAnnotationComposer,
    $$StoreProfilesTableCreateCompanionBuilder,
    $$StoreProfilesTableUpdateCompanionBuilder,
    (
      StoreProfileData,
      BaseReferences<_$AppDatabase, $StoreProfilesTable, StoreProfileData>
    ),
    StoreProfileData,
    PrefetchHooks Function()> {
  $$StoreProfilesTableTableManager(_$AppDatabase db, $StoreProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoreProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoreProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoreProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> storeName = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<String> headerMessage = const Value.absent(),
            Value<String> footerMessage = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              StoreProfilesCompanion(
            id: id,
            storeName: storeName,
            phone: phone,
            address: address,
            headerMessage: headerMessage,
            footerMessage: footerMessage,
            logoPath: logoPath,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> storeName = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<String> headerMessage = const Value.absent(),
            Value<String> footerMessage = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              StoreProfilesCompanion.insert(
            id: id,
            storeName: storeName,
            phone: phone,
            address: address,
            headerMessage: headerMessage,
            footerMessage: footerMessage,
            logoPath: logoPath,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StoreProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StoreProfilesTable,
    StoreProfileData,
    $$StoreProfilesTableFilterComposer,
    $$StoreProfilesTableOrderingComposer,
    $$StoreProfilesTableAnnotationComposer,
    $$StoreProfilesTableCreateCompanionBuilder,
    $$StoreProfilesTableUpdateCompanionBuilder,
    (
      StoreProfileData,
      BaseReferences<_$AppDatabase, $StoreProfilesTable, StoreProfileData>
    ),
    StoreProfileData,
    PrefetchHooks Function()>;
typedef $$StoresTableCreateCompanionBuilder = StoresCompanion Function({
  Value<int> id,
  required String storeName,
  Value<String> ownerName,
  Value<String> phone,
  Value<String> address,
  Value<String> headerMessage,
  Value<String> footerMessage,
  Value<String?> logoPath,
  required String pinHash,
  required String pinSalt,
  required String securityQuestion,
  required String securityAnswerHash,
  required String securityAnswerSalt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$StoresTableUpdateCompanionBuilder = StoresCompanion Function({
  Value<int> id,
  Value<String> storeName,
  Value<String> ownerName,
  Value<String> phone,
  Value<String> address,
  Value<String> headerMessage,
  Value<String> footerMessage,
  Value<String?> logoPath,
  Value<String> pinHash,
  Value<String> pinSalt,
  Value<String> securityQuestion,
  Value<String> securityAnswerHash,
  Value<String> securityAnswerSalt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$StoresTableReferences
    extends BaseReferences<_$AppDatabase, $StoresTable, StoreData> {
  $$StoresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CategoriesTable, List<CategoryData>>
      _categoriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.categories,
              aliasName: 'stores__id__categories__store_id');

  $$CategoriesTableProcessedTableManager get categoriesRefs {
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.storeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_categoriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ProductsTable, List<ProductData>>
      _productsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.products,
              aliasName: 'stores__id__products__store_id');

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager($_db, $_db.products)
        .filter((f) => f.storeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ServicesTable, List<ServiceData>>
      _servicesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.services,
              aliasName: 'stores__id__services__store_id');

  $$ServicesTableProcessedTableManager get servicesRefs {
    final manager = $$ServicesTableTableManager($_db, $_db.services)
        .filter((f) => f.storeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_servicesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionsTable, List<TransactionData>>
      _transactionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactions,
              aliasName: 'stores__id__transactions__store_id');

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.storeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BalanceLogsTable, List<BalanceLogData>>
      _balanceLogsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.balanceLogs,
              aliasName: 'stores__id__balance_logs__store_id');

  $$BalanceLogsTableProcessedTableManager get balanceLogsRefs {
    final manager = $$BalanceLogsTableTableManager($_db, $_db.balanceLogs)
        .filter((f) => f.storeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_balanceLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MonthlyAccountingTable,
      List<MonthlyAccountingData>> _monthlyAccountingRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.monthlyAccounting,
          aliasName: 'stores__id__monthly_accounting__store_id');

  $$MonthlyAccountingTableProcessedTableManager get monthlyAccountingRefs {
    final manager =
        $$MonthlyAccountingTableTableManager($_db, $_db.monthlyAccounting)
            .filter((f) => f.storeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_monthlyAccountingRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$StoresTableFilterComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storeName => $composableBuilder(
      column: $table.storeName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get headerMessage => $composableBuilder(
      column: $table.headerMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get footerMessage => $composableBuilder(
      column: $table.footerMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logoPath => $composableBuilder(
      column: $table.logoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pinHash => $composableBuilder(
      column: $table.pinHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pinSalt => $composableBuilder(
      column: $table.pinSalt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get securityQuestion => $composableBuilder(
      column: $table.securityQuestion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get securityAnswerHash => $composableBuilder(
      column: $table.securityAnswerHash,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get securityAnswerSalt => $composableBuilder(
      column: $table.securityAnswerSalt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> categoriesRefs(
      Expression<bool> Function($$CategoriesTableFilterComposer f) f) {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.storeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> productsRefs(
      Expression<bool> Function($$ProductsTableFilterComposer f) f) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.storeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> servicesRefs(
      Expression<bool> Function($$ServicesTableFilterComposer f) f) {
    final $$ServicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.services,
        getReferencedColumn: (t) => t.storeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServicesTableFilterComposer(
              $db: $db,
              $table: $db.services,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionsRefs(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.storeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> balanceLogsRefs(
      Expression<bool> Function($$BalanceLogsTableFilterComposer f) f) {
    final $$BalanceLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.balanceLogs,
        getReferencedColumn: (t) => t.storeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BalanceLogsTableFilterComposer(
              $db: $db,
              $table: $db.balanceLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> monthlyAccountingRefs(
      Expression<bool> Function($$MonthlyAccountingTableFilterComposer f) f) {
    final $$MonthlyAccountingTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.monthlyAccounting,
        getReferencedColumn: (t) => t.storeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MonthlyAccountingTableFilterComposer(
              $db: $db,
              $table: $db.monthlyAccounting,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StoresTableOrderingComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storeName => $composableBuilder(
      column: $table.storeName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get headerMessage => $composableBuilder(
      column: $table.headerMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get footerMessage => $composableBuilder(
      column: $table.footerMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logoPath => $composableBuilder(
      column: $table.logoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pinHash => $composableBuilder(
      column: $table.pinHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pinSalt => $composableBuilder(
      column: $table.pinSalt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get securityQuestion => $composableBuilder(
      column: $table.securityQuestion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get securityAnswerHash => $composableBuilder(
      column: $table.securityAnswerHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get securityAnswerSalt => $composableBuilder(
      column: $table.securityAnswerSalt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$StoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storeName =>
      $composableBuilder(column: $table.storeName, builder: (column) => column);

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get headerMessage => $composableBuilder(
      column: $table.headerMessage, builder: (column) => column);

  GeneratedColumn<String> get footerMessage => $composableBuilder(
      column: $table.footerMessage, builder: (column) => column);

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<String> get pinHash =>
      $composableBuilder(column: $table.pinHash, builder: (column) => column);

  GeneratedColumn<String> get pinSalt =>
      $composableBuilder(column: $table.pinSalt, builder: (column) => column);

  GeneratedColumn<String> get securityQuestion => $composableBuilder(
      column: $table.securityQuestion, builder: (column) => column);

  GeneratedColumn<String> get securityAnswerHash => $composableBuilder(
      column: $table.securityAnswerHash, builder: (column) => column);

  GeneratedColumn<String> get securityAnswerSalt => $composableBuilder(
      column: $table.securityAnswerSalt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> categoriesRefs<T extends Object>(
      Expression<T> Function($$CategoriesTableAnnotationComposer a) f) {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.storeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> productsRefs<T extends Object>(
      Expression<T> Function($$ProductsTableAnnotationComposer a) f) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.storeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> servicesRefs<T extends Object>(
      Expression<T> Function($$ServicesTableAnnotationComposer a) f) {
    final $$ServicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.services,
        getReferencedColumn: (t) => t.storeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServicesTableAnnotationComposer(
              $db: $db,
              $table: $db.services,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> transactionsRefs<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.storeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> balanceLogsRefs<T extends Object>(
      Expression<T> Function($$BalanceLogsTableAnnotationComposer a) f) {
    final $$BalanceLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.balanceLogs,
        getReferencedColumn: (t) => t.storeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BalanceLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.balanceLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> monthlyAccountingRefs<T extends Object>(
      Expression<T> Function($$MonthlyAccountingTableAnnotationComposer a) f) {
    final $$MonthlyAccountingTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.monthlyAccounting,
            getReferencedColumn: (t) => t.storeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MonthlyAccountingTableAnnotationComposer(
                  $db: $db,
                  $table: $db.monthlyAccounting,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$StoresTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StoresTable,
    StoreData,
    $$StoresTableFilterComposer,
    $$StoresTableOrderingComposer,
    $$StoresTableAnnotationComposer,
    $$StoresTableCreateCompanionBuilder,
    $$StoresTableUpdateCompanionBuilder,
    (StoreData, $$StoresTableReferences),
    StoreData,
    PrefetchHooks Function(
        {bool categoriesRefs,
        bool productsRefs,
        bool servicesRefs,
        bool transactionsRefs,
        bool balanceLogsRefs,
        bool monthlyAccountingRefs})> {
  $$StoresTableTableManager(_$AppDatabase db, $StoresTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> storeName = const Value.absent(),
            Value<String> ownerName = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<String> headerMessage = const Value.absent(),
            Value<String> footerMessage = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            Value<String> pinHash = const Value.absent(),
            Value<String> pinSalt = const Value.absent(),
            Value<String> securityQuestion = const Value.absent(),
            Value<String> securityAnswerHash = const Value.absent(),
            Value<String> securityAnswerSalt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              StoresCompanion(
            id: id,
            storeName: storeName,
            ownerName: ownerName,
            phone: phone,
            address: address,
            headerMessage: headerMessage,
            footerMessage: footerMessage,
            logoPath: logoPath,
            pinHash: pinHash,
            pinSalt: pinSalt,
            securityQuestion: securityQuestion,
            securityAnswerHash: securityAnswerHash,
            securityAnswerSalt: securityAnswerSalt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String storeName,
            Value<String> ownerName = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<String> headerMessage = const Value.absent(),
            Value<String> footerMessage = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            required String pinHash,
            required String pinSalt,
            required String securityQuestion,
            required String securityAnswerHash,
            required String securityAnswerSalt,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              StoresCompanion.insert(
            id: id,
            storeName: storeName,
            ownerName: ownerName,
            phone: phone,
            address: address,
            headerMessage: headerMessage,
            footerMessage: footerMessage,
            logoPath: logoPath,
            pinHash: pinHash,
            pinSalt: pinSalt,
            securityQuestion: securityQuestion,
            securityAnswerHash: securityAnswerHash,
            securityAnswerSalt: securityAnswerSalt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$StoresTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {categoriesRefs = false,
              productsRefs = false,
              servicesRefs = false,
              transactionsRefs = false,
              balanceLogsRefs = false,
              monthlyAccountingRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (categoriesRefs) db.categories,
                if (productsRefs) db.products,
                if (servicesRefs) db.services,
                if (transactionsRefs) db.transactions,
                if (balanceLogsRefs) db.balanceLogs,
                if (monthlyAccountingRefs) db.monthlyAccounting
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (categoriesRefs)
                    await $_getPrefetchedData<StoreData, $StoresTable,
                            CategoryData>(
                        currentTable: table,
                        referencedTable:
                            $$StoresTableReferences._categoriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StoresTableReferences(db, table, p0)
                                .categoriesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.storeId == item.id),
                        typedResults: items),
                  if (productsRefs)
                    await $_getPrefetchedData<StoreData, $StoresTable,
                            ProductData>(
                        currentTable: table,
                        referencedTable:
                            $$StoresTableReferences._productsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StoresTableReferences(db, table, p0).productsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.storeId == item.id),
                        typedResults: items),
                  if (servicesRefs)
                    await $_getPrefetchedData<StoreData, $StoresTable,
                            ServiceData>(
                        currentTable: table,
                        referencedTable:
                            $$StoresTableReferences._servicesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StoresTableReferences(db, table, p0).servicesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.storeId == item.id),
                        typedResults: items),
                  if (transactionsRefs)
                    await $_getPrefetchedData<StoreData, $StoresTable,
                            TransactionData>(
                        currentTable: table,
                        referencedTable:
                            $$StoresTableReferences._transactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StoresTableReferences(db, table, p0)
                                .transactionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.storeId == item.id),
                        typedResults: items),
                  if (balanceLogsRefs)
                    await $_getPrefetchedData<StoreData, $StoresTable,
                            BalanceLogData>(
                        currentTable: table,
                        referencedTable:
                            $$StoresTableReferences._balanceLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StoresTableReferences(db, table, p0)
                                .balanceLogsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.storeId == item.id),
                        typedResults: items),
                  if (monthlyAccountingRefs)
                    await $_getPrefetchedData<StoreData, $StoresTable,
                            MonthlyAccountingData>(
                        currentTable: table,
                        referencedTable: $$StoresTableReferences
                            ._monthlyAccountingRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StoresTableReferences(db, table, p0)
                                .monthlyAccountingRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.storeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$StoresTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StoresTable,
    StoreData,
    $$StoresTableFilterComposer,
    $$StoresTableOrderingComposer,
    $$StoresTableAnnotationComposer,
    $$StoresTableCreateCompanionBuilder,
    $$StoresTableUpdateCompanionBuilder,
    (StoreData, $$StoresTableReferences),
    StoreData,
    PrefetchHooks Function(
        {bool categoriesRefs,
        bool productsRefs,
        bool servicesRefs,
        bool transactionsRefs,
        bool balanceLogsRefs,
        bool monthlyAccountingRefs})>;
typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String username,
  required String email,
  required String passwordHash,
  required String salt,
  required String fullname,
  Value<String> role,
  Value<String?> photoPath,
  Value<DateTime> createdAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> email,
  Value<String> passwordHash,
  Value<String> salt,
  Value<String> fullname,
  Value<String> role,
  Value<String?> photoPath,
  Value<DateTime> createdAt,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, UserData> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<TransactionData>>
      _transactionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactions,
              aliasName: 'users__id__transactions__user_id');

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RestocksTable, List<RestockData>>
      _restocksRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.restocks,
              aliasName: 'users__id__restocks__user_id');

  $$RestocksTableProcessedTableManager get restocksRefs {
    final manager = $$RestocksTableTableManager($_db, $_db.restocks)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_restocksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ReturnsTable, List<ReturnData>> _returnsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.returns,
          aliasName: 'users__id__returns__user_id');

  $$ReturnsTableProcessedTableManager get returnsRefs {
    final manager = $$ReturnsTableTableManager($_db, $_db.returns)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_returnsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BalanceLogsTable, List<BalanceLogData>>
      _balanceLogsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.balanceLogs,
              aliasName: 'users__id__balance_logs__user_id');

  $$BalanceLogsTableProcessedTableManager get balanceLogsRefs {
    final manager = $$BalanceLogsTableTableManager($_db, $_db.balanceLogs)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_balanceLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MonthlyAccountingTable,
      List<MonthlyAccountingData>> _monthlyAccountingRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.monthlyAccounting,
          aliasName: 'users__id__monthly_accounting__closed_by_user_id');

  $$MonthlyAccountingTableProcessedTableManager get monthlyAccountingRefs {
    final manager = $$MonthlyAccountingTableTableManager(
            $_db, $_db.monthlyAccounting)
        .filter((f) => f.closedByUserId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_monthlyAccountingRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get salt => $composableBuilder(
      column: $table.salt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullname => $composableBuilder(
      column: $table.fullname, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> transactionsRefs(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> restocksRefs(
      Expression<bool> Function($$RestocksTableFilterComposer f) f) {
    final $$RestocksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.restocks,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RestocksTableFilterComposer(
              $db: $db,
              $table: $db.restocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> returnsRefs(
      Expression<bool> Function($$ReturnsTableFilterComposer f) f) {
    final $$ReturnsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.returns,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReturnsTableFilterComposer(
              $db: $db,
              $table: $db.returns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> balanceLogsRefs(
      Expression<bool> Function($$BalanceLogsTableFilterComposer f) f) {
    final $$BalanceLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.balanceLogs,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BalanceLogsTableFilterComposer(
              $db: $db,
              $table: $db.balanceLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> monthlyAccountingRefs(
      Expression<bool> Function($$MonthlyAccountingTableFilterComposer f) f) {
    final $$MonthlyAccountingTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.monthlyAccounting,
        getReferencedColumn: (t) => t.closedByUserId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MonthlyAccountingTableFilterComposer(
              $db: $db,
              $table: $db.monthlyAccounting,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get salt => $composableBuilder(
      column: $table.salt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullname => $composableBuilder(
      column: $table.fullname, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<String> get salt =>
      $composableBuilder(column: $table.salt, builder: (column) => column);

  GeneratedColumn<String> get fullname =>
      $composableBuilder(column: $table.fullname, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> restocksRefs<T extends Object>(
      Expression<T> Function($$RestocksTableAnnotationComposer a) f) {
    final $$RestocksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.restocks,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RestocksTableAnnotationComposer(
              $db: $db,
              $table: $db.restocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> returnsRefs<T extends Object>(
      Expression<T> Function($$ReturnsTableAnnotationComposer a) f) {
    final $$ReturnsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.returns,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReturnsTableAnnotationComposer(
              $db: $db,
              $table: $db.returns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> balanceLogsRefs<T extends Object>(
      Expression<T> Function($$BalanceLogsTableAnnotationComposer a) f) {
    final $$BalanceLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.balanceLogs,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BalanceLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.balanceLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> monthlyAccountingRefs<T extends Object>(
      Expression<T> Function($$MonthlyAccountingTableAnnotationComposer a) f) {
    final $$MonthlyAccountingTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.monthlyAccounting,
            getReferencedColumn: (t) => t.closedByUserId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MonthlyAccountingTableAnnotationComposer(
                  $db: $db,
                  $table: $db.monthlyAccounting,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    UserData,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (UserData, $$UsersTableReferences),
    UserData,
    PrefetchHooks Function(
        {bool transactionsRefs,
        bool restocksRefs,
        bool returnsRefs,
        bool balanceLogsRefs,
        bool monthlyAccountingRefs})> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> passwordHash = const Value.absent(),
            Value<String> salt = const Value.absent(),
            Value<String> fullname = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            username: username,
            email: email,
            passwordHash: passwordHash,
            salt: salt,
            fullname: fullname,
            role: role,
            photoPath: photoPath,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String username,
            required String email,
            required String passwordHash,
            required String salt,
            required String fullname,
            Value<String> role = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            username: username,
            email: email,
            passwordHash: passwordHash,
            salt: salt,
            fullname: fullname,
            role: role,
            photoPath: photoPath,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {transactionsRefs = false,
              restocksRefs = false,
              returnsRefs = false,
              balanceLogsRefs = false,
              monthlyAccountingRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionsRefs) db.transactions,
                if (restocksRefs) db.restocks,
                if (returnsRefs) db.returns,
                if (balanceLogsRefs) db.balanceLogs,
                if (monthlyAccountingRefs) db.monthlyAccounting
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<UserData, $UsersTable,
                            TransactionData>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._transactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .transactionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (restocksRefs)
                    await $_getPrefetchedData<UserData, $UsersTable,
                            RestockData>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._restocksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).restocksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (returnsRefs)
                    await $_getPrefetchedData<UserData, $UsersTable,
                            ReturnData>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._returnsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).returnsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (balanceLogsRefs)
                    await $_getPrefetchedData<UserData, $UsersTable,
                            BalanceLogData>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._balanceLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .balanceLogsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (monthlyAccountingRefs)
                    await $_getPrefetchedData<UserData, $UsersTable,
                            MonthlyAccountingData>(
                        currentTable: table,
                        referencedTable: $$UsersTableReferences
                            ._monthlyAccountingRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .monthlyAccountingRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.closedByUserId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    UserData,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (UserData, $$UsersTableReferences),
    UserData,
    PrefetchHooks Function(
        {bool transactionsRefs,
        bool restocksRefs,
        bool returnsRefs,
        bool balanceLogsRefs,
        bool monthlyAccountingRefs})>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<int?> storeId,
  required String name,
  required String type,
  Value<String?> iconName,
  Value<DateTime> createdAt,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<int?> storeId,
  Value<String> name,
  Value<String> type,
  Value<String?> iconName,
  Value<DateTime> createdAt,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, CategoryData> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StoresTable _storeIdTable(_$AppDatabase db) =>
      db.stores.createAlias('categories__store_id__stores__id');

  $$StoresTableProcessedTableManager? get storeId {
    final $_column = $_itemColumn<int>('store_id');
    if ($_column == null) return null;
    final manager = $$StoresTableTableManager($_db, $_db.stores)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_storeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ProductsTable, List<ProductData>>
      _productsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.products,
              aliasName: 'categories__id__products__category_id');

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager($_db, $_db.products)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ServicesTable, List<ServiceData>>
      _servicesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.services,
              aliasName: 'categories__id__services__category_id');

  $$ServicesTableProcessedTableManager get servicesRefs {
    final manager = $$ServicesTableTableManager($_db, $_db.services)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_servicesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconName => $composableBuilder(
      column: $table.iconName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$StoresTableFilterComposer get storeId {
    final $$StoresTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableFilterComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> productsRefs(
      Expression<bool> Function($$ProductsTableFilterComposer f) f) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> servicesRefs(
      Expression<bool> Function($$ServicesTableFilterComposer f) f) {
    final $$ServicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.services,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServicesTableFilterComposer(
              $db: $db,
              $table: $db.services,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconName => $composableBuilder(
      column: $table.iconName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$StoresTableOrderingComposer get storeId {
    final $$StoresTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableOrderingComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StoresTableAnnotationComposer get storeId {
    final $$StoresTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableAnnotationComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> productsRefs<T extends Object>(
      Expression<T> Function($$ProductsTableAnnotationComposer a) f) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> servicesRefs<T extends Object>(
      Expression<T> Function($$ServicesTableAnnotationComposer a) f) {
    final $$ServicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.services,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServicesTableAnnotationComposer(
              $db: $db,
              $table: $db.services,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    CategoryData,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (CategoryData, $$CategoriesTableReferences),
    CategoryData,
    PrefetchHooks Function(
        {bool storeId, bool productsRefs, bool servicesRefs})> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> storeId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> iconName = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            storeId: storeId,
            name: name,
            type: type,
            iconName: iconName,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> storeId = const Value.absent(),
            required String name,
            required String type,
            Value<String?> iconName = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            storeId: storeId,
            name: name,
            type: type,
            iconName: iconName,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {storeId = false, productsRefs = false, servicesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productsRefs) db.products,
                if (servicesRefs) db.services
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (storeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.storeId,
                    referencedTable:
                        $$CategoriesTableReferences._storeIdTable(db),
                    referencedColumn:
                        $$CategoriesTableReferences._storeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productsRefs)
                    await $_getPrefetchedData<CategoryData, $CategoriesTable,
                            ProductData>(
                        currentTable: table,
                        referencedTable:
                            $$CategoriesTableReferences._productsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableReferences(db, table, p0)
                                .productsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items),
                  if (servicesRefs)
                    await $_getPrefetchedData<CategoryData, $CategoriesTable,
                            ServiceData>(
                        currentTable: table,
                        referencedTable:
                            $$CategoriesTableReferences._servicesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableReferences(db, table, p0)
                                .servicesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    CategoryData,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (CategoryData, $$CategoriesTableReferences),
    CategoryData,
    PrefetchHooks Function(
        {bool storeId, bool productsRefs, bool servicesRefs})>;
typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  Value<int?> storeId,
  Value<String?> sku,
  required String name,
  Value<int?> categoryId,
  Value<String> unit,
  Value<int> costPrice,
  required int sellingPrice,
  Value<int> stock,
  Value<int> minStockAlert,
  Value<String?> photoPath,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  Value<int?> storeId,
  Value<String?> sku,
  Value<String> name,
  Value<int?> categoryId,
  Value<String> unit,
  Value<int> costPrice,
  Value<int> sellingPrice,
  Value<int> stock,
  Value<int> minStockAlert,
  Value<String?> photoPath,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, ProductData> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StoresTable _storeIdTable(_$AppDatabase db) =>
      db.stores.createAlias('products__store_id__stores__id');

  $$StoresTableProcessedTableManager? get storeId {
    final $_column = $_itemColumn<int>('store_id');
    if ($_column == null) return null;
    final manager = $$StoresTableTableManager($_db, $_db.stores)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_storeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('products__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TransactionItemsTable, List<TransactionItemData>>
      _transactionItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionItems,
              aliasName: 'products__id__transaction_items__product_id');

  $$TransactionItemsTableProcessedTableManager get transactionItemsRefs {
    final manager =
        $$TransactionItemsTableTableManager($_db, $_db.transactionItems)
            .filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_transactionItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RestocksTable, List<RestockData>>
      _restocksRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.restocks,
              aliasName: 'products__id__restocks__product_id');

  $$RestocksTableProcessedTableManager get restocksRefs {
    final manager = $$RestocksTableTableManager($_db, $_db.restocks)
        .filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_restocksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get costPrice => $composableBuilder(
      column: $table.costPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sellingPrice => $composableBuilder(
      column: $table.sellingPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minStockAlert => $composableBuilder(
      column: $table.minStockAlert, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$StoresTableFilterComposer get storeId {
    final $$StoresTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableFilterComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> transactionItemsRefs(
      Expression<bool> Function($$TransactionItemsTableFilterComposer f) f) {
    final $$TransactionItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionItems,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionItemsTableFilterComposer(
              $db: $db,
              $table: $db.transactionItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> restocksRefs(
      Expression<bool> Function($$RestocksTableFilterComposer f) f) {
    final $$RestocksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.restocks,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RestocksTableFilterComposer(
              $db: $db,
              $table: $db.restocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get costPrice => $composableBuilder(
      column: $table.costPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sellingPrice => $composableBuilder(
      column: $table.sellingPrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minStockAlert => $composableBuilder(
      column: $table.minStockAlert,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$StoresTableOrderingComposer get storeId {
    final $$StoresTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableOrderingComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get costPrice =>
      $composableBuilder(column: $table.costPrice, builder: (column) => column);

  GeneratedColumn<int> get sellingPrice => $composableBuilder(
      column: $table.sellingPrice, builder: (column) => column);

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<int> get minStockAlert => $composableBuilder(
      column: $table.minStockAlert, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$StoresTableAnnotationComposer get storeId {
    final $$StoresTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableAnnotationComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> transactionItemsRefs<T extends Object>(
      Expression<T> Function($$TransactionItemsTableAnnotationComposer a) f) {
    final $$TransactionItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionItems,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactionItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> restocksRefs<T extends Object>(
      Expression<T> Function($$RestocksTableAnnotationComposer a) f) {
    final $$RestocksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.restocks,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RestocksTableAnnotationComposer(
              $db: $db,
              $table: $db.restocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTable,
    ProductData,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (ProductData, $$ProductsTableReferences),
    ProductData,
    PrefetchHooks Function(
        {bool storeId,
        bool categoryId,
        bool transactionItemsRefs,
        bool restocksRefs})> {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> storeId = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int?> categoryId = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<int> costPrice = const Value.absent(),
            Value<int> sellingPrice = const Value.absent(),
            Value<int> stock = const Value.absent(),
            Value<int> minStockAlert = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ProductsCompanion(
            id: id,
            storeId: storeId,
            sku: sku,
            name: name,
            categoryId: categoryId,
            unit: unit,
            costPrice: costPrice,
            sellingPrice: sellingPrice,
            stock: stock,
            minStockAlert: minStockAlert,
            photoPath: photoPath,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> storeId = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            required String name,
            Value<int?> categoryId = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<int> costPrice = const Value.absent(),
            required int sellingPrice,
            Value<int> stock = const Value.absent(),
            Value<int> minStockAlert = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ProductsCompanion.insert(
            id: id,
            storeId: storeId,
            sku: sku,
            name: name,
            categoryId: categoryId,
            unit: unit,
            costPrice: costPrice,
            sellingPrice: sellingPrice,
            stock: stock,
            minStockAlert: minStockAlert,
            photoPath: photoPath,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProductsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {storeId = false,
              categoryId = false,
              transactionItemsRefs = false,
              restocksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionItemsRefs) db.transactionItems,
                if (restocksRefs) db.restocks
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (storeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.storeId,
                    referencedTable:
                        $$ProductsTableReferences._storeIdTable(db),
                    referencedColumn:
                        $$ProductsTableReferences._storeIdTable(db).id,
                  ) as T;
                }
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$ProductsTableReferences._categoryIdTable(db),
                    referencedColumn:
                        $$ProductsTableReferences._categoryIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionItemsRefs)
                    await $_getPrefetchedData<ProductData, $ProductsTable,
                            TransactionItemData>(
                        currentTable: table,
                        referencedTable: $$ProductsTableReferences
                            ._transactionItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductsTableReferences(db, table, p0)
                                .transactionItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.productId == item.id),
                        typedResults: items),
                  if (restocksRefs)
                    await $_getPrefetchedData<ProductData, $ProductsTable,
                            RestockData>(
                        currentTable: table,
                        referencedTable:
                            $$ProductsTableReferences._restocksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductsTableReferences(db, table, p0)
                                .restocksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.productId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProductsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductsTable,
    ProductData,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (ProductData, $$ProductsTableReferences),
    ProductData,
    PrefetchHooks Function(
        {bool storeId,
        bool categoryId,
        bool transactionItemsRefs,
        bool restocksRefs})>;
typedef $$ServicesTableCreateCompanionBuilder = ServicesCompanion Function({
  Value<int> id,
  Value<int?> storeId,
  required String serviceName,
  Value<int?> categoryId,
  Value<int> materialCost,
  required int finalPrice,
  Value<int> durationValue,
  Value<String> durationUnit,
  Value<String?> description,
  Value<String?> photoPath,
  Value<DateTime> createdAt,
});
typedef $$ServicesTableUpdateCompanionBuilder = ServicesCompanion Function({
  Value<int> id,
  Value<int?> storeId,
  Value<String> serviceName,
  Value<int?> categoryId,
  Value<int> materialCost,
  Value<int> finalPrice,
  Value<int> durationValue,
  Value<String> durationUnit,
  Value<String?> description,
  Value<String?> photoPath,
  Value<DateTime> createdAt,
});

final class $$ServicesTableReferences
    extends BaseReferences<_$AppDatabase, $ServicesTable, ServiceData> {
  $$ServicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StoresTable _storeIdTable(_$AppDatabase db) =>
      db.stores.createAlias('services__store_id__stores__id');

  $$StoresTableProcessedTableManager? get storeId {
    final $_column = $_itemColumn<int>('store_id');
    if ($_column == null) return null;
    final manager = $$StoresTableTableManager($_db, $_db.stores)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_storeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('services__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TransactionItemsTable, List<TransactionItemData>>
      _transactionItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionItems,
              aliasName: 'services__id__transaction_items__service_id');

  $$TransactionItemsTableProcessedTableManager get transactionItemsRefs {
    final manager =
        $$TransactionItemsTableTableManager($_db, $_db.transactionItems)
            .filter((f) => f.serviceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_transactionItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ServicesTableFilterComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceName => $composableBuilder(
      column: $table.serviceName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get materialCost => $composableBuilder(
      column: $table.materialCost, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get finalPrice => $composableBuilder(
      column: $table.finalPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationValue => $composableBuilder(
      column: $table.durationValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get durationUnit => $composableBuilder(
      column: $table.durationUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$StoresTableFilterComposer get storeId {
    final $$StoresTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableFilterComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> transactionItemsRefs(
      Expression<bool> Function($$TransactionItemsTableFilterComposer f) f) {
    final $$TransactionItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionItems,
        getReferencedColumn: (t) => t.serviceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionItemsTableFilterComposer(
              $db: $db,
              $table: $db.transactionItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ServicesTableOrderingComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceName => $composableBuilder(
      column: $table.serviceName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get materialCost => $composableBuilder(
      column: $table.materialCost,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get finalPrice => $composableBuilder(
      column: $table.finalPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationValue => $composableBuilder(
      column: $table.durationValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get durationUnit => $composableBuilder(
      column: $table.durationUnit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$StoresTableOrderingComposer get storeId {
    final $$StoresTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableOrderingComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ServicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serviceName => $composableBuilder(
      column: $table.serviceName, builder: (column) => column);

  GeneratedColumn<int> get materialCost => $composableBuilder(
      column: $table.materialCost, builder: (column) => column);

  GeneratedColumn<int> get finalPrice => $composableBuilder(
      column: $table.finalPrice, builder: (column) => column);

  GeneratedColumn<int> get durationValue => $composableBuilder(
      column: $table.durationValue, builder: (column) => column);

  GeneratedColumn<String> get durationUnit => $composableBuilder(
      column: $table.durationUnit, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StoresTableAnnotationComposer get storeId {
    final $$StoresTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableAnnotationComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> transactionItemsRefs<T extends Object>(
      Expression<T> Function($$TransactionItemsTableAnnotationComposer a) f) {
    final $$TransactionItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionItems,
        getReferencedColumn: (t) => t.serviceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactionItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ServicesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ServicesTable,
    ServiceData,
    $$ServicesTableFilterComposer,
    $$ServicesTableOrderingComposer,
    $$ServicesTableAnnotationComposer,
    $$ServicesTableCreateCompanionBuilder,
    $$ServicesTableUpdateCompanionBuilder,
    (ServiceData, $$ServicesTableReferences),
    ServiceData,
    PrefetchHooks Function(
        {bool storeId, bool categoryId, bool transactionItemsRefs})> {
  $$ServicesTableTableManager(_$AppDatabase db, $ServicesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> storeId = const Value.absent(),
            Value<String> serviceName = const Value.absent(),
            Value<int?> categoryId = const Value.absent(),
            Value<int> materialCost = const Value.absent(),
            Value<int> finalPrice = const Value.absent(),
            Value<int> durationValue = const Value.absent(),
            Value<String> durationUnit = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ServicesCompanion(
            id: id,
            storeId: storeId,
            serviceName: serviceName,
            categoryId: categoryId,
            materialCost: materialCost,
            finalPrice: finalPrice,
            durationValue: durationValue,
            durationUnit: durationUnit,
            description: description,
            photoPath: photoPath,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> storeId = const Value.absent(),
            required String serviceName,
            Value<int?> categoryId = const Value.absent(),
            Value<int> materialCost = const Value.absent(),
            required int finalPrice,
            Value<int> durationValue = const Value.absent(),
            Value<String> durationUnit = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ServicesCompanion.insert(
            id: id,
            storeId: storeId,
            serviceName: serviceName,
            categoryId: categoryId,
            materialCost: materialCost,
            finalPrice: finalPrice,
            durationValue: durationValue,
            durationUnit: durationUnit,
            description: description,
            photoPath: photoPath,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ServicesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {storeId = false,
              categoryId = false,
              transactionItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionItemsRefs) db.transactionItems
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (storeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.storeId,
                    referencedTable:
                        $$ServicesTableReferences._storeIdTable(db),
                    referencedColumn:
                        $$ServicesTableReferences._storeIdTable(db).id,
                  ) as T;
                }
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$ServicesTableReferences._categoryIdTable(db),
                    referencedColumn:
                        $$ServicesTableReferences._categoryIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionItemsRefs)
                    await $_getPrefetchedData<ServiceData, $ServicesTable,
                            TransactionItemData>(
                        currentTable: table,
                        referencedTable: $$ServicesTableReferences
                            ._transactionItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ServicesTableReferences(db, table, p0)
                                .transactionItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.serviceId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ServicesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ServicesTable,
    ServiceData,
    $$ServicesTableFilterComposer,
    $$ServicesTableOrderingComposer,
    $$ServicesTableAnnotationComposer,
    $$ServicesTableCreateCompanionBuilder,
    $$ServicesTableUpdateCompanionBuilder,
    (ServiceData, $$ServicesTableReferences),
    ServiceData,
    PrefetchHooks Function(
        {bool storeId, bool categoryId, bool transactionItemsRefs})>;
typedef $$TransactionsTableCreateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<int?> storeId,
  required String invoiceNumber,
  Value<String?> customerName,
  Value<String?> customerPhone,
  required int subtotal,
  Value<int> discount,
  required int totalAmount,
  required int paymentAmount,
  Value<int> changeAmount,
  Value<String> paymentMethod,
  Value<int> totalProfit,
  required int userId,
  Value<DateTime> createdAt,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<int?> storeId,
  Value<String> invoiceNumber,
  Value<String?> customerName,
  Value<String?> customerPhone,
  Value<int> subtotal,
  Value<int> discount,
  Value<int> totalAmount,
  Value<int> paymentAmount,
  Value<int> changeAmount,
  Value<String> paymentMethod,
  Value<int> totalProfit,
  Value<int> userId,
  Value<DateTime> createdAt,
});

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, TransactionData> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StoresTable _storeIdTable(_$AppDatabase db) =>
      db.stores.createAlias('transactions__store_id__stores__id');

  $$StoresTableProcessedTableManager? get storeId {
    final $_column = $_itemColumn<int>('store_id');
    if ($_column == null) return null;
    final manager = $$StoresTableTableManager($_db, $_db.stores)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_storeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('transactions__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TransactionItemsTable, List<TransactionItemData>>
      _transactionItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionItems,
              aliasName: 'transactions__id__transaction_items__transaction_id');

  $$TransactionItemsTableProcessedTableManager get transactionItemsRefs {
    final manager = $$TransactionItemsTableTableManager(
            $_db, $_db.transactionItems)
        .filter((f) => f.transactionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_transactionItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ReturnsTable, List<ReturnData>> _returnsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.returns,
          aliasName: 'transactions__id__returns__transaction_id');

  $$ReturnsTableProcessedTableManager get returnsRefs {
    final manager = $$ReturnsTableTableManager($_db, $_db.returns)
        .filter((f) => f.transactionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_returnsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerPhone => $composableBuilder(
      column: $table.customerPhone, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get discount => $composableBuilder(
      column: $table.discount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paymentAmount => $composableBuilder(
      column: $table.paymentAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get changeAmount => $composableBuilder(
      column: $table.changeAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalProfit => $composableBuilder(
      column: $table.totalProfit, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$StoresTableFilterComposer get storeId {
    final $$StoresTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableFilterComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> transactionItemsRefs(
      Expression<bool> Function($$TransactionItemsTableFilterComposer f) f) {
    final $$TransactionItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionItems,
        getReferencedColumn: (t) => t.transactionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionItemsTableFilterComposer(
              $db: $db,
              $table: $db.transactionItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> returnsRefs(
      Expression<bool> Function($$ReturnsTableFilterComposer f) f) {
    final $$ReturnsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.returns,
        getReferencedColumn: (t) => t.transactionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReturnsTableFilterComposer(
              $db: $db,
              $table: $db.returns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerName => $composableBuilder(
      column: $table.customerName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerPhone => $composableBuilder(
      column: $table.customerPhone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get discount => $composableBuilder(
      column: $table.discount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paymentAmount => $composableBuilder(
      column: $table.paymentAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get changeAmount => $composableBuilder(
      column: $table.changeAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalProfit => $composableBuilder(
      column: $table.totalProfit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$StoresTableOrderingComposer get storeId {
    final $$StoresTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableOrderingComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => column);

  GeneratedColumn<String> get customerPhone => $composableBuilder(
      column: $table.customerPhone, builder: (column) => column);

  GeneratedColumn<int> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<int> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<int> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => column);

  GeneratedColumn<int> get paymentAmount => $composableBuilder(
      column: $table.paymentAmount, builder: (column) => column);

  GeneratedColumn<int> get changeAmount => $composableBuilder(
      column: $table.changeAmount, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<int> get totalProfit => $composableBuilder(
      column: $table.totalProfit, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StoresTableAnnotationComposer get storeId {
    final $$StoresTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableAnnotationComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> transactionItemsRefs<T extends Object>(
      Expression<T> Function($$TransactionItemsTableAnnotationComposer a) f) {
    final $$TransactionItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionItems,
        getReferencedColumn: (t) => t.transactionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactionItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> returnsRefs<T extends Object>(
      Expression<T> Function($$ReturnsTableAnnotationComposer a) f) {
    final $$ReturnsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.returns,
        getReferencedColumn: (t) => t.transactionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReturnsTableAnnotationComposer(
              $db: $db,
              $table: $db.returns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionsTable,
    TransactionData,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (TransactionData, $$TransactionsTableReferences),
    TransactionData,
    PrefetchHooks Function(
        {bool storeId,
        bool userId,
        bool transactionItemsRefs,
        bool returnsRefs})> {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> storeId = const Value.absent(),
            Value<String> invoiceNumber = const Value.absent(),
            Value<String?> customerName = const Value.absent(),
            Value<String?> customerPhone = const Value.absent(),
            Value<int> subtotal = const Value.absent(),
            Value<int> discount = const Value.absent(),
            Value<int> totalAmount = const Value.absent(),
            Value<int> paymentAmount = const Value.absent(),
            Value<int> changeAmount = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<int> totalProfit = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TransactionsCompanion(
            id: id,
            storeId: storeId,
            invoiceNumber: invoiceNumber,
            customerName: customerName,
            customerPhone: customerPhone,
            subtotal: subtotal,
            discount: discount,
            totalAmount: totalAmount,
            paymentAmount: paymentAmount,
            changeAmount: changeAmount,
            paymentMethod: paymentMethod,
            totalProfit: totalProfit,
            userId: userId,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> storeId = const Value.absent(),
            required String invoiceNumber,
            Value<String?> customerName = const Value.absent(),
            Value<String?> customerPhone = const Value.absent(),
            required int subtotal,
            Value<int> discount = const Value.absent(),
            required int totalAmount,
            required int paymentAmount,
            Value<int> changeAmount = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<int> totalProfit = const Value.absent(),
            required int userId,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TransactionsCompanion.insert(
            id: id,
            storeId: storeId,
            invoiceNumber: invoiceNumber,
            customerName: customerName,
            customerPhone: customerPhone,
            subtotal: subtotal,
            discount: discount,
            totalAmount: totalAmount,
            paymentAmount: paymentAmount,
            changeAmount: changeAmount,
            paymentMethod: paymentMethod,
            totalProfit: totalProfit,
            userId: userId,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TransactionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {storeId = false,
              userId = false,
              transactionItemsRefs = false,
              returnsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionItemsRefs) db.transactionItems,
                if (returnsRefs) db.returns
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (storeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.storeId,
                    referencedTable:
                        $$TransactionsTableReferences._storeIdTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._storeIdTable(db).id,
                  ) as T;
                }
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$TransactionsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionItemsRefs)
                    await $_getPrefetchedData<TransactionData,
                            $TransactionsTable, TransactionItemData>(
                        currentTable: table,
                        referencedTable: $$TransactionsTableReferences
                            ._transactionItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TransactionsTableReferences(db, table, p0)
                                .transactionItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.transactionId == item.id),
                        typedResults: items),
                  if (returnsRefs)
                    await $_getPrefetchedData<TransactionData,
                            $TransactionsTable, ReturnData>(
                        currentTable: table,
                        referencedTable:
                            $$TransactionsTableReferences._returnsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TransactionsTableReferences(db, table, p0)
                                .returnsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.transactionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TransactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionsTable,
    TransactionData,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (TransactionData, $$TransactionsTableReferences),
    TransactionData,
    PrefetchHooks Function(
        {bool storeId,
        bool userId,
        bool transactionItemsRefs,
        bool returnsRefs})>;
typedef $$TransactionItemsTableCreateCompanionBuilder
    = TransactionItemsCompanion Function({
  Value<int> id,
  required int transactionId,
  required String itemType,
  Value<int?> productId,
  Value<int?> serviceId,
  required String itemName,
  Value<int> costPrice,
  required int sellingPrice,
  Value<int> quantity,
  required int subtotalPrice,
  Value<int> subtotalProfit,
  Value<String> serviceStatus,
  Value<String?> notes,
});
typedef $$TransactionItemsTableUpdateCompanionBuilder
    = TransactionItemsCompanion Function({
  Value<int> id,
  Value<int> transactionId,
  Value<String> itemType,
  Value<int?> productId,
  Value<int?> serviceId,
  Value<String> itemName,
  Value<int> costPrice,
  Value<int> sellingPrice,
  Value<int> quantity,
  Value<int> subtotalPrice,
  Value<int> subtotalProfit,
  Value<String> serviceStatus,
  Value<String?> notes,
});

final class $$TransactionItemsTableReferences extends BaseReferences<
    _$AppDatabase, $TransactionItemsTable, TransactionItemData> {
  $$TransactionItemsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TransactionsTable _transactionIdTable(_$AppDatabase db) =>
      db.transactions
          .createAlias('transaction_items__transaction_id__transactions__id');

  $$TransactionsTableProcessedTableManager get transactionId {
    final $_column = $_itemColumn<int>('transaction_id')!;

    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('transaction_items__product_id__products__id');

  $$ProductsTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<int>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductsTableTableManager($_db, $_db.products)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ServicesTable _serviceIdTable(_$AppDatabase db) =>
      db.services.createAlias('transaction_items__service_id__services__id');

  $$ServicesTableProcessedTableManager? get serviceId {
    final $_column = $_itemColumn<int>('service_id');
    if ($_column == null) return null;
    final manager = $$ServicesTableTableManager($_db, $_db.services)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_serviceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TransactionItemsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionItemsTable> {
  $$TransactionItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemType => $composableBuilder(
      column: $table.itemType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemName => $composableBuilder(
      column: $table.itemName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get costPrice => $composableBuilder(
      column: $table.costPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sellingPrice => $composableBuilder(
      column: $table.sellingPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get subtotalPrice => $composableBuilder(
      column: $table.subtotalPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get subtotalProfit => $composableBuilder(
      column: $table.subtotalProfit,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceStatus => $composableBuilder(
      column: $table.serviceStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  $$TransactionsTableFilterComposer get transactionId {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ServicesTableFilterComposer get serviceId {
    final $$ServicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.serviceId,
        referencedTable: $db.services,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServicesTableFilterComposer(
              $db: $db,
              $table: $db.services,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionItemsTable> {
  $$TransactionItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemType => $composableBuilder(
      column: $table.itemType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemName => $composableBuilder(
      column: $table.itemName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get costPrice => $composableBuilder(
      column: $table.costPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sellingPrice => $composableBuilder(
      column: $table.sellingPrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get subtotalPrice => $composableBuilder(
      column: $table.subtotalPrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get subtotalProfit => $composableBuilder(
      column: $table.subtotalProfit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceStatus => $composableBuilder(
      column: $table.serviceStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  $$TransactionsTableOrderingComposer get transactionId {
    final $$TransactionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableOrderingComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableOrderingComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ServicesTableOrderingComposer get serviceId {
    final $$ServicesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.serviceId,
        referencedTable: $db.services,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServicesTableOrderingComposer(
              $db: $db,
              $table: $db.services,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionItemsTable> {
  $$TransactionItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<String> get itemName =>
      $composableBuilder(column: $table.itemName, builder: (column) => column);

  GeneratedColumn<int> get costPrice =>
      $composableBuilder(column: $table.costPrice, builder: (column) => column);

  GeneratedColumn<int> get sellingPrice => $composableBuilder(
      column: $table.sellingPrice, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get subtotalPrice => $composableBuilder(
      column: $table.subtotalPrice, builder: (column) => column);

  GeneratedColumn<int> get subtotalProfit => $composableBuilder(
      column: $table.subtotalProfit, builder: (column) => column);

  GeneratedColumn<String> get serviceStatus => $composableBuilder(
      column: $table.serviceStatus, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$TransactionsTableAnnotationComposer get transactionId {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ServicesTableAnnotationComposer get serviceId {
    final $$ServicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.serviceId,
        referencedTable: $db.services,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServicesTableAnnotationComposer(
              $db: $db,
              $table: $db.services,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionItemsTable,
    TransactionItemData,
    $$TransactionItemsTableFilterComposer,
    $$TransactionItemsTableOrderingComposer,
    $$TransactionItemsTableAnnotationComposer,
    $$TransactionItemsTableCreateCompanionBuilder,
    $$TransactionItemsTableUpdateCompanionBuilder,
    (TransactionItemData, $$TransactionItemsTableReferences),
    TransactionItemData,
    PrefetchHooks Function(
        {bool transactionId, bool productId, bool serviceId})> {
  $$TransactionItemsTableTableManager(
      _$AppDatabase db, $TransactionItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> transactionId = const Value.absent(),
            Value<String> itemType = const Value.absent(),
            Value<int?> productId = const Value.absent(),
            Value<int?> serviceId = const Value.absent(),
            Value<String> itemName = const Value.absent(),
            Value<int> costPrice = const Value.absent(),
            Value<int> sellingPrice = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<int> subtotalPrice = const Value.absent(),
            Value<int> subtotalProfit = const Value.absent(),
            Value<String> serviceStatus = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              TransactionItemsCompanion(
            id: id,
            transactionId: transactionId,
            itemType: itemType,
            productId: productId,
            serviceId: serviceId,
            itemName: itemName,
            costPrice: costPrice,
            sellingPrice: sellingPrice,
            quantity: quantity,
            subtotalPrice: subtotalPrice,
            subtotalProfit: subtotalProfit,
            serviceStatus: serviceStatus,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int transactionId,
            required String itemType,
            Value<int?> productId = const Value.absent(),
            Value<int?> serviceId = const Value.absent(),
            required String itemName,
            Value<int> costPrice = const Value.absent(),
            required int sellingPrice,
            Value<int> quantity = const Value.absent(),
            required int subtotalPrice,
            Value<int> subtotalProfit = const Value.absent(),
            Value<String> serviceStatus = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              TransactionItemsCompanion.insert(
            id: id,
            transactionId: transactionId,
            itemType: itemType,
            productId: productId,
            serviceId: serviceId,
            itemName: itemName,
            costPrice: costPrice,
            sellingPrice: sellingPrice,
            quantity: quantity,
            subtotalPrice: subtotalPrice,
            subtotalProfit: subtotalProfit,
            serviceStatus: serviceStatus,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TransactionItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {transactionId = false, productId = false, serviceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (transactionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.transactionId,
                    referencedTable: $$TransactionItemsTableReferences
                        ._transactionIdTable(db),
                    referencedColumn: $$TransactionItemsTableReferences
                        ._transactionIdTable(db)
                        .id,
                  ) as T;
                }
                if (productId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productId,
                    referencedTable:
                        $$TransactionItemsTableReferences._productIdTable(db),
                    referencedColumn: $$TransactionItemsTableReferences
                        ._productIdTable(db)
                        .id,
                  ) as T;
                }
                if (serviceId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.serviceId,
                    referencedTable:
                        $$TransactionItemsTableReferences._serviceIdTable(db),
                    referencedColumn: $$TransactionItemsTableReferences
                        ._serviceIdTable(db)
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
        ));
}

typedef $$TransactionItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionItemsTable,
    TransactionItemData,
    $$TransactionItemsTableFilterComposer,
    $$TransactionItemsTableOrderingComposer,
    $$TransactionItemsTableAnnotationComposer,
    $$TransactionItemsTableCreateCompanionBuilder,
    $$TransactionItemsTableUpdateCompanionBuilder,
    (TransactionItemData, $$TransactionItemsTableReferences),
    TransactionItemData,
    PrefetchHooks Function(
        {bool transactionId, bool productId, bool serviceId})>;
typedef $$RestocksTableCreateCompanionBuilder = RestocksCompanion Function({
  Value<int> id,
  required int productId,
  required int quantityAdded,
  required int totalPurchaseCost,
  required int userId,
  Value<DateTime> restockDate,
  Value<String?> notes,
});
typedef $$RestocksTableUpdateCompanionBuilder = RestocksCompanion Function({
  Value<int> id,
  Value<int> productId,
  Value<int> quantityAdded,
  Value<int> totalPurchaseCost,
  Value<int> userId,
  Value<DateTime> restockDate,
  Value<String?> notes,
});

final class $$RestocksTableReferences
    extends BaseReferences<_$AppDatabase, $RestocksTable, RestockData> {
  $$RestocksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('restocks__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager($_db, $_db.products)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('restocks__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RestocksTableFilterComposer
    extends Composer<_$AppDatabase, $RestocksTable> {
  $$RestocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantityAdded => $composableBuilder(
      column: $table.quantityAdded, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalPurchaseCost => $composableBuilder(
      column: $table.totalPurchaseCost,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get restockDate => $composableBuilder(
      column: $table.restockDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RestocksTableOrderingComposer
    extends Composer<_$AppDatabase, $RestocksTable> {
  $$RestocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantityAdded => $composableBuilder(
      column: $table.quantityAdded,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalPurchaseCost => $composableBuilder(
      column: $table.totalPurchaseCost,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get restockDate => $composableBuilder(
      column: $table.restockDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableOrderingComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RestocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $RestocksTable> {
  $$RestocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantityAdded => $composableBuilder(
      column: $table.quantityAdded, builder: (column) => column);

  GeneratedColumn<int> get totalPurchaseCost => $composableBuilder(
      column: $table.totalPurchaseCost, builder: (column) => column);

  GeneratedColumn<DateTime> get restockDate => $composableBuilder(
      column: $table.restockDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RestocksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RestocksTable,
    RestockData,
    $$RestocksTableFilterComposer,
    $$RestocksTableOrderingComposer,
    $$RestocksTableAnnotationComposer,
    $$RestocksTableCreateCompanionBuilder,
    $$RestocksTableUpdateCompanionBuilder,
    (RestockData, $$RestocksTableReferences),
    RestockData,
    PrefetchHooks Function({bool productId, bool userId})> {
  $$RestocksTableTableManager(_$AppDatabase db, $RestocksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RestocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RestocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RestocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> productId = const Value.absent(),
            Value<int> quantityAdded = const Value.absent(),
            Value<int> totalPurchaseCost = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<DateTime> restockDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              RestocksCompanion(
            id: id,
            productId: productId,
            quantityAdded: quantityAdded,
            totalPurchaseCost: totalPurchaseCost,
            userId: userId,
            restockDate: restockDate,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int productId,
            required int quantityAdded,
            required int totalPurchaseCost,
            required int userId,
            Value<DateTime> restockDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              RestocksCompanion.insert(
            id: id,
            productId: productId,
            quantityAdded: quantityAdded,
            totalPurchaseCost: totalPurchaseCost,
            userId: userId,
            restockDate: restockDate,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$RestocksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({productId = false, userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (productId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productId,
                    referencedTable:
                        $$RestocksTableReferences._productIdTable(db),
                    referencedColumn:
                        $$RestocksTableReferences._productIdTable(db).id,
                  ) as T;
                }
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable: $$RestocksTableReferences._userIdTable(db),
                    referencedColumn:
                        $$RestocksTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RestocksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RestocksTable,
    RestockData,
    $$RestocksTableFilterComposer,
    $$RestocksTableOrderingComposer,
    $$RestocksTableAnnotationComposer,
    $$RestocksTableCreateCompanionBuilder,
    $$RestocksTableUpdateCompanionBuilder,
    (RestockData, $$RestocksTableReferences),
    RestockData,
    PrefetchHooks Function({bool productId, bool userId})>;
typedef $$ReturnsTableCreateCompanionBuilder = ReturnsCompanion Function({
  Value<int> id,
  required int transactionId,
  required String invoiceNumber,
  required int totalRefundAmount,
  required int totalItemReturned,
  Value<String?> reason,
  required int userId,
  Value<DateTime> returnDate,
});
typedef $$ReturnsTableUpdateCompanionBuilder = ReturnsCompanion Function({
  Value<int> id,
  Value<int> transactionId,
  Value<String> invoiceNumber,
  Value<int> totalRefundAmount,
  Value<int> totalItemReturned,
  Value<String?> reason,
  Value<int> userId,
  Value<DateTime> returnDate,
});

final class $$ReturnsTableReferences
    extends BaseReferences<_$AppDatabase, $ReturnsTable, ReturnData> {
  $$ReturnsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TransactionsTable _transactionIdTable(_$AppDatabase db) =>
      db.transactions.createAlias('returns__transaction_id__transactions__id');

  $$TransactionsTableProcessedTableManager get transactionId {
    final $_column = $_itemColumn<int>('transaction_id')!;

    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('returns__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ReturnsTableFilterComposer
    extends Composer<_$AppDatabase, $ReturnsTable> {
  $$ReturnsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalRefundAmount => $composableBuilder(
      column: $table.totalRefundAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalItemReturned => $composableBuilder(
      column: $table.totalItemReturned,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get returnDate => $composableBuilder(
      column: $table.returnDate, builder: (column) => ColumnFilters(column));

  $$TransactionsTableFilterComposer get transactionId {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReturnsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReturnsTable> {
  $$ReturnsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalRefundAmount => $composableBuilder(
      column: $table.totalRefundAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalItemReturned => $composableBuilder(
      column: $table.totalItemReturned,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get returnDate => $composableBuilder(
      column: $table.returnDate, builder: (column) => ColumnOrderings(column));

  $$TransactionsTableOrderingComposer get transactionId {
    final $$TransactionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableOrderingComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReturnsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReturnsTable> {
  $$ReturnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber, builder: (column) => column);

  GeneratedColumn<int> get totalRefundAmount => $composableBuilder(
      column: $table.totalRefundAmount, builder: (column) => column);

  GeneratedColumn<int> get totalItemReturned => $composableBuilder(
      column: $table.totalItemReturned, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get returnDate => $composableBuilder(
      column: $table.returnDate, builder: (column) => column);

  $$TransactionsTableAnnotationComposer get transactionId {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReturnsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReturnsTable,
    ReturnData,
    $$ReturnsTableFilterComposer,
    $$ReturnsTableOrderingComposer,
    $$ReturnsTableAnnotationComposer,
    $$ReturnsTableCreateCompanionBuilder,
    $$ReturnsTableUpdateCompanionBuilder,
    (ReturnData, $$ReturnsTableReferences),
    ReturnData,
    PrefetchHooks Function({bool transactionId, bool userId})> {
  $$ReturnsTableTableManager(_$AppDatabase db, $ReturnsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReturnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReturnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReturnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> transactionId = const Value.absent(),
            Value<String> invoiceNumber = const Value.absent(),
            Value<int> totalRefundAmount = const Value.absent(),
            Value<int> totalItemReturned = const Value.absent(),
            Value<String?> reason = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<DateTime> returnDate = const Value.absent(),
          }) =>
              ReturnsCompanion(
            id: id,
            transactionId: transactionId,
            invoiceNumber: invoiceNumber,
            totalRefundAmount: totalRefundAmount,
            totalItemReturned: totalItemReturned,
            reason: reason,
            userId: userId,
            returnDate: returnDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int transactionId,
            required String invoiceNumber,
            required int totalRefundAmount,
            required int totalItemReturned,
            Value<String?> reason = const Value.absent(),
            required int userId,
            Value<DateTime> returnDate = const Value.absent(),
          }) =>
              ReturnsCompanion.insert(
            id: id,
            transactionId: transactionId,
            invoiceNumber: invoiceNumber,
            totalRefundAmount: totalRefundAmount,
            totalItemReturned: totalItemReturned,
            reason: reason,
            userId: userId,
            returnDate: returnDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ReturnsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({transactionId = false, userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (transactionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.transactionId,
                    referencedTable:
                        $$ReturnsTableReferences._transactionIdTable(db),
                    referencedColumn:
                        $$ReturnsTableReferences._transactionIdTable(db).id,
                  ) as T;
                }
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable: $$ReturnsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$ReturnsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ReturnsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReturnsTable,
    ReturnData,
    $$ReturnsTableFilterComposer,
    $$ReturnsTableOrderingComposer,
    $$ReturnsTableAnnotationComposer,
    $$ReturnsTableCreateCompanionBuilder,
    $$ReturnsTableUpdateCompanionBuilder,
    (ReturnData, $$ReturnsTableReferences),
    ReturnData,
    PrefetchHooks Function({bool transactionId, bool userId})>;
typedef $$BalanceLogsTableCreateCompanionBuilder = BalanceLogsCompanion
    Function({
  Value<int> id,
  Value<int?> storeId,
  required int amount,
  required String flowType,
  required String category,
  Value<String> paymentType,
  Value<String?> notes,
  required int userId,
  Value<DateTime> createdAt,
});
typedef $$BalanceLogsTableUpdateCompanionBuilder = BalanceLogsCompanion
    Function({
  Value<int> id,
  Value<int?> storeId,
  Value<int> amount,
  Value<String> flowType,
  Value<String> category,
  Value<String> paymentType,
  Value<String?> notes,
  Value<int> userId,
  Value<DateTime> createdAt,
});

final class $$BalanceLogsTableReferences
    extends BaseReferences<_$AppDatabase, $BalanceLogsTable, BalanceLogData> {
  $$BalanceLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StoresTable _storeIdTable(_$AppDatabase db) =>
      db.stores.createAlias('balance_logs__store_id__stores__id');

  $$StoresTableProcessedTableManager? get storeId {
    final $_column = $_itemColumn<int>('store_id');
    if ($_column == null) return null;
    final manager = $$StoresTableTableManager($_db, $_db.stores)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_storeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('balance_logs__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BalanceLogsTableFilterComposer
    extends Composer<_$AppDatabase, $BalanceLogsTable> {
  $$BalanceLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get flowType => $composableBuilder(
      column: $table.flowType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$StoresTableFilterComposer get storeId {
    final $$StoresTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableFilterComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BalanceLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $BalanceLogsTable> {
  $$BalanceLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get flowType => $composableBuilder(
      column: $table.flowType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$StoresTableOrderingComposer get storeId {
    final $$StoresTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableOrderingComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BalanceLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BalanceLogsTable> {
  $$BalanceLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get flowType =>
      $composableBuilder(column: $table.flowType, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StoresTableAnnotationComposer get storeId {
    final $$StoresTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableAnnotationComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BalanceLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BalanceLogsTable,
    BalanceLogData,
    $$BalanceLogsTableFilterComposer,
    $$BalanceLogsTableOrderingComposer,
    $$BalanceLogsTableAnnotationComposer,
    $$BalanceLogsTableCreateCompanionBuilder,
    $$BalanceLogsTableUpdateCompanionBuilder,
    (BalanceLogData, $$BalanceLogsTableReferences),
    BalanceLogData,
    PrefetchHooks Function({bool storeId, bool userId})> {
  $$BalanceLogsTableTableManager(_$AppDatabase db, $BalanceLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BalanceLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BalanceLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BalanceLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> storeId = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String> flowType = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> paymentType = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BalanceLogsCompanion(
            id: id,
            storeId: storeId,
            amount: amount,
            flowType: flowType,
            category: category,
            paymentType: paymentType,
            notes: notes,
            userId: userId,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> storeId = const Value.absent(),
            required int amount,
            required String flowType,
            required String category,
            Value<String> paymentType = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required int userId,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BalanceLogsCompanion.insert(
            id: id,
            storeId: storeId,
            amount: amount,
            flowType: flowType,
            category: category,
            paymentType: paymentType,
            notes: notes,
            userId: userId,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BalanceLogsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({storeId = false, userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (storeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.storeId,
                    referencedTable:
                        $$BalanceLogsTableReferences._storeIdTable(db),
                    referencedColumn:
                        $$BalanceLogsTableReferences._storeIdTable(db).id,
                  ) as T;
                }
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$BalanceLogsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$BalanceLogsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BalanceLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BalanceLogsTable,
    BalanceLogData,
    $$BalanceLogsTableFilterComposer,
    $$BalanceLogsTableOrderingComposer,
    $$BalanceLogsTableAnnotationComposer,
    $$BalanceLogsTableCreateCompanionBuilder,
    $$BalanceLogsTableUpdateCompanionBuilder,
    (BalanceLogData, $$BalanceLogsTableReferences),
    BalanceLogData,
    PrefetchHooks Function({bool storeId, bool userId})>;
typedef $$MonthlyAccountingTableCreateCompanionBuilder
    = MonthlyAccountingCompanion Function({
  Value<int> id,
  Value<int?> storeId,
  required String periodMonthYear,
  Value<int> initialCash,
  Value<int> initialDigital,
  Value<int> initialStockValue,
  Value<int> incomeGoods,
  Value<int> incomeServices,
  Value<int> totalExpense,
  Value<int> netProfit,
  Value<int> finalCash,
  Value<int> finalDigital,
  Value<int> finalStockValue,
  Value<String> status,
  Value<int?> closedByUserId,
  Value<DateTime?> closedAt,
});
typedef $$MonthlyAccountingTableUpdateCompanionBuilder
    = MonthlyAccountingCompanion Function({
  Value<int> id,
  Value<int?> storeId,
  Value<String> periodMonthYear,
  Value<int> initialCash,
  Value<int> initialDigital,
  Value<int> initialStockValue,
  Value<int> incomeGoods,
  Value<int> incomeServices,
  Value<int> totalExpense,
  Value<int> netProfit,
  Value<int> finalCash,
  Value<int> finalDigital,
  Value<int> finalStockValue,
  Value<String> status,
  Value<int?> closedByUserId,
  Value<DateTime?> closedAt,
});

final class $$MonthlyAccountingTableReferences extends BaseReferences<
    _$AppDatabase, $MonthlyAccountingTable, MonthlyAccountingData> {
  $$MonthlyAccountingTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StoresTable _storeIdTable(_$AppDatabase db) =>
      db.stores.createAlias('monthly_accounting__store_id__stores__id');

  $$StoresTableProcessedTableManager? get storeId {
    final $_column = $_itemColumn<int>('store_id');
    if ($_column == null) return null;
    final manager = $$StoresTableTableManager($_db, $_db.stores)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_storeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _closedByUserIdTable(_$AppDatabase db) =>
      db.users.createAlias('monthly_accounting__closed_by_user_id__users__id');

  $$UsersTableProcessedTableManager? get closedByUserId {
    final $_column = $_itemColumn<int>('closed_by_user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_closedByUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MonthlyAccountingTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyAccountingTable> {
  $$MonthlyAccountingTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get periodMonthYear => $composableBuilder(
      column: $table.periodMonthYear,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get initialCash => $composableBuilder(
      column: $table.initialCash, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get initialDigital => $composableBuilder(
      column: $table.initialDigital,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get initialStockValue => $composableBuilder(
      column: $table.initialStockValue,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get incomeGoods => $composableBuilder(
      column: $table.incomeGoods, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get incomeServices => $composableBuilder(
      column: $table.incomeServices,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalExpense => $composableBuilder(
      column: $table.totalExpense, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get netProfit => $composableBuilder(
      column: $table.netProfit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get finalCash => $composableBuilder(
      column: $table.finalCash, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get finalDigital => $composableBuilder(
      column: $table.finalDigital, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get finalStockValue => $composableBuilder(
      column: $table.finalStockValue,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnFilters(column));

  $$StoresTableFilterComposer get storeId {
    final $$StoresTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableFilterComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get closedByUserId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.closedByUserId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MonthlyAccountingTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyAccountingTable> {
  $$MonthlyAccountingTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get periodMonthYear => $composableBuilder(
      column: $table.periodMonthYear,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get initialCash => $composableBuilder(
      column: $table.initialCash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get initialDigital => $composableBuilder(
      column: $table.initialDigital,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get initialStockValue => $composableBuilder(
      column: $table.initialStockValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get incomeGoods => $composableBuilder(
      column: $table.incomeGoods, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get incomeServices => $composableBuilder(
      column: $table.incomeServices,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalExpense => $composableBuilder(
      column: $table.totalExpense,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get netProfit => $composableBuilder(
      column: $table.netProfit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get finalCash => $composableBuilder(
      column: $table.finalCash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get finalDigital => $composableBuilder(
      column: $table.finalDigital,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get finalStockValue => $composableBuilder(
      column: $table.finalStockValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnOrderings(column));

  $$StoresTableOrderingComposer get storeId {
    final $$StoresTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableOrderingComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get closedByUserId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.closedByUserId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MonthlyAccountingTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyAccountingTable> {
  $$MonthlyAccountingTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get periodMonthYear => $composableBuilder(
      column: $table.periodMonthYear, builder: (column) => column);

  GeneratedColumn<int> get initialCash => $composableBuilder(
      column: $table.initialCash, builder: (column) => column);

  GeneratedColumn<int> get initialDigital => $composableBuilder(
      column: $table.initialDigital, builder: (column) => column);

  GeneratedColumn<int> get initialStockValue => $composableBuilder(
      column: $table.initialStockValue, builder: (column) => column);

  GeneratedColumn<int> get incomeGoods => $composableBuilder(
      column: $table.incomeGoods, builder: (column) => column);

  GeneratedColumn<int> get incomeServices => $composableBuilder(
      column: $table.incomeServices, builder: (column) => column);

  GeneratedColumn<int> get totalExpense => $composableBuilder(
      column: $table.totalExpense, builder: (column) => column);

  GeneratedColumn<int> get netProfit =>
      $composableBuilder(column: $table.netProfit, builder: (column) => column);

  GeneratedColumn<int> get finalCash =>
      $composableBuilder(column: $table.finalCash, builder: (column) => column);

  GeneratedColumn<int> get finalDigital => $composableBuilder(
      column: $table.finalDigital, builder: (column) => column);

  GeneratedColumn<int> get finalStockValue => $composableBuilder(
      column: $table.finalStockValue, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  $$StoresTableAnnotationComposer get storeId {
    final $$StoresTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storeId,
        referencedTable: $db.stores,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoresTableAnnotationComposer(
              $db: $db,
              $table: $db.stores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get closedByUserId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.closedByUserId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MonthlyAccountingTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MonthlyAccountingTable,
    MonthlyAccountingData,
    $$MonthlyAccountingTableFilterComposer,
    $$MonthlyAccountingTableOrderingComposer,
    $$MonthlyAccountingTableAnnotationComposer,
    $$MonthlyAccountingTableCreateCompanionBuilder,
    $$MonthlyAccountingTableUpdateCompanionBuilder,
    (MonthlyAccountingData, $$MonthlyAccountingTableReferences),
    MonthlyAccountingData,
    PrefetchHooks Function({bool storeId, bool closedByUserId})> {
  $$MonthlyAccountingTableTableManager(
      _$AppDatabase db, $MonthlyAccountingTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyAccountingTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyAccountingTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyAccountingTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> storeId = const Value.absent(),
            Value<String> periodMonthYear = const Value.absent(),
            Value<int> initialCash = const Value.absent(),
            Value<int> initialDigital = const Value.absent(),
            Value<int> initialStockValue = const Value.absent(),
            Value<int> incomeGoods = const Value.absent(),
            Value<int> incomeServices = const Value.absent(),
            Value<int> totalExpense = const Value.absent(),
            Value<int> netProfit = const Value.absent(),
            Value<int> finalCash = const Value.absent(),
            Value<int> finalDigital = const Value.absent(),
            Value<int> finalStockValue = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> closedByUserId = const Value.absent(),
            Value<DateTime?> closedAt = const Value.absent(),
          }) =>
              MonthlyAccountingCompanion(
            id: id,
            storeId: storeId,
            periodMonthYear: periodMonthYear,
            initialCash: initialCash,
            initialDigital: initialDigital,
            initialStockValue: initialStockValue,
            incomeGoods: incomeGoods,
            incomeServices: incomeServices,
            totalExpense: totalExpense,
            netProfit: netProfit,
            finalCash: finalCash,
            finalDigital: finalDigital,
            finalStockValue: finalStockValue,
            status: status,
            closedByUserId: closedByUserId,
            closedAt: closedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> storeId = const Value.absent(),
            required String periodMonthYear,
            Value<int> initialCash = const Value.absent(),
            Value<int> initialDigital = const Value.absent(),
            Value<int> initialStockValue = const Value.absent(),
            Value<int> incomeGoods = const Value.absent(),
            Value<int> incomeServices = const Value.absent(),
            Value<int> totalExpense = const Value.absent(),
            Value<int> netProfit = const Value.absent(),
            Value<int> finalCash = const Value.absent(),
            Value<int> finalDigital = const Value.absent(),
            Value<int> finalStockValue = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> closedByUserId = const Value.absent(),
            Value<DateTime?> closedAt = const Value.absent(),
          }) =>
              MonthlyAccountingCompanion.insert(
            id: id,
            storeId: storeId,
            periodMonthYear: periodMonthYear,
            initialCash: initialCash,
            initialDigital: initialDigital,
            initialStockValue: initialStockValue,
            incomeGoods: incomeGoods,
            incomeServices: incomeServices,
            totalExpense: totalExpense,
            netProfit: netProfit,
            finalCash: finalCash,
            finalDigital: finalDigital,
            finalStockValue: finalStockValue,
            status: status,
            closedByUserId: closedByUserId,
            closedAt: closedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MonthlyAccountingTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({storeId = false, closedByUserId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (storeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.storeId,
                    referencedTable:
                        $$MonthlyAccountingTableReferences._storeIdTable(db),
                    referencedColumn:
                        $$MonthlyAccountingTableReferences._storeIdTable(db).id,
                  ) as T;
                }
                if (closedByUserId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.closedByUserId,
                    referencedTable: $$MonthlyAccountingTableReferences
                        ._closedByUserIdTable(db),
                    referencedColumn: $$MonthlyAccountingTableReferences
                        ._closedByUserIdTable(db)
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
        ));
}

typedef $$MonthlyAccountingTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MonthlyAccountingTable,
    MonthlyAccountingData,
    $$MonthlyAccountingTableFilterComposer,
    $$MonthlyAccountingTableOrderingComposer,
    $$MonthlyAccountingTableAnnotationComposer,
    $$MonthlyAccountingTableCreateCompanionBuilder,
    $$MonthlyAccountingTableUpdateCompanionBuilder,
    (MonthlyAccountingData, $$MonthlyAccountingTableReferences),
    MonthlyAccountingData,
    PrefetchHooks Function({bool storeId, bool closedByUserId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StoreProfilesTableTableManager get storeProfiles =>
      $$StoreProfilesTableTableManager(_db, _db.storeProfiles);
  $$StoresTableTableManager get stores =>
      $$StoresTableTableManager(_db, _db.stores);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$ServicesTableTableManager get services =>
      $$ServicesTableTableManager(_db, _db.services);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$TransactionItemsTableTableManager get transactionItems =>
      $$TransactionItemsTableTableManager(_db, _db.transactionItems);
  $$RestocksTableTableManager get restocks =>
      $$RestocksTableTableManager(_db, _db.restocks);
  $$ReturnsTableTableManager get returns =>
      $$ReturnsTableTableManager(_db, _db.returns);
  $$BalanceLogsTableTableManager get balanceLogs =>
      $$BalanceLogsTableTableManager(_db, _db.balanceLogs);
  $$MonthlyAccountingTableTableManager get monthlyAccounting =>
      $$MonthlyAccountingTableTableManager(_db, _db.monthlyAccounting);
}
