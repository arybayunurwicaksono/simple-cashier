// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_dao.dart';

// ignore_for_file: type=lint
mixin _$BalanceDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $BalanceLogsTable get balanceLogs => attachedDatabase.balanceLogs;
  BalanceDaoManager get managers => BalanceDaoManager(this);
}

class BalanceDaoManager {
  final _$BalanceDaoMixin _db;
  BalanceDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$BalanceLogsTableTableManager get balanceLogs =>
      $$BalanceLogsTableTableManager(_db.attachedDatabase, _db.balanceLogs);
}
