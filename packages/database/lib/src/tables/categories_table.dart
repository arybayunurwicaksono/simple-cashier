import 'package:drift/drift.dart';
import 'stores_table.dart';

@DataClassName('CategoryData')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer().nullable().references(Stores, #id)();
  TextColumn get name => text()();
  TextColumn get type => text()(); // 'goods' | 'services'
  TextColumn get iconName => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
