# Crystal Navigation Bar

A frosted, floating bottom navigation bar with blur, animated indicator, badges, optional labels, and typed IconData / SVG icons.

<p align="center">
  <img src="https://img.shields.io/badge/Maintained%3F-Yes-green?style=for-the-badge" alt="Maintained">
  <br>
  <a href="https://pub.dev/packages/crystal_navigation_bar"><img alt="Pub platforms" src="https://badgen.net/pub/flutter-platform/crystal_navigation_bar"></a>
  <a href="https://pub.dev/packages/crystal_navigation_bar"><img alt="Pub SDK" src="https://badgen.net/pub/sdk-version/crystal_navigation_bar"></a>
  <br>
  <a href="https://pub.dev/packages/crystal_navigation_bar"><img alt="Pub version" src="https://badgen.net/pub/v/crystal_navigation_bar"></a>
  <a href="https://pub.dev/packages/crystal_navigation_bar"><img alt="Pub likes" src="https://badgen.net/pub/likes/crystal_navigation_bar"></a>
  <a href="https://pub.dev/packages/crystal_navigation_bar"><img alt="Pub points" src="https://badgen.net/pub/points/crystal_navigation_bar"></a>
</p>

<p align="left">
  <img src="https://github.com/immi420/crystal_navigation_bar/blob/master/screenshots/example.gif?raw=true" width="100%" alt="Demo" />
</p>

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/immi420/crystal_navigation_bar/blob/master/screenshots/screenshot1.png?raw=true" alt="With border" width="300"/>
      <p>Border + floating blur</p>
    </td>
    <td align="center">
      <img src="https://github.com/immi420/crystal_navigation_bar/blob/master/screenshots/screenshot_with_badge.png?raw=true" alt="With badge" width="300"/>
      <p>Badge support</p>
    </td>
  </tr>
</table>

## Features

- Blur / frosted glass navigation bar (`blurSigma`)
- Floating or edge-to-edge modes
- Animated selection indicator
- Badges (any `Widget`)
- Optional text labels
- Typed IconData and SVG icons
- Accessibility semantics

## Install

```yaml
dependencies:
  crystal_navigation_bar: ^2.0.0
```

```dart
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
```

Set `extendBody: true` on your `Scaffold` when using the floating bar so content shows through the blur.

## Basic usage

```dart
Scaffold(
  extendBody: true,
  body: YourBody(),
  bottomNavigationBar: CrystalNavigationBar(
    currentIndex: index,
    onTap: (i) => setState(() => index = i),
    unselectedItemColor: Colors.white70,
    backgroundColor: Colors.black.withValues(alpha: 0.35),
    borderWidth: 2,
    outlineBorderColor: Colors.white,
    items: [
      CrystalNavigationBarItem(
        icon: Icons.home,
        unselectedIcon: Icons.home_outlined,
        selectedColor: Colors.white,
        label: 'Home',
        badge: Badge(label: Text('9+')),
      ),
      CrystalNavigationBarItem(
        icon: Icons.search,
        unselectedIcon: Icons.search_outlined,
        selectedColor: Colors.white,
        label: 'Search',
      ),
    ],
  ),
);
```

### SVG icons

Declare assets in your app, then:

```dart
CrystalNavigationBarItem.svg(
  iconPath: 'assets/icons/home.svg',
  unselectedIconPath: 'assets/icons/home_outline.svg',
  label: 'Home',
)
```

Or use `CrystalNavigationBarItem.custom` with `CrystalNavIcon.data` / `CrystalNavIcon.svg`.

## Migrating from 1.x

| 1.x | 2.0 |
|-----|-----|
| Optional `onTap` | **Required** `onTap` |
| `enablePaddingAnimation` | **Removed** (was unused) |
| `dynamic` icons | Typed constructors / `CrystalNavIcon` |
| `Badge? badge` | `Widget? badge` |
| Height floored to 105 | Custom `height` honored (default `86`) |
| Exported `Body` | **Not exported** |
| — | New: `blurSigma`, `showLabels`, item `label` |

## Parameters

**CrystalNavigationBar**

| Parameter | Description |
|-----------|-------------|
| `items` | Tabs to show |
| `currentIndex` | Selected index |
| `onTap` | Tap callback |
| `height` | Bar height (default `86`) |
| `selectedItemColor` / `unselectedItemColor` | Fallback icon/label colors |
| `indicatorColor` | Indicator color |
| `backgroundColor` | Fill behind blur |
| `outlineBorderColor` / `borderWidth` | Border |
| `borderRadius` | Corner radius |
| `marginR` / `paddingR` | Floating margins / inner padding |
| `margin` / `itemPadding` | Non-floating / per-item padding |
| `duration` / `curve` | Selection animation |
| `boxShadow` | Floating shadows |
| `enableFloatingNavBar` | Floating vs edge-to-edge |
| `blurSigma` | Backdrop blur strength |
| `showLabels` | Show item labels |
| `splashColor` / `splashBorderRadius` | Ink splash |

**CrystalNavigationBarItem**

| Parameter | Description |
|-----------|-------------|
| `icon` / `unselectedIcon` | Via constructors |
| `selectedColor` / `unselectedColor` | Per-item colors |
| `badge` | Any overlay widget |
| `label` | Optional text when `showLabels` is true |

Adjust colors for your UI. See [example/lib/main.dart](example/lib/main.dart) for a full demo.

## Contributing

Pull requests are welcome.

## Contributors

Imtiaz Ahmad

- [Twitter](https://twitter.com/its_immi)
- [GitHub](https://github.com/immi420)
- [LinkedIn](https://www.linkedin.com/in/imtiazahmadofficial/)
