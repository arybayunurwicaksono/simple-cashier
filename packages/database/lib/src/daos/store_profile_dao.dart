import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/store_profiles_table.dart';

part 'store_profile_dao.g.dart';

@DriftAccessor(tables: [StoreProfiles])
class StoreProfileDao extends DatabaseAccessor<AppDatabase> with _$StoreProfileDaoMixin {
  StoreProfileDao(super.db);

  Future<StoreProfileData?> getStoreProfile() =>
      (select(storeProfiles)..limit(1)).getSingleOrNull();

  Stream<StoreProfileData?> watchStoreProfile() =>
      (select(storeProfiles)..limit(1)).watchSingleOrNull();

  Future<int> setStoreProfile(StoreProfilesCompanion profile) async {
    final existing = await getStoreProfile();
    if (existing != null) {
      return (update(storeProfiles)..where((tbl) => tbl.id.equals(existing.id)))
          .write(profile);
    } else {
      return into(storeProfiles).insert(profile);
    }
  }
}
