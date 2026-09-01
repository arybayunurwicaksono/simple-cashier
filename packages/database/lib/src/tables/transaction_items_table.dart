import 'package:drift/drift.dart';
import 'transactions_table.dart';
import 'products_table.dart';
import 'services_table.dart';

@DataClassName('TransactionItemData')
class TransactionItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get transactionId => integer().references(Transactions, #id, onDelete: KeyAction.cascade)();
  TextColumn get itemType => text()(); // 'product' | 'service'
  IntColumn get productId => integer().nullable().references(Products, #id)();
  IntColumn get serviceId => integer().nullable().references(Services, #id)();
  TextColumn get itemName => text()();
  IntColumn get costPrice => integer().withDefault(const Constant(0))();
  IntColumn get sellingPrice => integer()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  IntColumn get subtotalPrice => integer()();
  IntColumn get subtotalProfit => integer().withDefault(const Constant(0))();
  TextColumn get serviceStatus => text().withDefault(const Constant('none'))(); // 'none' | 'queued' | 'in_progress' | 'completed' | 'picked_up'
  TextColumn get notes => text().nullable()();
}
