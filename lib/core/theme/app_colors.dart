import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Brand Colors
  static const Color primary = Color(0xFF2C1810);       // Deep dark brown
  static const Color primaryLight = Color(0xFF4A2E22);  // Medium brown
  static const Color accent = Color(0xFF8B5E52);        // Rose brown
  static const Color accentLight = Color(0xFFB08070);   // Light rose

  // Background
  static const Color background = Color(0xFFF5F2EF);    // Warm off-white
  static const Color backgroundDark = Color(0xFF1A1A1A);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0EBE6); // Warm cream

  // Text
  static const Color textPrimary = Color(0xFF1C1C1C);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFFAAAAAA);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnDarkSecondary = Color(0xFFCCCCCC);

  // Input Fields
  static const Color inputBackground = Color(0xFFFFFFFF);
  static const Color inputBorder = Color(0xFFE5DED8);
  static const Color inputFocused = Color(0xFF2C1810);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF6B9BC4); // Muted blue used in scanner

  // Divider & Border
  static const Color divider = Color(0xFFE8E0D8);
  static const Color border = Color(0xFFD5CCC4);

  // Overlay
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);

  // AI Badge
  static const Color aiBadge = Color(0xFF4A90D9);
  static const Color aiMatchBadge = Color(0xFF2C7BE5);

  // Scanner
  static const Color scannerBackground = Color(0xFF3D5A73);
  static const Color scannerOverlay = Color(0xFF2D4A63);
}