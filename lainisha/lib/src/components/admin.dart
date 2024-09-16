import 'package:adaptive_chameleon_theme/adaptive_chameleon_theme.dart';
import 'package:flutter/material.dart';
import 'package:lainisha/lainisha.dart';

class LainishaAdmin extends StatelessWidget {
  const LainishaAdmin({
    required this.resources,
    required this.dataProvider,
    required this.title,
    super.key,
    this.dashboard,
  });
  final DataProvider dataProvider;
  final List<Resource> resources;
  final String title;
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
