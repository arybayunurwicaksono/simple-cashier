import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/categories_table.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  CategoryDao(super.db);

  Future<List<CategoryData>> getAllCategories([String? type, int? storeId]) {
    final query = select(categories);
    if (type != null) {
      query.where((tbl) => tbl.type.equals(type));
    }
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return query.get();
  }

  Stream<List<CategoryData>> watchAllCategories([String? type, int? storeId]) {
    final query = select(categories);
    if (type != null) {
      query.where((tbl) => tbl.type.equals(type));
    }
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return query.watch();
  }

  Future<int> insertCategory(CategoriesCompanion category) =>
      into(categories).insert(category);

  Future<bool> updateCategory(CategoryData category) =>
      update(categories).replace(category);

  Future<int> deleteCategory(int id) =>
      (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
}
