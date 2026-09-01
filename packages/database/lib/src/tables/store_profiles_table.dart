import 'package:drift/drift.dart';

@DataClassName('StoreProfileData')
class StoreProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get storeName => text().withDefault(const Constant('Simple Cashier Store'))();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get address => text().withDefault(const Constant(''))();
  TextColumn get headerMessage => text().withDefault(const Constant('Terima kasih atas kunjungan Anda'))();
  TextColumn get footerMessage => text().withDefault(const Constant('Barang yang sudah dibeli tidak dapat ditukar'))();
  TextColumn get logoPath => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
