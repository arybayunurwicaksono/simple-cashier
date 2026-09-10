import 'package:flutter/material.dart';
import 'package:database/database.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/product_store.dart';
import '../../stores/auth_store.dart';

class RestockDialog extends StatefulWidget {
  final ProductData product;

  const RestockDialog({super.key, required this.product});

  static Future<void> show(BuildContext context, {required ProductData product}) {
    return showDialog(
      context: context,
      builder: (_) => RestockDialog(product: product),
    );
  }

  @override
  State<RestockDialog> createState() => _RestockDialogState();
}

class _RestockDialogState extends State<RestockDialog> {
  final _productStore = getIt<ProductStore>();
  final _authStore = getIt<AuthStore>();
  final _formKey = GlobalKey<FormState>();

  final _qtyController = TextEditingController(text: '10');
  final _totalCostController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _totalCostController.text = (widget.product.costPrice * 10).toString();
  }

  @override
  void dispose() {
    _qtyController.dispose();
    _totalCostController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _handleRestock() async {
    if (!_formKey.currentState!.validate()) return;

    final qty = int.tryParse(_qtyController.text) ?? 0;
    final totalCost = int.tryParse(_totalCostController.text) ?? 0;
    final userId = _authStore.currentUser?.id ?? 1;

    final success = await _productStore.restockProduct(
      productId: widget.product.id,
      quantityAdded: qty,
      totalPurchaseCost: totalCost,
      userId: userId,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      AppNotification.showSuccess(
        context,
        'Stok ${widget.product.name} bertambah $qty ${widget.product.unit}',
      );
      Navigator.of(context).pop();
    } else {
      AppNotification.showError(
        context,
        _productStore.errorMessage ?? 'Gagal restock',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Text('Restock / Kulak Stok', style: AppTextStyles.titleMedium),
              const SizedBox(height: 4),
              Text(
                '${widget.product.name} (Sisa: ${widget.product.stock} ${widget.product.unit})',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary(context)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),
              AppTextField(
                label: 'Jumlah Tambahan (${widget.product.unit}) *',
                hint: '0',
                controller: _qtyController,
                keyboardType: TextInputType.number,
                validator: (v) => FormValidators.positiveNumber(v, 'Jumlah stok'),
                onChanged: (v) {
                  final q = int.tryParse(v) ?? 0;
                  _totalCostController.text = (widget.product.costPrice * q).toString();
                },
              ),
              const SizedBox(height: 10),
              AppTextField(
                label: 'Total Biaya Kulak (Rp) *',
                hint: '0',
                controller: _totalCostController,
                keyboardType: TextInputType.number,
                validator: (v) => FormValidators.positiveNumber(v, 'Total biaya'),
              ),
              const SizedBox(height: 10),
              AppTextField(
                label: 'Catatan / Nama Supplier',
                hint: 'Opsional',
                controller: _notesController,
              ),
              const SizedBox(height: 18),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 220;
                  if (isNarrow) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppButton(
                          label: 'Simpan',
                          variant: AppButtonVariant.secondary,
                          height: 40,
                          onPressed: _handleRestock,
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
                          variant: AppButtonVariant.secondary,
                          height: 40,
                          onPressed: _handleRestock,
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
