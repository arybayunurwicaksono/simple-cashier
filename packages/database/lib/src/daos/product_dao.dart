import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/products_table.dart';
import '../tables/restocks_table.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [Products, Restocks])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  Future<List<ProductData>> getAllProducts() =>
      (select(products)..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).get();

  Stream<List<ProductData>> watchAllProducts() =>
      (select(products)..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).watch();

  Future<ProductData?> getProductById(int id) =>
      (select(products)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<List<ProductData>> searchProducts(String query) {
    return (select(products)
          ..where((tbl) =>
              tbl.name.like('%$query%') |
              tbl.sku.like('%$query%')))
        .get();
  }

  Stream<List<ProductData>> watchLowStockProducts() {
    return (select(products)
          ..where((tbl) => tbl.stock.isSmallerOrEqual(tbl.minStockAlert))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.stock)]))
        .watch();
  }

  Future<int> insertProduct(ProductsCompanion product) =>
      into(products).insert(product);

  Future<bool> updateProduct(ProductData product) =>
      update(products).replace(product);

  Future<int> deleteProduct(int id) =>
      (delete(products)..where((tbl) => tbl.id.equals(id))).go();

  /// Adds stock and logs restock entry atomically
  Future<void> restockProduct({
    required int productId,
    required int quantityAdded,
    required int totalPurchaseCost,
    required int userId,
    String? notes,
  }) {
    return transaction(() async {
      final product = await getProductById(productId);
      if (product == null) return;

      final updatedStock = product.stock + quantityAdded;
      await (update(products)..where((tbl) => tbl.id.equals(productId))).write(
        ProductsCompanion(
          stock: Value(updatedStock),
          costPrice: Value(totalPurchaseCost ~/ quantityAdded),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await into(restocks).insert(
        RestocksCompanion(
          productId: Value(productId),
          quantityAdded: Value(quantityAdded),
          totalPurchaseCost: Value(totalPurchaseCost),
          userId: Value(userId),
          notes: Value(notes),
        ),
      );
    });
  }

  Future<int> getTotalStockWorth() async {
    final allProducts = await select(products).get();
    return allProducts.fold<int>(0, (int sum, ProductData p) => sum + (p.costPrice * p.stock));
  }

  Future<int> getTotalStockCount() async {
    final allProducts = await select(products).get();
    return allProducts.fold<int>(0, (int sum, ProductData p) => sum + p.stock);
  }
}
