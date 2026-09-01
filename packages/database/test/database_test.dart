import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:database/database.dart';
import 'package:core/core.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    // In-memory SQLite database for test isolate
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('SimpleCashier Database & Security Integration Tests', () {
    test('Password Hasher creates unique hash with salt and verifies correctly', () {
      const password = 'mySecretPassword123';
      final salt = PasswordHasher.generateSalt();
      final hash = PasswordHasher.hashPassword(password, salt);

      expect(PasswordHasher.verifyPassword(password, hash, salt), isTrue);
      expect(PasswordHasher.verifyPassword('wrongPassword', hash, salt), isFalse);
    });

    test('Insert user and retrieve from UserDao', () async {
      final salt = PasswordHasher.generateSalt();
      final hash = PasswordHasher.hashPassword('admin123', salt);

      final userId = await db.userDao.insertUser(
        UsersCompanion(
          username: const Value('owner'),
          email: const Value('owner@simplecashier.com'),
          passwordHash: Value(hash),
          salt: Value(salt),
          fullname: const Value('Toko Owner'),
          role: const Value('owner'),
        ),
      );

      final user = await db.userDao.getUserById(userId);
      expect(user, isNotNull);
      expect(user!.username, equals('owner'));
      expect(user.role, equals('owner'));
    });

    test('Atomic Checkout decrements physical product stock accurately', () async {
      // 1. Setup user
      final userId = await db.userDao.insertUser(
        const UsersCompanion(
          username: Value('cashier1'),
          email: Value('cashier1@simplecashier.com'),
          passwordHash: Value('hash'),
          salt: Value('salt'),
          fullname: Value('Kasir 1'),
          role: Value('cashier'),
        ),
      );

      // 2. Setup product with initial stock 20
      final productId = await db.productDao.insertProduct(
        const ProductsCompanion(
          name: Value('Sabun Cuci Sepatu 250ml'),
          costPrice: Value(15000),
          sellingPrice: Value(35000),
          stock: Value(20),
          minStockAlert: Value(5),
        ),
      );

      // 3. Process Checkout of 3 items
      final txResult = await db.transactionDao.processCheckout(
        transactionCompanion: TransactionsCompanion(
          invoiceNumber: const Value('INV-TEST-001'),
          subtotal: const Value(105000),
          discount: const Value(5000),
          totalAmount: const Value(100000),
          paymentAmount: const Value(100000),
          changeAmount: const Value(0),
          paymentMethod: const Value('cash'),
          totalProfit: const Value(55000),
          userId: Value(userId),
        ),
        items: [
          TransactionItemsCompanion(
            itemType: const Value('product'),
            productId: Value(productId),
            itemName: const Value('Sabun Cuci Sepatu 250ml'),
            costPrice: const Value(15000),
            sellingPrice: const Value(35000),
            quantity: const Value(3),
            subtotalPrice: const Value(105000),
            subtotalProfit: const Value(60000),
          ),
        ],
      );

      expect(txResult.transaction.id, isPositive);
      expect(txResult.items.length, equals(1));

      // 4. Verify product stock was decremented from 20 -> 17
      final updatedProduct = await db.productDao.getProductById(productId);
      expect(updatedProduct!.stock, equals(17));
    });
  });
}
