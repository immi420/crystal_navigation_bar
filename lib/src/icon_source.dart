import 'package:flutter/widgets.dart';

/// Typed icon source for [CrystalNavigationBarItem].
sealed class CrystalNavIcon {
  const CrystalNavIcon();

  /// Icon from [IconData] (Material, Cupertino, custom icon fonts, etc.).
  const factory CrystalNavIcon.data(IconData icon) = CrystalIconData;

  /// Icon from an SVG asset path (requires the asset in the host app).
  factory CrystalNavIcon.svg(String assetPath) = CrystalSvgIcon;
}

/// [IconData]-backed nav icon.
final class CrystalIconData extends CrystalNavIcon {
  const CrystalIconData(this.icon);

  final IconData icon;
}

/// SVG asset-backed nav icon.
final class CrystalSvgIcon extends CrystalNavIcon {
  CrystalSvgIcon(this.assetPath)
      : assert(
          assetPath.endsWith('.svg'),
          'SVG path must end with .svg',
        );

  final String assetPath;
}
