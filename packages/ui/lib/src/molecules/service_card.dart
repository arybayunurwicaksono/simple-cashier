import 'dart:io';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../atoms/app_badge.dart';
import '../atoms/currency_text.dart';

enum ServiceCardMode {
  catalog,
  pos,
}

class ServiceCard extends StatelessWidget {
  final String serviceName;
  final int finalPrice;
  final int? materialCost;
  final int durationValue;
  final String durationUnit;
  final String? description;
  final String? photoPath;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final int cartQuantity;
  final ServiceCardMode mode;

  const ServiceCard({
    super.key,
    required this.serviceName,
    required this.finalPrice,
    this.materialCost,
    required this.durationValue,
    required this.durationUnit,
    this.description,
    this.photoPath,
    this.onTap,
    this.onAddToCart,
    this.onIncrement,
    this.onDecrement,
    this.cartQuantity = 0,
    this.mode = ServiceCardMode.catalog,
  });

  String _formatDuration() {
    switch (durationUnit) {
      case 'minutes':
        return '$durationValue mnt';
      case 'hours':
        return '$durationValue jam';
      case 'days':
        return '$durationValue hari';
      default:
        return '$durationValue hari';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: cartQuantity > 0
                ? (isDark ? AppColors.infoDark : AppColors.info)
                : AppColors.border(context),
            width: cartQuantity > 0 ? 1.8 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: cartQuantity > 0
                  ? AppColors.info.withValues(alpha: 0.12)
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
                  Positioned(
                    top: 6,
                    left: 6,
                    right: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.65),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.build_rounded, size: 12, color: Colors.white),
                        ),
                        AppBadge(
                          label: _formatDuration(),
                          variant: BadgeVariant.info,
                          icon: Icons.timer_outlined,
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
                    Text(
                      serviceName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.textPrimary(context),
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (mode == ServiceCardMode.catalog) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (materialCost != null && materialCost! > 0)
                                  Text(
                                    'Bahan: Rp $materialCost',
                                    style: TextStyle(
                                      fontSize: 9.5,
                                      color: AppColors.textSecondary(context),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                CurrencyText(
                                  amount: finalPrice,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: isDark ? AppColors.infoDark : AppColors.info,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CurrencyText(
                              amount: finalPrice,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5,
                                color: isDark ? AppColors.infoDark : AppColors.info,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          if (cartQuantity == 0)
                            Material(
                              color: AppColors.info,
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                onTap: onAddToCart,
                                borderRadius: BorderRadius.circular(8),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          else
                            Container(
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.cardDark : const Color(0xFFE0F2FE),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.info, width: 1.2),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: onDecrement,
                                    borderRadius: BorderRadius.circular(6),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(Icons.remove_rounded, size: 14, color: AppColors.info),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: Text(
                                      '$cartQuantity',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: AppColors.info,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: onIncrement,
                                    borderRadius: BorderRadius.circular(6),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(Icons.add_rounded, size: 14, color: AppColors.info),
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
          colors: [Color(0xFFE0F2FE), Color(0xFFBAE6FD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.build_circle_rounded,
          size: 32,
          color: Color(0xFF0284C7),
        ),
      ),
    );
  }
}
