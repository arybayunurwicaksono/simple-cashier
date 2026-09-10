// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_dao.dart';

// ignore_for_file: type=lint
mixin _$ServiceDaoMixin on DatabaseAccessor<AppDatabase> {
  $StoresTable get stores => attachedDatabase.stores;
  $CategoriesTable get categories => attachedDatabase.categories;
  $ServicesTable get services => attachedDatabase.services;
  ServiceDaoManager get managers => ServiceDaoManager(this);
}

class ServiceDaoManager {
  final _$ServiceDaoMixin _db;
  ServiceDaoManager(this._db);
  $$StoresTableTableManager get stores =>
      $$StoresTableTableManager(_db.attachedDatabase, _db.stores);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$ServicesTableTableManager get services =>
      $$ServicesTableTableManager(_db.attachedDatabase, _db.services);
}
