import 'package:drift/drift.dart';
import 'transactions_table.dart';
import 'users_table.dart';

@DataClassName('ReturnData')
class Returns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get transactionId => integer().references(Transactions, #id)();
  TextColumn get invoiceNumber => text()();
  IntColumn get totalRefundAmount => integer()();
  IntColumn get totalItemReturned => integer()();
  TextColumn get reason => text().nullable()();
  IntColumn get userId => integer().references(Users, #id)();
  DateTimeColumn get returnDate => dateTime().withDefault(currentDateAndTime)();
}
