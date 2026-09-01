import 'package:drift/drift.dart';
import 'categories_table.dart';

@DataClassName('ProductData')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sku => text().nullable()();
  TextColumn get name => text()();
  IntColumn get categoryId => integer().nullable().references(Categories, #id)();
  TextColumn get unit => text().withDefault(const Constant('pcs'))();
  IntColumn get costPrice => integer().withDefault(const Constant(0))(); // Harga Modal / Beli
  IntColumn get sellingPrice => integer()(); // Harga Jual
  IntColumn get stock => integer().withDefault(const Constant(0))();
  IntColumn get minStockAlert => integer().withDefault(const Constant(5))();
  TextColumn get photoPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
