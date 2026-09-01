// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:thermal_printer/thermal_printer.dart';

part 'pos_store.g.dart';

class CartItemModel {
  final String id; // unique uuid or temp string
  final String itemType; // 'product' | 'service'
  final int? productId;
  final int? serviceId;
  final String name;
  final int costPrice;
  final int sellingPrice;
  int quantity;
  String? notes;

  CartItemModel({
    required this.id,
    required this.itemType,
    this.productId,
    this.serviceId,
    required this.name,
    required this.costPrice,
    required this.sellingPrice,
    this.quantity = 1,
    this.notes,
  });

  int get subtotalPrice => sellingPrice * quantity;
  int get subtotalProfit => (sellingPrice - costPrice) * quantity;
}

class PosStore = _PosStore with _$PosStore;

abstract class _PosStore with Store {
  final TransactionDao _transactionDao;
  final ThermalPrinterService _thermalPrinter;
  final StoreProfileDao _storeProfileDao;

  _PosStore({
    required TransactionDao transactionDao,
    required ThermalPrinterService thermalPrinter,
    required StoreProfileDao storeProfileDao,
  })  : _transactionDao = transactionDao,
        _thermalPrinter = thermalPrinter,
        _storeProfileDao = storeProfileDao;

  @observable
  ObservableList<CartItemModel> cartItems = ObservableList<CartItemModel>();

  @observable
  String? customerName;

  @observable
  String? customerPhone;

  @observable
  int discount = 0;

  @observable
  int paymentAmount = 0;

  @observable
  String paymentMethod = 'cash'; // 'cash' | 'digital'

  @observable
  bool isProcessingCheckout = false;

  @observable
  String? errorMessage;

  @observable
  TransactionWithItems? lastCompletedTransaction;

  @computed
  int get subtotal => cartItems.fold<int>(0, (sum, item) => sum + item.subtotalPrice);

  @computed
  int get totalProfit => cartItems.fold<int>(0, (sum, item) => sum + item.subtotalProfit) - discount;

  @computed
  int get totalAmount {
    final amount = subtotal - discount;
    return amount < 0 ? 0 : amount;
  }

  @computed
  int get changeAmount {
    final change = paymentAmount - totalAmount;
    return change < 0 ? 0 : change;
  }

  @computed
  int get totalCartItemCount => cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

  @computed
  bool get canCheckout => cartItems.isNotEmpty && paymentAmount >= totalAmount;

  int getProductQuantityInCart(int productId) {
    for (final item in cartItems) {
      if (item.itemType == 'product' && item.productId == productId) {
        return item.quantity;
      }
    }
    return 0;
  }

  int getServiceQuantityInCart(int serviceId) {
    for (final item in cartItems) {
      if (item.itemType == 'service' && item.serviceId == serviceId) {
        return item.quantity;
      }
    }
    return 0;
  }

