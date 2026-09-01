import 'package:flutter/material.dart';
import 'package:core/core.dart';

class SplineAreaChart extends StatelessWidget {
  final String title;
  final String subtitle;
  final int totalRevenue;
  final int productRevenue;
  final int serviceRevenue;
  final double growthPercentage;
  final List<ChartDataPoint> trendPoints;

  const SplineAreaChart({
    super.key,
    required this.title,
    this.subtitle = '',
    required this.totalRevenue,
    required this.productRevenue,
    required this.serviceRevenue,
    this.growthPercentage = 0.0,
    required this.trendPoints,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Title & Ratio Pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    if (subtitle.isNotEmpty) ...[
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
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Ratio Pill (Barang vs Jasa)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.chartTrack(context),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.chartBorder(context),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shopping_bag_outlined, size: 12, color: AppColors.accentBlue),
                    const SizedBox(width: 4),
                    Text(
                      '${totalRevenue > 0 ? ((productRevenue / totalRevenue) * 100).toInt() : 50}%',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.accentBlue),
                    ),
                    Text(' : ', style: TextStyle(fontSize: 11, color: AppColors.textMuted(context))),
                    const Icon(Icons.build_circle_outlined, size: 12, color: AppColors.accentGreen),
                    const SizedBox(width: 4),
                    Text(
                      '${totalRevenue > 0 ? ((serviceRevenue / totalRevenue) * 100).toInt() : 50}%',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.accentGreen),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Total Badge & Growth Pill Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.chartTrack(context),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.chartBorder(context),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Omset Uang Masuk',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary(context),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          CurrencyFormatter.format(totalRevenue),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: growthPercentage >= 0
                        ? AppColors.accentGreen.withValues(alpha: 0.18)
                        : AppColors.accentRed.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        growthPercentage >= 0 ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                        size: 15,
                        color: growthPercentage >= 0 ? AppColors.accentGreenLight : AppColors.accentRedLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${growthPercentage >= 0 ? "+" : ""}${growthPercentage.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: growthPercentage >= 0 ? AppColors.accentGreenLight : AppColors.accentRedLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Spline Area Graph Canvas
          SizedBox(
            height: 140,
            width: double.infinity,
            child: trendPoints.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada data grafik',
                      style: TextStyle(fontSize: 12, color: AppColors.textMuted(context)),
                    ),
                  )
                : CustomPaint(
                    painter: _SplineChartPainter(
                      points: trendPoints,
                      isDark: isDark,
                      primaryColor: AppColors.accentBlue,
                    ),
                  ),
          ),

          const SizedBox(height: 6),

          // Bottom Horizontal Axis Labels
          if (trendPoints.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: trendPoints.map((pt) {
                return Text(
                  pt.label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary(context),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _SplineChartPainter extends CustomPainter {
  final List<ChartDataPoint> points;
  final bool isDark;
  final Color primaryColor;

  _SplineChartPainter({
    required this.points,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final n = points.length;
    final dx = n > 1 ? size.width / (n - 1) : size.width;
    const topPadding = 12.0;
    const bottomPadding = 10.0;
    final chartHeight = size.height - topPadding - bottomPadding;

    final offsets = <Offset>[];
    for (int i = 0; i < n; i++) {
      final x = n > 1 ? i * dx : size.width / 2;
      final normY = (1.0 - points[i].percentage).clamp(0.0, 1.0);
      final y = topPadding + (normY * chartHeight);
      offsets.add(Offset(x, y));
    }

    // 1. Build smooth cubic bezier curve
    final path = Path();
    path.moveTo(offsets[0].dx, offsets[0].dy);

    for (int i = 0; i < offsets.length - 1; i++) {
      final p0 = offsets[i];
      final p1 = offsets[i + 1];

      final controlX = (p0.dx + p1.dx) / 2;
      path.cubicTo(controlX, p0.dy, controlX, p1.dy, p1.dx, p1.dy);
    }

    // 2. Area Gradient under the path
    final fillPath = Path.from(path);
    fillPath.lineTo(offsets.last.dx, size.height);
    fillPath.lineTo(offsets.first.dx, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          primaryColor.withValues(alpha: isDark ? 0.35 : 0.22),
          primaryColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // 3. Stroke Line
    final strokePaint = Paint()
      ..shader = const LinearGradient(
        colors: [AppColors.chartGlow, AppColors.accentBlue, AppColors.accentCyan],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, strokePaint);

    // 4. Draw data glow points
    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final outerGlowPaint = Paint()
      ..color = AppColors.chartGlow.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    for (final off in offsets) {
      canvas.drawCircle(off, 6.0, outerGlowPaint);
      canvas.drawCircle(off, 3.5, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SplineChartPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.isDark != isDark;
  }
}
