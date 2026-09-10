import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/stores_table.dart';

part 'store_dao.g.dart';

@DriftAccessor(tables: [Stores])
class StoreDao extends DatabaseAccessor<AppDatabase> with _$StoreDaoMixin {
  StoreDao(super.db);

  Future<List<StoreData>> getAllStores() => select(stores).get();

  Stream<List<StoreData>> watchAllStores() => select(stores).watch();

  Future<StoreData?> getStoreById(int id) =>
      (select(stores)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<int> countStores() async {
    final countExp = stores.id.count();
    final query = selectOnly(stores)..addColumns([countExp]);
    return await query.map((row) => row.read(countExp)).getSingle() ?? 0;
  }

  Future<int> insertStore(StoresCompanion store) => into(stores).insert(store);

  Future<bool> updateStore(StoreData store) => update(stores).replace(store);

  Future<int> updateStorePin({
    required int storeId,
    required String pinHash,
    required String pinSalt,
  }) {
    return (update(stores)..where((tbl) => tbl.id.equals(storeId))).write(
      StoresCompanion(
        pinHash: Value(pinHash),
        pinSalt: Value(pinSalt),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deleteStore(int id) =>
      (delete(stores)..where((tbl) => tbl.id.equals(id))).go();
}
