import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_selector/file_selector.dart';

class BackupService {
  /// Converts a data Map into a formatted JSON file and returns the File
  Future<File> generateBackupFile({
    required Map<String, dynamic> data,
  }) async {
    final jsonString = const JsonEncoder.withIndent('  ').convert(data);

    final tempDir = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final filename = 'Backup_SimpleCashier_$timestamp.json';
    final file = File(p.join(tempDir.path, filename));

    await file.writeAsString(jsonString);
    return file;
  }

  /// Shares a generated backup file via native share sheet (Google Drive, WA, Email, Save to Files, etc.)
  Future<void> shareBackupFile(File file, {String? storeName}) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/json')],
        text: 'Backup Database Simple Cashier ${storeName != null ? "- $storeName" : ""}',
        subject: 'Backup Database Simple Cashier',
      ),
    );
  }

  /// Opens the system file picker to select a .json backup file and validates its format
  Future<Map<String, dynamic>?> pickAndValidateBackupFile() async {
    const typeGroup = XTypeGroup(
      label: 'JSON Backup',
      extensions: ['json'],
      mimeTypes: ['application/json', 'text/json', 'text/plain'],
    );

    final XFile? selectedFile = await openFile(
      acceptedTypeGroups: [typeGroup],
    );

    if (selectedFile == null) {
      return null;
    }

    final content = await selectedFile.readAsString();

    try {
      final decoded = jsonDecode(content);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Format file backup tidak valid (harus berupa JSON objek).');
      }

      final metadata = decoded['metadata'];
      if (metadata == null || metadata['format'] != 'simple_cashier_backup') {
        throw const FormatException('File yang dipilih bukan merupakan file backup resmi Simple Cashier.');
      }

      return decoded;
    } catch (e) {
      throw FormatException('Gagal membaca file backup: ${e.toString()}');
    }
  }
}
