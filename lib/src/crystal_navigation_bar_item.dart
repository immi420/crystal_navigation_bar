import 'package:flutter/material.dart';

/// A tab to display in a [CrystalNavigationBar]
class CrystalNavigationBarItem {
  /// An icon to display (can be IconData or String path for SVG).
  final dynamic icon;

  /// An icon to display when unselected.
  final dynamic? unselectedIcon;

  /// Badge to display on the icon.
  final Badge? badge;

  /// A primary color to use for this tab.
  final Color? selectedColor;

  /// The color to display when this tab is not selected.
  final Color? unselectedColor;

  /// Creates a navigation bar item with an IconData icon.
  CrystalNavigationBarItem({
    required this.icon,
    this.unselectedIcon,
    this.selectedColor,
    this.unselectedColor,
    this.badge,
  }) : assert(icon is IconData, 'Icon must be of type IconData');

  /// Creates a navigation bar item with an SVG asset.
  CrystalNavigationBarItem.svg({
    required String iconPath,
    String? unselectedIconPath,
    this.selectedColor,
    this.unselectedColor,
    this.badge,
  })  : icon = iconPath,
        unselectedIcon = unselectedIconPath ?? iconPath,
        assert(iconPath.endsWith('.svg'), 'SVG path must end with .svg');

  /// Whether this item uses an SVG asset.
  bool get isSvg => icon is String && (icon as String).endsWith('.svg');

  /// Whether this item uses an IconData icon.
  bool get isIcon => !isSvg;
}
