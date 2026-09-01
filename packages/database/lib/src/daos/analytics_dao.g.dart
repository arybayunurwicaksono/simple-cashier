// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_dao.dart';

// ignore_for_file: type=lint
mixin _$AnalyticsDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $TransactionsTable get transactions => attachedDatabase.transactions;
  $CategoriesTable get categories => attachedDatabase.categories;
  $ProductsTable get products => attachedDatabase.products;
  $ServicesTable get services => attachedDatabase.services;
  $TransactionItemsTable get transactionItems =>
      attachedDatabase.transactionItems;
  $BalanceLogsTable get balanceLogs => attachedDatabase.balanceLogs;
  $RestocksTable get restocks => attachedDatabase.restocks;
  AnalyticsDaoManager get managers => AnalyticsDaoManager(this);
}

class AnalyticsDaoManager {
  final _$AnalyticsDaoMixin _db;
  AnalyticsDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
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
  $$RestocksTableTableManager get restocks =>
      $$RestocksTableTableManager(_db.attachedDatabase, _db.restocks);
}
