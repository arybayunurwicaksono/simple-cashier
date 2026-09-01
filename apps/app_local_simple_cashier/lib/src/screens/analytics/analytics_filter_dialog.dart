import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../../stores/analytics_store.dart';

class AnalyticsFilterDialog extends StatefulWidget {
  final AnalyticsStore store;

  const AnalyticsFilterDialog({
    super.key,
    required this.store,
  });

  static Future<void> show(BuildContext context, AnalyticsStore store) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AnalyticsFilterDialog(store: store),
    );
  }

  @override
  State<AnalyticsFilterDialog> createState() => _AnalyticsFilterDialogState();
}

class _AnalyticsFilterDialogState extends State<AnalyticsFilterDialog> {
  late String _tempFilter;
  late int _tempYear;
  late int _tempMonth;

  final List<String> _monthNames = const [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
  ];

  @override
  void initState() {
    super.initState();
    _tempFilter = widget.store.timeFilter;
    _tempYear = widget.store.selectedYear;
    _tempMonth = widget.store.selectedMonth;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentYear = DateTime.now().year;
    final availableYears = [
      currentYear - 3,
      currentYear - 2,
      currentYear - 1,
      currentYear,
      currentYear + 1,
    ];

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1.5,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? AppColors.borderDark : AppColors.borderSubtleLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header: Title & Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccent(context).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.tune_rounded,
                      size: 20,
                      color: AppColors.primaryAccent(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Filter Analisis Bisnis',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Section 1: Tipe Rentang
          Text(
            'Tipe Rentang Waktu',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary(context),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildTypeChip('yearly', 'Tahunan'),
              const SizedBox(width: 8),
              _buildTypeChip('monthly', 'Bulanan'),
              const SizedBox(width: 8),
              _buildTypeChip('weekly', '7 Hari Terakhir'),
            ],
          ),

          // Section 2: Pilih Tahun (Only if yearly or monthly)
          if (_tempFilter != 'weekly') ...[
            const SizedBox(height: 18),
            Text(
              'Pilih Tahun',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary(context),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: availableYears.map((yr) {
                  final isSelected = _tempYear == yr;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        '$yr',
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? Colors.white
                              : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: isDark ? AppColors.accentBlue : AppColors.primary,
                      backgroundColor: isDark ? AppColors.chartTrackDark : AppColors.chartTrackLight,
                      onSelected: (selected) {
                        if (selected) setState(() => _tempYear = yr);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          // Section 3: Pilih Bulan (Only if monthly)
          if (_tempFilter == 'monthly') ...[
            const SizedBox(height: 18),
            Text(
              'Pilih Bulan ($_tempYear)',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary(context),
              ),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 12,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2.2,
              ),
              itemBuilder: (ctx, idx) {
                final monthNum = idx + 1;
                final isSelected = _tempMonth == monthNum;
                return GestureDetector(
                  onTap: () => setState(() => _tempMonth = monthNum),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark ? AppColors.accentBlue : AppColors.primary)
                          : (isDark ? AppColors.chartTrackDark : AppColors.chartTrackLight),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.chartGlow
                            : (isDark ? AppColors.borderDark : AppColors.borderLight),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _monthNames[idx],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : (isDark ? AppColors.textPrimaryDark : AppColors.textSecondaryLight),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? AppColors.accentBlue : AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    widget.store.selectedYear = _tempYear;
                    widget.store.selectedMonth = _tempMonth;
                    widget.store.timeFilter = _tempFilter;
                    await widget.store.loadAnalytics();
                  },
                  child: const Text('Terapkan Filter', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip(String filterKey, String label) {
    final isSelected = _tempFilter == filterKey;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tempFilter = filterKey),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? AppColors.accentBlue : AppColors.primary)
                : (isDark ? AppColors.chartTrackDark : AppColors.chartTrackLight),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? AppColors.chartGlow
                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
