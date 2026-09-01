import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareService {
  /// Shares a PDF document bytes directly via the OS share sheet (WhatsApp, Telegram, Email, etc.)
  static Future<void> sharePdfBytes({
    required Uint8List pdfBytes,
    required String filename,
    String? subject,
    String? text,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$filename');
    await file.writeAsBytes(pdfBytes);

    // ignore: deprecated_member_use
    await Share.shareXFiles(
      [XFile(file.path)],
      subject: subject,
      text: text,
    );
  }

  /// Opens WhatsApp directly with a pre-filled text message
  static Future<bool> sendWhatsAppMessage({
    required String phoneNumber,
    required String message,
  }) async {
    // Format phone to international format without + or 0 prefix (e.g. 628123456789)
    var cleanedPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanedPhone.startsWith('0')) {
      cleanedPhone = '62${cleanedPhone.substring(1)}';
    }

    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse('https://wa.me/$cleanedPhone?text=$encodedMessage');

    if (await canLaunchUrl(url)) {
      return await launchUrl(url, mode: LaunchMode.externalApplication);
    }
    return false;
  }
}
