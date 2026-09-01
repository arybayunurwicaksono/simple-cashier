import 'package:drift/drift.dart';

@DataClassName('UserData')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().unique()();
  TextColumn get email => text().unique()();
  TextColumn get passwordHash => text()();
  TextColumn get salt => text()();
  TextColumn get fullname => text()();
  TextColumn get role => text().withDefault(const Constant('cashier'))(); // 'owner' | 'cashier'
  TextColumn get photoPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
