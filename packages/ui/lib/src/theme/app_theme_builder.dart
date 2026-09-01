import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme_tokens.dart';

class AppThemeBuilder {
  static ThemeData buildLightTheme({Color? primaryOverride}) {
    final primary = primaryOverride ?? AppThemeTokens.light.primary;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
      primary: primary,
      secondary: AppThemeTokens.light.secondary,
      surface: AppThemeTokens.light.surface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppThemeTokens.light.background,
      cardColor: AppThemeTokens.light.card,
      dividerColor: AppThemeTokens.light.border,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: AppThemeTokens.light.surface,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 1,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppThemeTokens.light.textPrimary,
        ),
        iconTheme: IconThemeData(color: AppThemeTokens.light.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppThemeTokens.light.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppThemeTokens.light.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1),
        ),
      ),
    );
  }

  static ThemeData buildDarkTheme({Color? primaryOverride}) {
    final primary = primaryOverride ?? AppThemeTokens.dark.primary;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
      primary: primary,
      secondary: AppThemeTokens.dark.secondary,
      surface: AppThemeTokens.dark.surface,
      surfaceContainerHighest: const Color(0xFF334155),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppThemeTokens.dark.background,
      cardColor: AppThemeTokens.dark.card,
      dividerColor: AppThemeTokens.dark.border,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: AppThemeTokens.dark.surface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppThemeTokens.dark.textPrimary,
        ),
        iconTheme: IconThemeData(color: AppThemeTokens.dark.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppThemeTokens.dark.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF334155), width: 1),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: Color(0xFF1E293B),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppThemeTokens.dark.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(color: Color(0xFF64748B)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF334155), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF334155), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1),
        ),
      ),
    );
  }
}
