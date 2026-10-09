import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'crystal_navigation_bar_item.dart';
import 'icon_source.dart';

/// Internal row of animated nav items. Not part of the public API.
class NavigationBarBody extends StatelessWidget {
  const NavigationBarBody({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.curve,
    required this.duration,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.onTap,
    required this.itemPadding,
    required this.indicatorColor,
    required this.showLabels,
    this.splashBorderRadius,
    this.splashColor,
  });

  final List<CrystalNavigationBarItem> items;
  final int currentIndex;
  final Curve curve;
  final Duration duration;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final ValueChanged<int> onTap;
  final EdgeInsets itemPadding;
  final Color? indicatorColor;
  final bool showLabels;
  final Color? splashColor;
  final double? splashBorderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var index = 0; index < items.length; index++)
          _NavItem(
            item: items[index],
            index: index,
            selected: index == currentIndex,
            curve: curve,
            duration: duration,
            selectedItemColor: selectedItemColor,
            unselectedItemColor: unselectedItemColor,
            primaryColor: colorScheme.primary,
            fallbackUnselected: theme.iconTheme.color ?? colorScheme.onSurface,
            onTap: onTap,
            itemPadding: itemPadding,
            indicatorColor: indicatorColor,
            showLabels: showLabels,
            splashColor: splashColor,
            splashBorderRadius: splashBorderRadius,
          ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.index,
    required this.selected,
    required this.curve,
    required this.duration,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.primaryColor,
    required this.fallbackUnselected,
    required this.onTap,
    required this.itemPadding,
    required this.indicatorColor,
    required this.showLabels,
    required this.splashColor,
    required this.splashBorderRadius,
  });

  final CrystalNavigationBarItem item;
  final int index;
  final bool selected;
  final Curve curve;
  final Duration duration;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Color primaryColor;
  final Color fallbackUnselected;
  final ValueChanged<int> onTap;
  final EdgeInsets itemPadding;
  final Color? indicatorColor;
  final bool showLabels;
  final Color? splashColor;
  final double? splashBorderRadius;

  @override
  Widget build(BuildContext context) {
    final selectedColor =
        item.selectedColor ?? selectedItemColor ?? primaryColor;
    final unselectedColor =
        item.unselectedColor ?? unselectedItemColor ?? fallbackUnselected;
    final semanticsLabel = item.label ?? 'Tab ${index + 1}';

    return Expanded(
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: selected ? 1.0 : 0.0),
        curve: curve,
        duration: duration,
        builder: (context, t, _) {
          final color = Color.lerp(unselectedColor, selectedColor, t)!;
          final splash = splashColor ?? selectedColor.withValues(alpha: 0.1);

          return Semantics(
            button: true,
            selected: selected,
            label: semanticsLabel,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(splashBorderRadius ?? 8),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => onTap(index),
                focusColor: splash,
                highlightColor: splash,
                splashColor: splash,
                hoverColor: splash,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: itemPadding,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildIcon(
                            selected ? item.icon : (item.unselectedIcon ?? item.icon),
                            color,
                          ),
                          if (showLabels && item.label != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              item.label!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: color,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (item.badge != null)
                      Positioned(
                        top: 0,
                        right: 8,
                        child: item.badge!,
                      ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Center(
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.center,
                            widthFactor: t.clamp(0.0, 1.0),
                            child: Container(
                              height: 2,
                              width: 16,
                              decoration: BoxDecoration(
                                color: indicatorColor ?? selectedColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIcon(CrystalNavIcon source, Color color) {
    return switch (source) {
      CrystalIconData(:final icon) => Icon(icon, size: 24, color: color),
      CrystalSvgIcon(:final assetPath) => SvgPicture.asset(
          assetPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
    };
  }
}
