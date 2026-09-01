// ignore_for_file: library_private_types_in_public_api
import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';

part 'product_store.g.dart';

class ProductStore = _ProductStore with _$ProductStore;

abstract class _ProductStore with Store {
  final ProductDao _productDao;
  final CategoryDao _categoryDao;
  final FileStorageService _fileStorage;

  _ProductStore({
    required ProductDao productDao,
    required CategoryDao categoryDao,
    required FileStorageService fileStorage,
  })  : _productDao = productDao,
        _categoryDao = categoryDao,
        _fileStorage = fileStorage;

  @observable
  ObservableList<ProductData> products = ObservableList<ProductData>();

  @observable
  ObservableList<CategoryData> goodsCategories = ObservableList<CategoryData>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String searchQuery = '';

  @observable
  int? selectedCategoryId;

  @computed
  List<ProductData> get filteredProducts {
    return products.where((p) {
      final matchesQuery = searchQuery.isEmpty ||
          p.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (p.sku?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false);

      final matchesCategory = selectedCategoryId == null || p.categoryId == selectedCategoryId;

      return matchesQuery && matchesCategory;
    }).toList();
  }

  @action
  Future<void> loadProducts() async {
    isLoading = true;
    try {
      final list = await _productDao.getAllProducts();
      products = ObservableList.of(list);

      final categories = await _categoryDao.getAllCategories('goods');
      goodsCategories = ObservableList.of(categories);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
  }

  @action
  void setSelectedCategory(int? categoryId) {
    selectedCategoryId = categoryId;
  }

  @action
  Future<bool> createProduct({
    required String name,
    String? sku,
    int? categoryId,
    String unit = 'pcs',
    required int costPrice,
    required int sellingPrice,
    int initialStock = 0,
    int minStockAlert = 5,
    File? imageFile,
  }) async {
    isLoading = true;
    try {
      String? photoPath;
      if (imageFile != null) {
        photoPath = await _fileStorage.saveImageFile(imageFile);
      }

      await _productDao.insertProduct(
        ProductsCompanion(
          name: Value(name),
          sku: Value(sku),
          categoryId: Value(categoryId),
          unit: Value(unit),
          costPrice: Value(costPrice),
          sellingPrice: Value(sellingPrice),
          stock: Value(initialStock),
          minStockAlert: Value(minStockAlert),
          photoPath: Value(photoPath),
        ),
      );
      await loadProducts();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> updateProduct({
    required int id,
    required String name,
    String? sku,
    int? categoryId,
    String unit = 'pcs',
    required int costPrice,
    required int sellingPrice,
    required int stock,
    int minStockAlert = 5,
    File? newImageFile,
    String? existingPhotoPath,
  }) async {
    isLoading = true;
    try {
      String? photoPath = existingPhotoPath;
      if (newImageFile != null) {
        photoPath = await _fileStorage.saveImageFile(newImageFile);
      }

      await _productDao.updateProduct(
        ProductData(
          id: id,
          name: name,
          sku: sku,
          categoryId: categoryId,
          unit: unit,
          costPrice: costPrice,
          sellingPrice: sellingPrice,
          stock: stock,
          minStockAlert: minStockAlert,
          photoPath: photoPath,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
      await loadProducts();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> deleteProduct(int id) async {
    isLoading = true;
    try {
      await _productDao.deleteProduct(id);
      await loadProducts();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> restockProduct({
    required int productId,
    required int quantityAdded,
    required int totalPurchaseCost,
    required int userId,
    String? notes,
  }) async {
    isLoading = true;
    try {
      await _productDao.restockProduct(
        productId: productId,
        quantityAdded: quantityAdded,
        totalPurchaseCost: totalPurchaseCost,
        userId: userId,
        notes: notes,
      );
      await loadProducts();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> addCategory(String name) async {
    try {
      await _categoryDao.insertCategory(
        CategoriesCompanion(
          name: Value(name),
          type: const Value('goods'),
        ),
      );
      final categories = await _categoryDao.getAllCategories('goods');
      goodsCategories = ObservableList.of(categories);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }
}
