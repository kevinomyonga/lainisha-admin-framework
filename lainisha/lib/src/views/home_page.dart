import 'package:flutter/material.dart';
import 'package:lainisha/lainisha.dart';

/// A stateful widget that serves as the home page for the Lainisha Admin
/// panel. It provides a sidebar navigation for selecting resources and
/// displays the corresponding resource view.
///
/// It takes a [dataProvider] for fetching data, a list of [resources], 
/// an optional [dashboard] widget, and a [title] for the app.
class LainishaHomePage extends StatefulWidget {
  /// Creates a [LainishaHomePage] with the given [dataProvider], [resources],
  /// [title], and optional [dashboard] widget.
  ///
  /// [dataProvider] is used to fetch data for the resources.
  /// [resources] is the list of resources available in the sidebar.
  /// [title] is the title of the app.
  /// [dashboard] is an optional widget to be displayed on the home page.
  const LainishaHomePage({
    required this.dataProvider,
    required this.resources,
    required this.title,
    super.key,
    this.dashboard,
  });

  /// The data provider used to fetch data for the resources.
  final DataProvider dataProvider;

  /// The list of resources available in the sidebar.
  final List<Resource> resources;

  /// An optional widget to be displayed on the home page.
  final Widget? dashboard;

  /// The title of the app.
  final String title;

  @override
  State<LainishaHomePage> createState() => _LainishaHomePageState();
}

class _LainishaHomePageState extends State<LainishaHomePage> {
  Resource? selectedResource;

  @override
  Widget build(BuildContext context) {
    // App structure
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primary,
              ),
              child: Text(widget.title, style: const TextStyle(fontSize: 24)),
            ),
            ...widget.resources.map((resource) {
              return ListTile(
                title: Text(resource.name),
                selected: selectedResource == resource,
                onTap: () {
                  setState(() {
                    selectedResource = resource;
                  });
                  Navigator.pop(
                    context,
                  ); // Close the drawer when an item is tapped
                },
              );
            }),
            const Divider(),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings page or show settings dialog
              },
            ),
          ],
        ),
      ),
      body: selectedResource == null
          ? const Center(child: Text('Select a resource'))
          : ResourceView(
              resource: selectedResource!,
              dataProvider: widget.dataProvider,
              createFormBuilder: selectedResource?.create,
              editFormBuilder: selectedResource?.edit,
            ),
    );
  }
}
