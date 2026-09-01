import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/product_store.dart';
import '../../stores/service_store.dart';
import '../../stores/auth_store.dart';
import 'product_form_screen.dart';
import 'service_form_screen.dart';
import 'restock_dialog.dart';

import '../widgets/app_end_drawer.dart';

class CatalogManagementScreen extends StatefulWidget {
  final VoidCallback? onOpenEndDrawer;

  const CatalogManagementScreen({super.key, this.onOpenEndDrawer});

  @override
  State<CatalogManagementScreen> createState() => _CatalogManagementScreenState();
}

class _CatalogManagementScreenState extends State<CatalogManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _productStore = getIt<ProductStore>();
  final _serviceStore = getIt<ServiceStore>();
  final _searchController = TextEditingController();
  final _authStore = getIt<AuthStore>();

  bool _isGridView = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _productStore.loadProducts();
    _serviceStore.loadServices();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      endDrawer: const AppEndDrawer(),
      appBar: AppBar(
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Katalog Barang & Jasa',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Kelola stok produk fisik & tarif jasa layanan',
              style: TextStyle(
                fontSize: 11,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.menu_rounded),
              tooltip: 'Buka Menu',
              onPressed: () {
                if (widget.onOpenEndDrawer != null) {
                  widget.onOpenEndDrawer!();
                } else {
                  Scaffold.of(ctx).openEndDrawer();
                }
              },
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryAccent(context),
          labelColor: AppColors.primaryAccent(context),
          unselectedLabelColor: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          tabs: const [
            Tab(icon: Icon(Icons.inventory_2_outlined, size: 20), text: 'Barang Fisik'),
            Tab(icon: Icon(Icons.build_circle_outlined, size: 20), text: 'Jasa & Layanan'),
          ],
        ),
      ),
      floatingActionButton: _authStore.isOwner
          ? FloatingActionButton.extended(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              elevation: 4,
              icon: const Icon(Icons.add_rounded),
              label: Text(_tabController.index == 0 ? 'Tambah Barang' : 'Tambah Jasa'),
              onPressed: () {
                if (_tabController.index == 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProductFormScreen()),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ServiceFormScreen()),
                  );
                }
              },
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            child: Row(
              children: [
                Expanded(
                  child: AppSearchBar(
                    controller: _searchController,
                    hint: 'Cari nama barang, SKU, atau jasa...',
                    onChanged: (val) {
                      _productStore.setSearchQuery(val);
                      _serviceStore.setSearchQuery(val);
                    },
                    onClear: () {
                      _productStore.setSearchQuery('');
                      _serviceStore.setSearchQuery('');
                    },
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isGridView = !_isGridView;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
                      color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A),
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductsTab(),
                _buildServicesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    return Observer(
      builder: (_) {
        if (_productStore.isLoading && _productStore.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = _productStore.filteredProducts;

        if (items.isEmpty) {
          return EmptyStateView(
            title: 'Belum Ada Barang',
            message: 'Tambahkan data barang fisik dan stok dagangan Anda',
            icon: Icons.inventory_2_outlined,
            actionLabel: _authStore.isOwner ? 'Tambah Barang Baru' : null,
            onActionPressed: _authStore.isOwner
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ProductFormScreen()),
                    );
                  }
                : null,
          );
        }

        if (!_isGridView) {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final item = items[i];
              return ProductListTile(
                name: item.name,
                sku: item.sku,
                sellingPrice: item.sellingPrice,
                costPrice: _authStore.isOwner ? item.costPrice : null,
                stock: item.stock,
                minStockAlert: item.minStockAlert,
                photoPath: item.photoPath,
                unit: item.unit,
                mode: ProductCardMode.catalog,
                onTap: () => _showProductDetailSheet(item),
              );
            },
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossCount = constraints.maxWidth > 500 ? 3 : 2;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                childAspectRatio: 0.72,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: items.length,
              itemBuilder: (ctx, i) {
                final item = items[i];
                return ProductCard(
                  name: item.name,
                  sku: item.sku,
                  sellingPrice: item.sellingPrice,
                  costPrice: _authStore.isOwner ? item.costPrice : null,
                  stock: item.stock,
                  minStockAlert: item.minStockAlert,
                  photoPath: item.photoPath,
                  unit: item.unit,
                  mode: ProductCardMode.catalog,
                  onTap: () => _showProductDetailSheet(item),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildServicesTab() {
    return Observer(
      builder: (_) {
        if (_serviceStore.isLoading && _serviceStore.services.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = _serviceStore.filteredServices;

        if (items.isEmpty) {
          return EmptyStateView(
            title: 'Belum Ada Layanan Jasa',
            message: 'Tambahkan jenis layanan atau pengerjaan jasa toko Anda',
            icon: Icons.build_circle_outlined,
            actionLabel: _authStore.isOwner ? 'Tambah Jasa Baru' : null,
            onActionPressed: _authStore.isOwner
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ServiceFormScreen()),
                    );
                  }
                : null,
          );
        }

        if (!_isGridView) {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final item = items[i];
              return ServiceListTile(
                serviceName: item.serviceName,
                finalPrice: item.finalPrice,
                materialCost: _authStore.isOwner ? item.materialCost : null,
                durationValue: item.durationValue,
                durationUnit: item.durationUnit,
                description: item.description,
                photoPath: item.photoPath,
                mode: ServiceCardMode.catalog,
                onTap: () => _showServiceDetailSheet(item),
              );
            },
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossCount = constraints.maxWidth > 500 ? 3 : 2;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                childAspectRatio: 0.72,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: items.length,
              itemBuilder: (ctx, i) {
                final item = items[i];
                return ServiceCard(
                  serviceName: item.serviceName,
                  finalPrice: item.finalPrice,
                  materialCost: _authStore.isOwner ? item.materialCost : null,
                  durationValue: item.durationValue,
                  durationUnit: item.durationUnit,
                  description: item.description,
                  photoPath: item.photoPath,
                  mode: ServiceCardMode.catalog,
                  onTap: () => _showServiceDetailSheet(item),
                );
              },
            );
          },
        );
      },
    );
  }

  void _showProductDetailSheet(dynamic product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(product.name, style: AppTextStyles.titleMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                ),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
              ],
            ),
            const SizedBox(height: 8),
            Text('SKU / Kode: ${product.sku ?? "-"}', style: AppTextStyles.bodyMedium),
            if (_authStore.isOwner)
              Text('Harga Modal: ${CurrencyFormatter.format(product.costPrice)}', style: AppTextStyles.bodyMedium),
            Text('Harga Jual: ${CurrencyFormatter.format(product.sellingPrice)}', style: AppTextStyles.bodyMedium),
            Text('Sisa Stok: ${product.stock} ${product.unit}', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Restock / Kulak',
                    variant: AppButtonVariant.secondary,
                    icon: Icons.add_business_rounded,
                    height: 40,
                    onPressed: () {
                      Navigator.pop(ctx);
                      RestockDialog.show(context, product: product);
                    },
                  ),
                ),
                if (_authStore.isOwner) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: AppButton(
                      label: 'Edit Barang',
                      variant: AppButtonVariant.outline,
                      icon: Icons.edit_rounded,
                      height: 40,
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductFormScreen(product: product),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showServiceDetailSheet(dynamic service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(service.serviceName, style: AppTextStyles.titleMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                ),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tarif Jasa: ${CurrencyFormatter.format(service.finalPrice)}', style: AppTextStyles.bodyMedium),
            if (_authStore.isOwner)
              Text('Modal Bahan: ${CurrencyFormatter.format(service.materialCost)}', style: AppTextStyles.bodyMedium),
            Text('Estimasi: ${service.durationValue} ${service.durationUnit}', style: AppTextStyles.bodyMedium),
            if (service.description != null && service.description!.isNotEmpty)
              Text('Keterangan: ${service.description}', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 20),
            if (_authStore.isOwner)
              AppButton(
                label: 'Edit Layanan Jasa',
                variant: AppButtonVariant.outline,
                width: double.infinity,
                height: 40,
                icon: Icons.edit_rounded,
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ServiceFormScreen(service: service),
                    ),
                  );
                },
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
