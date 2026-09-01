import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/product_store.dart';
import '../../stores/service_store.dart';
import '../../stores/pos_store.dart';
import 'product_form_screen.dart';
import 'service_form_screen.dart';
import 'restock_dialog.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _productStore = getIt<ProductStore>();
  final _serviceStore = getIt<ServiceStore>();
  final _posStore = getIt<PosStore>();
  final _searchController = TextEditingController();

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
      appBar: AppBar(
        title: const Text('Katalog Barang & Jasa'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A),
          labelColor: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A),
          unselectedLabelColor: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          tabs: const [
            Tab(icon: Icon(Icons.inventory_2_outlined, size: 20), text: 'Barang Fisik'),
            Tab(icon: Icon(Icons.build_circle_outlined, size: 20), text: 'Jasa & Layanan'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: AppSearchBar(
              controller: _searchController,
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
            message: 'Silakan tambahkan data produk atau barang dagangan Anda',
            icon: Icons.inventory_2_outlined,
            actionLabel: 'Tambah Barang Baru',
            onActionPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProductFormScreen()),
              );
            },
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossCount = constraints.maxWidth > 500 ? 3 : 2;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 80),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                childAspectRatio: 0.80,
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
                  stock: item.stock,
                  minStockAlert: item.minStockAlert,
                  photoPath: item.photoPath,
                  unit: item.unit,
                  onTap: () {
                    _showProductDetailSheet(item);
                  },
                  onAddToCart: () {
                    _posStore.addProductToCart(item);
                    AppNotification.showSuccess(
                      context,
                      '${item.name} dimasukkan ke keranjang',
                      duration: const Duration(milliseconds: 1500),
                    );
                  },
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
            message: 'Silakan tambahkan jenis jasa atau layanan yang toko Anda sediakan',
            icon: Icons.build_circle_outlined,
            actionLabel: 'Tambah Jasa Baru',
            onActionPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ServiceFormScreen()),
              );
            },
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossCount = constraints.maxWidth > 500 ? 3 : 2;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 80),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                childAspectRatio: 0.80,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: items.length,
              itemBuilder: (ctx, i) {
                final item = items[i];
                return ServiceCard(
                  serviceName: item.serviceName,
                  finalPrice: item.finalPrice,
                  durationValue: item.durationValue,
                  durationUnit: item.durationUnit,
                  description: item.description,
                  onTap: () {
                    _showServiceDetailSheet(item);
                  },
                  onAddToCart: () {
                    _posStore.addServiceToCart(item);
                    AppNotification.showSuccess(
                      context,
                      '${item.serviceName} dimasukkan ke keranjang',
                      duration: const Duration(milliseconds: 1500),
                    );
                  },
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
            Text(product.name, style: AppTextStyles.titleMedium),
            const SizedBox(height: 8),
            Text('SKU / Kode: ${product.sku ?? "-"}', style: AppTextStyles.bodyMedium),
            Text('Harga Beli / Modal: ${CurrencyFormatter.format(product.costPrice)}', style: AppTextStyles.bodyMedium),
            Text('Harga Jual: ${CurrencyFormatter.format(product.sellingPrice)}', style: AppTextStyles.bodyMedium),
            Text('Sisa Stok: ${product.stock} ${product.unit}', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Restock',
                    variant: AppButtonVariant.secondary,
                    icon: Icons.add_business,
                    height: 40,
                    onPressed: () {
                      Navigator.pop(ctx);
                      RestockDialog.show(context, product: product);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AppButton(
                    label: 'Edit',
                    variant: AppButtonVariant.outline,
                    icon: Icons.edit,
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
            Text(service.serviceName, style: AppTextStyles.titleMedium),
            const SizedBox(height: 8),
            Text('Tarif Jasa: ${CurrencyFormatter.format(service.finalPrice)}', style: AppTextStyles.bodyMedium),
            Text('Modal Bahan: ${CurrencyFormatter.format(service.materialCost)}', style: AppTextStyles.bodyMedium),
            Text('Estimasi: ${service.durationValue} ${service.durationUnit}', style: AppTextStyles.bodyMedium),
            if (service.description != null && service.description!.isNotEmpty)
              Text('Keterangan: ${service.description}', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 20),
            AppButton(
              label: 'Edit Jasa',
              variant: AppButtonVariant.outline,
              width: double.infinity,
              height: 40,
              icon: Icons.edit,
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
