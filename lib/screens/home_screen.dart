import 'package:flutter/material.dart';
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
              IconButton(
                icon: const Icon(Icons.home_outlined),
                onPressed: () => _onItemTapped(0),
                color: _selectedIndex == 0
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.cloud_outlined),
                onPressed: () => _onItemTapped(1),
                color: _selectedIndex == 1
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              const SizedBox(width: 48), // space for FAB
              IconButton(
                icon: const Icon(Icons.smart_toy_outlined),
                onPressed: () => _onItemTapped(3),
                color: _selectedIndex == 3
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.people_outline),
                onPressed: () => _onItemTapped(4),
                color: _selectedIndex == 4
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/detect'),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
