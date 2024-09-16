import 'package:flutter/material.dart';

/// A widget that displays a paginated list of data, automatically guessing
/// the data's structure and rendering it in a table format.
class ListGuesser extends StatefulWidget {
  /// Creates a [ListGuesser] widget.
  ///
  /// [data] is the list of dynamic data to be displayed in the table.
  const ListGuesser({required this.data, super.key});

  /// The list of dynamic data to be paginated and displayed.
  final List<dynamic> data;

  @override
  State<ListGuesser> createState() => _ListGuesserState();
}

class _ListGuesserState extends State<ListGuesser> {
  int _currentPage = 0;
  int _itemsPerPage = 10;
  List<Map<String, dynamic>> paginatedData = [];

  @override
  void initState() {
    super.initState();
    paginateData();
  }

  /// Paginate the data into pages of [_itemsPerPage] size.
  void paginateData() {
    final typedData = widget.data.cast<Map<String, dynamic>>();
    final start = _currentPage * _itemsPerPage;
    final end = start + _itemsPerPage;
    setState(() {
      paginatedData = typedData.sublist(
        start,
        end > typedData.length ? typedData.length : end,
      );
    });
  }

  /// Change to a new page and repaginate the data.
  ///
  /// [newPage] is the page index to change to.
  void onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
      paginateData();
    });
  }

  /// Change the number of items per page and reset to the first page.
  ///
  /// [newValue] is the new number of items per page.
  void onItemsPerPageChanged(int? newValue) {
    if (newValue != null) {
      setState(() {
        _itemsPerPage = newValue;
        _currentPage = 0; // Reset to the first page
        paginateData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Text('No data available');
    }

    final typedData = widget.data.cast<Map<String, dynamic>>();
    final keys =
        typedData.isNotEmpty ? typedData.first.keys.toList() : <dynamic>[];
    final totalItems = typedData.length;
    final totalPages = (totalItems / _itemsPerPage).ceil();

    return Column(
      children: [
        // Pagination controls
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<int>(
              value: _itemsPerPage,
              items: [10, 25, 50, 100].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('Show $value items'),
                );
              }).toList(),
              onChanged: onItemsPerPageChanged,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _currentPage > 0
                      ? () => onPageChanged(_currentPage - 1)
                      : null,
                  icon: const Icon(Icons.arrow_back),
                ),
                Text('Page ${_currentPage + 1} of $totalPages'),
                IconButton(
                  onPressed: _currentPage < totalPages - 1
                      ? () => onPageChanged(_currentPage + 1)
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: keys
                    .map((key) => DataColumn(label: Text(key.toString())))
                    .toList(),
                rows: paginatedData.map((item) {
                  return DataRow(
                    cells: keys
                        .map(
                          (key) => DataCell(Text(item[key]?.toString() ?? '')),
                        )
                        .toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
