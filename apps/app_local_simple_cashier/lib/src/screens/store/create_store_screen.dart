import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/store_store.dart';

class CreateStoreScreen extends StatefulWidget {
  const CreateStoreScreen({super.key});

  @override
  State<CreateStoreScreen> createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends State<CreateStoreScreen> {
  final _formKey = GlobalKey<FormState>();
  final _storeNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final _answerController = TextEditingController();
  late String _selectedSecurityQuestion;
  bool _setAsDefault = false;

  final _storeStore = getIt<StoreStore>();

  @override
  void initState() {
    super.initState();
    _selectedSecurityQuestion = AppConstants.defaultSecurityQuestions.first;
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _ownerNameController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _handleCreateStore() async {
    if (_formKey.currentState?.validate() ?? false) {
      final store = await _storeStore.createStore(
        storeName: _storeNameController.text.trim(),
        ownerName: _ownerNameController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        pin: _pinController.text.trim(),
        securityQuestion: _selectedSecurityQuestion,
        securityAnswer: _answerController.text.trim(),
        setAsDefault: _setAsDefault,
      );

      if (!mounted) return;

      if (store != null) {
        AppNotification.showSuccess(
          context,
          'Toko "${store.storeName}" berhasil ditambahkan!',
        );
        Navigator.of(context).pop(store);
      } else {
        AppNotification.showError(
          context,
          _storeStore.errorMessage ?? 'Gagal membuat toko.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Toko Baru'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionHeader(
                  icon: Icons.storefront_rounded,
                  title: '1. Profil Toko',
                  subtitle: 'Informasi identitas toko yang akan dicetak di struk',
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border(context)),
                  ),
                  child: Column(
                    children: [
                      AppTextField(
                        label: 'Nama Toko / Usaha',
                        hint: 'Contoh: Cabang Kopi Senja 2',
                        controller: _storeNameController,
                        prefixIcon: Icons.storefront_outlined,
                        validator: (v) => FormValidators.required(v, 'Nama toko wajib diisi'),
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        label: 'No. Telepon / WhatsApp',
                        hint: '081234567890',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.phone_outlined,
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        label: 'Alamat Toko',
                        hint: 'Alamat cabang',
                        controller: _addressController,
                        prefixIcon: Icons.location_on_outlined,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                _buildSectionHeader(
                  icon: Icons.lock_outline_rounded,
                  title: '2. Akses Pemilik & PIN Toko',
                  subtitle: 'PIN 6-digit untuk membuka akses kasir toko ini',
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border(context)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        label: 'Nama Pemilik Toko',
                        hint: 'Nama lengkap pengelola',
                        controller: _ownerNameController,
                        prefixIcon: Icons.person_outline,
                        validator: (v) => FormValidators.required(v, 'Nama pemilik wajib diisi'),
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        label: 'Buat 6-Digit PIN',
                        hint: '6 angka rahasia',
                        controller: _pinController,
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
                        label: 'Konfirmasi PIN',
                        hint: 'Ulangi 6 digit PIN',
                        controller: _confirmPinController,
                        isPassword: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        prefixIcon: Icons.check_circle_outline,
                        validator: (v) {
                          if (v != _pinController.text) {
                            return 'Konfirmasi PIN tidak cocok';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Pertanyaan Pemulihan (Jika Lupa PIN):',
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedSecurityQuestion,
                        isExpanded: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.help_outline_rounded),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppColors.border(context)),
                          ),
                        ),
                        dropdownColor: Theme.of(context).cardColor,
                        items: AppConstants.defaultSecurityQuestions.map((q) {
                          return DropdownMenuItem(
                            value: q,
                            child: Text(
                              q,
                              style: const TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedSecurityQuestion = val);
                        },
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        label: 'Jawaban Rahasia',
                        hint: 'Jawaban pemulihan jika sewaktu-waktu lupa PIN',
                        controller: _answerController,
                        prefixIcon: Icons.vpn_key_outlined,
                        validator: (v) => FormValidators.required(v, 'Jawaban pemulihan wajib diisi'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border(context)),
                  ),
                  child: SwitchListTile.adaptive(
                    value: _setAsDefault,
                    title: Text(
                      'Jadikan Toko Utama',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                    subtitle: Text(
                      'Aplikasi akan langsung membuka PIN toko ini saat dimulai',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    activeTrackColor: AppColors.primaryAccent(context),
                    onChanged: (val) => setState(() => _setAsDefault = val),
                  ),
                ),
                const SizedBox(height: 24),

                Observer(
                  builder: (_) => AppButton(
                    label: 'Simpan Toko Baru',
                    icon: Icons.add_business_rounded,
                    height: 48,
                    isLoading: _storeStore.isLoading,
                    onPressed: _handleCreateStore,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryAccent(context)),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.labelLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
            ),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary(context),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
