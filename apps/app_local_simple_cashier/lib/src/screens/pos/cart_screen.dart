import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/pos_store.dart';
import '../../stores/auth_store.dart';
import 'receipt_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _posStore = getIt<PosStore>();
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _discountController = TextEditingController();
  final _paymentAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _paymentAmountController.text = _posStore.paymentAmount > 0
        ? _posStore.paymentAmount.toString()
        : _posStore.totalAmount.toString();
    _posStore.setPaymentAmount(
      _posStore.paymentAmount > 0 ? _posStore.paymentAmount : _posStore.totalAmount,
    );
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _discountController.dispose();
    _paymentAmountController.dispose();
    super.dispose();
  }

  Future<void> _handleCheckout() async {
    _posStore.setCustomerInfo(
      name: _customerNameController.text.trim().isEmpty
          ? null
          : _customerNameController.text.trim(),
      phone: _customerPhoneController.text.trim().isEmpty
          ? null
          : _customerPhoneController.text.trim(),
    );

    final authStore = getIt<AuthStore>();
    final activeUserId = authStore.currentUser?.id ?? 1;
    final success = await _posStore.processCheckout(activeUserId);

    if (!mounted) return;

    if (success && _posStore.lastCompletedTransaction != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ReceiptScreen(
            transactionWithItems: _posStore.lastCompletedTransaction!,
          ),
        ),
      );
    } else if (_posStore.errorMessage != null) {
      AppNotification.showError(
        context,
        _posStore.errorMessage ?? 'Checkout gagal',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Keranjang Kasir'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined, color: AppColors.error),
            onPressed: () {
              ConfirmationDialog.show(
                context,
                title: 'Kosongkan Keranjang?',
                message: 'Semua item di keranjang akan dihapus.',
                isDanger: true,
                onConfirm: () => _posStore.clearCart(),
              );
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_posStore.cartItems.isEmpty) {
            return const EmptyStateView(
              title: 'Keranjang Masih Kosong',
              message: 'Pilih barang atau jasa dari menu kasir untuk ditambahkan',
              icon: Icons.remove_shopping_cart_outlined,
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              // Items List
              ..._posStore.cartItems.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;
                return CartTile(
                  title: item.name,
                  subtitle: '${CurrencyFormatter.format(item.sellingPrice)} / item',
                  unitPrice: item.sellingPrice,
                  quantity: item.quantity,
                  itemType: item.itemType,
                  onIncrement: () => _posStore.incrementQuantity(idx),
                  onDecrement: () => _posStore.decrementQuantity(idx),
                  onRemove: () => _posStore.removeFromCart(idx),
                );
              }),
              const SizedBox(height: 10),

              // Customer Details Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border(context)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Pelanggan (Opsional)',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      hint: 'Nama Pelanggan',
                      controller: _customerNameController,
                      prefixIcon: Icons.person_outline,
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      hint: 'Nomor WA (08123456789)',
                      controller: _customerPhoneController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Payment & Discount Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border(context)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pembayaran & Diskon',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _posStore.setPaymentMethod('cash'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: _posStore.paymentMethod == 'cash'
                                    ? AppColors.primaryContainerAdaptive(context)
                                    : (isDark ? AppColors.backgroundDark : const Color(0xFFF1F5F9)),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: _posStore.paymentMethod == 'cash'
                                      ? AppColors.primaryAccent(context)
                                      : Colors.transparent,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'TUNAI (Cash)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: _posStore.paymentMethod == 'cash'
                                        ? AppColors.primaryAccent(context)
                                        : AppColors.textSecondary(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: () => _posStore.setPaymentMethod('digital'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: _posStore.paymentMethod == 'digital'
                                    ? AppColors.primaryContainerAdaptive(context)
                                    : (isDark ? AppColors.backgroundDark : const Color(0xFFF1F5F9)),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: _posStore.paymentMethod == 'digital'
                                      ? AppColors.primaryAccent(context)
                                      : Colors.transparent,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'DIGITAL / QRIS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: _posStore.paymentMethod == 'digital'
                                        ? AppColors.primaryAccent(context)
                                        : AppColors.textSecondary(context),
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
                      label: 'Potongan / Diskon (Rp)',
                      hint: '0',
                      controller: _discountController,
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        final d = int.tryParse(v) ?? 0;
                        _posStore.setDiscount(d);
                      },
                    ),
                    const SizedBox(height: 10),
                    AppTextField(
                      label: 'Uang Diterima (Rp)',
                      hint: '0',
                      controller: _paymentAmountController,
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        final p = int.tryParse(v) ?? 0;
                        _posStore.setPaymentAmount(p);
                      },
                    ),
                    const SizedBox(height: 8),

                    // Quick Cash Buttons
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _buildQuickAmountChip('Uang Pas', _posStore.totalAmount),
                        _buildQuickAmountChip('Rp 20rb', 20000),
                        _buildQuickAmountChip('Rp 50rb', 50000),
                        _buildQuickAmountChip('Rp 100rb', 100000),
                      ],
                    ),
                    const Divider(height: 20),

                    // Summary Rows
                    _buildSummaryRow(context, 'Subtotal', _posStore.subtotal),
                    if (_posStore.discount > 0)
                      _buildSummaryRow(context, 'Diskon', -_posStore.discount, color: AppColors.error),
                    const SizedBox(height: 2),
                    _buildSummaryRow(
                      context,
                      'TOTAL BAYAR',
                      _posStore.totalAmount,
                      isBold: true,
                      color: AppColors.primaryAccent(context),
                      fontSize: 14,
                    ),
                    const SizedBox(height: 2),
                    _buildSummaryRow(context, 'Kembalian', _posStore.changeAmount, color: isDark ? AppColors.secondaryLight : AppColors.secondaryDark),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              AppButton(
                label: 'SELESAIKAN TRANSAKSI',
                width: double.infinity,
                isLoading: _posStore.isProcessingCheckout,
                onPressed: _posStore.canCheckout ? _handleCheckout : null,
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQuickAmountChip(String label, int amount) {
    return ActionChip(
      visualDensity: VisualDensity.compact,
      label: Text(label, style: const TextStyle(fontSize: 11)),
      onPressed: () {
        _paymentAmountController.text = amount.toString();
        _posStore.setPaymentAmount(amount);
      },
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, int amount, {bool isBold = false, Color? color, double fontSize = 12}) {
    final defaultTextColor = AppColors.textPrimary(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isBold ? (color ?? defaultTextColor) : AppColors.textSecondary(context),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          CurrencyText(
            amount: amount,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color ?? defaultTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
