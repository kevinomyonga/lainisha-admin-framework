import 'package:flutter/material.dart';

class Resource {
  Resource({
    required this.name,
    this.label,
    this.list,
    this.create,
    this.edit,
  });
  final String name;
  final String? label;
  final WidgetBuilder? list;
  final WidgetBuilder? create;
  final Widget Function(BuildContext context, Map<String, dynamic> item)? edit;

  // Computed property to get label or fallback to name
  String get displayLabel => label ?? name;
}
