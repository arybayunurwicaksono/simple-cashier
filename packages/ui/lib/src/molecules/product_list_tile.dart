import 'dart:io';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../atoms/app_badge.dart';
import '../atoms/currency_text.dart';
import 'product_card.dart';

class ProductListTile extends StatelessWidget {
  final String name;
  final String? sku;
  final int sellingPrice;
  final int? costPrice;
  final int stock;
  final int minStockAlert;
  final String? photoPath;
  final String unit;
  final ProductCardMode mode;
  final int cartQuantity;
  final VoidCallback onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const ProductListTile({
    super.key,
    required this.name,
    this.sku,
    required this.sellingPrice,
    this.costPrice,
    required this.stock,
    this.minStockAlert = 5,
    this.photoPath,
    this.unit = 'pcs',
    this.mode = ProductCardMode.pos,
    this.cartQuantity = 0,
    required this.onTap,
    this.onAddToCart,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final remainingStock = stock - cartQuantity;
    final isMaxInCart = remainingStock <= 0;
    final isLowStock = remainingStock <= minStockAlert && remainingStock > 0;
    final isOutOfStock = stock <= 0;
    final isDark = AppColors.isDark(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: cartQuantity > 0
                ? (isDark ? AppColors.primaryDarkAccent : AppColors.primaryLight)
                : AppColors.border(context),
            width: cartQuantity > 0 ? 1.6 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: cartQuantity > 0
                  ? AppColors.primaryLight.withValues(alpha: 0.10)
                  : Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Thumbnail
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isDark ? AppColors.backgroundDark : const Color(0xFFF1F5F9),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildImage(),
                  if (isOutOfStock)
                    Container(
                      color: Colors.black.withValues(alpha: 0.55),
                      child: const Center(
                        child: Text(
                          'HABIS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Center Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                      color: AppColors.textPrimary(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      if (sku != null && sku!.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.borderDark : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            sku!,
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary(context),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      if (isOutOfStock)
                        const AppBadge(label: 'Habis', variant: BadgeVariant.error)
                      else if (mode == ProductCardMode.catalog)
                        if (stock <= minStockAlert)
                          AppBadge(label: 'Sisa $stock', variant: BadgeVariant.warning)
                        else
                          AppBadge(label: '$stock $unit', variant: BadgeVariant.neutral)
                      else
                        if (remainingStock <= 0)
                          const AppBadge(label: 'Maksimal', variant: BadgeVariant.warning)
                        else if (isLowStock)
                          AppBadge(label: 'Sisa $remainingStock', variant: BadgeVariant.warning)
                        else
                          AppBadge(label: 'Sisa $remainingStock $unit', variant: BadgeVariant.neutral),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      CurrencyText(
                        amount: sellingPrice,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.5,
                          color: AppColors.primaryAccent(context),
                        ),
                      ),
                      if (costPrice != null && costPrice! > 0) ...[
                        const SizedBox(width: 8),
                        Text(
                          'Modal: Rp $costPrice',
                          style: TextStyle(
                            fontSize: 10.5,
                            color: AppColors.textMuted(context),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Right Action
            if (mode == ProductCardMode.catalog)
              Icon(Icons.chevron_right_rounded, color: AppColors.textMuted(context), size: 22)
            else ...[
              if (cartQuantity == 0)
                Material(
                  color: isOutOfStock
                      ? (isDark ? AppColors.borderDark : AppColors.borderLight)
                      : const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: isOutOfStock ? null : onAddToCart,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add_shopping_cart_rounded,
                            size: 16,
                            color: isOutOfStock ? AppColors.textMuted(context) : Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Pilih',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isOutOfStock ? AppColors.textMuted(context) : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.cardDark : const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primaryLight, width: 1.2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: onDecrement,
                        borderRadius: BorderRadius.circular(8),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                          child: Icon(Icons.remove_rounded, size: 16, color: AppColors.primaryLight),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '$cartQuantity',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: isMaxInCart ? null : onIncrement,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                          child: Icon(
                            Icons.add_rounded,
                            size: 16,
                            color: isMaxInCart ? AppColors.textMuted(context) : AppColors.primaryLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (photoPath != null && photoPath!.isNotEmpty) {
      File? file;
      if (ProductCard.customImageResolver != null) {
        file = ProductCard.customImageResolver!(photoPath);
      }
      file ??= File(photoPath!);

      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildFallback(),
        );
      }
    }
    return _buildFallback();
  }

  Widget _buildFallback() {
    return Container(
      color: const Color(0xFFE0E7FF),
      child: const Center(
        child: Icon(Icons.inventory_2_rounded, size: 28, color: Color(0xFF4F46E5)),
      ),
    );
  }
}
