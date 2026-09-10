import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:ui/ui.dart';
import '../../../di/injection.dart';
import '../../../stores/store_store.dart';

class ForgotPinDialog extends StatefulWidget {
  final StoreData store;

  const ForgotPinDialog({
    super.key,
    required this.store,
  });

  static Future<bool?> show(BuildContext context, StoreData store) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ForgotPinDialog(store: store),
    );
  }

  @override
  State<ForgotPinDialog> createState() => _ForgotPinDialogState();
}

class _ForgotPinDialogState extends State<ForgotPinDialog> {
  int _step = 0; // 0: verify question, 1: reset pin

  final _answerFormKey = GlobalKey<FormState>();
  final _answerController = TextEditingController();

  final _pinFormKey = GlobalKey<FormState>();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  final _storeStore = getIt<StoreStore>();
  String? _errorMessage;

  @override
  void dispose() {
    _answerController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  Future<void> _handleVerifyAnswer() async {
    setState(() => _errorMessage = null);
    if (_answerFormKey.currentState?.validate() ?? false) {
      final isMatch = await _storeStore.verifySecurityAnswer(
        storeId: widget.store.id,
        answer: _answerController.text.trim(),
      );

      if (!mounted) return;

      if (isMatch) {
        setState(() {
          _step = 1;
          _errorMessage = null;
        });
      } else {
        setState(() {
          _errorMessage = 'Jawaban keamanan tidak sesuai. Periksa kembali jawaban Anda.';
        });
      }
    }
  }

  Future<void> _handleResetPin() async {
    setState(() => _errorMessage = null);
    if (_pinFormKey.currentState?.validate() ?? false) {
      final success = await _storeStore.resetStorePin(
        storeId: widget.store.id,
        newPin: _newPinController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        AppNotification.showSuccess(
          context,
          'PIN toko berhasil diperbarui! Silakan masuk dengan PIN baru.',
        );
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          _errorMessage = _storeStore.errorMessage ?? 'Gagal menyetel ulang PIN.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryAccent(context).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_reset_rounded,
              color: AppColors.primaryAccent(context),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _step == 0 ? 'Lupa PIN Toko' : 'Buat PIN Baru',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                Text(
                  widget.store.storeName,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary(context),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 380,
        child: _step == 0 ? _buildStep0Content() : _buildStep1Content(),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Batal',
            style: TextStyle(color: AppColors.textSecondary(context)),
          ),
        ),
        Observer(
          builder: (_) => AppButton(
            label: _step == 0 ? 'Verifikasi' : 'Simpan PIN',
            isLoading: _storeStore.isLoading,
            height: 40,
            onPressed: _step == 0 ? _handleVerifyAnswer : _handleResetPin,
          ),
        ),
      ],
    );
  }

  // --- Step 0: Pertanyaan Keamanan ---
  Widget _buildStep0Content() {
    return Form(
      key: _answerFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Text(
            'Jawab pertanyaan keamanan rahasia yang telah Anda atur saat pendaftaran toko ini:',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary(context),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryContainerAdaptive(context),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryAccent(context).withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.help_outline_rounded,
                  size: 18,
                  color: AppColors.primaryAccent(context),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.store.securityQuestion,
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          AppTextField(
            label: 'Jawaban Rahasia',
            hint: 'Ketikkan jawaban Anda',
            controller: _answerController,
            prefixIcon: Icons.vpn_key_outlined,
            validator: (v) => FormValidators.required(v, 'Jawaban wajib diisi'),
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: 10),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  // --- Step 1: Setel Ulang PIN Baru ---
  Widget _buildStep1Content() {
    return Form(
      key: _pinFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Text(
            'Verifikasi berhasil! Masukkan 6-digit PIN baru untuk toko ini.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary(context),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          AppTextField(
            label: 'PIN Baru (6 Digit)',
            hint: '6 angka',
            controller: _newPinController,
            isPassword: true,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            prefixIcon: Icons.password_rounded,
            validator: (v) {
              if (v == null || v.length != 6) {
                return 'PIN harus terdiri dari 6 digit angka';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          AppTextField(
            label: 'Konfirmasi PIN Baru',
            hint: 'Ulangi 6 angka',
            controller: _confirmPinController,
            isPassword: true,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            prefixIcon: Icons.check_circle_outline,
            validator: (v) {
              if (v != _newPinController.text) {
                return 'Konfirmasi PIN tidak cocok';
              }
              return null;
            },
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: 10),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}
