import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/transactions_table.dart';
import '../tables/transaction_items_table.dart';
import '../tables/products_table.dart';
import '../tables/returns_table.dart';
import '../tables/users_table.dart';
import '../models/transaction_with_items.dart';

part 'transaction_dao.g.dart';

@DriftAccessor(tables: [Transactions, TransactionItems, Products, Returns, Users])
class TransactionDao extends DatabaseAccessor<AppDatabase> with _$TransactionDaoMixin {
  TransactionDao(super.db);

  Stream<List<TransactionData>> watchAllTransactions({int? storeId}) {
    final query = select(transactions);
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).watch();
  }

  Future<List<TransactionData>> getAllTransactions({int? storeId}) {
    final query = select(transactions);
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).get();
  }

  Future<TransactionWithItems?> getTransactionWithItems(int transactionId) async {
    final transactionRow = await (select(transactions)
          ..where((tbl) => tbl.id.equals(transactionId)))
        .getSingleOrNull();
    if (transactionRow == null) return null;

    final itemRows = await (select(transactionItems)
          ..where((tbl) => tbl.transactionId.equals(transactionId)))
        .get();

    final userRow = await (select(users)
          ..where((tbl) => tbl.id.equals(transactionRow.userId)))
        .getSingleOrNull();

    return TransactionWithItems(
      transaction: transactionRow,
      items: itemRows,
      user: userRow,
    );
  }

  /// Atomic Checkout: Creates transaction record, inserts all items, decrements stock for products
  Future<TransactionWithItems> processCheckout({
    required TransactionsCompanion transactionCompanion,
    required List<TransactionItemsCompanion> items,
  }) {
    return transaction(() async {
      final transactionId = await into(transactions).insert(transactionCompanion);

      final insertedItems = <TransactionItemData>[];
      for (final item in items) {
        final itemWithTxId = item.copyWith(transactionId: Value(transactionId));
        final itemId = await into(transactionItems).insert(itemWithTxId);

        // If item is a physical product, decrement local stock atomically
        if (item.itemType.value == 'product' && item.productId.value != null) {
          final productId = item.productId.value!;
          final qtyToDeduct = item.quantity.value;
          final productRow = await (select(products)..where((tbl) => tbl.id.equals(productId))).getSingleOrNull();
          if (productRow != null) {
            final newStock = productRow.stock - qtyToDeduct;
            await (update(products)..where((tbl) => tbl.id.equals(productId))).write(
              ProductsCompanion(
                stock: Value(newStock < 0 ? 0 : newStock),
                updatedAt: Value(DateTime.now()),
              ),
            );
          }
        }

        final insertedItem = await (select(transactionItems)..where((tbl) => tbl.id.equals(itemId))).getSingle();
        insertedItems.add(insertedItem);
      }

      final savedTx = await (select(transactions)..where((tbl) => tbl.id.equals(transactionId))).getSingle();
      final user = await (select(users)..where((tbl) => tbl.id.equals(savedTx.userId))).getSingleOrNull();

      return TransactionWithItems(
        transaction: savedTx,
        items: insertedItems,
        user: user,
      );
    });
  }

  /// Updates status of a service item in a transaction (e.g. 'in_progress', 'completed', 'picked_up')
  Future<bool> updateServiceItemStatus(int itemId, String newStatus) async {
    final count = await (update(transactionItems)..where((tbl) => tbl.id.equals(itemId))).write(
      TransactionItemsCompanion(serviceStatus: Value(newStatus)),
    );
    return count > 0;
  }

  /// Process return with stock restoration & logging
  Future<void> processReturn({
    required int transactionId,
    required String invoiceNumber,
    required int refundAmount,
    required int totalItemReturned,
    required int userId,
    String? reason,
    List<Map<String, int>>? productRestorations, // List of {productId: qty}
  }) {
    return transaction(() async {
      await into(returns).insert(
        ReturnsCompanion(
          transactionId: Value(transactionId),
          invoiceNumber: Value(invoiceNumber),
          totalRefundAmount: Value(refundAmount),
          totalItemReturned: Value(totalItemReturned),
          userId: Value(userId),
          reason: Value(reason),
        ),
      );

      if (productRestorations != null) {
        for (final item in productRestorations) {
          final pId = item['productId'];
          final qty = item['quantity'];
          if (pId != null && qty != null) {
            final product = await (select(products)..where((tbl) => tbl.id.equals(pId))).getSingleOrNull();
            if (product != null) {
              await (update(products)..where((tbl) => tbl.id.equals(pId))).write(
                ProductsCompanion(
                  stock: Value(product.stock + qty),
                  updatedAt: Value(DateTime.now()),
                ),
              );
            }
          }
        }
      }
    });
  }

  Stream<List<TransactionData>> watchTransactionsByUser(int userId, {int? storeId}) {
    final query = select(transactions)..where((tbl) => tbl.userId.equals(userId));
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).watch();
  }

  Future<List<TransactionData>> getTransactionsByUser(int userId, {int? storeId}) {
    final query = select(transactions)..where((tbl) => tbl.userId.equals(userId));
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).get();
  }

  Stream<List<ReturnData>> watchReturnsByUser(int userId) {
    final query = select(returns)..where((tbl) => tbl.userId.equals(userId));
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).watch();
  }

  Future<List<ReturnData>> getReturnsByUser(int userId) {
    final query = select(returns)..where((tbl) => tbl.userId.equals(userId));
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).get();
  }
}
