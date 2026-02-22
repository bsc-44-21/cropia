import 'package:flutter/material.dart';
import '../theme.dart';
import 'weather_screen.dart';
import 'agribot_screen.dart';
import 'community_screen.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting
          const Text(
            'Hello, Mr.Luwiji! 👋',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Welcome back. Here\'s your farm dashboard',
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),

          const SizedBox(height: 20),

          // Location Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: AppTheme.primary, size: 20),
                    const SizedBox(width: 4),
                    const Text(
                      'Zomba',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('🌤️', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 8),
                    Text(
                      '26 °C',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Divider(color: Colors.grey[300], height: 1),
          const SizedBox(height: 20),

          // Cropia Tools header
          const Text(
            'Cropia Tools',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // 🔲 2x2 Tools Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 8,
            childAspectRatio: 1.3,
            children: [
              _buildToolItem(
                context,
                icon: Icons.health_and_safety,
                label: 'Disease Detector',
                onTap: () => Navigator.pushNamed(context, '/detect'),
              ),
              _buildToolItem(
                context,
                icon: Icons.smart_toy,
                label: 'Agribot Assistant',
                onTap: () => context
                    .findAncestorStateOfType<_HomeScreenState>()
                    ?.onToolTap(3),
              ),
              _buildToolItem(
                context,
                icon: Icons.cloud,
                label: 'Weather Notifier',
                onTap: () => context
                    .findAncestorStateOfType<_HomeScreenState>()
                    ?.onToolTap(1),
              ),
              _buildToolItem(
                context,
                icon: Icons.people,
                label: 'Live Community',
                onTap: () => context
                    .findAncestorStateOfType<_HomeScreenState>()
                    ?.onToolTap(4),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Divider(color: Colors.grey[300], height: 1),
          const SizedBox(height: 20),

          // 🔥 Trending Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Trending Now',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                ),
                child: Text(
                  'See All',
                  style: TextStyle(color: AppTheme.primary, fontSize: 13),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 140,
                  child: _buildTrendingImage(index: index),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
          Divider(color: Colors.grey[300], height: 1),
          const SizedBox(height: 20),

          // Tips Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Agricultural Tips',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                ),
                child: Text(
                  'See All',
                  style: TextStyle(color: AppTheme.primary, fontSize: 13),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Column(
            children: [
              _buildTipCard(
                '1. In the morning',
                'Disease 1.jpg',
                'Best time to water crops early before sunrise for optimal absorption',
              ),
              const SizedBox(height: 12),
              _buildTipCard(
                '2. After sunset',
                'Disease 2.jpg',
                'Water your plants in evening to minimize evaporation loss',
              ),
              const SizedBox(height: 12),
              _buildTipCard(
                '3. Take care',
                'Disease 3.jpg',
                'Regular monitoring helps detect diseases early and prevent spread',
              ),
              const SizedBox(height: 12),
              _buildTipCard(
                '4. Use cool water',
                'Disease 4.jpg',
                'Room temperature water reduces plant stress and shock',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.primary, size: 22),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(String tipText, String imageName, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tipText,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'lib/assets/images/$imageName',
              height: 70,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingImage({int index = 0}) {
    final diseases = [
      'Disease 1.jpg',
      'Disease 2.jpg',
      'Disease 3.jpg',
      'Disease 4.jpg',
    ];
    final diseaseImage = diseases[index % diseases.length];
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'lib/assets/images/$diseaseImage',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.28)),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Trending',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
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
    HomeContent(),
    WeatherScreen(),
    SizedBox.shrink(),
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

  void onToolTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
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
              const SizedBox(width: 48),
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
