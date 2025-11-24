import 'package:flutter/material.dart';
import 'package:planeance/theme/extensions/custom_colors.dart';

class AppColors {
  // ── Light ────────────────────────────────────────────────────────
  static const Color primaryLight = Color(0xFF1E40AF);
  static const Color secondaryLight = Color(0xFF4F46E5);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color errorLight = Color(0xFFB91C1C);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onSurfaceLight = Color(0xFF1F2937);

  // ── Dark ────────────────────────────────────────────────────────
  static const Color primaryDark = Color(0xFF60A5FA);
  static const Color secondaryDark = Color(0xFF818CF8);
  static const Color surfaceDark = Color(0xFF1F2937);
  static const Color backgroundDark = Color(0xFF111827);
  static const Color errorDark = Color(0xFFEF4444);
  static const Color onPrimaryDark = Color(0xFF111827);
  static const Color onSurfaceDark = Color(0xFFF9FAFB);
}

/// Thèmes (light & dark) construits à partir des `ColorScheme`.
class AppTheme {
  // -----------------------------------------------------------------
  // Light Theme
  // -----------------------------------------------------------------
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: 'Lato',

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryLight,
      onPrimary: AppColors.onPrimaryLight,
      secondary: AppColors.secondaryLight,
      onSecondary: Colors.white,

      surface: AppColors.surfaceLight,
      onSurface: AppColors.onSurfaceLight,
      error: AppColors.errorLight,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    // AppBar utilise la couleur primaire et le contraste adéquat
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.onPrimaryLight,
    ),
    extensions: <ThemeExtension<dynamic>>[
      const CustomSelectColors(selectedIcon: Colors.green),
      const CustomUnselectColors(
        unselectedIcon: Color.fromARGB(255, 160, 188, 202),
      ),
    ],
    // Exemple de style de texte (facultatif, tu peux le personnaliser)
    textTheme: _commonTextTheme(AppColors.onSurfaceLight),
  );

  // -----------------------------------------------------------------
  // Dark Theme
  // -----------------------------------------------------------------
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: 'Lato',

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryDark,
      onPrimary: AppColors.onPrimaryDark,
      secondary: AppColors.secondaryDark,
      onSecondary: Colors.black,

      surface: AppColors.surfaceDark,
      onSurface: AppColors.onSurfaceDark,
      error: AppColors.errorDark,
      onError: Colors.black,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.onPrimaryDark,
    ),
    extensions: <ThemeExtension<dynamic>>[
      const CustomSelectColors(selectedIcon: Color.fromARGB(255, 0, 94, 34)),
      const CustomUnselectColors(
        unselectedIcon: Color.fromARGB(255, 255, 255, 255),
      ),
    ],
    textTheme: _commonTextTheme(AppColors.onSurfaceDark),
  );



  static TextTheme _commonTextTheme(Color onSurface) {
    return TextTheme(
      titleLarge: const TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w900,
        fontSize: 30,
     
      ),
      titleMedium: const TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w600,
        fontSize: 26,
      ),
      titleSmall: const TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        fontSize: 22,
      ),
      headlineLarge: const TextStyle(fontSize: 28),
      headlineMedium: const TextStyle(fontSize: 24),
      headlineSmall: const TextStyle(fontSize: 20),
      // bodyLarge: TextStyle(color: onSurface),
      // bodyMedium: TextStyle(color: onSurface),
    );
  }
}
