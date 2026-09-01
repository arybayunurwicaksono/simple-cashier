import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FileStorageService {
  static String? _baseAppDocPath;

  /// Initializes the base application documents directory path
  static Future<void> initialize() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      _baseAppDocPath = appDir.path;
    } catch (_) {
      // Fallback if unable to query during early init
    }
  }

  /// Synchronously or fast-resolves a stored path to a full File object
  static File? resolveFile(String? storedPath) {
    if (storedPath == null || storedPath.trim().isEmpty) return null;

    // 1. Direct file check (if storedPath is already absolute)
    final directFile = File(storedPath);
    if (directFile.existsSync()) {
      return directFile;
    }

    // 2. Resolve relative path using cached app documents directory
    if (_baseAppDocPath != null) {
      final fullPath = p.join(_baseAppDocPath!, storedPath);
      final resolved = File(fullPath);
      if (resolved.existsSync()) {
        return resolved;
      }
    }

    return null;
  }

  /// Saves a source image file to local app documents directory and returns the relative path
  Future<String> saveImageFile(File sourceFile, {String subDirectory = 'products'}) async {
    final appDir = await getApplicationDocumentsDirectory();
    _baseAppDocPath = appDir.path;

    final targetDir = Directory(p.join(appDir.path, subDirectory));
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }

    final fileExtension = p.extension(sourceFile.path);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}$fileExtension';
    final targetPath = p.join(targetDir.path, fileName);

    await sourceFile.copy(targetPath);
    // Return relative path for database storage
    return p.join(subDirectory, fileName);
  }

  /// Resolves a stored relative path to a full File object
  Future<File?> getAbsoluteFile(String? relativePath) async {
    if (relativePath == null || relativePath.isEmpty) return null;
    final appDir = await getApplicationDocumentsDirectory();
    _baseAppDocPath = appDir.path;

    final fullPath = p.join(appDir.path, relativePath);
    final file = File(fullPath);
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  /// Deletes a file given its relative path
  Future<bool> deleteFile(String? relativePath) async {
    if (relativePath == null || relativePath.isEmpty) return false;
    final appDir = await getApplicationDocumentsDirectory();
    _baseAppDocPath = appDir.path;

    final file = File(p.join(appDir.path, relativePath));
    if (await file.exists()) {
      await file.delete();
      return true;
    }
    return false;
  }
}
