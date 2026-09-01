import 'package:drift/drift.dart';
import 'products_table.dart';
import 'users_table.dart';

@DataClassName('RestockData')
class Restocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get quantityAdded => integer()();
  IntColumn get totalPurchaseCost => integer()();
  IntColumn get userId => integer().references(Users, #id)();
  DateTimeColumn get restockDate => dateTime().withDefault(currentDateAndTime)();
  TextColumn get notes => text().nullable()();
}
