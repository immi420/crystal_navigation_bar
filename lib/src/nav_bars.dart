import 'dart:ui';

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';

class CrystalNavigationBar extends StatelessWidget {
  const CrystalNavigationBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.height = 105,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
    this.indicatorColor,
    this.marginR = const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
    this.paddingR = const EdgeInsets.only(bottom: 5, top: 10),
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
        offset: Offset(0, 0), // changes position of shadow
      ),
    ],
    this.enableFloatingNavBar = true,
    this.enablePaddingAnimation = true,
    this.splashColor,
  });

  /// A list of tabs to display, ie `Home`, `Profile`,`Cart`, etc
  final List<CrystalNavigationBarItem> items;

  /// The tab to display.
  final int currentIndex;

  /// Returns the index of the tab that was tapped.
  final Function(int)? onTap;

  /// The color of the icon and text when the item is selected.
  final Color? selectedItemColor;

  /// The color of the icon and text when the item is not selected.
  final Color? unselectedItemColor;

  /// A convenience field for the margin surrounding the entire widget.
  final EdgeInsets margin;

  /// The padding of each item.
  final EdgeInsets itemPadding;

  /// The transition duration
  final Duration duration;

  /// The transition curve
  final Curve curve;

  /// The color of the bottom indicator.
  final Color? indicatorColor;

  /// margin for the bar to give some radius
  final EdgeInsetsGeometry? marginR;

  /// padding for the bar to give some radius
  final EdgeInsetsGeometry? paddingR;

  /// border radius
  final double? borderRadius;

  ///height
  final double? height;

  ///bgd colors for the nav bar
  final Color? backgroundColor;

  ///outline border colors for the nav bar
  final Color outlineBorderColor;

  ///borderWidth

  final double borderWidth;

  /// List of box shadow
  final List<BoxShadow> boxShadow;
  final bool enableFloatingNavBar;
  final bool enablePaddingAnimation;

  /// Color of the item's Splash Color
  ///
  /// To disable, use `Colors.transparent`
  final Color? splashColor;

  /// Color of the item's Splash Color
  ///
  /// To disable, use `Colors.transparent`
  final double? splashBorderRadius;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return enableFloatingNavBar
        ? BottomAppBar(
            color: Colors.transparent,
            padding: EdgeInsets.zero,
            elevation: 0,
            height: height! < 105 ? 105 : height,
            child: Padding(
              padding: marginR!,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: boxShadow, // Apply the shadow here
                  borderRadius: BorderRadius.circular(borderRadius!),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius!),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                    child: Container(
                      padding: paddingR,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius!),
                        border: Border.all(
                            width: borderWidth, color: outlineBorderColor),
                        color: backgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Body(
                            items: items,
                            currentIndex: currentIndex,
                            curve: curve,
                            duration: duration,
                            selectedItemColor: selectedItemColor,
                            theme: theme,
                            unselectedItemColor: unselectedItemColor,
                            onTap: onTap!,
                            itemPadding: itemPadding,
                            indicatorColor: indicatorColor,
                            splashColor: splashColor,
                            splashBorderRadius: splashBorderRadius),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: backgroundColor,
            child: Padding(
              padding: margin,
              child: Body(
                  items: items,
                  currentIndex: currentIndex,
                  curve: curve,
                  duration: duration,
                  selectedItemColor: selectedItemColor,
                  theme: theme,
                  unselectedItemColor: unselectedItemColor,
                  onTap: onTap!,
                  itemPadding: itemPadding,
                  indicatorColor: indicatorColor,
                  splashColor: splashColor,
                  splashBorderRadius: splashBorderRadius),
            ),
          );
  }
}
