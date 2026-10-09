import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import 'crystal_navigation_bar_item.dart';
import 'navigation_bar_body.dart';

/// A frosted / floating bottom navigation bar with animated selection.
class CrystalNavigationBar extends StatelessWidget {
  CrystalNavigationBar({
    super.key,
    required this.items,
    required this.onTap,
    this.currentIndex = 0,
    this.height = 86,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
    this.indicatorColor,
    this.marginR = const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
    this.paddingR = const EdgeInsets.only(bottom: 4, top: 8),
    this.borderRadius = 30,
    this.splashBorderRadius,
    this.backgroundColor = Colors.transparent,
    this.outlineBorderColor = Colors.white24,
    this.borderWidth = 0.0,
    this.boxShadow = const [
      BoxShadow(
        color: Colors.transparent,
        spreadRadius: 0,
        blurRadius: 0,
        offset: Offset.zero,
      ),
    ],
    this.enableFloatingNavBar = true,
    this.splashColor,
    this.blurSigma = 10,
    this.showLabels = false,
  }) : assert(items.isNotEmpty, 'items cannot be empty'),
       assert(
         currentIndex >= 0 && currentIndex < items.length,
         'currentIndex must be within items range',
       ),
       assert(height > 0, 'height must be positive'),
       assert(blurSigma >= 0, 'blurSigma must be non-negative');

  /// Tabs to display.
  final List<CrystalNavigationBarItem> items;

  /// Currently selected tab index.
  final int currentIndex;

  /// Called when a tab is tapped.
  final ValueChanged<int> onTap;

  /// Color of the icon (and label) when selected, if the item has none.
  final Color? selectedItemColor;

  /// Color of the icon (and label) when unselected, if the item has none.
  final Color? unselectedItemColor;

  /// Margin around the bar when [enableFloatingNavBar] is false.
  final EdgeInsets margin;

  /// Padding inside each item.
  final EdgeInsets itemPadding;

  /// Selection animation duration.
  final Duration duration;

  /// Selection animation curve.
  final Curve curve;

  /// Color of the bottom indicator; defaults to the selected color.
  final Color? indicatorColor;

  /// Outer margin for the floating bar.
  final EdgeInsetsGeometry marginR;

  /// Inner padding for the floating bar content.
  final EdgeInsetsGeometry paddingR;

  /// Corner radius of the bar chrome.
  final double borderRadius;

  /// Height of the bar (floating mode uses [BottomAppBar] height).
  final double height;

  /// Background color behind the blur.
  final Color backgroundColor;

  /// Outline border color.
  final Color outlineBorderColor;

  /// Outline border width.
  final double borderWidth;

  /// Shadows behind the floating bar.
  final List<BoxShadow> boxShadow;

  /// When true, renders a floating rounded bar; otherwise edge-to-edge.
  final bool enableFloatingNavBar;

  /// Ink splash / highlight color. Use [Colors.transparent] to disable.
  final Color? splashColor;

  /// Border radius of the ink splash clip.
  final double? splashBorderRadius;

  /// Backdrop blur strength (`ImageFilter.blur` sigma).
  final double blurSigma;

  /// When true, shows each item's [CrystalNavigationBarItem.label] if set.
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    // Labels need extra vertical room beyond the icon-only default.
    final resolvedHeight = showLabels ? math.max(height, 110.0) : height;

    final body = NavigationBarBody(
      items: items,
      currentIndex: currentIndex,
      curve: curve,
      duration: duration,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      onTap: onTap,
      itemPadding: itemPadding,
      indicatorColor: indicatorColor,
      splashColor: splashColor,
      splashBorderRadius: splashBorderRadius,
      showLabels: showLabels,
    );

    if (enableFloatingNavBar) {
      return BottomAppBar(
        color: Colors.transparent,
        padding: EdgeInsets.zero,
        elevation: 0,
        height: resolvedHeight,
        child: Padding(
          padding: marginR,
          child: _BlurChrome(
            blurSigma: blurSigma,
            borderRadius: borderRadius,
            boxShadow: boxShadow,
            backgroundColor: backgroundColor,
            outlineBorderColor: outlineBorderColor,
            borderWidth: borderWidth,
            padding: paddingR,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: body,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: resolvedHeight,
      child: _BlurChrome(
        blurSigma: blurSigma,
        borderRadius: 0,
        boxShadow: const [],
        backgroundColor: backgroundColor,
        outlineBorderColor: outlineBorderColor,
        borderWidth: borderWidth,
        padding: margin,
        child: body,
      ),
    );
  }
}

class _BlurChrome extends StatelessWidget {
  const _BlurChrome({
    required this.blurSigma,
    required this.borderRadius,
    required this.boxShadow,
    required this.backgroundColor,
    required this.outlineBorderColor,
    required this.borderWidth,
    required this.padding,
    required this.child,
  });

  final double blurSigma;
  final double borderRadius;
  final List<BoxShadow> boxShadow;
  final Color backgroundColor;
  final Color outlineBorderColor;
  final double borderWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        borderRadius: radius,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(width: borderWidth, color: outlineBorderColor),
              color: backgroundColor,
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
