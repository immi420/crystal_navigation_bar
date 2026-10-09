import 'package:flutter/material.dart';

import 'icon_source.dart';

/// A tab to display in a [CrystalNavigationBar].
class CrystalNavigationBarItem {
  /// Creates an item with [IconData] icons.
  CrystalNavigationBarItem({
    required IconData icon,
    IconData? unselectedIcon,
    this.selectedColor,
    this.unselectedColor,
    this.badge,
    this.label,
  })  : icon = CrystalNavIcon.data(icon),
        unselectedIcon = unselectedIcon != null
            ? CrystalNavIcon.data(unselectedIcon)
            : null;

  /// Creates an item with SVG asset icons.
  CrystalNavigationBarItem.svg({
    required String iconPath,
    String? unselectedIconPath,
    this.selectedColor,
    this.unselectedColor,
    this.badge,
    this.label,
  })  : icon = CrystalNavIcon.svg(iconPath),
        unselectedIcon = CrystalNavIcon.svg(
          unselectedIconPath ?? iconPath,
        );

  /// Creates an item with an explicit [CrystalNavIcon].
  CrystalNavigationBarItem.custom({
    required this.icon,
    this.unselectedIcon,
    this.selectedColor,
    this.unselectedColor,
    this.badge,
    this.label,
  });

  /// Selected (or only) icon.
  final CrystalNavIcon icon;

  /// Icon when unselected; falls back to [icon] when null.
  final CrystalNavIcon? unselectedIcon;

  /// Optional overlay (notification count, etc.). Any [Widget] is allowed.
  final Widget? badge;

  /// Optional text label under the icon when `showLabels` is enabled.
  final String? label;

  /// Color when this tab is selected.
  final Color? selectedColor;

  /// Color when this tab is not selected.
  final Color? unselectedColor;
}
