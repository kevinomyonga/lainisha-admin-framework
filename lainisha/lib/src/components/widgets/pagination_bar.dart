import 'package:flutter/material.dart';

/// A widget that provides pagination controls for navigating through pages
/// of data and changing the number of items displayed per page.
///
/// It includes buttons for navigating between pages and a dropdown for
/// selecting the number of items per page.
class PaginationBar extends StatelessWidget {
  /// Creates a [PaginationBar] with the given [currentPage], [onPageChanged],
  /// and [onLimitChanged] callback functions.
  ///
  /// [currentPage] is the current page number.
  /// [onPageChanged] is a callback function to be called when the page changes.
  /// [onLimitChanged] is a callback function to be called when the items per
  /// page limit changes.
  const PaginationBar({
    required this.currentPage,
    required this.onPageChanged,
    required this.onLimitChanged,
    super.key,
  });

  /// The current page number.
  final int currentPage;

  /// Callback function triggered when the page is changed.
  final ValueChanged<int> onPageChanged;

  /// Callback function triggered when the items per page limit is changed.
  final ValueChanged<int> onLimitChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: currentPage > 1
                  ? () => onPageChanged(currentPage - 1)
                  : null,
              icon: const Icon(Icons.chevron_left),
            ),
            Text('Page $currentPage'),
            IconButton(
              onPressed: () => onPageChanged(currentPage + 1),
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        DropdownButton<int>(
          value: 10,
          items: [10, 20, 50, 100].map((int limitOption) {
            return DropdownMenuItem<int>(
              value: limitOption,
              child: Text('$limitOption Per Page'),
            );
          }).toList(),
          onChanged: (int? newLimit) {
            if (newLimit != null) {
              onLimitChanged(newLimit);
            }
          },
        ),
      ],
    );
  }
}
