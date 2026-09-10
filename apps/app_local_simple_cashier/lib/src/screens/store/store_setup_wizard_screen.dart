import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/store_store.dart';
import '../auth/register_screen.dart';

class StoreSetupWizardScreen extends StatefulWidget {
  const StoreSetupWizardScreen({super.key});

  @override
  State<StoreSetupWizardScreen> createState() => _StoreSetupWizardScreenState();
}

class _StoreSetupWizardScreenState extends State<StoreSetupWizardScreen> {
  final _pageController = PageController();
  int _currentStep = 0;

  // Step 1 - Form Toko
  final _step1FormKey = GlobalKey<FormState>();
  final _storeNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  // Step 2 - Form Keamanan & PIN
  final _step2FormKey = GlobalKey<FormState>();
  final _ownerNameController = TextEditingController();
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final _answerController = TextEditingController();
  late String _selectedSecurityQuestion;

  final _storeStore = getIt<StoreStore>();

  @override
  void initState() {
    super.initState();
    _selectedSecurityQuestion = AppConstants.defaultSecurityQuestions.first;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _storeNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _ownerNameController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  void _goToStep2() {
    if (_step1FormKey.currentState?.validate() ?? false) {
      setState(() => _currentStep = 1);
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToStep1() {
    setState(() => _currentStep = 0);
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _handleFinishSetup() async {
    if (_step2FormKey.currentState?.validate() ?? false) {
      final store = await _storeStore.createStore(
        storeName: _storeNameController.text.trim(),
        ownerName: _ownerNameController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        pin: _pinController.text.trim(),
        securityQuestion: _selectedSecurityQuestion,
        securityAnswer: _answerController.text.trim(),
        setAsDefault: true,
      );

      if (!mounted) return;

      if (store != null) {
        AppNotification.showSuccess(
          context,
          'Toko "${store.storeName}" berhasil dibuat! Silakan buat akun login Pemilik (Owner).',
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => RegisterScreen(
              isInitialOwnerSetup: true,
              initialFullname: store.ownerName,
            ),
          ),
          (route) => false,
        );
      } else {
        AppNotification.showError(
          context,
          _storeStore.errorMessage ?? 'Gagal membuat toko baru.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopIndicator(isDark),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildStep1View(isDark),
                  _buildStep2View(isDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopIndicator(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(bottom: BorderSide(color: AppColors.border(context))),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryAccent(context).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.storefront_rounded,
              color: AppColors.primaryAccent(context),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Setup Toko Baru',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                Text(
                  _currentStep == 0 ? 'Langkah 1 dari 2: Profil Toko' : 'Langkah 2 dari 2: PIN & Keamanan',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          // Step Progress Pills
          Row(
            children: [
              _buildStepDot(isActive: true, isDone: _currentStep > 0),
              const SizedBox(width: 6),
              _buildStepDot(isActive: _currentStep >= 1, isDone: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepDot({required bool isActive, required bool isDone}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: isActive ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primaryAccent(context)
            : (Theme.of(context).brightness == Brightness.dark ? Colors.white24 : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // --- Step 1: Profil Toko ---
  Widget _buildStep1View(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Form(
        key: _step1FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainerAdaptive(context),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.store_rounded,
                  size: 32,
                  color: AppColors.primaryAccent(context),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Informasi Usaha Toko',
              style: AppTextStyles.titleLarge.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Masukkan nama dan kontak usaha yang akan dicantumkan pada struk transaksi.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary(context),
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border(context)),
              ),
              child: Column(
                children: [
                  AppTextField(
                    label: 'Nama Toko / Usaha',
                    hint: 'Contoh: Toko Berkah Jaya',
                    controller: _storeNameController,
                    prefixIcon: Icons.storefront_outlined,
                    validator: (v) => FormValidators.required(v, 'Nama toko wajib diisi'),
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    label: 'No. Telepon / WhatsApp',
                    hint: 'Contoh: 081234567890',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone_outlined,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    label: 'Alamat Toko',
                    hint: 'Contoh: Jl. Ahmad Yani No. 12, Surabaya',
                    controller: _addressController,
                    prefixIcon: Icons.location_on_outlined,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Lanjut ke PIN Keamanan',
              icon: Icons.arrow_forward_rounded,
              height: 46,
              onPressed: _goToStep2,
            ),
          ],
        ),
      ),
    );
  }

  // --- Step 2: Keamanan PIN & Pemulihan ---
  Widget _buildStep2View(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Form(
        key: _step2FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainerAdaptive(context),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_outline_rounded,
                  size: 32,
                  color: AppColors.primaryAccent(context),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Akses Pemilik & Keamanan PIN',
              style: AppTextStyles.titleLarge.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'PIN 6-digit digunakan untuk membuka kasir toko ini setiap hari.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary(context),
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border(context)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    label: 'Nama Pemilik Toko',
                    hint: 'Nama lengkap Anda',
                    controller: _ownerNameController,
                    prefixIcon: Icons.person_outline,
                    validator: (v) => FormValidators.required(v, 'Nama pemilik wajib diisi'),
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    label: 'Buat 6-Digit PIN',
                    hint: '6 digit angka (contoh: 123456)',
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
                  const SizedBox(height: 14),
                  AppTextField(
                    label: 'Konfirmasi PIN',
                    hint: 'Ulangi 6 digit PIN di atas',
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
                  const SizedBox(height: 18),
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
                  const SizedBox(height: 14),
                  AppTextField(
                    label: 'Jawaban Rahasia',
                    hint: 'Jawaban pemulihan (bebas huruf besar/kecil)',
                    controller: _answerController,
                    prefixIcon: Icons.vpn_key_outlined,
                    validator: (v) => FormValidators.required(v, 'Jawaban pemulihan wajib diisi'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 46),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _goToStep1,
                    child: const Text('Kembali'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Observer(
                    builder: (_) => AppButton(
                      label: 'Simpan & Buat Akun Owner',
                      icon: Icons.arrow_forward_rounded,
                      height: 46,
                      isLoading: _storeStore.isLoading,
                      onPressed: _handleFinishSetup,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
