import 'package:flutter/material.dart';

class AppThemeTokens {
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;
  final Color primaryContainer;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color card;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  const AppThemeTokens({
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.primaryContainer,
    required this.secondary,
    required this.surface,
    required this.background,
    required this.card,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
  });

  static const light = AppThemeTokens(
    primary: Color(0xFF1E3A8A),
    primaryDark: Color(0xFF0F172A),
    primaryLight: Color(0xFF3B82F6),
    primaryContainer: Color(0xFFDBEAFE),
    secondary: Color(0xFF10B981),
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFF8FAFC),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE2E8F0),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF64748B),
    textMuted: Color(0xFF94A3B8),
  );

  static const dark = AppThemeTokens(
    primary: Color(0xFF3B82F6),
    primaryDark: Color(0xFF1E3A8A),
    primaryLight: Color(0xFF60A5FA),
    primaryContainer: Color(0xFF1E293B),
    secondary: Color(0xFF34D399),
    surface: Color(0xFF1E293B),
    background: Color(0xFF0F172A),
    card: Color(0xFF1E293B),
    border: Color(0xFF334155),
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFF94A3B8),
    textMuted: Color(0xFF64748B),
  );
}
