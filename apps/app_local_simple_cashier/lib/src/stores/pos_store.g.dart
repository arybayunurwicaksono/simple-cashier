// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PosStore on _PosStore, Store {
  Computed<int>? _$subtotalComputed;

  @override
  int get subtotal => (_$subtotalComputed ??=
          Computed<int>(() => super.subtotal, name: '_PosStore.subtotal'))
      .value;
  Computed<int>? _$totalProfitComputed;

  @override
  int get totalProfit => (_$totalProfitComputed ??=
          Computed<int>(() => super.totalProfit, name: '_PosStore.totalProfit'))
      .value;
  Computed<int>? _$totalAmountComputed;

  @override
  int get totalAmount => (_$totalAmountComputed ??=
          Computed<int>(() => super.totalAmount, name: '_PosStore.totalAmount'))
      .value;
  Computed<int>? _$changeAmountComputed;

  @override
  int get changeAmount =>
      (_$changeAmountComputed ??= Computed<int>(() => super.changeAmount,
              name: '_PosStore.changeAmount'))
          .value;
  Computed<int>? _$totalCartItemCountComputed;

  @override
  int get totalCartItemCount => (_$totalCartItemCountComputed ??= Computed<int>(
          () => super.totalCartItemCount,
          name: '_PosStore.totalCartItemCount'))
      .value;
  Computed<bool>? _$canCheckoutComputed;

  @override
  bool get canCheckout =>
      (_$canCheckoutComputed ??= Computed<bool>(() => super.canCheckout,
              name: '_PosStore.canCheckout'))
          .value;

  late final _$cartItemsAtom =
      Atom(name: '_PosStore.cartItems', context: context);

  @override
  ObservableList<CartItemModel> get cartItems {
    _$cartItemsAtom.reportRead();
    return super.cartItems;
  }

  @override
  set cartItems(ObservableList<CartItemModel> value) {
    _$cartItemsAtom.reportWrite(value, super.cartItems, () {
      super.cartItems = value;
    });
  }

  late final _$customerNameAtom =
      Atom(name: '_PosStore.customerName', context: context);

  @override
  String? get customerName {
    _$customerNameAtom.reportRead();
    return super.customerName;
  }

  @override
  set customerName(String? value) {
    _$customerNameAtom.reportWrite(value, super.customerName, () {
      super.customerName = value;
    });
  }

  late final _$customerPhoneAtom =
      Atom(name: '_PosStore.customerPhone', context: context);

  @override
  String? get customerPhone {
    _$customerPhoneAtom.reportRead();
    return super.customerPhone;
  }

  @override
  set customerPhone(String? value) {
    _$customerPhoneAtom.reportWrite(value, super.customerPhone, () {
      super.customerPhone = value;
    });
  }

  late final _$discountAtom =
      Atom(name: '_PosStore.discount', context: context);

  @override
  int get discount {
    _$discountAtom.reportRead();
    return super.discount;
  }

  @override
  set discount(int value) {
    _$discountAtom.reportWrite(value, super.discount, () {
      super.discount = value;
    });
  }

  late final _$paymentAmountAtom =
      Atom(name: '_PosStore.paymentAmount', context: context);

  @override
  int get paymentAmount {
    _$paymentAmountAtom.reportRead();
    return super.paymentAmount;
  }

  @override
  set paymentAmount(int value) {
    _$paymentAmountAtom.reportWrite(value, super.paymentAmount, () {
      super.paymentAmount = value;
    });
  }

  late final _$paymentMethodAtom =
      Atom(name: '_PosStore.paymentMethod', context: context);

  @override
  String get paymentMethod {
    _$paymentMethodAtom.reportRead();
    return super.paymentMethod;
  }

  @override
  set paymentMethod(String value) {
    _$paymentMethodAtom.reportWrite(value, super.paymentMethod, () {
      super.paymentMethod = value;
    });
  }

  late final _$isProcessingCheckoutAtom =
      Atom(name: '_PosStore.isProcessingCheckout', context: context);

  @override
  bool get isProcessingCheckout {
    _$isProcessingCheckoutAtom.reportRead();
    return super.isProcessingCheckout;
  }

  @override
  set isProcessingCheckout(bool value) {
    _$isProcessingCheckoutAtom.reportWrite(value, super.isProcessingCheckout,
        () {
      super.isProcessingCheckout = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_PosStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$lastCompletedTransactionAtom =
      Atom(name: '_PosStore.lastCompletedTransaction', context: context);

  @override
  TransactionWithItems? get lastCompletedTransaction {
    _$lastCompletedTransactionAtom.reportRead();
    return super.lastCompletedTransaction;
  }

  @override
  set lastCompletedTransaction(TransactionWithItems? value) {
    _$lastCompletedTransactionAtom
        .reportWrite(value, super.lastCompletedTransaction, () {
      super.lastCompletedTransaction = value;
    });
  }

  late final _$processCheckoutAsyncAction =
      AsyncAction('_PosStore.processCheckout', context: context);

  @override
  Future<bool> processCheckout(int activeUserId) {
    return _$processCheckoutAsyncAction
        .run(() => super.processCheckout(activeUserId));
  }

  late final _$printReceiptAsyncAction =
      AsyncAction('_PosStore.printReceipt', context: context);

  @override
  Future<bool> printReceipt(TransactionWithItems txWithItems) {
    return _$printReceiptAsyncAction.run(() => super.printReceipt(txWithItems));
  }

  late final _$_PosStoreActionController =
      ActionController(name: '_PosStore', context: context);

  @override
  void addProductToCart(ProductData product) {
    final _$actionInfo = _$_PosStoreActionController.startAction(
        name: '_PosStore.addProductToCart');
    try {
      return super.addProductToCart(product);
    } finally {
      _$_PosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeProductFromCart(int productId) {
    final _$actionInfo = _$_PosStoreActionController.startAction(
        name: '_PosStore.removeProductFromCart');
    try {
      return super.removeProductFromCart(productId);
    } finally {
      _$_PosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addServiceToCart(ServiceData service) {
    final _$actionInfo = _$_PosStoreActionController.startAction(
        name: '_PosStore.addServiceToCart');
    try {
      return super.addServiceToCart(service);
    } finally {
      _$_PosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeServiceFromCart(int serviceId) {
    final _$actionInfo = _$_PosStoreActionController.startAction(
        name: '_PosStore.removeServiceFromCart');
    try {
      return super.removeServiceFromCart(serviceId);
    } finally {
      _$_PosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementQuantity(int index) {
    final _$actionInfo = _$_PosStoreActionController.startAction(
        name: '_PosStore.incrementQuantity');
    try {
      return super.incrementQuantity(index);
    } finally {
      _$_PosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity(int index) {
    final _$actionInfo = _$_PosStoreActionController.startAction(
        name: '_PosStore.decrementQuantity');
    try {
      return super.decrementQuantity(index);
    } finally {
      _$_PosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromCart(int index) {
    final _$actionInfo = _$_PosStoreActionController.startAction(
        name: '_PosStore.removeFromCart');
    try {
      return super.removeFromCart(index);
    } finally {
      _$_PosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDiscount(int val) {
    final _$actionInfo =
        _$_PosStoreActionController.startAction(name: '_PosStore.setDiscount');
    try {
      return super.setDiscount(val);
    } finally {
      _$_PosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPaymentAmount(int val) {
    final _$actionInfo = _$_PosStoreActionController.startAction(
        name: '_PosStore.setPaymentAmount');
    try {
      return super.setPaymentAmount(val);
    } finally {
      _$_PosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPaymentMethod(String method) {
    final _$actionInfo = _$_PosStoreActionController.startAction(
        name: '_PosStore.setPaymentMethod');
    try {
      return super.setPaymentMethod(method);
    } finally {
      _$_PosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCustomerInfo({String? name, String? phone}) {
    final _$actionInfo = _$_PosStoreActionController.startAction(
        name: '_PosStore.setCustomerInfo');
    try {
      return super.setCustomerInfo(name: name, phone: phone);
    } finally {
      _$_PosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCart() {
    final _$actionInfo =
        _$_PosStoreActionController.startAction(name: '_PosStore.clearCart');
    try {
      return super.clearCart();
    } finally {
      _$_PosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartItems: ${cartItems},
customerName: ${customerName},
customerPhone: ${customerPhone},
discount: ${discount},
paymentAmount: ${paymentAmount},
paymentMethod: ${paymentMethod},
isProcessingCheckout: ${isProcessingCheckout},
errorMessage: ${errorMessage},
lastCompletedTransaction: ${lastCompletedTransaction},
subtotal: ${subtotal},
totalProfit: ${totalProfit},
totalAmount: ${totalAmount},
changeAmount: ${changeAmount},
totalCartItemCount: ${totalCartItemCount},
canCheckout: ${canCheckout}
    ''';
  }
}
