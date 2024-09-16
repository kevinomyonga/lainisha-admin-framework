import 'package:flutter/material.dart';

/// A class representing a resource that can be managed in an admin system.
/// 
/// The resource defines properties such as name, label, and various builders
/// for list, create, and edit views.
class Resource {
  /// Constructs a [Resource] instance.
  ///
  /// [name] is required and identifies the resource.
  /// [label] is an optional, more user-friendly name for the resource.
  /// [list] defines the widget builder for listing the resource items.
  /// [create] defines the widget builder for creating a new resource item.
  /// [edit] defines the widget builder for editing a specific resource item.
  Resource({
    required this.name,
    this.label,
    this.list,
    this.create,
    this.edit,
  });

  /// The name of the resource, typically used for API endpoints or internal
  /// identifiers.
  final String name;

  /// The display label for the resource. If not provided, [name] is used as
  /// a fallback for display purposes.
  final String? label;

  /// The widget builder for listing resource items.
  final WidgetBuilder? list;

  /// The widget builder for creating a new resource item.
  final WidgetBuilder? create;

  /// The widget builder for editing an existing resource item. The builder
  /// provides the context and the item data to be edited.
  final Widget Function(BuildContext context, Map<String, dynamic> item)? edit;

  /// A computed property that returns the display label. If [label] is
  /// not provided, it defaults to the [name] of the resource.
  String get displayLabel => label ?? name;
}
