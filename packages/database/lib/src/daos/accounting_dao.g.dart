// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_dao.dart';

// ignore_for_file: type=lint
mixin _$AccountingDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $MonthlyAccountingTable get monthlyAccounting =>
      attachedDatabase.monthlyAccounting;
  $TransactionsTable get transactions => attachedDatabase.transactions;
  $CategoriesTable get categories => attachedDatabase.categories;
  $ProductsTable get products => attachedDatabase.products;
  $ServicesTable get services => attachedDatabase.services;
  $TransactionItemsTable get transactionItems =>
      attachedDatabase.transactionItems;
  $BalanceLogsTable get balanceLogs => attachedDatabase.balanceLogs;
  AccountingDaoManager get managers => AccountingDaoManager(this);
}

class AccountingDaoManager {
  final _$AccountingDaoMixin _db;
  AccountingDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$MonthlyAccountingTableTableManager get monthlyAccounting =>
      $$MonthlyAccountingTableTableManager(
          _db.attachedDatabase, _db.monthlyAccounting);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db.attachedDatabase, _db.transactions);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$ServicesTableTableManager get services =>
      $$ServicesTableTableManager(_db.attachedDatabase, _db.services);
  $$TransactionItemsTableTableManager get transactionItems =>
      $$TransactionItemsTableTableManager(
          _db.attachedDatabase, _db.transactionItems);
  $$BalanceLogsTableTableManager get balanceLogs =>
      $$BalanceLogsTableTableManager(_db.attachedDatabase, _db.balanceLogs);
}
