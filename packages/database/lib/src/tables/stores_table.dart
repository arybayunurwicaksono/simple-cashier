import 'package:drift/drift.dart';

@DataClassName('StoreData')
class Stores extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get storeName => text()();
  TextColumn get ownerName => text().withDefault(const Constant(''))();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get address => text().withDefault(const Constant(''))();
  TextColumn get headerMessage => text().withDefault(const Constant('Terima kasih atas kunjungan Anda'))();
  TextColumn get footerMessage => text().withDefault(const Constant('Barang yang sudah dibeli tidak dapat ditukar'))();
  TextColumn get logoPath => text().nullable()();
  TextColumn get pinHash => text()();
  TextColumn get pinSalt => text()();
  TextColumn get securityQuestion => text()();
  TextColumn get securityAnswerHash => text()();
  TextColumn get securityAnswerSalt => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
