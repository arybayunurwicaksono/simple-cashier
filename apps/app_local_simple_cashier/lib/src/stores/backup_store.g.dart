// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BackupStore on _BackupStore, Store {
  Computed<bool>? _$hasPendingRestoreComputed;

  @override
  bool get hasPendingRestore => (_$hasPendingRestoreComputed ??= Computed<bool>(
          () => super.hasPendingRestore,
          name: '_BackupStore.hasPendingRestore'))
      .value;
  Computed<Map<String, dynamic>?>? _$pendingMetadataComputed;

  @override
  Map<String, dynamic>? get pendingMetadata => (_$pendingMetadataComputed ??=
          Computed<Map<String, dynamic>?>(() => super.pendingMetadata,
              name: '_BackupStore.pendingMetadata'))
      .value;

  late final _$isLoadingAtom =
      Atom(name: '_BackupStore.isLoading', context: context);

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

  late final _$isExportingAtom =
      Atom(name: '_BackupStore.isExporting', context: context);

  @override
  bool get isExporting {
    _$isExportingAtom.reportRead();
    return super.isExporting;
  }

  @override
  set isExporting(bool value) {
    _$isExportingAtom.reportWrite(value, super.isExporting, () {
      super.isExporting = value;
    });
  }

  late final _$isRestoringAtom =
      Atom(name: '_BackupStore.isRestoring', context: context);

  @override
  bool get isRestoring {
    _$isRestoringAtom.reportRead();
    return super.isRestoring;
  }

  @override
  set isRestoring(bool value) {
    _$isRestoringAtom.reportWrite(value, super.isRestoring, () {
      super.isRestoring = value;
    });
  }

  late final _$statusMessageAtom =
      Atom(name: '_BackupStore.statusMessage', context: context);

  @override
  String? get statusMessage {
    _$statusMessageAtom.reportRead();
    return super.statusMessage;
  }

  @override
  set statusMessage(String? value) {
    _$statusMessageAtom.reportWrite(value, super.statusMessage, () {
      super.statusMessage = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_BackupStore.errorMessage', context: context);

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

  late final _$lastExportedFileAtom =
      Atom(name: '_BackupStore.lastExportedFile', context: context);

  @override
  File? get lastExportedFile {
    _$lastExportedFileAtom.reportRead();
    return super.lastExportedFile;
  }

  @override
  set lastExportedFile(File? value) {
    _$lastExportedFileAtom.reportWrite(value, super.lastExportedFile, () {
      super.lastExportedFile = value;
    });
  }

  late final _$pendingRestoreDataAtom =
      Atom(name: '_BackupStore.pendingRestoreData', context: context);

  @override
  Map<String, dynamic>? get pendingRestoreData {
    _$pendingRestoreDataAtom.reportRead();
    return super.pendingRestoreData;
  }

  @override
  set pendingRestoreData(Map<String, dynamic>? value) {
    _$pendingRestoreDataAtom.reportWrite(value, super.pendingRestoreData, () {
      super.pendingRestoreData = value;
    });
  }

  late final _$exportAndShareDatabaseAsyncAction =
      AsyncAction('_BackupStore.exportAndShareDatabase', context: context);

  @override
  Future<File?> exportAndShareDatabase() {
    return _$exportAndShareDatabaseAsyncAction
        .run(() => super.exportAndShareDatabase());
  }

  late final _$selectAndPreviewBackupFileAsyncAction =
      AsyncAction('_BackupStore.selectAndPreviewBackupFile', context: context);

  @override
  Future<bool> selectAndPreviewBackupFile() {
    return _$selectAndPreviewBackupFileAsyncAction
        .run(() => super.selectAndPreviewBackupFile());
  }

  late final _$executeRestoreAsyncAction =
      AsyncAction('_BackupStore.executeRestore', context: context);

  @override
  Future<bool> executeRestore({required Function onReloadAllStores}) {
    return _$executeRestoreAsyncAction
        .run(() => super.executeRestore(onReloadAllStores: onReloadAllStores));
  }

  late final _$_BackupStoreActionController =
      ActionController(name: '_BackupStore', context: context);

  @override
  void cancelPendingRestore() {
    final _$actionInfo = _$_BackupStoreActionController.startAction(
        name: '_BackupStore.cancelPendingRestore');
    try {
      return super.cancelPendingRestore();
    } finally {
      _$_BackupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isExporting: ${isExporting},
isRestoring: ${isRestoring},
statusMessage: ${statusMessage},
errorMessage: ${errorMessage},
lastExportedFile: ${lastExportedFile},
pendingRestoreData: ${pendingRestoreData},
hasPendingRestore: ${hasPendingRestore},
pendingMetadata: ${pendingMetadata}
    ''';
  }
}
