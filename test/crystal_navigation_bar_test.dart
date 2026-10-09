import 'dart:ui' show Tristate;

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(
      extendBody: true,
      body: const SizedBox.expand(),
      bottomNavigationBar: child,
    ),
  );
}

List<CrystalNavigationBarItem> _items({bool withBadge = false}) {
  return [
    CrystalNavigationBarItem(
      icon: Icons.home,
      unselectedIcon: Icons.home_outlined,
      label: 'Home',
      badge: withBadge
          ? const Badge(label: Text('9+', style: TextStyle(fontSize: 10)))
          : null,
    ),
    CrystalNavigationBarItem(
      icon: Icons.search,
      unselectedIcon: Icons.search_outlined,
      label: 'Search',
    ),
    CrystalNavigationBarItem(
      icon: Icons.person,
      unselectedIcon: Icons.person_outline,
      label: 'Profile',
    ),
  ];
}

void main() {
  testWidgets('renders items and reports taps', (tester) async {
    final taps = <int>[];

    await tester.pumpWidget(
      _wrap(
        CrystalNavigationBar(
          currentIndex: 0,
          onTap: taps.add,
          items: _items(),
        ),
      ),
    );

    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.search_outlined), findsOneWidget);
    expect(find.byIcon(Icons.person_outline), findsOneWidget);

    await tester.tap(find.byIcon(Icons.search_outlined));
    await tester.pumpAndSettle();
    expect(taps, [1]);

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();
    expect(taps, [1, 2]);
  });

  testWidgets('selected index shows selected icon', (tester) async {
    await tester.pumpWidget(
      _wrap(
        CrystalNavigationBar(
          currentIndex: 1,
          onTap: (_) {},
          items: _items(),
        ),
      ),
    );

    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byIcon(Icons.person_outline), findsOneWidget);
  });

  testWidgets('shows badge when provided', (tester) async {
    await tester.pumpWidget(
      _wrap(
        CrystalNavigationBar(
          currentIndex: 0,
          onTap: (_) {},
          items: _items(withBadge: true),
        ),
      ),
    );

    expect(find.text('9+'), findsOneWidget);
  });

  testWidgets('shows labels when enabled', (tester) async {
    await tester.pumpWidget(
      _wrap(
        CrystalNavigationBar(
          currentIndex: 0,
          onTap: (_) {},
          showLabels: true,
          items: _items(),
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('semantics mark selected tab', (tester) async {
    final handle = tester.ensureSemantics();
    try {
      await tester.pumpWidget(
        _wrap(
          CrystalNavigationBar(
            currentIndex: 0,
            onTap: (_) {},
            items: _items(),
          ),
        ),
      );

      final home = tester.getSemantics(find.bySemanticsLabel('Home'));
      expect(home.label, 'Home');
      expect(home.flagsCollection.isButton, isTrue);
      expect(home.flagsCollection.isSelected, Tristate.isTrue);

      final search = tester.getSemantics(find.bySemanticsLabel('Search'));
      expect(search.label, 'Search');
      expect(search.flagsCollection.isButton, isTrue);
      expect(search.flagsCollection.isSelected, isNot(Tristate.isTrue));
    } finally {
      handle.dispose();
    }
  });

  test('svg item constructor builds typed icons', () {
    final item = CrystalNavigationBarItem.svg(
      iconPath: 'assets/icons/home.svg',
      unselectedIconPath: 'assets/icons/home_outline.svg',
      label: 'Home',
    );

    expect(item.icon, isA<CrystalSvgIcon>());
    expect(item.unselectedIcon, isA<CrystalSvgIcon>());
    expect((item.icon as CrystalSvgIcon).assetPath, 'assets/icons/home.svg');
  });

  test('icon data factory', () {
    const icon = CrystalNavIcon.data(Icons.star);
    expect(icon, isA<CrystalIconData>());
  });
}
