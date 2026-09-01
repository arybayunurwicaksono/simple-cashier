import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/product_store.dart';
import '../../stores/service_store.dart';
import '../../stores/pos_store.dart';
import 'cart_screen.dart';

class NewTransactionPosScreen extends StatefulWidget {
  const NewTransactionPosScreen({super.key});

  @override
  State<NewTransactionPosScreen> createState() => _NewTransactionPosScreenState();
}

class _NewTransactionPosScreenState extends State<NewTransactionPosScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _productStore = getIt<ProductStore>();
  final _serviceStore = getIt<ServiceStore>();
  final _posStore = getIt<PosStore>();
  final _searchController = TextEditingController();

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
      appBar: AppBar(
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kasir POS Transaksi Baru',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Pilih produk atau jasa untuk keranjang belanja',
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryAccent(context),
          labelColor: AppColors.primaryAccent(context),
          unselectedLabelColor: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          tabs: const [
            Tab(icon: Icon(Icons.inventory_2_outlined, size: 20), text: 'Barang'),
            Tab(icon: Icon(Icons.build_circle_outlined, size: 20), text: 'Jasa'),
          ],
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (_) {
          if (_posStore.cartItems.isEmpty) return const SizedBox.shrink();

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                top: BorderSide(
                  color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0F172A) : const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Badge(
                      label: Text('${_posStore.totalCartItemCount}'),
                      child: Icon(Icons.shopping_bag_rounded, color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A), size: 22),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total Pesanan',
                          style: TextStyle(fontSize: 10.5, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                        ),
                        CurrencyText(
                          amount: _posStore.totalAmount,
                          style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold, color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A)),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_checkout_rounded, size: 18),
                    label: const Text('Bayar Sekarang', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            child: Row(
              children: [
                Expanded(
                  child: AppSearchBar(
                    controller: _searchController,
                    hint: 'Cari barang / jasa untuk kasir...',
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
                _buildProductsGrid(),
                _buildServicesGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
    return Observer(
      builder: (_) {
        if (_productStore.isLoading && _productStore.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = _productStore.filteredProducts;

        if (items.isEmpty) {
          return const EmptyStateView(
            title: 'Barang Tidak Ditemukan',
            message: 'Silakan tambah produk baru di menu Katalog',
            icon: Icons.inventory_2_outlined,
          );
        }

        if (!_isGridView) {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final item = items[i];

              return Observer(
                builder: (_) {
                  final cartQty = _posStore.getProductQuantityInCart(item.id);

                  return ProductListTile(
                    name: item.name,
                    sku: item.sku,
                    sellingPrice: item.sellingPrice,
                    stock: item.stock,
                    minStockAlert: item.minStockAlert,
                    photoPath: item.photoPath,
                    unit: item.unit,
                    mode: ProductCardMode.pos,
                    cartQuantity: cartQty,
                    onTap: () {
                      if (item.stock > cartQty) {
                        _posStore.addProductToCart(item);
                      }
                    },
                    onAddToCart: () {
                      _posStore.addProductToCart(item);
                    },
                    onIncrement: () {
                      _posStore.addProductToCart(item);
                    },
                    onDecrement: () {
                      _posStore.removeProductFromCart(item.id);
                    },
                  );
                },
              );
            },
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossCount = constraints.maxWidth > 500 ? 3 : 2;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                childAspectRatio: 0.72,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: items.length,
              itemBuilder: (ctx, i) {
                final item = items[i];

                return Observer(
                  builder: (_) {
                    final cartQty = _posStore.getProductQuantityInCart(item.id);

                    return ProductCard(
                      name: item.name,
                      sku: item.sku,
                      sellingPrice: item.sellingPrice,
                      stock: item.stock,
                      minStockAlert: item.minStockAlert,
                      photoPath: item.photoPath,
                      unit: item.unit,
                      mode: ProductCardMode.pos,
                      cartQuantity: cartQty,
                      onTap: () {
                        if (item.stock > cartQty) {
                          _posStore.addProductToCart(item);
                        }
                      },
                      onAddToCart: () {
                        _posStore.addProductToCart(item);
                      },
                      onIncrement: () {
                        _posStore.addProductToCart(item);
                      },
                      onDecrement: () {
                        _posStore.removeProductFromCart(item.id);
                      },
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

  Widget _buildServicesGrid() {
    return Observer(
      builder: (_) {
        if (_serviceStore.isLoading && _serviceStore.services.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = _serviceStore.filteredServices;

        if (items.isEmpty) {
          return const EmptyStateView(
            title: 'Jasa Tidak Ditemukan',
            message: 'Silakan tambah data jasa baru di menu Katalog',
            icon: Icons.build_circle_outlined,
          );
        }

        if (!_isGridView) {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final item = items[i];

              return Observer(
                builder: (_) {
                  final cartQty = _posStore.getServiceQuantityInCart(item.id);

                  return ServiceListTile(
                    serviceName: item.serviceName,
                    finalPrice: item.finalPrice,
                    durationValue: item.durationValue,
                    durationUnit: item.durationUnit,
                    description: item.description,
                    photoPath: item.photoPath,
                    mode: ServiceCardMode.pos,
                    cartQuantity: cartQty,
                    onTap: () {
                      _posStore.addServiceToCart(item);
                    },
                    onAddToCart: () {
                      _posStore.addServiceToCart(item);
                    },
                    onIncrement: () {
                      _posStore.addServiceToCart(item);
                    },
                    onDecrement: () {
                      _posStore.removeServiceFromCart(item.id);
                    },
                  );
                },
              );
            },
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossCount = constraints.maxWidth > 500 ? 3 : 2;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                childAspectRatio: 0.72,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: items.length,
              itemBuilder: (ctx, i) {
                final item = items[i];

                return Observer(
                  builder: (_) {
                    final cartQty = _posStore.getServiceQuantityInCart(item.id);

                    return ServiceCard(
                      serviceName: item.serviceName,
                      finalPrice: item.finalPrice,
                      durationValue: item.durationValue,
                      durationUnit: item.durationUnit,
                      description: item.description,
                      photoPath: item.photoPath,
                      mode: ServiceCardMode.pos,
                      cartQuantity: cartQty,
                      onTap: () {
                        _posStore.addServiceToCart(item);
                      },
                      onAddToCart: () {
                        _posStore.addServiceToCart(item);
                      },
                      onIncrement: () {
                        _posStore.addServiceToCart(item);
                      },
                      onDecrement: () {
                        _posStore.removeServiceFromCart(item.id);
                      },
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
}
