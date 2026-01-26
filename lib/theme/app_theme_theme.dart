import 'package:flutter/material.dart';

// Brand Colors
class AppColors {
  // Primary color - deep purple
  static const Color primary = Color(0xFF5D0066);

  // Text color
  static const Color textPrimary = Color(0xFF353B3C);

  // Background color - light beige
  static const Color background = Color(0xFFDECED2);

  // Secondary color - light blue
  static const Color secondary = Color(0xFFC1E0F7);

  // Surface color - white
  static const Color surface = Color(0xFFFFFFFF);

  // Status color - gold/warning
  static const Color status = Color(0xFF9D8420);

  // Navigation color - light pink
  static const Color navigation = Color(0xFFF2ECEE);
}

// App Theme Configuration
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.status,
        surface: AppColors.surface,
        background: AppColors.background,
        error: const Color(0xFFB3261E),
        onPrimary: AppColors.surface,
        onSecondary: AppColors.textPrimary,
        onTertiary: AppColors.surface,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.navigation,
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: AppColors.surface,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
