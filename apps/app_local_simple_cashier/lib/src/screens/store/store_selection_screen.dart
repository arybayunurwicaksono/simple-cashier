import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/auth_store.dart';
import '../../stores/store_store.dart';
import '../auth/login_screen.dart';
import '../auth/register_screen.dart';
import '../dashboard_screen.dart';
import 'create_store_screen.dart';
import 'store_setup_wizard_screen.dart';
import 'widgets/store_pin_sheet.dart';

class StoreSelectionScreen extends StatefulWidget {
  final int? autoPromptStoreId;

  const StoreSelectionScreen({
    super.key,
    this.autoPromptStoreId,
  });

  @override
  State<StoreSelectionScreen> createState() => _StoreSelectionScreenState();
}

class _StoreSelectionScreenState extends State<StoreSelectionScreen> {
  final _storeStore = getIt<StoreStore>();

  @override
  void initState() {
    super.initState();
    _storeStore.loadStores().then((_) {
      if (widget.autoPromptStoreId != null && mounted) {
        final targetStore = _storeStore.storeList
            .where((s) => s.id == widget.autoPromptStoreId)
            .firstOrNull;
        if (targetStore != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _handleStoreTapped(targetStore, allowSwitchStore: true);
            }
          });
        }
      }
    });
  }

  Future<void> _handleStoreTapped(StoreData store, {bool allowSwitchStore = false}) async {
    final success = await StorePinSheet.show(
      context,
      store: store,
      allowSwitchStore: allowSwitchStore,
    );

    if (!mounted) return;

    if (success == true) {
      final authStore = getIt<AuthStore>();
      final userDao = getIt<UserDao>();
      final allUsers = await userDao.getAllUsers();
      final hasOwner = allUsers.any((u) => u.role == 'owner');

      if (!mounted) return;

      if (!hasOwner) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => RegisterScreen(
              isInitialOwnerSetup: true,
              initialFullname: store.ownerName,
            ),
          ),
          (route) => false,
        );
      } else if (authStore.isAuthenticated) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
          (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }

  Future<void> _handleAddNewStore() async {
    final createdStore = await Navigator.of(context).push<StoreData?>(
      MaterialPageRoute(builder: (_) => const CreateStoreScreen()),
    );

    if (!mounted) return;

    if (createdStore != null) {
      await _storeStore.loadStores();
      final userDao = getIt<UserDao>();
      final allUsers = await userDao.getAllUsers();
      final hasOwner = allUsers.any((u) => u.role == 'owner');

      if (!hasOwner && mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => RegisterScreen(
              isInitialOwnerSetup: true,
              initialFullname: createdStore.ownerName,
            ),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Toko / Usaha'),
        elevation: 0,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) {
            if (_storeStore.isLoading && _storeStore.storeList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (_storeStore.storeList.isEmpty) {
              return Center(
                child: EmptyStateView(
                  title: 'Belum Ada Toko Terdaftar',
                  message: 'Silakan mulai dengan mendaftarkan toko pertama Anda untuk memulai operasional kasir.',
                  actionLabel: 'Setup Toko Pertama',
                  onActionPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const StoreSetupWizardScreen()),
                    );
                  },
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => _storeStore.loadStores(),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                children: [
                  Text(
                    'Pilih toko yang ingin Anda buka kasirnya hari ini:',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary(context),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ...List.generate(_storeStore.storeList.length, (index) {
                    final store = _storeStore.storeList[index];
                    final isDefault = _storeStore.defaultStoreId == store.id;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildStoreCard(store, isDefault, isDark),
                    );
                  }),

                  const SizedBox(height: 12),

                  // Add Store Button
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: BorderSide(
                        color: AppColors.primaryAccent(context).withValues(alpha: 0.6),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    icon: Icon(
                      Icons.add_business_rounded,
                      color: AppColors.primaryAccent(context),
                      size: 20,
                    ),
                    label: Text(
                      'Tambah Toko Baru',
                      style: TextStyle(
                        color: AppColors.primaryAccent(context),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    onPressed: _handleAddNewStore,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStoreCard(StoreData store, bool isDefault, bool isDark) {
    final initials = store.storeName.isNotEmpty
        ? store.storeName.trim().substring(0, 1).toUpperCase()
        : 'T';

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDefault
              ? AppColors.primaryAccent(context).withValues(alpha: 0.5)
              : AppColors.border(context),
          width: isDefault ? 1.5 : 1.0,
        ),
        boxShadow: isDefault
            ? [
                BoxShadow(
                  color: AppColors.primaryAccent(context).withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _handleStoreTapped(store),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Circular Avatar
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryAccent(context),
                        AppColors.secondary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Store Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              store.storeName,
                              style: AppTextStyles.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary(context),
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isDefault)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.primaryAccent(context).withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Toko Utama',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryAccent(context),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      if (store.ownerName.isNotEmpty)
                        Text(
                          'Pemilik: ${store.ownerName}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary(context),
                            fontSize: 12,
                          ),
                        ),
                      if (store.address.isNotEmpty)
                        Text(
                          store.address,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary(context).withValues(alpha: 0.8),
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Trailing Lock/Arrow Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outline_rounded,
                    size: 18,
                    color: AppColors.primaryAccent(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
