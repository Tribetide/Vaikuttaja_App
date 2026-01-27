import 'package:flutter/material.dart';

/// Brand Colors
class AppColors {
  static const Color primary = Color(0xFF5D0066);
  static const Color textPrimary = Color(0xFF353B3C);

  // App tausta (scaffoldBackgroundColor)
  static const Color background = Color(0xFFDECED2);

  // “Brand secondary”
  static const Color secondary = Color(0xFFC1E0F7);

  // Pääpinnat (kortit, inputit)
  static const Color surface = Color(0xFFE6E0E3);

  // Korostus / status
  static const Color status = Color(0xFF9D8420);

  // Bottom nav tausta
  static const Color navigation = Color(0xFFF2ECEE);
}

/// alpha helper without withOpacity() deprecation
Color _a(Color c, double opacity) => c.withAlpha((opacity * 255).round());

/// App Theme Configuration
class AppTheme {
  static ThemeData get lightTheme {
    // ColorScheme.fromSeed välttää deprecated background-parametrin.
    // Pidetään brändivärit mukana overrideilla.
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      tertiary: AppColors.status,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // Appin yleinen tausta (ei ColorScheme.background)
      scaffoldBackgroundColor: AppColors.background,

      // Yleinen ikoniväri (jos ei erikseen määritetä)
      iconTheme: IconThemeData(color: colorScheme.primary),

      // AppBar (käytössä esim. chat thread, event details)
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textPrimary,
        elevation: 1,
      ),

      // Bottom nav (ShellScreen)
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.navigation,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: _a(colorScheme.primary, 0.65),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),

      // Cardien peruslook (Profile, Events, jne)
      cardTheme: CardThemeData(
        elevation: 1, // tai 0 jos haluat täysin flat
        color: _a(colorScheme.secondary, 0.28), // tai AppColors.surface
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0), // jos haluat täysin “suorat”
        ),
      ),


      dividerTheme: DividerThemeData(
        color: _a(colorScheme.primary, 0.08),
        thickness: 1,
        space: 1,
      ),

      listTileTheme: ListTileThemeData(
        textColor: AppColors.textPrimary,
        iconColor: colorScheme.primary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: _a(colorScheme.surface, 0.85),
        selectedColor: _a(colorScheme.primary, 0.18),
        disabledColor: _a(colorScheme.surface, 0.60),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        labelStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 12,
        ),
        shape: StadiumBorder(
          side: BorderSide(color: _a(colorScheme.primary, 0.10)),
        ),
      ),

      // Input-kentät (AddInfluencer, tuleva CreateUser, jne)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _a(colorScheme.primary, 0.15)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _a(colorScheme.primary, 0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _a(colorScheme.primary, 0.55), width: 1.5),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.surface,
        contentTextStyle: TextStyle(color: colorScheme.onSurface),
      ),

      // Tekstityylit (screenit voi käyttää suoraan textThemea)
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
        titleMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
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
