import 'package:adaptive_chameleon_theme/adaptive_chameleon_theme.dart';
import 'package:flutter/material.dart';
import 'package:lainisha/lainisha.dart';

/// {@template app_dark_themes}
/// Provides dark mode themes for the application.
/// {@endtemplate}
class AppDarkThemes extends AppThemes {
  /// Creates an instance of [AppDarkThemes].
  ///
  /// The [AppDarkThemes] class defines various dark mode themes for the
  /// application, including specific themes for teal, purple, amber, blue,
  /// and red color schemes.
  const AppDarkThemes();

  /// Provides the base `ThemeData` for the app UI.
  ///
  /// Returns a [ThemeData] instance with default dark theme settings.
  @override
  ThemeData get themeData {
    /// Returns the base dark theme for the application.
    return ThemeData(
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: FontFamily.workSans,
    );
  }

  /// Returns the dark theme with a green color scheme.
  ThemeData get greenThemeDark {
    final base = themeData;
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreenColor,
        brightness: Brightness.dark,
      ),
    );
  }

  /// Returns the dark theme with a purple color scheme.
  ThemeData get purpleThemeDark {
    final base = themeData;
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryPurpleColor,
        brightness: Brightness.dark,
      ),
    );
  }

  /// Returns the dark theme with an yellow color scheme.
  ThemeData get yellowThemeDark {
    final base = themeData;
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryYellowColor,
        brightness: Brightness.dark,
      ),
    );
  }

  /// Returns the dark theme with a blue color scheme.
  ThemeData get blueThemeDark {
    final base = themeData;
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlueColor,
        brightness: Brightness.dark,
      ),
    );
  }

  /// Returns the dark theme with a red color scheme.
  ThemeData get redThemeDark {
    final base = themeData;
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryRedColor,
        brightness: Brightness.dark,
      ),
    );
  }

  /// Provides a collection of dark themes for the application.
  ThemeCollection get themeCollectionDark {
    return ThemeCollection(
      themes: {
        AppThemes.ryokugyu: greenThemeDark,
        AppThemes.fujitora: purpleThemeDark,
        AppThemes.kizaru: yellowThemeDark,
        AppThemes.aokiji: blueThemeDark,
        AppThemes.akainu: redThemeDark,
      },
      // Optional fallback theme, default value is ThemeData.dark()
      fallbackTheme: ThemeData.dark(),
    );
  }
}
