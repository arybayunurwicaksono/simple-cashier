import 'package:flutter/material.dart';

/// Centralized Color System and Design Tokens for Simple Cashier App.
/// Placed within the `ui` package as the single source of truth for all UI styling.
class AppColors {
  // =========================================================================
  // Primary Palette (Deep Navy & Sapphire)
  // =========================================================================
  static const Color primary = Color(0xFF1E3A8A);
  static const Color primaryDark = Color(0xFF0F172A);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryContainer = Color(0xFFDBEAFE);
  static const Color primaryDarkAccent = Color(0xFF60A5FA);
  static const Color primaryContainerDark = Color(0xFF1E3A8A);
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryBlueDark = Color(0xFF1E40AF);
  static const Color primaryBlueSubtle = Color(0xFF93C5FD);
  static const Color primaryBlueLightest = Color(0xFFEFF6FF);

  // =========================================================================
  // Secondary Accent (Emerald Green & Teal for POS success / profit)
  // =========================================================================
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryDark = Color(0xFF047857);
  static const Color secondaryLight = Color(0xFF34D399);
  static const Color secondaryContainer = Color(0xFFD1FAE5);
  static const Color secondaryContainerDark = Color(0xFF064E3B);

  // =========================================================================
  // Semantic Colors
  // =========================================================================
  // Success
  static const Color success = Color(0xFF16A34A);
  static const Color successDark = Color(0xFF10B981);
  static const Color successContainer = Color(0xFFDCFCE7);
  static const Color successContainerDark = Color(0xFF064E3B);
  static const Color successLight = Color(0xFFBBF7D0);
  static const Color successLightest = Color(0xFFF0FDF4);

  // Warning
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningDark = Color(0xFFFBBF24);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color warningContainerDark = Color(0xFF451A03);
  static const Color warningLight = Color(0xFFFDE68A);
  static const Color warningLightest = Color(0xFFFFFBEB);

  // Error & Danger
  static const Color error = Color(0xFFDC2626);
  static const Color errorDark = Color(0xFFF87171);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color errorContainerDark = Color(0xFF450A0A);
  static const Color errorLight = Color(0xFFFECACA);
  static const Color errorSubtle = Color(0xFFFCA5A5);
  static const Color errorDarkest = Color(0xFF7F1D1D);

  // Info & Sky
  static const Color info = Color(0xFF0284C7);
  static const Color infoDark = Color(0xFF38BDF8);
  static const Color infoContainer = Color(0xFFE0F2FE);
  static const Color infoContainerDark = Color(0xFF0C4A6E);
  static const Color infoLight = Color(0xFFBAE6FD);
  static const Color infoSubtle = Color(0xFF7DD3FC);
  static const Color infoLightest = Color(0xFFF0F9FF);
  static const Color infoDarkest = Color(0xFF0369A1);

  // =========================================================================
  // Neutral Scale (Slate Palette)
  // =========================================================================
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // Neutral Mappings - Light Theme
  static const Color backgroundLight = slate50;
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = slate200;
  static const Color borderSubtleLight = slate300;
  static const Color textPrimaryLight = slate900;
  static const Color textSecondaryLight = slate500;
  static const Color textMutedLight = slate400;

  // Neutral Mappings - Dark Theme
  static const Color backgroundDark = slate900;
  static const Color surfaceDark = slate800;
  static const Color cardDark = slate800;
  static const Color borderDark = slate700;
  static const Color borderSubtleDark = slate600;
  static const Color textPrimaryDark = slate50;
  static const Color textSecondaryDark = slate400;
  static const Color textMutedDark = slate500;

  // =========================================================================
  // Domain Specific Palettes (Owner, Cashier, Products, Services)
  // =========================================================================
  // Owner (Emerald)
  static const Color ownerEmerald = Color(0xFF059669);
  static const Color ownerEmeraldLight = Color(0xFF10B981);
  static const Color ownerEmeraldSubtle = Color(0xFF6EE7B7);
  static const Color ownerEmeraldDark = Color(0xFF047857);
  static const Color ownerEmeraldDarkest = Color(0xFF064E3B);
  static const Color ownerBgLight = Color(0xFFECFDF5);
  static const Color ownerBorderLight = Color(0xFFA7F3D0);

  // Cashier (Amber)
  static const Color cashierAmber = Color(0xFFD97706);
  static const Color cashierAmberLight = Color(0xFFF59E0B);
  static const Color cashierAmberDark = Color(0xFFB45309);
  static const Color cashierAmberDarkest = Color(0xFF78350F);
  static const Color cashierAmberContainerDark = Color(0xFF451A03);
  static const Color cashierAmberSubtle = Color(0xFFFDE68A);
  static const Color cashierAmberBorderLight = Color(0xFFFCD34D);
  static const Color cashierBgLight = Color(0xFFFFFBEB);

