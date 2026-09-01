// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductStore on _ProductStore, Store {
  Computed<List<ProductData>>? _$filteredProductsComputed;

  @override
  List<ProductData> get filteredProducts => (_$filteredProductsComputed ??=
          Computed<List<ProductData>>(() => super.filteredProducts,
              name: '_ProductStore.filteredProducts'))
      .value;

  late final _$productsAtom =
      Atom(name: '_ProductStore.products', context: context);

  @override
  ObservableList<ProductData> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<ProductData> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$goodsCategoriesAtom =
      Atom(name: '_ProductStore.goodsCategories', context: context);

  @override
  ObservableList<CategoryData> get goodsCategories {
    _$goodsCategoriesAtom.reportRead();
    return super.goodsCategories;
  }

  @override
  set goodsCategories(ObservableList<CategoryData> value) {
    _$goodsCategoriesAtom.reportWrite(value, super.goodsCategories, () {
      super.goodsCategories = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ProductStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_ProductStore.errorMessage', context: context);

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

  late final _$searchQueryAtom =
      Atom(name: '_ProductStore.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$selectedCategoryIdAtom =
      Atom(name: '_ProductStore.selectedCategoryId', context: context);

  @override
  int? get selectedCategoryId {
    _$selectedCategoryIdAtom.reportRead();
    return super.selectedCategoryId;
  }

  @override
  set selectedCategoryId(int? value) {
    _$selectedCategoryIdAtom.reportWrite(value, super.selectedCategoryId, () {
      super.selectedCategoryId = value;
    });
  }

  late final _$loadProductsAsyncAction =
      AsyncAction('_ProductStore.loadProducts', context: context);

  @override
  Future<void> loadProducts() {
    return _$loadProductsAsyncAction.run(() => super.loadProducts());
  }

  late final _$createProductAsyncAction =
      AsyncAction('_ProductStore.createProduct', context: context);

  @override
  Future<bool> createProduct(
      {required String name,
      String? sku,
      int? categoryId,
      String unit = 'pcs',
      required int costPrice,
      required int sellingPrice,
      int initialStock = 0,
      int minStockAlert = 5,
      File? imageFile}) {
    return _$createProductAsyncAction.run(() => super.createProduct(
        name: name,
        sku: sku,
        categoryId: categoryId,
        unit: unit,
        costPrice: costPrice,
        sellingPrice: sellingPrice,
        initialStock: initialStock,
        minStockAlert: minStockAlert,
        imageFile: imageFile));
  }

  late final _$updateProductAsyncAction =
      AsyncAction('_ProductStore.updateProduct', context: context);

  @override
  Future<bool> updateProduct(
      {required int id,
      required String name,
      String? sku,
      int? categoryId,
      String unit = 'pcs',
      required int costPrice,
      required int sellingPrice,
      required int stock,
      int minStockAlert = 5,
      File? newImageFile,
      String? existingPhotoPath}) {
    return _$updateProductAsyncAction.run(() => super.updateProduct(
        id: id,
        name: name,
        sku: sku,
        categoryId: categoryId,
        unit: unit,
        costPrice: costPrice,
        sellingPrice: sellingPrice,
        stock: stock,
        minStockAlert: minStockAlert,
        newImageFile: newImageFile,
        existingPhotoPath: existingPhotoPath));
  }

  late final _$deleteProductAsyncAction =
      AsyncAction('_ProductStore.deleteProduct', context: context);

  @override
  Future<bool> deleteProduct(int id) {
    return _$deleteProductAsyncAction.run(() => super.deleteProduct(id));
  }

  late final _$restockProductAsyncAction =
      AsyncAction('_ProductStore.restockProduct', context: context);

  @override
  Future<bool> restockProduct(
      {required int productId,
      required int quantityAdded,
      required int totalPurchaseCost,
      required int userId,
      String? notes}) {
    return _$restockProductAsyncAction.run(() => super.restockProduct(
        productId: productId,
        quantityAdded: quantityAdded,
        totalPurchaseCost: totalPurchaseCost,
        userId: userId,
        notes: notes));
  }

  late final _$addCategoryAsyncAction =
      AsyncAction('_ProductStore.addCategory', context: context);

  @override
  Future<bool> addCategory(String name) {
    return _$addCategoryAsyncAction.run(() => super.addCategory(name));
  }

  late final _$_ProductStoreActionController =
      ActionController(name: '_ProductStore', context: context);

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_ProductStoreActionController.startAction(
        name: '_ProductStore.setSearchQuery');
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCategory(int? categoryId) {
    final _$actionInfo = _$_ProductStoreActionController.startAction(
        name: '_ProductStore.setSelectedCategory');
    try {
      return super.setSelectedCategory(categoryId);
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
goodsCategories: ${goodsCategories},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
searchQuery: ${searchQuery},
selectedCategoryId: ${selectedCategoryId},
filteredProducts: ${filteredProducts}
    ''';
  }
}
