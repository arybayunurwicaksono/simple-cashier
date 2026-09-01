import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette (Deep Navy & Sapphire)
  static const Color primary = Color(0xFF1E3A8A);
  static const Color primaryDark = Color(0xFF0F172A);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryContainer = Color(0xFFDBEAFE);
  static const Color primaryDarkAccent = Color(0xFF60A5FA);
  static const Color primaryContainerDark = Color(0xFF1E3A8A);

  // Secondary Accent (Emerald Green & Teal for POS success / profit)
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryDark = Color(0xFF047857);
  static const Color secondaryLight = Color(0xFF34D399);
  static const Color secondaryContainer = Color(0xFFD1FAE5);
  static const Color secondaryContainerDark = Color(0xFF064E3B);

  // Semantic Colors
  static const Color success = Color(0xFF16A34A);
  static const Color successDark = Color(0xFF10B981);
  static const Color successContainer = Color(0xFFDCFCE7);
  static const Color successContainerDark = Color(0xFF064E3B);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningDark = Color(0xFFFBBF24);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color warningContainerDark = Color(0xFF451A03);

  static const Color error = Color(0xFFDC2626);
  static const Color errorDark = Color(0xFFF87171);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color errorContainerDark = Color(0xFF450A0A);

  static const Color info = Color(0xFF0284C7);
  static const Color infoDark = Color(0xFF38BDF8);
  static const Color infoContainer = Color(0xFFE0F2FE);
  static const Color infoContainerDark = Color(0xFF0C4A6E);

  // Neutral Colors (Light Theme)
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderSubtleLight = Color(0xFFCBD5E1);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textMutedLight = Color(0xFF94A3B8);

  // Neutral Colors (Dark Theme)
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color borderDark = Color(0xFF334155);
  static const Color borderSubtleDark = Color(0xFF475569);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF64748B);

  // Chart & Analytics Theming Tokens
  static const Color chartGlow = Color(0xFF60A5FA);
  static const Color chartFillBottom = Color(0xFF1D4ED8);
  static const Color chartFillTop = Color(0xFF60A5FA);
  static const Color chartFillNegativeBottom = Color(0xFFB91C1C);
  static const Color chartFillNegativeTop = Color(0xFFF87171);
  static const Color chartTrackDark = Color(0xFF0F172A);
  static const Color chartTrackLight = Color(0xFFF1F5F9);
  static const Color chartCardDark = Color(0xFF192238);
  static const Color chartCardLight = Color(0xFFFFFFFF);
  static const Color chartBorderDark = Color(0xFF26334D);
  static const Color chartBorderLight = Color(0xFFE2E8F0);
  static const Color accentOrange = Color(0xFFF97316);
  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentBlueLight = Color(0xFF60A5FA);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentGreenLight = Color(0xFF34D399);
  static const Color accentRed = Color(0xFFEF4444);
  static const Color accentRedLight = Color(0xFFF87171);

  // ==========================================
  // Adaptive Dynamic Theme Helper Methods
  // ==========================================
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color textPrimary(BuildContext context) =>
      isDark(context) ? textPrimaryDark : textPrimaryLight;

  static Color textSecondary(BuildContext context) =>
      isDark(context) ? textSecondaryDark : textSecondaryLight;

  static Color textMuted(BuildContext context) =>
      isDark(context) ? textMutedDark : textMutedLight;

  static Color border(BuildContext context) =>
      isDark(context) ? borderDark : borderLight;

  static Color borderSubtle(BuildContext context) =>
      isDark(context) ? borderSubtleDark : borderSubtleLight;

  static Color card(BuildContext context) =>
      isDark(context) ? cardDark : cardLight;

  static Color surface(BuildContext context) =>
      isDark(context) ? surfaceDark : surfaceLight;

  static Color background(BuildContext context) =>
      isDark(context) ? backgroundDark : backgroundLight;

  static Color primaryAccent(BuildContext context) =>
      isDark(context) ? primaryDarkAccent : primary;

  static Color primaryContainerAdaptive(BuildContext context) =>
      isDark(context) ? primaryContainerDark : primaryContainer;

  static Color secondaryContainerAdaptive(BuildContext context) =>
      isDark(context) ? secondaryContainerDark : secondaryContainer;

  static Color successContainerAdaptive(BuildContext context) =>
      isDark(context) ? successContainerDark : successContainer;

  static Color errorContainerAdaptive(BuildContext context) =>
      isDark(context) ? errorContainerDark : errorContainer;

  static Color infoContainerAdaptive(BuildContext context) =>
      isDark(context) ? infoContainerDark : infoContainer;

  static Color warningContainerAdaptive(BuildContext context) =>
      isDark(context) ? warningContainerDark : warningContainer;

  static Color chartCard(BuildContext context) =>
      isDark(context) ? chartCardDark : chartCardLight;

  static Color chartBorder(BuildContext context) =>
      isDark(context) ? chartBorderDark : chartBorderLight;

  static Color chartTrack(BuildContext context) =>
      isDark(context) ? chartTrackDark : chartTrackLight;
}

extension AppThemeContextExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  Color get textPrimaryColor => AppColors.textPrimary(this);
  Color get textSecondaryColor => AppColors.textSecondary(this);
  Color get textMutedColor => AppColors.textMuted(this);
  Color get borderColor => AppColors.border(this);
  Color get borderSubtleColor => AppColors.borderSubtle(this);
  Color get cardBgColor => AppColors.card(this);
  Color get primaryAccentColor => AppColors.primaryAccent(this);
  Color get chartCardBg => AppColors.chartCard(this);
  Color get chartBorderColor => AppColors.chartBorder(this);
  Color get chartTrackColor => AppColors.chartTrack(this);
}
