import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/services_table.dart';

part 'service_dao.g.dart';

@DriftAccessor(tables: [Services])
class ServiceDao extends DatabaseAccessor<AppDatabase> with _$ServiceDaoMixin {
  ServiceDao(super.db);

  Future<List<ServiceData>> getAllServices({int? storeId}) {
    final query = select(services);
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).get();
  }

  Stream<List<ServiceData>> watchAllServices({int? storeId}) {
    final query = select(services);
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).watch();
  }

  Future<ServiceData?> getServiceById(int id) =>
      (select(services)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<List<ServiceData>> searchServices(String query, {int? storeId}) {
    final q = select(services)..where((tbl) => tbl.serviceName.like('%$query%'));
    if (storeId != null) {
      q.where((tbl) => tbl.storeId.equals(storeId));
    }
    return q.get();
  }

  Future<int> insertService(ServicesCompanion service) =>
      into(services).insert(service);

  Future<bool> updateService(ServiceData service) =>
      update(services).replace(service);

  Future<int> deleteService(int id) =>
      (delete(services)..where((tbl) => tbl.id.equals(id))).go();
}
