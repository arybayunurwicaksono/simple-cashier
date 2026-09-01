// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_dao.dart';

// ignore_for_file: type=lint
mixin _$BackupDaoMixin on DatabaseAccessor<AppDatabase> {
  $StoreProfilesTable get storeProfiles => attachedDatabase.storeProfiles;
  $UsersTable get users => attachedDatabase.users;
  $CategoriesTable get categories => attachedDatabase.categories;
  $ProductsTable get products => attachedDatabase.products;
  $ServicesTable get services => attachedDatabase.services;
  $TransactionsTable get transactions => attachedDatabase.transactions;
  $TransactionItemsTable get transactionItems =>
      attachedDatabase.transactionItems;
  $RestocksTable get restocks => attachedDatabase.restocks;
  $ReturnsTable get returns => attachedDatabase.returns;
  $BalanceLogsTable get balanceLogs => attachedDatabase.balanceLogs;
  $MonthlyAccountingTable get monthlyAccounting =>
      attachedDatabase.monthlyAccounting;
  BackupDaoManager get managers => BackupDaoManager(this);
}

class BackupDaoManager {
  final _$BackupDaoMixin _db;
  BackupDaoManager(this._db);
  $$StoreProfilesTableTableManager get storeProfiles =>
      $$StoreProfilesTableTableManager(_db.attachedDatabase, _db.storeProfiles);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$ServicesTableTableManager get services =>
      $$ServicesTableTableManager(_db.attachedDatabase, _db.services);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db.attachedDatabase, _db.transactions);
  $$TransactionItemsTableTableManager get transactionItems =>
      $$TransactionItemsTableTableManager(
          _db.attachedDatabase, _db.transactionItems);
  $$RestocksTableTableManager get restocks =>
      $$RestocksTableTableManager(_db.attachedDatabase, _db.restocks);
  $$ReturnsTableTableManager get returns =>
      $$ReturnsTableTableManager(_db.attachedDatabase, _db.returns);
  $$BalanceLogsTableTableManager get balanceLogs =>
      $$BalanceLogsTableTableManager(_db.attachedDatabase, _db.balanceLogs);
  $$MonthlyAccountingTableTableManager get monthlyAccounting =>
      $$MonthlyAccountingTableTableManager(
          _db.attachedDatabase, _db.monthlyAccounting);
}
