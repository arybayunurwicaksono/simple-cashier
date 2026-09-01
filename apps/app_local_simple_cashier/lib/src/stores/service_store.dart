// ignore_for_file: library_private_types_in_public_api
import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';

part 'service_store.g.dart';

class ServiceStore = _ServiceStore with _$ServiceStore;

abstract class _ServiceStore with Store {
  final ServiceDao _serviceDao;
  final CategoryDao _categoryDao;
  final FileStorageService _fileStorage;

  _ServiceStore({
    required ServiceDao serviceDao,
    required CategoryDao categoryDao,
    required FileStorageService fileStorage,
  })  : _serviceDao = serviceDao,
        _categoryDao = categoryDao,
        _fileStorage = fileStorage;

  @observable
  ObservableList<ServiceData> services = ObservableList<ServiceData>();

  @observable
  ObservableList<CategoryData> serviceCategories = ObservableList<CategoryData>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String searchQuery = '';

  @observable
  int? selectedCategoryId;

  @computed
  List<ServiceData> get filteredServices {
    return services.where((s) {
      final matchesQuery = searchQuery.isEmpty ||
          s.serviceName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (s.description?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false);

      final matchesCategory = selectedCategoryId == null || s.categoryId == selectedCategoryId;

      return matchesQuery && matchesCategory;
    }).toList();
  }

  @action
  Future<void> loadServices() async {
    isLoading = true;
    try {
      final list = await _serviceDao.getAllServices();
      services = ObservableList.of(list);

      final categories = await _categoryDao.getAllCategories('services');
      serviceCategories = ObservableList.of(categories);
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
  Future<bool> createService({
    required String serviceName,
    int? categoryId,
    int materialCost = 0,
    required int finalPrice,
    int durationValue = 1,
    String durationUnit = 'days',
    String? description,
    File? imageFile,
  }) async {
    isLoading = true;
    try {
      String? photoPath;
      if (imageFile != null) {
        photoPath = await _fileStorage.saveImageFile(imageFile, subDirectory: 'services');
      }

      await _serviceDao.insertService(
        ServicesCompanion(
          serviceName: Value(serviceName),
          categoryId: Value(categoryId),
          materialCost: Value(materialCost),
          finalPrice: Value(finalPrice),
          durationValue: Value(durationValue),
          durationUnit: Value(durationUnit),
          description: Value(description),
          photoPath: Value(photoPath),
        ),
      );
      await loadServices();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> updateService({
    required int id,
    required String serviceName,
    int? categoryId,
    required int materialCost,
    required int finalPrice,
    required int durationValue,
    required String durationUnit,
    String? description,
    File? newImageFile,
    String? existingPhotoPath,
  }) async {
    isLoading = true;
    try {
      String? photoPath = existingPhotoPath;
      if (newImageFile != null) {
        photoPath = await _fileStorage.saveImageFile(newImageFile, subDirectory: 'services');
      }

      await _serviceDao.updateService(
        ServiceData(
          id: id,
          serviceName: serviceName,
          categoryId: categoryId,
          materialCost: materialCost,
          finalPrice: finalPrice,
          durationValue: durationValue,
          durationUnit: durationUnit,
          description: description,
          photoPath: photoPath,
          createdAt: DateTime.now(),
        ),
      );
      await loadServices();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> deleteService(int id) async {
    isLoading = true;
    try {
      await _serviceDao.deleteService(id);
      await loadServices();
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
          type: const Value('services'),
        ),
      );
      final categories = await _categoryDao.getAllCategories('services');
      serviceCategories = ObservableList.of(categories);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }
}
