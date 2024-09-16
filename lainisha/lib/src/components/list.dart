import 'package:flutter/material.dart';

class ListWithEdit extends StatelessWidget {
  const ListWithEdit({
    required this.data,
    required this.resourceName,
    this.editBuilder,
    super.key,
  });
  final List<Map<String, dynamic>> data;
  final String resourceName;
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
                        // If editBuilder is provided, navigate to the edit view
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
