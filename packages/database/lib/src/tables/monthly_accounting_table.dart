import 'package:drift/drift.dart';
import 'users_table.dart';
import 'stores_table.dart';

@DataClassName('MonthlyAccountingData')
class MonthlyAccounting extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer().nullable().references(Stores, #id)();
  TextColumn get periodMonthYear => text()(); // e.g. "Agustus 2026"
  IntColumn get initialCash => integer().withDefault(const Constant(0))();
  IntColumn get initialDigital => integer().withDefault(const Constant(0))();
  IntColumn get initialStockValue => integer().withDefault(const Constant(0))();
  IntColumn get incomeGoods => integer().withDefault(const Constant(0))();
  IntColumn get incomeServices => integer().withDefault(const Constant(0))();
  IntColumn get totalExpense => integer().withDefault(const Constant(0))();
  IntColumn get netProfit => integer().withDefault(const Constant(0))();
  IntColumn get finalCash => integer().withDefault(const Constant(0))();
  IntColumn get finalDigital => integer().withDefault(const Constant(0))();
  IntColumn get finalStockValue => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('on_progress'))(); // 'on_progress' | 'closed'
  IntColumn get closedByUserId => integer().nullable().references(Users, #id)();
  DateTimeColumn get closedAt => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {storeId, periodMonthYear},
      ];
}
