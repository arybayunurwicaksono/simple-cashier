import 'package:drift/drift.dart';
import 'users_table.dart';

@DataClassName('BalanceLogData')
class BalanceLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amount => integer()();
  TextColumn get flowType => text()(); // 'in' | 'out'
  TextColumn get category => text()(); // 'capital' | 'operational' | 'withdrawal' | 'other'
  TextColumn get paymentType => text().withDefault(const Constant('cash'))(); // 'cash' | 'digital'
  TextColumn get notes => text().nullable()();
  IntColumn get userId => integer().references(Users, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
