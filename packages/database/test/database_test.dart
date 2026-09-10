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

    test('UserDao updates profile and password properly', () async {
      final userId = await db.userDao.insertUser(
        const UsersCompanion(
          username: Value('staff1'),
          email: Value('staff1@store.com'),
          passwordHash: Value('oldHash'),
          salt: Value('oldSalt'),
          fullname: Value('Staff Satu'),
          role: Value('cashier'),
        ),
      );

      final updateProfileSuccess = await db.userDao.updateUserProfile(
        userId: userId,
        fullname: 'Staff Satu Updated',
        email: 'staff1_new@store.com',
        role: 'cashier',
      );
      expect(updateProfileSuccess, isTrue);

      final updatePassSuccess = await db.userDao.updateUserPassword(
        userId: userId,
        newPasswordHash: 'newHash123',
        newSalt: 'newSalt123',
      );
      expect(updatePassSuccess, isTrue);

      final user = await db.userDao.getUserById(userId);
      expect(user?.fullname, equals('Staff Satu Updated'));
      expect(user?.email, equals('staff1_new@store.com'));
      expect(user?.passwordHash, equals('newHash123'));
    });

    test('Employee activity filtering for transactions, restocks, balance, and returns', () async {
      // 1. Create two employees
      final user1 = await db.userDao.insertUser(
        const UsersCompanion(
          username: Value('kasir_a'),
          email: Value('a@store.com'),
          passwordHash: Value('h1'),
          salt: Value('s1'),
          fullname: Value('Kasir A'),
          role: Value('cashier'),
        ),
      );

      final user2 = await db.userDao.insertUser(
        const UsersCompanion(
          username: Value('kasir_b'),
          email: Value('b@store.com'),
          passwordHash: Value('h2'),
          salt: Value('s2'),
          fullname: Value('Kasir B'),
          role: Value('cashier'),
        ),
      );

      // 2. Insert product and restock by user1
      final pId = await db.productDao.insertProduct(
        const ProductsCompanion(
          name: Value('Buku Tulis'),
          costPrice: Value(3000),
          sellingPrice: Value(5000),
          stock: Value(10),
        ),
      );

      await db.productDao.restockProduct(
        productId: pId,
        quantityAdded: 25,
        totalPurchaseCost: 75000,
        userId: user1,
        notes: 'Restock Grosir',
      );

      // 3. Transactions by user1 and user2
      await db.transactionDao.processCheckout(
        transactionCompanion: TransactionsCompanion(
          invoiceNumber: const Value('INV-U1-001'),
          subtotal: const Value(15000),
          totalAmount: const Value(15000),
          paymentAmount: const Value(20000),
          userId: Value(user1),
        ),
        items: [],
      );

      await db.transactionDao.processCheckout(
        transactionCompanion: TransactionsCompanion(
          invoiceNumber: const Value('INV-U2-001'),
          subtotal: const Value(30000),
          totalAmount: const Value(30000),
          paymentAmount: const Value(30000),
          userId: Value(user2),
        ),
        items: [],
      );

      // 4. Balance logs by user1
      await db.balanceDao.insertBalanceLog(
        BalanceLogsCompanion(
          amount: const Value(50000),
          flowType: const Value('in'),
          category: const Value('capital'),
          userId: Value(user1),
        ),
      );

      // 5. Query logs by user1
      final u1Txs = await db.transactionDao.getTransactionsByUser(user1);
      final u2Txs = await db.transactionDao.getTransactionsByUser(user2);
      final u1Restocks = await db.productDao.getRestocksWithProduct(userId: user1);
      final u2Restocks = await db.productDao.getRestocksWithProduct(userId: user2);
      final u1Balance = await db.balanceDao.getBalanceLogsByUser(user1);
      final u2Balance = await db.balanceDao.getBalanceLogsByUser(user2);

      expect(u1Txs.length, equals(1));
      expect(u1Txs.first.invoiceNumber, equals('INV-U1-001'));
      expect(u2Txs.length, equals(1));
      expect(u2Txs.first.invoiceNumber, equals('INV-U2-001'));

      expect(u1Restocks.length, equals(1));
      expect(u1Restocks.first.product?.name, equals('Buku Tulis'));
      expect(u1Restocks.first.restock.quantityAdded, equals(25));
      expect(u2Restocks.isEmpty, isTrue);

      expect(u1Balance.length, equals(1));
      expect(u1Balance.first.amount, equals(50000));
      expect(u2Balance.isEmpty, isTrue);
    });
  });
}
