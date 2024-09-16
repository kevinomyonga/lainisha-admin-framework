import 'package:flutter/material.dart';

/// A widget that displays a list of data with optional edit functionality.
class ListWithEdit extends StatelessWidget {
  /// Creates a [ListWithEdit] widget.
  ///
  /// [data] is the list of data to be displayed.
  /// [resourceName] is the name of the resource, used in the edit dialog.
  /// [editBuilder] is an optional function that returns a widget for editing
  /// a selected item.
  const ListWithEdit({
    required this.data,
    required this.resourceName,
    this.editBuilder,
    super.key,
  });

  /// The list of data to be displayed, where each item is a map of key-value
  /// pairs.
  final List<Map<String, dynamic>> data;

  /// The name of the resource to be displayed, used in the edit dialog title.
  final String resourceName;

  /// An optional function that builds a widget to edit the selected item.
  final Widget Function(BuildContext context, Map<String, dynamic> item)?
      editBuilder;

  @override
  Widget build(BuildContext context) {
    // Get the column headers dynamically from the keys of the first item
    final keys = data.isNotEmpty ? data.first.keys.toList() : <String>[];

    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            ...keys.map((key) => DataColumn(label: Text(key))),
            if (editBuilder != null) const DataColumn(label: Text('Actions')),
          ],
          rows: data.map((item) {
            return DataRow(
              cells: [
                ...keys
                    .map((key) => DataCell(Text(item[key]?.toString() ?? ''))),
                if (editBuilder != null)
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // If editBuilder is provided, show the edit dialog
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          useRootNavigator: true,
                          showDragHandle: true,
                          useSafeArea: true,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Edit $resourceName'),
                              content: editBuilder!(context, item),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Save changes
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
