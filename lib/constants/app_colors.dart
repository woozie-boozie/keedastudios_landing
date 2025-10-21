import 'package:flutter/material.dart';

class AppColors {
  // Dark theme background
  static const Color backgroundStart = Color(0xFF0a0a0f);
  static const Color backgroundEnd = Color(0xFF1a1a2e);

  // Glassmorphic card colors
  static const Color glassBackground = Color(0x0DFFFFFF); // 5% white opacity
  static const Color glassBorder = Color(0x1AFFFFFF); // 10% white opacity
  static const Color glassHover = Color(0x14FFFFFF); // 8% white opacity

  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF808080);

  // Accent colors
  static const Color accentPrimary = Color(0xFF5B7FFF); // Vibrant blue
  static const Color accentSecondary = Color(0xFF8B5FFF); // Purple accent
  static const Color accentGradientStart = Color(0xFF5B7FFF);
  static const Color accentGradientEnd = Color(0xFF8B5FFF);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);

  // Shadow and glow
  static const Color shadowColor = Color(0x33000000);
  static Color glowColor = accentPrimary.withOpacity(0.3);

  // Background gradient
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [backgroundStart, backgroundEnd],
  );

  // Accent gradient
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentGradientStart, accentGradientEnd],
  );
}
