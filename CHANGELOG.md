# Changelog

## 2.0.0

### Breaking changes
* Required `onTap` (`ValueChanged<int>`) — no longer optional (avoids null crash).
* Removed unused `enablePaddingAnimation`.
* Icons are typed via `CrystalNavIcon` / constructors — no more `dynamic` icon fields.
* `badge` is now `Widget?` (any widget), not Material `Badge` only.
* Default bar `height` is `86`; custom heights are honored (removed silent 105 floor).
* Non-null defaults for `marginR`, `paddingR`, `borderRadius`, `height`, `backgroundColor`.
* Internal `Body` is no longer exported.

### Features
* Configurable `blurSigma` (applied in floating and non-floating modes).
* Optional item `label` and bar `showLabels`.
* Semantics on each item (button + selected state).
* Material 3 color fallbacks (`ColorScheme.primary`).
* Replaced deprecated `withOpacity` with `withValues`.

### Other
* Restructured `lib/` with a clean public barrel.
* Real widget tests.
* Updated example and README (migration notes).
* SDK `^3.5.0`, Flutter `>=3.24.0`.
* Example uses Material icons (Iconly is incompatible with current Flutter `IconData`).

## 1.1.0
* SVG icon support added - Use `CrystalNavigationBarItem.svg()` constructor to use SVG assets as icons.
* Added `flutter_svg` dependency for SVG rendering support.

## 1.0.4
* Readme Docs Updated.

## 1.0.3
* borderWidth property added.
* badge property added.(to display notification count etc)
* Readme Docs Updated.

## 1.0.2

* Shadow not showing[Fixed].
* Readme Docs Updated.


## 1.0.1

* Bug Fixes
* Readme Docs Updated.

## 1.0.0

* Updated to Flutter 3.16
* BottomBar Height bug resolved.
* Added height parameter for Custom height of BottomNavigationBar

## 0.0.2

* Readme Docs Updated.

## 0.0.1

* initial release.
