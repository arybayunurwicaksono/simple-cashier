// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_profile_dao.dart';

// ignore_for_file: type=lint
mixin _$StoreProfileDaoMixin on DatabaseAccessor<AppDatabase> {
  $StoreProfilesTable get storeProfiles => attachedDatabase.storeProfiles;
  StoreProfileDaoManager get managers => StoreProfileDaoManager(this);
}

class StoreProfileDaoManager {
  final _$StoreProfileDaoMixin _db;
  StoreProfileDaoManager(this._db);
  $$StoreProfilesTableTableManager get storeProfiles =>
      $$StoreProfilesTableTableManager(_db.attachedDatabase, _db.storeProfiles);
}
