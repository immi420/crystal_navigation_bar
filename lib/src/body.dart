import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.curve,
    required this.duration,
    required this.selectedItemColor,
    required this.theme,
    required this.unselectedItemColor,
    required this.onTap,
    required this.itemPadding,
    required this.indicatorColor,
    this.splashBorderRadius,
    this.splashColor,
  });

  final List<CrystalNavigationBarItem> items;
  final int currentIndex;
  final Curve curve;
  final Duration duration;
  final Color? selectedItemColor;
  final ThemeData theme;
  final Color? unselectedItemColor;
  final Function(int index) onTap;
  final EdgeInsets itemPadding;
  final Color? indicatorColor;
  // final bool enablePaddingAnimation;
  final Color? splashColor;
  final double? splashBorderRadius;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final item in items)
          TweenAnimationBuilder<double>(
            tween: Tween(
              end: items.indexOf(item) == currentIndex ? 1.0 : 0.0,
            ),
            curve: curve,
            duration: duration,
            builder: (context, t, _) {
              final selectedColor =
                  item.selectedColor ?? selectedItemColor ?? theme.primaryColor;

              final unselectedColor = item.unselectedColor ??
                  unselectedItemColor ??
                  theme.iconTheme.color;

              return Material(
                color: Color.lerp(Colors.transparent, Colors.transparent, t),
                borderRadius: BorderRadius.circular(splashBorderRadius ?? 8),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => onTap.call(items.indexOf(item)),
                  focusColor: splashColor ?? selectedColor.withOpacity(0.1),
                  highlightColor: splashColor ?? selectedColor.withOpacity(0.1),
                  splashColor: splashColor ?? selectedColor.withOpacity(0.1),
                  hoverColor: splashColor ?? selectedColor.withOpacity(0.1),
                  child: Stack(children: <Widget>[
                    Padding(
                      padding: itemPadding +
                          const EdgeInsets.symmetric(
                            horizontal: 2,
                          ),
                      child: Icon(
                        items.indexOf(item) == currentIndex
                            ? item.icon
                            : (item.unselectedIcon ?? item.icon),
                        size: 24,
                        color: Color.lerp(unselectedColor, selectedColor, t),
                      ),
                    ),
                    ClipRect(
                      child: SizedBox(
                        height: 48,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          widthFactor: t,
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: itemPadding.right / 0.63,
                                end: itemPadding.right),
                            child: DefaultTextStyle(
                              style: TextStyle(
                                color: Color.lerp(
                                    selectedColor.withOpacity(0.0),
                                    selectedColor,
                                    t),
                                fontWeight: FontWeight.w600,
                              ),
                              child: Container(
                                height: 2,
                                width: 16,
                                decoration: BoxDecoration(
                                    color: indicatorColor ?? selectedColor,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            },
          ),
      ],
    );
  }
}
