import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/balance_store.dart';
import '../../stores/auth_store.dart';

class BalanceLogDialog extends StatefulWidget {
  final VoidCallback onSuccess;

  const BalanceLogDialog({super.key, required this.onSuccess});

  static Future<void> show(BuildContext context, {required VoidCallback onSuccess}) {
    return showDialog(
      context: context,
      builder: (_) => BalanceLogDialog(onSuccess: onSuccess),
    );
  }

  @override
  State<BalanceLogDialog> createState() => _BalanceLogDialogState();
}

class _BalanceLogDialogState extends State<BalanceLogDialog> {
  final _balanceStore = getIt<BalanceStore>();
  final _authStore = getIt<AuthStore>();
  final _formKey = GlobalKey<FormState>();

  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  String _flowType = 'in'; // 'in' | 'out'
  String _category = 'capital'; // 'capital' | 'operational' | 'withdrawal' | 'other'
  String _paymentType = 'cash'; // 'cash' | 'digital'

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = int.tryParse(_amountController.text) ?? 0;
    final userId = _authStore.currentUser?.id ?? 1;

    final success = await _balanceStore.addBalanceLog(
      amount: amount,
      flowType: _flowType,
      category: _category,
      paymentType: _paymentType,
      userId: userId,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      AppNotification.showSuccess(
        context,
        'Arus kas berhasil dicatat',
      );
      Navigator.pop(context);
      widget.onSuccess();
    } else {
      AppNotification.showError(
        context,
        _balanceStore.errorMessage ?? 'Gagal mencatat arus kas',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Catat Pemasukan / Pengeluaran', style: AppTextStyles.titleMedium),
              const SizedBox(height: 12),

              // Flow Type Segment
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _flowType = 'in'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _flowType == 'in'
                              ? AppColors.successContainerAdaptive(context)
                              : (isDark ? AppColors.backgroundDark : const Color(0xFFF1F5F9)),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _flowType == 'in'
                                ? (isDark ? AppColors.successDark : AppColors.success)
                                : (isDark ? AppColors.borderDark : Colors.transparent),
                          ),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Pemasukan (Masuk)',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: _flowType == 'in'
                                    ? (isDark ? const Color(0xFF6EE7B7) : AppColors.success)
                                    : AppColors.textSecondary(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _flowType = 'out'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _flowType == 'out'
                              ? AppColors.errorContainerAdaptive(context)
                              : (isDark ? AppColors.backgroundDark : const Color(0xFFF1F5F9)),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _flowType == 'out'
                                ? (isDark ? AppColors.errorDark : AppColors.error)
                                : (isDark ? AppColors.borderDark : Colors.transparent),
                          ),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Pengeluaran (Keluar)',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: _flowType == 'out'
                                    ? (isDark ? const Color(0xFFFCA5A5) : AppColors.error)
                                    : AppColors.textSecondary(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              AppTextField(
                label: 'Jumlah Nominal (Rp) *',
                hint: '0',
                controller: _amountController,
                keyboardType: TextInputType.number,
                validator: (v) => FormValidators.positiveNumber(v, 'Nominal'),
              ),
              const SizedBox(height: 10),

              // Category Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kategori Kas',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border(context)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _category,
                        isExpanded: true,
                        dropdownColor: Theme.of(context).cardColor,
                        items: const [
                          DropdownMenuItem(value: 'capital', child: Text('Modal Usaha / Tambahan', style: TextStyle(fontSize: 13))),
                          DropdownMenuItem(value: 'operational', child: Text('Biaya Operasional / Listrik', style: TextStyle(fontSize: 13))),
                          DropdownMenuItem(value: 'withdrawal', child: Text('Prive / Penarikan Pemilik', style: TextStyle(fontSize: 13))),
                          DropdownMenuItem(value: 'other', child: Text('Lain-lain', style: TextStyle(fontSize: 13))),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => _category = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Payment Type
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Metode Akun Kas',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border(context)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _paymentType,
                        isExpanded: true,
                        dropdownColor: Theme.of(context).cardColor,
                        items: const [
                          DropdownMenuItem(value: 'cash', child: Text('Kas Tunai (Fisik)', style: TextStyle(fontSize: 13))),
                          DropdownMenuItem(value: 'digital', child: Text('Kas Digital (Bank/QRIS)', style: TextStyle(fontSize: 13))),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => _paymentType = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              AppTextField(
                label: 'Keterangan / Catatan',
                hint: 'Contoh: Bayar token listrik toko',
                controller: _notesController,
              ),
              const SizedBox(height: 16),

              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 220;
                  if (isNarrow) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppButton(
                          label: 'Simpan',
                          height: 40,
                          onPressed: _handleSave,
                        ),
                        const SizedBox(height: 8),
                        AppButton(
                          label: 'Batal',
                          variant: AppButtonVariant.outline,
                          height: 40,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: 'Batal',
                          variant: AppButtonVariant.outline,
                          height: 40,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppButton(
                          label: 'Simpan',
                          height: 40,
                          onPressed: _handleSave,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
