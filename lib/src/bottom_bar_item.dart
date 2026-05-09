import 'package:flutter/material.dart';

/// A model class that represents an item in the bottom navigation bar.
class BottomBarItem {
  /// The widget (usually an Icon) to display when this item is inactive.
  final Widget inActiveItem;

  /// The widget (usually an Icon) to display when this item is active.
  final Widget activeItem;

  /// An optional label to display below the icon.
  final String? itemLabel;

  /// Creates a [BottomBarItem].
  const BottomBarItem({
    required this.inActiveItem,
    required this.activeItem,
    this.itemLabel,
  });
}
