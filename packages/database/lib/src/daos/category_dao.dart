import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/categories_table.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  CategoryDao(super.db);

  Future<List<CategoryData>> getAllCategories([String? type]) {
    if (type != null) {
      return (select(categories)..where((tbl) => tbl.type.equals(type))).get();
    }
    return select(categories).get();
  }

  Stream<List<CategoryData>> watchAllCategories([String? type]) {
    if (type != null) {
      return (select(categories)..where((tbl) => tbl.type.equals(type))).watch();
    }
    return select(categories).watch();
  }

  Future<int> insertCategory(CategoriesCompanion category) =>
      into(categories).insert(category);

  Future<bool> updateCategory(CategoryData category) =>
      update(categories).replace(category);

  Future<int> deleteCategory(int id) =>
      (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
}
