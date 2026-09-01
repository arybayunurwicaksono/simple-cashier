import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/services_table.dart';

part 'service_dao.g.dart';

@DriftAccessor(tables: [Services])
class ServiceDao extends DatabaseAccessor<AppDatabase> with _$ServiceDaoMixin {
  ServiceDao(super.db);

  Future<List<ServiceData>> getAllServices() =>
      (select(services)..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).get();

  Stream<List<ServiceData>> watchAllServices() =>
      (select(services)..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).watch();

  Future<ServiceData?> getServiceById(int id) =>
      (select(services)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<List<ServiceData>> searchServices(String query) {
    return (select(services)..where((tbl) => tbl.serviceName.like('%$query%'))).get();
  }

  Future<int> insertService(ServicesCompanion service) =>
      into(services).insert(service);

  Future<bool> updateService(ServiceData service) =>
      update(services).replace(service);

  Future<int> deleteService(int id) =>
      (delete(services)..where((tbl) => tbl.id.equals(id))).go();
}
