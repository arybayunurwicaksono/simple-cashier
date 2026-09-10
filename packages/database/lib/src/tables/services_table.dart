import 'package:drift/drift.dart';
import 'categories_table.dart';
import 'stores_table.dart';

@DataClassName('ServiceData')
class Services extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer().nullable().references(Stores, #id)();
  TextColumn get serviceName => text()();
  IntColumn get categoryId => integer().nullable().references(Categories, #id)();
  IntColumn get materialCost => integer().withDefault(const Constant(0))(); // Biaya Bahan / Modal
  IntColumn get finalPrice => integer()(); // Tarif Jual
  IntColumn get durationValue => integer().withDefault(const Constant(1))();
  TextColumn get durationUnit => text().withDefault(const Constant('days'))(); // 'minutes' | 'hours' | 'days'
  TextColumn get description => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
