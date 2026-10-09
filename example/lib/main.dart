import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum _SelectedTab { home, favorite, add, search, person }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crystal Navigation Bar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedTab = _SelectedTab.home;
  var _showLabels = false;

  void _handleIndexChanged(int i) {
    setState(() => _selectedTab = _SelectedTab.values[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.pexels.com/photos/1671325/pexels-photo-1671325.jpeg'
            '?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.blueGrey.shade800,
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.25)),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: FilterChip(
                      label: Text(_showLabels ? 'Labels on' : 'Labels off'),
                      selected: _showLabels,
                      onSelected: (v) => setState(() => _showLabels = v),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _selectedTab.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        onTap: _handleIndexChanged,
        showLabels: _showLabels,
        blurSigma: 14,
        indicatorColor: Colors.white,
        unselectedItemColor: Colors.white54,
        borderWidth: 1.5,
        outlineBorderColor: Colors.white.withValues(alpha: 0.55),
        backgroundColor: Colors.black.withValues(alpha: 0.45),
        items: [
          CrystalNavigationBarItem(
            icon: Icons.home,
            unselectedIcon: Icons.home_outlined,
            selectedColor: Colors.white,
            label: 'Home',
            badge: Badge(
              backgroundColor: const Color(0xFFE53935),
              textColor: Colors.white,
              label: const Text(
                '9+',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          CrystalNavigationBarItem(
            icon: Icons.favorite,
            unselectedIcon: Icons.favorite_border,
            selectedColor: const Color(0xFFFF5252),
            label: 'Liked',
          ),
          CrystalNavigationBarItem(
            icon: Icons.add_circle,
            unselectedIcon: Icons.add_circle_outline,
            selectedColor: const Color(0xFF69F0AE),
            label: 'Add',
          ),
          CrystalNavigationBarItem(
            icon: Icons.search,
            unselectedIcon: Icons.search_outlined,
            selectedColor: const Color(0xFF40C4FF),
            label: 'Search',
          ),
          CrystalNavigationBarItem(
            icon: Icons.person,
            unselectedIcon: Icons.person_outline,
            selectedColor: const Color(0xFFFFD740),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
