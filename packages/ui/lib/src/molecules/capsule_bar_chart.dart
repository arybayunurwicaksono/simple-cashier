import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'package:core/core.dart';

class CapsuleBarChart extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<ChartDataPoint> dataPoints;
  final String? badgeLabel;
  final Function(ChartDataPoint point)? onBarTap;

  const CapsuleBarChart({
    super.key,
    required this.title,
    this.subtitle = '',
    required this.dataPoints,
    this.badgeLabel,
    this.onBarTap,
  });

  @override
  State<CapsuleBarChart> createState() => _CapsuleBarChartState();
}

class _CapsuleBarChartState extends State<CapsuleBarChart> {
  int? _selectedIndex;

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
          // Header Row: Title & Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary(context),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.subtitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle,
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
              if (widget.badgeLabel != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentBlue.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.accentBlue.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accentBlue,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.badgeLabel!,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.chartGlow,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 16),

          // Selected Tooltip if tapped
          if (_selectedIndex != null && _selectedIndex! < widget.dataPoints.length) ...[
            Builder(
              builder: (ctx) {
                final pt = widget.dataPoints[_selectedIndex!];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainerAdaptive(context).withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primaryDarkAccent.withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${pt.label}: ',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: isDark ? Colors.white70 : AppColors.textPrimaryLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        CurrencyFormatter.format(pt.value),
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppColors.chartGlow : AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],

          // Horizontal Scrollable Capsule Cylinder Bars
          SizedBox(
            height: 190,
            child: widget.dataPoints.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada data untuk periode ini',
                      style: TextStyle(fontSize: 12, color: AppColors.textMuted(context)),
                    ),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.dataPoints.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemBuilder: (ctx, i) {
                      final point = widget.dataPoints[i];
                      final isSelected = _selectedIndex == i;
                      final fillPct = point.percentage.clamp(0.05, 1.0);
                      final displayPercentText = '${(point.percentage * 100).toInt()}%';

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = isSelected ? null : i;
                          });
                          widget.onBarTap?.call(point);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 240),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Percentage text on top of capsule
                              Text(
                                point.value > 0 ? displayPercentText : '0%',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                  color: isSelected
                                      ? AppColors.chartGlow
                                      : (isDark ? AppColors.textPrimaryDark : AppColors.textSecondaryLight),
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Capsule Cylinder Bar Tube
                              Container(
                                width: 38,
                                height: 132,
                                decoration: BoxDecoration(
                                  color: AppColors.chartTrack(context),
                                  borderRadius: BorderRadius.circular(19),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.chartGlow
                                        : AppColors.chartBorder(context),
                                    width: isSelected ? 1.8 : 1.0,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: AppColors.accentBlue.withValues(alpha: 0.4),
                                            blurRadius: 10,
                                            offset: const Offset(0, 0),
                                          ),
                                        ]
                                      : null,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    // Animated Cylinder Fill
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(begin: 0.0, end: fillPct),
                                      duration: const Duration(milliseconds: 600),
                                      curve: Curves.easeOutCubic,
                                      builder: (context, value, child) {
                                        return FractionallySizedBox(
                                          heightFactor: value,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(19),
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: point.value >= 0
                                                    ? [
                                                        AppColors.chartFillBottom,
                                                        AppColors.accentBlue,
                                                        AppColors.chartFillTop,
                                                      ]
                                                    : [
                                                        AppColors.chartFillNegativeBottom,
                                                        AppColors.accentRed,
                                                        AppColors.chartFillNegativeTop,
                                                      ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: (point.value >= 0
                                                          ? AppColors.accentBlue
                                                          : AppColors.accentRed)
                                                      .withValues(alpha: 0.4),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, -2),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Month / Period Label at bottom
                              Text(
                                point.label,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: isSelected
                                      ? AppColors.chartGlow
                                      : AppColors.textSecondary(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
