import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:core/core.dart';

class CircularDonutChart extends StatelessWidget {
  final String title;
  final String subtitle;
  final int totalSold;
  final int totalIncoming;
  final double percentage; // 0.0 - 100.0
  final Color primaryColor;
  final Color secondaryColor;

  const CircularDonutChart({
    super.key,
    required this.title,
    required this.subtitle,
    required this.totalSold,
    required this.totalIncoming,
    required this.percentage,
    this.primaryColor = AppColors.accentBlue,
    this.secondaryColor = AppColors.accentOrange,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.chartCard(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.chartBorder(context),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Column: Details & Legends
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textSecondary(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),

                // Legend 1: Barang Terjual
                Row(
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withValues(alpha: 0.5),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Terjual: $totalSold unit',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary(context),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Legend 2: Stok Masuk
                Row(
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: secondaryColor.withValues(alpha: 0.5),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Restok: $totalIncoming unit',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary(context),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Right Column: Donut Progress Ring
          Expanded(
            flex: 5,
            child: Center(
              child: SizedBox(
                width: 110,
                height: 110,
                child: CustomPaint(
                  painter: _DonutRingPainter(
                    soldRatio: (totalSold + totalIncoming) > 0
                        ? (totalSold / (totalSold + totalIncoming)).clamp(0.0, 1.0)
                        : 0.5,
                    primaryColor: primaryColor,
                    secondaryColor: secondaryColor,
                    trackColor: AppColors.chartTrack(context),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${percentage.toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                        Icon(
                          percentage >= 50 ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                          size: 18,
                          color: percentage >= 50 ? AppColors.accentGreen : AppColors.accentRed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DonutRingPainter extends CustomPainter {
  final double soldRatio; // 0.0 - 1.0
  final Color primaryColor;
  final Color secondaryColor;
  final Color trackColor;

  _DonutRingPainter({
    required this.soldRatio,
    required this.primaryColor,
    required this.secondaryColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 16) / 2;
    const strokeWidth = 12.0;

    // 1. Background Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);

    // 2. Secondary Arc (Restock)
    final secPaint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    const totalSweep = 2 * math.pi;

    canvas.drawArc(rect, startAngle, totalSweep, false, secPaint);

    // 3. Primary Arc (Sold)
    final primSweep = totalSweep * soldRatio;
    final primPaint = Paint()
      ..shader = LinearGradient(
        colors: [primaryColor, AppColors.chartGlow],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, primSweep, false, primPaint);
  }

  @override
  bool shouldRepaint(covariant _DonutRingPainter oldDelegate) {
    return oldDelegate.soldRatio != soldRatio ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.trackColor != trackColor;
  }
}