  @action
  void addProductToCart(ProductData product) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.itemType == 'product' && item.productId == product.id,
    );

    if (existingIndex >= 0) {
      final current = cartItems[existingIndex];
      // Check stock limit
      if (current.quantity + 1 <= product.stock) {
        current.quantity += 1;
        cartItems = ObservableList.of(cartItems);
      }
    } else {
      if (product.stock > 0) {
        cartItems.add(
          CartItemModel(
            id: 'prod_${product.id}_${DateTime.now().millisecondsSinceEpoch}',
            itemType: 'product',
            productId: product.id,
            name: product.name,
            costPrice: product.costPrice,
            sellingPrice: product.sellingPrice,
            quantity: 1,
          ),
        );
        cartItems = ObservableList.of(cartItems);
      }
    }
  }

  @action
  void removeProductFromCart(int productId) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.itemType == 'product' && item.productId == productId,
    );
    if (existingIndex >= 0) {
      decrementQuantity(existingIndex);
    }
  }

  @action
  void addServiceToCart(ServiceData service) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.itemType == 'service' && item.serviceId == service.id,
    );

    if (existingIndex >= 0) {
      final current = cartItems[existingIndex];
      current.quantity += 1;
      cartItems = ObservableList.of(cartItems);
    } else {
      cartItems.add(
        CartItemModel(
          id: 'srv_${service.id}_${DateTime.now().millisecondsSinceEpoch}',
          itemType: 'service',
          serviceId: service.id,
          name: service.serviceName,
          costPrice: service.materialCost,
          sellingPrice: service.finalPrice,
          quantity: 1,
        ),
      );
      cartItems = ObservableList.of(cartItems);
    }
  }

  @action
  void removeServiceFromCart(int serviceId) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.itemType == 'service' && item.serviceId == serviceId,
    );
    if (existingIndex >= 0) {
      decrementQuantity(existingIndex);
    }
  }

  @action
  void incrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      final item = cartItems[index];
      item.quantity += 1;
      cartItems = ObservableList.of(cartItems);
    }
  }

  @action
  void decrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      final item = cartItems[index];
      if (item.quantity > 1) {
        item.quantity -= 1;
        cartItems = ObservableList.of(cartItems);
      } else {
        cartItems.removeAt(index);
        cartItems = ObservableList.of(cartItems);
      }
    }
  }

  @action
  void removeFromCart(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
      cartItems = ObservableList.of(cartItems);
    }
  }

  @action
  void setDiscount(int val) {
    discount = val < 0 ? 0 : val;
  }

  @action
  void setPaymentAmount(int val) {
    paymentAmount = val < 0 ? 0 : val;
  }

  @action
  void setPaymentMethod(String method) {
    paymentMethod = method;
  }

  @action
  void setCustomerInfo({String? name, String? phone}) {
    customerName = name;
    customerPhone = phone;
  }

  @action
  void clearCart() {
    cartItems.clear();
    customerName = null;
    customerPhone = null;
    discount = 0;
    paymentAmount = 0;
    paymentMethod = 'cash';
    errorMessage = null;
  }

  @action
  Future<bool> processCheckout(int activeUserId) async {
    if (!canCheckout) return false;
    isProcessingCheckout = true;
    errorMessage = null;

    try {
      final invoice = DateFormatter.generateInvoiceNumber();

      final txCompanion = TransactionsCompanion(
        invoiceNumber: Value(invoice),
        customerName: Value(customerName),
        customerPhone: Value(customerPhone),
        subtotal: Value(subtotal),
        discount: Value(discount),
        totalAmount: Value(totalAmount),
        paymentAmount: Value(paymentAmount),
        changeAmount: Value(changeAmount),
        paymentMethod: Value(paymentMethod),
        totalProfit: Value(totalProfit),
        userId: Value(activeUserId),
      );

      final itemCompanions = cartItems.map((item) {
        return TransactionItemsCompanion(
          itemType: Value(item.itemType),
          productId: Value(item.productId),
          serviceId: Value(item.serviceId),
          itemName: Value(item.name),
          costPrice: Value(item.costPrice),
          sellingPrice: Value(item.sellingPrice),
          quantity: Value(item.quantity),
          subtotalPrice: Value(item.subtotalPrice),
          subtotalProfit: Value(item.subtotalProfit),
          serviceStatus: Value(item.itemType == 'service' ? 'queued' : 'none'),
          notes: Value(item.notes),
        );
      }).toList();

      lastCompletedTransaction = await _transactionDao.processCheckout(
        transactionCompanion: txCompanion,
        items: itemCompanions,
      );

      clearCart();
      return true;
    } catch (e) {
      errorMessage = 'Checkout gagal: ${e.toString()}';
      return false;
    } finally {
      isProcessingCheckout = false;
    }
  }

  @action
  Future<bool> printReceipt(TransactionWithItems txWithItems) async {
    try {
      final store = await _storeProfileDao.getStoreProfile();

      final receiptLines = txWithItems.items.map((item) {
        return ReceiptLineItem(
          name: item.itemName,
          unitPrice: item.sellingPrice,
          quantity: item.quantity,
          subtotal: item.subtotalPrice,
        );
      }).toList();

      final bytes = await EscPosReceiptBuilder.buildReceiptBytes(
        storeName: store?.storeName ?? 'Simple Cashier Store',
        storeAddress: store?.address ?? '',
        storePhone: store?.phone ?? '',
        invoiceNumber: txWithItems.transaction.invoiceNumber,
        dateFormatted: DateFormatter.formatFull(txWithItems.transaction.createdAt),
        cashierName: txWithItems.user?.fullname ?? 'Kasir',
        customerName: txWithItems.transaction.customerName,
        items: receiptLines,
        subtotal: txWithItems.transaction.subtotal,
        discount: txWithItems.transaction.discount,
        totalAmount: txWithItems.transaction.totalAmount,
        paymentAmount: txWithItems.transaction.paymentAmount,
        changeAmount: txWithItems.transaction.changeAmount,
        paymentMethod: txWithItems.transaction.paymentMethod.toUpperCase(),
        headerMessage: store?.headerMessage ?? 'Terima kasih atas kunjungan Anda',
        footerMessage: store?.footerMessage ?? 'Barang yang sudah dibeli tidak dapat ditukar',
      );

      return await _thermalPrinter.writeBytes(bytes);
    } catch (e) {
      errorMessage = 'Gagal mencetak struk: ${e.toString()}';
      return false;
    }
  }
}
