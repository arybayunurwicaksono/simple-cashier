import 'package:drift/drift.dart';
import 'users_table.dart';

@DataClassName('TransactionData')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get invoiceNumber => text().unique()();
  TextColumn get customerName => text().nullable()();
  TextColumn get customerPhone => text().nullable()();
  IntColumn get subtotal => integer()();
  IntColumn get discount => integer().withDefault(const Constant(0))();
  IntColumn get totalAmount => integer()();
  IntColumn get paymentAmount => integer()();
  IntColumn get changeAmount => integer().withDefault(const Constant(0))();
  TextColumn get paymentMethod => text().withDefault(const Constant('cash'))(); // 'cash' | 'digital'
  IntColumn get totalProfit => integer().withDefault(const Constant(0))();
  IntColumn get userId => integer().references(Users, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
