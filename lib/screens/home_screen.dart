import 'package:flutter/material.dart';
import '../theme.dart';
import 'detect_screen.dart';
import 'weather_screen.dart';
import 'agribot_screen.dart';
import 'community_screen.dart';

// Add this new widget for the home content
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location and Temperature Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: AppTheme.primary, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      'Zomba',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '26 °C (26 °C, 26 °C)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Search tool trending tips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
 decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'search tool trending tips',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

// Cropla Tools Section
          const Text(
            'Cropla Tools',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: [
              _buildToolItem(
                icon: Icons.health_and_safety,
                label: 'Disease Detector',
                onTap: () => Navigator.pushNamed(context, '/detect'),
              ),
              _buildToolItem(
                icon: Icons.smart_toy,
                label: 'Agribot Assistant',
                onTap: () => context.findAncestorStateOfType<_HomeScreenState>()?.onToolTap(3),
              ),
              _buildToolItem(
                icon: Icons.cloud,
                label: 'Weather Notifier',
                onTap: () => context.findAncestorStateOfType<_HomeScreenState>()?.onToolTap(1),
              ),
              _buildToolItem(
                icon: Icons.people,
                label: 'Live Community',
                onTap: () => context.findAncestorStateOfType<_HomeScreenState>()?.onToolTap(4),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Trending Now Section
          const Text(
            'Trending Now',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildTrendingChip('Trending'),
              const SizedBox(width: 8),
              _buildTrendingChip('Trending'),
              const SizedBox(width: 8),
              _buildTrendingChip('Trending'),
            ],
          ),

          const SizedBox(height: 24),

          // Agricultural Tips Section
          const Text(
            'Agricultural Tips',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildTipsColumn([
                  '1. In the morning',
                  '2. After sun set',
                  '3. Take care',
                  '4. Use cool water',
                  '5. Not warm',
                  '6. This is all!',
                ]),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTipsColumn([
                  '1. In the morning',
                  '2. After sun set',
                  '3. Take care',
                  '4. Cold water',
                  '5. Not warm',
                  '6. You got this!',
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

 Widget _buildToolItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppTheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  Widget _buildTrendingChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTipsColumn(List<String> tips) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tips.map((tip) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            tip,
            style: const TextStyle(fontSize: 13),
          ),
        )).toList(),
      ),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeContent(), // Changed from placeholder to actual home content
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

  // Helper method for tool navigation from HomeContent
  void onToolTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cropia', style: TextStyle(color: AppTheme.primary)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
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