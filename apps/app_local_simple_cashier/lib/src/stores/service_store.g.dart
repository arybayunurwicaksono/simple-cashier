// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServiceStore on _ServiceStore, Store {
  Computed<List<ServiceData>>? _$filteredServicesComputed;

  @override
  List<ServiceData> get filteredServices => (_$filteredServicesComputed ??=
          Computed<List<ServiceData>>(() => super.filteredServices,
              name: '_ServiceStore.filteredServices'))
      .value;

  late final _$servicesAtom =
      Atom(name: '_ServiceStore.services', context: context);

  @override
  ObservableList<ServiceData> get services {
    _$servicesAtom.reportRead();
    return super.services;
  }

  @override
  set services(ObservableList<ServiceData> value) {
    _$servicesAtom.reportWrite(value, super.services, () {
      super.services = value;
    });
  }

  late final _$serviceCategoriesAtom =
      Atom(name: '_ServiceStore.serviceCategories', context: context);

  @override
  ObservableList<CategoryData> get serviceCategories {
    _$serviceCategoriesAtom.reportRead();
    return super.serviceCategories;
  }

  @override
  set serviceCategories(ObservableList<CategoryData> value) {
    _$serviceCategoriesAtom.reportWrite(value, super.serviceCategories, () {
      super.serviceCategories = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ServiceStore.isLoading', context: context);

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
      Atom(name: '_ServiceStore.errorMessage', context: context);

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
      Atom(name: '_ServiceStore.searchQuery', context: context);

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
      Atom(name: '_ServiceStore.selectedCategoryId', context: context);

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

  late final _$loadServicesAsyncAction =
      AsyncAction('_ServiceStore.loadServices', context: context);

  @override
  Future<void> loadServices() {
    return _$loadServicesAsyncAction.run(() => super.loadServices());
  }

  late final _$createServiceAsyncAction =
      AsyncAction('_ServiceStore.createService', context: context);

  @override
  Future<bool> createService(
      {required String serviceName,
      int? categoryId,
      int materialCost = 0,
      required int finalPrice,
      int durationValue = 1,
      String durationUnit = 'days',
      String? description,
      File? imageFile}) {
    return _$createServiceAsyncAction.run(() => super.createService(
        serviceName: serviceName,
        categoryId: categoryId,
        materialCost: materialCost,
        finalPrice: finalPrice,
        durationValue: durationValue,
        durationUnit: durationUnit,
        description: description,
        imageFile: imageFile));
  }

  late final _$updateServiceAsyncAction =
      AsyncAction('_ServiceStore.updateService', context: context);

  @override
  Future<bool> updateService(
      {required int id,
      required String serviceName,
      int? categoryId,
      required int materialCost,
      required int finalPrice,
      required int durationValue,
      required String durationUnit,
      String? description,
      File? newImageFile,
      String? existingPhotoPath}) {
    return _$updateServiceAsyncAction.run(() => super.updateService(
        id: id,
        serviceName: serviceName,
        categoryId: categoryId,
        materialCost: materialCost,
        finalPrice: finalPrice,
        durationValue: durationValue,
        durationUnit: durationUnit,
        description: description,
        newImageFile: newImageFile,
        existingPhotoPath: existingPhotoPath));
  }

  late final _$deleteServiceAsyncAction =
      AsyncAction('_ServiceStore.deleteService', context: context);

  @override
  Future<bool> deleteService(int id) {
    return _$deleteServiceAsyncAction.run(() => super.deleteService(id));
  }

  late final _$addCategoryAsyncAction =
      AsyncAction('_ServiceStore.addCategory', context: context);

  @override
  Future<bool> addCategory(String name) {
    return _$addCategoryAsyncAction.run(() => super.addCategory(name));
  }

  late final _$_ServiceStoreActionController =
      ActionController(name: '_ServiceStore', context: context);

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_ServiceStoreActionController.startAction(
        name: '_ServiceStore.setSearchQuery');
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_ServiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCategory(int? categoryId) {
    final _$actionInfo = _$_ServiceStoreActionController.startAction(
        name: '_ServiceStore.setSelectedCategory');
    try {
      return super.setSelectedCategory(categoryId);
    } finally {
      _$_ServiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
services: ${services},
serviceCategories: ${serviceCategories},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
searchQuery: ${searchQuery},
selectedCategoryId: ${selectedCategoryId},
filteredServices: ${filteredServices}
    ''';
  }
}