  // Services (Teal)
  static const Color tealDarkest = Color(0xFF042F2E);
  static const Color tealDark = Color(0xFF0F766E);
  static const Color teal = Color(0xFF0D9488);
  static const Color tealLight = Color(0xFF14B8A6);
  static const Color tealAccent = Color(0xFF2DD4BF);
  static const Color tealSubtle = Color(0xFF5EEAD4);
  static const Color tealLightest = Color(0xFFF0FDFA);

  // Products (Indigo)
  static const Color indigoDark = Color(0xFF4338CA);
  static const Color indigo = Color(0xFF4F46E5);
  static const Color indigoLight = Color(0xFF6366F1);
  static const Color indigoAccent = Color(0xFF818CF8);

  // Analytics & Reports (Purple)
  static const Color purpleDark = Color(0xFF6D28D9);
  static const Color purple = Color(0xFF7C3AED);
  static const Color purpleLight = Color(0xFF8B5CF6);

  // Returns & Expenses (Rose)
  static const Color roseDark = Color(0xFFBE123C);
  static const Color rose = Color(0xFFF43F5E);
  static const Color roseLight = Color(0xFFFB7185);
  static const Color roseContainerLight = Color(0xFFFEE2E8);

  // =========================================================================
  // Chart & Analytics Theming Tokens
  // =========================================================================
  static const Color chartGlow = Color(0xFF60A5FA);
  static const Color chartFillBottom = Color(0xFF1D4ED8);
  static const Color chartFillTop = Color(0xFF60A5FA);
  static const Color chartFillNegativeBottom = Color(0xFFB91C1C);
  static const Color chartFillNegativeTop = Color(0xFFF87171);
  static const Color chartTrackDark = slate900;
  static const Color chartTrackLight = slate100;
  static const Color chartCardDark = Color(0xFF192238);
  static const Color chartCardLight = Color(0xFFFFFFFF);
  static const Color chartBorderDark = Color(0xFF26334D);
  static const Color chartBorderLight = slate200;
  static const Color accentOrange = Color(0xFFF97316);
  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentBlueLight = Color(0xFF60A5FA);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentGreenLight = Color(0xFF34D399);
  static const Color accentRed = Color(0xFFEF4444);
  static const Color accentRedLight = Color(0xFFF87171);

  // =========================================================================
  // Standard Gradient Tokens
  // =========================================================================
  static const List<Color> primaryGradient = [primary, primaryLight];
  static const List<Color> secondaryGradient = [secondaryDark, secondary];
  static const List<Color> ownerGradient = [ownerEmerald, ownerEmeraldLight];
  static const List<Color> cashierGradient = [cashierAmber, cashierAmberLight];
  static const List<Color> tealGradient = [teal, tealLight];
  static const List<Color> indigoGradient = [indigoDark, indigoLight];
  static const List<Color> indigoAltGradient = [indigo, purple];
  static const List<Color> purpleGradient = [purpleDark, purpleLight];
  static const List<Color> roseGradient = [roseDark, rose];
  static const List<Color> blueGradient = [primary, primaryLight];
  static const List<Color> amberGradient = [cashierAmber, cashierAmberLight];
  static const List<Color> skyGradient = [info, infoDark];

  // =========================================================================
  // Adaptive Dynamic Theme Helper Methods
  // =========================================================================
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

  static Color chipBackground(BuildContext context) =>
      isDark(context) ? slate800 : slate100;

  static Color chipBorder(BuildContext context) =>
      isDark(context) ? slate700 : slate200;

  // Role Badge Adaptive Colors
  static Color roleBadgeBg(BuildContext context, {required bool isOwner}) {
    final dark = isDark(context);
    if (isOwner) {
      return dark ? ownerEmeraldDarkest.withValues(alpha: 0.3) : ownerBgLight;
    }
    return dark ? cashierAmberContainerDark : cashierBgLight;
  }

  static Color roleBadgeBorder(BuildContext context, {required bool isOwner}) {
    final dark = isDark(context);
    if (isOwner) {
      return dark ? ownerEmeraldDark : ownerBorderLight;
    }
    return dark ? cashierAmberDarkest : cashierAmberSubtle;
  }

  static Color roleBadgeText(BuildContext context, {required bool isOwner}) {
    final dark = isDark(context);
    if (isOwner) {
      return dark ? ownerEmeraldLight : ownerEmerald;
    }
    return dark ? cashierAmberLight : cashierAmber;
  }

  static List<Color> roleGradient({required bool isOwner}) {
    return isOwner ? ownerGradient : cashierGradient;
  }
}

// Convenient BuildContext extensions for color access
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
  Color get chipBgColor => AppColors.chipBackground(this);
  Color get chipBorderColor => AppColors.chipBorder(this);
}
