import 'package:adaptive_chameleon_theme/adaptive_chameleon_theme.dart';
import 'package:flutter/material.dart';
import 'package:lainisha/lainisha.dart';

/// {@template app_themes}
/// The Default App [ThemeData].
/// {@endtemplate}
class AppThemes {
  /// Creates an instance of [AppThemes].
  ///
  /// This class provides various themes for the application including teal,
  /// purple, amber, blue, and red color schemes.
  const AppThemes();

  /// The app's themes.
  ///
  /// This code is used to connect readable names
  /// to integer theme IDs. Each integer constant
  /// represents a unique color theme for the application.

  /// The integer ID for the 'Ryokugyu' color theme.
  /// This theme ID is associated with the teal color scheme.
  static const int ryokugyu = 0;

  /// The integer ID for the 'Fujitora' color theme.
  /// This theme ID is associated with the purple color scheme.
  /// used within the application.
  static const int fujitora = 1;

  /// The integer ID for the 'Kizaru' color theme.
  /// This theme ID is associated with the amber color scheme.
  static const int kizaru = 2;

  /// The integer ID for the 'Aokiji' color theme.
  /// This theme ID is associated with the blue color scheme.
  static const int aokiji = 3;

  /// The integer ID for the 'Akainu' color theme.
  /// This theme ID is associated with the red color scheme.
  static const int akainu = 4;

  /// Converts a theme ID to its string representation.
  ///
  /// [themeId] is the ID of the theme to convert.
  /// Returns the name of the theme as a [String].
  String toStr(int themeId) {
    switch (themeId) {
      case ryokugyu:
        return 'Ryokugyu';
      case fujitora:
        return 'Fujitora';
      case kizaru:
        return 'Kizaru';
      case aokiji:
        return 'Aokiji';
      case akainu:
        return 'Akainu';
      default:
        return 'Unknown';
    }
  }

  /// Provides the base `ThemeData` for the app UI.
  ///
  /// Returns a [ThemeData] instance with default light theme settings.
  ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: FontFamily.workSans,
    );
  }

  /// Returns the light theme with a teal color scheme.
  ///
  /// Uses [AppColors.primaryGreenColor] as the primary color.
  ThemeData get greenTheme {
    final base = themeData;
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreenColor,
      ),
    );
  }

  /// Returns the light theme with a purple color scheme.
  ///
  /// Uses [AppColors.primaryPurpleColor] as the primary color.
  ThemeData get purpleTheme {
    final base = themeData;
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryPurpleColor,
      ),
    );
  }

  /// Returns the light theme with an yellow color scheme.
  ///
  /// Uses [AppColors.primaryYellowColor] as the primary color.
  ThemeData get yellowTheme {
    final base = themeData;
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryYellowColor,
      ),
    );
  }

  /// Returns the light theme with a blue color scheme.
  ///
  /// Uses a default color scheme.
  ThemeData get blueTheme {
    final base = themeData;
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlueColor,
      ),
    );
  }

  /// Returns the light theme with a red color scheme.
  ///
  /// Uses [AppColors.primaryRedColor] as the primary color.
  ThemeData get redTheme {
    final base = themeData;
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryRedColor,
      ),
    );
  }

  /// Provides a collection of themes for the application.
  ///
  /// Includes themes for teal, purple, amber, blue, and red color schemes.
  /// Sets a fallback theme as [ThemeData.light].
  ThemeCollection get themeCollection {
    return ThemeCollection(
      themes: {
        ryokugyu: greenTheme,
        fujitora: purpleTheme,
        kizaru: yellowTheme,
        aokiji: blueTheme,
        akainu: redTheme,
      },
      // Optional fallback theme, default value is ThemeData.light()
      fallbackTheme: ThemeData.light(),
    );
  }
}
