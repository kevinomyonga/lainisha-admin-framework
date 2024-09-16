import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:lainisha/lainisha.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class ResourceView extends StatefulWidget {
  const ResourceView({
    required this.resource,
    required this.dataProvider,
    this.createFormBuilder,
    this.editFormBuilder,
    super.key,
  });
  final Resource resource;
  final DataProvider dataProvider;
  final Widget Function(BuildContext context)? createFormBuilder;
  final Widget Function(BuildContext context, Map<String, dynamic> item)?
      editFormBuilder;

  @override
  _ResourceViewState createState() => _ResourceViewState();
}

class _ResourceViewState extends State<ResourceView> {
  List<Map<String, dynamic>> resourceData = [];
  List<Map<String, dynamic>> selectedRecords = [];

  bool isLoading = false;
  String? errorMessage;

  int currentPage = 1;
  int limit = 10;
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    _fetchResourceData();
  }

  @override
  void didUpdateWidget(ResourceView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the resource has changed
    if (oldWidget.resource.name != widget.resource.name) {
      // Clear the data and reset pagination
      setState(() {
        resourceData = [];
        currentPage = 1;
        totalPages = 1; // Reset totalPages when resource changes
      });
      _fetchResourceData(); // Fetch data for the new resource
    }
  }

  Future<void> _fetchResourceData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response =
          await widget.dataProvider.fetchList<Map<String, dynamic>>(
        widget.resource.name,
        page: currentPage,
        limit: limit,
      );
      // setState(() {
      //   resourceData = data;
      // });

      if (response.isNotEmpty) {
        setState(() {
          resourceData = response;
        });
      } else {
        setState(() {
          resourceData = [];
          totalPages = 1; // Set to 1 if no data is returned
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error: $error';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onPageChanged(int newPage) {
    if (newPage >= 1 && newPage <= totalPages) {
      setState(() {
        currentPage = newPage;
      });
      _fetchResourceData();
    }
  }

  void _onLimitChanged(int newLimit) {
    setState(() {
      limit = newLimit;
      currentPage = 1; // Reset to the first page when limit changes
    });
    _fetchResourceData();
  }

  void _openCreateForm() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      useRootNavigator: true,
      showDragHandle: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create ${widget.resource.name}'),
          content: widget.createFormBuilder?.call(context) ??
              const Text('No form provided'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement save functionality
                Navigator.pop(context);
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.resource.name} Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _showExportDialog,
          ),
          if (widget.createFormBuilder != null)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _openCreateForm,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: _fetchResourceData,
                      child: resourceData.isNotEmpty
                          ? ListWithEdit(
                              data: resourceData,
                              resourceName: widget.resource.name,
                              editBuilder: widget.editFormBuilder,
                            )
                          : Center(
                              child: Text(errorMessage ?? 'No data available'),
                            ),
                    ),
            ),
            if (resourceData.isNotEmpty)
              PaginationBar(
                currentPage: currentPage,
                onPageChanged: _onPageChanged,
                onLimitChanged: _onLimitChanged,
              ),
          ],
        ),
      ),
    );
  }

  // Dialog to choose CSV or PDF export
  void _showExportDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Export Data'),
          content: const Text('Choose format to export data:'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _exportToCSV();
              },
              child: const Text('Export to CSV'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _exportToPDF();
              },
              child: const Text('Export to PDF'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _exportToCSV() async {
    final rows = <List<dynamic>>[];

    // Prepare headers
    final headers = resourceData.first.keys.toList();
    rows.add(headers);

    // Add selected or all records
    final recordsToExport =
        selectedRecords.isNotEmpty ? selectedRecords : resourceData;

    for (final record in recordsToExport) {
      rows.add(record.values.toList());
    }

    final csv = const ListToCsvConverter().convert(rows);
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/${widget.resource.name}.csv';
    final file = File(path);
    await file.writeAsString(csv);

    // Open the file after saving
    await OpenFilex.open(path);
  }

  Future<void> _exportToPDF() async {
    final pdf = pw.Document();

    // Add the records as table to the PDF
    final headers = resourceData.first.keys.toList();
    final recordsToExport =
        selectedRecords.isNotEmpty ? selectedRecords : resourceData;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.TableHelper.fromTextArray(
            headers: headers,
            data: recordsToExport
                .map((record) => record.values.toList())
                .toList(),
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/${widget.resource.name}.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    // Open the file after saving
    await OpenFilex.open(path);
  }
}
