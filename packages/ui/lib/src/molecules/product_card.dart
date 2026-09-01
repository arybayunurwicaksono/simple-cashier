import 'dart:io';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../atoms/app_badge.dart';
import '../atoms/currency_text.dart';

enum ProductCardMode {
  catalog,
  pos,
}

class ProductCard extends StatelessWidget {
  final String name;
  final String? sku;
  final int sellingPrice;
  final int? costPrice;
  final int stock;
  final int minStockAlert;
  final String? photoPath;
  final String unit;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final int cartQuantity;
  final ProductCardMode mode;

  const ProductCard({
    super.key,
    required this.name,
    this.sku,
    required this.sellingPrice,
    this.costPrice,
    required this.stock,
    this.minStockAlert = 5,
    this.photoPath,
    this.unit = 'pcs',
    this.onTap,
    this.onAddToCart,
    this.onIncrement,
    this.onDecrement,
    this.cartQuantity = 0,
    this.mode = ProductCardMode.catalog,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final remainingStock = stock - cartQuantity;
    final isLowStock = remainingStock <= minStockAlert && remainingStock > 0;
    final isMaxInCart = cartQuantity >= stock;

    return InkWell(
      onTap: onTap ?? (mode == ProductCardMode.pos && stock > 0 && !isMaxInCart ? onAddToCart : null),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: cartQuantity > 0
                ? (isDark ? AppColors.primaryDarkAccent : AppColors.primaryLight)
                : AppColors.border(context),
            width: cartQuantity > 0 ? 1.8 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: cartQuantity > 0
                  ? AppColors.primaryLight.withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Thumbnail Section
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildImagePreview(),
                  // Top Overlay for badges
                  Positioned(
                    top: 6,
                    left: 6,
                    right: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (sku != null && sku!.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.65),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              sku!,
                              style: const TextStyle(fontSize: 9.5, color: Colors.white, fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        if (stock <= 0)
                          const AppBadge(label: 'Habis', variant: BadgeVariant.error)
                        else if (mode == ProductCardMode.catalog)
                          if (stock <= minStockAlert)
                            AppBadge(label: 'Sisa $stock', variant: BadgeVariant.warning)
                          else
                            AppBadge(label: '$stock $unit', variant: BadgeVariant.neutral)
                        else
                          // POS Mode (Live reactive remaining stock)
                          if (remainingStock <= 0)
                            const AppBadge(label: 'Maksimal', variant: BadgeVariant.warning)
                          else if (isLowStock)
                            AppBadge(label: 'Sisa $remainingStock', variant: BadgeVariant.warning)
                          else
                            AppBadge(
                              label: 'Sisa $remainingStock $unit',
                              variant: BadgeVariant.neutral,
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Information Section
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product Title
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.textPrimary(context),
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Price & Action row
                    if (mode == ProductCardMode.catalog) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (costPrice != null && costPrice! > 0)
                                  Text(
                                    'Modal: Rp $costPrice',
                                    style: TextStyle(
                                      fontSize: 9.5,
                                      color: AppColors.textSecondary(context),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                CurrencyText(
                                  amount: sellingPrice,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: AppColors.primaryAccent(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.borderDark : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(Icons.more_horiz, size: 16, color: AppColors.textSecondary(context)),
                          ),
                        ],
                      ),
                    ] else ...[
                      // POS Mode: Selling price and [+] / [- qty +] Stepper
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CurrencyText(
                              amount: sellingPrice,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5,
                                color: AppColors.primaryAccent(context),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          if (cartQuantity == 0)
                            Material(
                              color: stock <= 0
                                  ? (isDark ? AppColors.borderDark : AppColors.borderLight)
                                  : const Color(0xFF2563EB),
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                onTap: stock <= 0 ? null : onAddToCart,
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add_rounded,
                                        size: 14,
                                        color: stock <= 0 ? AppColors.textMuted(context) : Colors.white,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        'Pilih',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: stock <= 0 ? AppColors.textMuted(context) : Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          else
                            // Quantity Stepper
                            Container(
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.cardDark : const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.primaryLight, width: 1.2),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: onDecrement,
                                    borderRadius: BorderRadius.circular(6),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(Icons.remove_rounded, size: 14, color: AppColors.primaryLight),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: Text(
                                      '$cartQuantity',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: AppColors.primaryLight,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: isMaxInCart ? null : onIncrement,
                                    borderRadius: BorderRadius.circular(6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.add_rounded,
                                        size: 14,
                                        color: isMaxInCart ? AppColors.textMuted(context) : AppColors.primaryLight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static File? Function(String?)? customImageResolver;

  Widget _buildImagePreview() {
    if (photoPath != null && photoPath!.isNotEmpty) {
      File? file;
      if (customImageResolver != null) {
        file = customImageResolver!(photoPath);
      }
      file ??= File(photoPath!);

      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildFallbackArtwork(),
        );
      }
    }
    return _buildFallbackArtwork();
  }

  Widget _buildFallbackArtwork() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE0E7FF), Color(0xFFC7D2FE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.inventory_2_rounded,
          size: 32,
          color: Color(0xFF4F46E5),
        ),
      ),
    );
  }
}
