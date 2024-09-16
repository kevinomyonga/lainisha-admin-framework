import 'package:adaptive_chameleon_theme/adaptive_chameleon_theme.dart';
import 'package:flutter/material.dart';
import 'package:lainisha/lainisha.dart';

/// The main admin widget for the Lainisha framework, wrapping the 
/// admin home page in a theme.
class LainishaAdmin extends StatelessWidget {
  /// Creates a [LainishaAdmin] widget.
  ///
  /// [resources] are the admin resources to manage.
  /// [dataProvider] is the source of data for the admin panel.
  /// [title] is the app's title shown in the app bar.
  /// [dashboard] is the optional dashboard widget for the home page.
  const LainishaAdmin({
    required this.resources,
    required this.dataProvider,
    required this.title,
    super.key,
    this.dashboard,
  });

  /// The data provider for managing resources.
  final DataProvider dataProvider;

  /// The list of admin resources to display.
  final List<Resource> resources;

  /// The title of the admin panel.
  final String title;

  /// An optional dashboard widget for the home page.
  final Widget? dashboard;

  @override
  Widget build(BuildContext context) {
    return AdaptiveChameleonThemeWidget(
      themeCollection: const AppThemes().themeCollection,
      darkThemeCollection: const AppDarkThemes().themeCollectionDark,
      builder: (context, theme, darkTheme, themeMode) {
        return MaterialApp(
          theme: theme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: LainishaHomePage(
            dataProvider: dataProvider,
            resources: resources,
            title: title,
            dashboard: dashboard,
          ),
        );
      },
    );
  }
}
