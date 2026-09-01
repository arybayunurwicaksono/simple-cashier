import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/product_store.dart';
import '../../stores/service_store.dart';
import '../../stores/pos_store.dart';
import 'cart_screen.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('Kasir POS'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A),
          labelColor: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A),
          unselectedLabelColor: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
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
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                  blurRadius: 10,
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Badge(
                      label: Text('${_posStore.totalCartItemCount}'),
                      child: Icon(Icons.shopping_bag_outlined, color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A), size: 20),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total Pesanan',
                          style: TextStyle(fontSize: 10, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                        ),
                        CurrencyText(
                          amount: _posStore.totalAmount,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A)),
                        ),
                      ],
                    ),
                  ),
                  AppButton(
                    label: 'Keranjang',
                    height: 38,
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: AppSearchBar(
                    controller: _searchController,
                    hint: 'Cari barang / jasa...',
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
            message: 'Silakan tambahkan data barang di menu Katalog',
            icon: Icons.inventory_2_outlined,
          );
        }

        if (!_isGridView) {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
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
                    onAddToCart: () => _posStore.addProductToCart(item),
                    onIncrement: () => _posStore.addProductToCart(item),
                    onDecrement: () => _posStore.removeProductFromCart(item.id),
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
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
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
                      onAddToCart: () => _posStore.addProductToCart(item),
                      onIncrement: () => _posStore.addProductToCart(item),
                      onDecrement: () => _posStore.removeProductFromCart(item.id),
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
            message: 'Silakan tambahkan data jasa di menu Katalog',
            icon: Icons.build_circle_outlined,
          );
        }

        if (!_isGridView) {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
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
                    onTap: () => _posStore.addServiceToCart(item),
                    onAddToCart: () => _posStore.addServiceToCart(item),
                    onIncrement: () => _posStore.addServiceToCart(item),
                    onDecrement: () => _posStore.removeServiceFromCart(item.id),
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
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
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
                      onTap: () => _posStore.addServiceToCart(item),
                      onAddToCart: () => _posStore.addServiceToCart(item),
                      onIncrement: () => _posStore.addServiceToCart(item),
                      onDecrement: () => _posStore.removeServiceFromCart(item.id),
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
