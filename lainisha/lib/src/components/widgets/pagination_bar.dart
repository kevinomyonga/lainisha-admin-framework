import 'package:flutter/material.dart';

class PaginationBar extends StatelessWidget {
  const PaginationBar({
    required this.currentPage,
    required this.onPageChanged,
    required this.onLimitChanged,
    super.key,
  });
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onLimitChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed:
                  currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
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


// import 'package:flutter/material.dart';

// typedef PageChangedCallback = void Function(int page);

// class PaginationBar extends StatelessWidget {
//   const PaginationBar({
//     required this.currentPage,
//     required this.totalPages,
//     required this.onPageChanged,
//     super.key,
//   });

//   final int currentPage;
//   final int totalPages;
//   final PageChangedCallback onPageChanged;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         ElevatedButton(
//           onPressed: currentPage > 1
//               ? () => onPageChanged(currentPage - 1)
//               : null,
//           child: const Text('Previous'),
//         ),
//         Text('Page $currentPage of $totalPages'),
//         ElevatedButton(
//           onPressed: currentPage < totalPages
//               ? () => onPageChanged(currentPage + 1)
//               : null,
//           child: const Text('Next'),
//         ),
//       ],
//     );
//   }
// }
