import 'package:flutter/material.dart';
import '../theme.dart';
import 'detect_screen.dart';
import 'weather_screen.dart';
import 'agribot_screen.dart';
import 'community_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text('Home - Dashboard')),
    WeatherScreen(),
    SizedBox.shrink(), // camera handled by FAB -> route
    AgriBotScreen(),
    CommunityScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.pushNamed(context, '/detect');
      return;
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cropia'), centerTitle: true),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppIconButton(
                activeIcon: Icons.home,
                inactiveIcon: Icons.home_outlined,
                active: _selectedIndex == 0,
                onPressed: () => _onItemTapped(0),
              ),
              AppIconButton(
                activeIcon: Icons.cloud,
                inactiveIcon: Icons.cloud_outlined,
                active: _selectedIndex == 1,
                onPressed: () => _onItemTapped(1),
              ),
              const SizedBox(width: 48), // space for FAB
              AppIconButton(
                activeIcon: Icons.smart_toy,
                inactiveIcon: Icons.smart_toy_outlined,
                active: _selectedIndex == 3,
                onPressed: () => _onItemTapped(3),
              ),
              AppIconButton(
                activeIcon: Icons.people,
                inactiveIcon: Icons.people_outline,
                active: _selectedIndex == 4,
                onPressed: () => _onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/detect'),
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.camera_alt, color: Colors.white),
      ),
    );
  }
}
