import 'package:flutter/material.dart';
import 'package:lainisha/lainisha.dart';

class LainishaHomePage extends StatefulWidget {
  const LainishaHomePage({
    required this.dataProvider,
    required this.resources,
    required this.title,
    super.key,
    this.dashboard,
  });
  final DataProvider dataProvider;
  final List<Resource> resources;
  final Widget? dashboard;
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
        title: const Text('Lainisha Admin'),
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
