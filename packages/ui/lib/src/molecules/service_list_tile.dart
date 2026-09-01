import 'dart:io';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../atoms/app_badge.dart';
import '../atoms/currency_text.dart';
import 'service_card.dart';

class ServiceListTile extends StatelessWidget {
  final String serviceName;
  final int finalPrice;
  final int? materialCost;
  final int durationValue;
  final String durationUnit;
  final String? description;
  final String? photoPath;
  final ServiceCardMode mode;
  final int cartQuantity;
  final VoidCallback onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const ServiceListTile({
    super.key,
    required this.serviceName,
    required this.finalPrice,
    this.materialCost,
    required this.durationValue,
    this.durationUnit = 'days',
    this.description,
    this.photoPath,
    this.mode = ServiceCardMode.pos,
    this.cartQuantity = 0,
    required this.onTap,
    this.onAddToCart,
    this.onIncrement,
    this.onDecrement,
  });

  String _formatDuration() {
    switch (durationUnit) {
      case 'minutes':
        return '$durationValue mnt';
      case 'hours':
        return '$durationValue jam';
      case 'days':
      default:
        return '$durationValue hari';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                ? (isDark ? AppColors.infoDark : AppColors.info)
                : AppColors.border(context),
            width: cartQuantity > 0 ? 1.6 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: cartQuantity > 0
                  ? AppColors.info.withValues(alpha: 0.10)
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
                color: isDark ? AppColors.backgroundDark : const Color(0xFFF0F9FF),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildImage(),
                  Positioned(
                    bottom: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.timer_outlined, size: 9, color: Colors.white),
                          const SizedBox(width: 2),
                          Text(
                            _formatDuration(),
                            style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
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
                    serviceName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                      color: AppColors.textPrimary(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (description != null && description!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      description!,
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary(context)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ] else ...[
                    const SizedBox(height: 2),
                    const AppBadge(
                      label: 'Jasa & Pengerjaan',
                      variant: BadgeVariant.info,
                    ),
                  ],
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      CurrencyText(
                        amount: finalPrice,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.5,
                          color: isDark ? AppColors.infoDark : AppColors.info,
                        ),
                      ),
                      if (materialCost != null && materialCost! > 0) ...[
                        const SizedBox(width: 8),
                        Text(
                          'Bahan: Rp $materialCost',
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
            if (mode == ServiceCardMode.catalog)
              Icon(Icons.chevron_right_rounded, color: AppColors.textMuted(context), size: 22)
            else ...[
              if (cartQuantity == 0)
                Material(
                  color: AppColors.info,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: onAddToCart,
                    borderRadius: BorderRadius.circular(10),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Pilih',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                    color: isDark ? AppColors.cardDark : const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.info, width: 1.2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: onDecrement,
                        borderRadius: BorderRadius.circular(8),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                          child: Icon(Icons.remove_rounded, size: 16, color: AppColors.info),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '$cartQuantity',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppColors.info,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onIncrement,
                        borderRadius: BorderRadius.circular(8),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                          child: Icon(
                            Icons.add_rounded,
                            size: 16,
                            color: AppColors.info,
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
      if (ServiceCard.customImageResolver != null) {
        file = ServiceCard.customImageResolver!(photoPath);
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
      color: const Color(0xFFE0F2FE),
      child: const Center(
        child: Icon(Icons.build_circle_rounded, size: 28, color: Color(0xFF0284C7)),
      ),
    );
  }
}
