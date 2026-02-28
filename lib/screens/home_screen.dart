import 'package:flutter/material.dart';
import '../theme.dart';
import 'weather_screen.dart';
import 'agribot_screen.dart';
import 'community_screen.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting
          Text(
            'Hello, Mr.Luwiji! 👋',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Welcome back. Here\'s your farm dashboard',
            style: TextStyle(fontSize: 13, color: isDark ? Colors.grey[400] : Colors.grey[600]),
          ),

          const SizedBox(height: 20),

          // Location Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.primary.withOpacity(isDark ? 0.4 : 0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
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
                      style: TextStyle(fontSize: 16, color: isDark ? Colors.grey[300] : Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Divider(color: isDark ? Colors.grey[800] : Colors.grey[300], height: 1),
          const SizedBox(height: 20),

          // Cropia Tools header
          Text(
            'Cropia Tools',
            style: TextStyle(
              fontSize: 15, 
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
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
          Divider(color: isDark ? Colors.grey[800] : Colors.grey[300], height: 1),
          const SizedBox(height: 20),

          // 🔥 Trending Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Now',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
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
                  child: _buildTrendingImage(context, index: index),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
          Divider(color: isDark ? Colors.grey[800] : Colors.grey[300], height: 1),
          const SizedBox(height: 20),

          // Tips Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Last Detects',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
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
              _buildHistoryCard(
                context,
                {
                  'disease': 'Tomato Early Blight',
                  'date': '2026-02-27',
                  'imageName': 'Disease 1.jpg',
                  'description': 'Target-like spots on older leaves, starting near the ground.',
                  'signs': ['Concentric rings in spots', 'Yellowing around spots', 'Stem lesions'],
                  'prevention': ['Crop rotation', 'Remove infected debris', 'Copper-based fungicides'],
                  'chemicals': ['Chlorothalonil', 'Mancozeb', 'Copper Fungicide'],
                  'risk': 0.85,
                },
              ),
              const SizedBox(height: 12),
              _buildHistoryCard(
                context,
                {
                  'disease': 'Maize Rust',
                  'date': '2026-02-25',
                  'imageName': 'Disease 2.jpg',
                  'description': 'Small, powdery, orange-to-brown pustules on leaf surfaces.',
                  'signs': ['Orange pustules', 'Leaf yellowing', 'Reduced grain fill'],
                  'prevention': ['Resistant varieties', 'Early planting', 'Foliar fungicides'],
                  'chemicals': ['Azoxystrobin', 'Propiconazole', 'Pyraclostrobin'],
                  'risk': 0.45,
                },
              ),
              const SizedBox(height: 12),
              _buildHistoryCard(
                context,
                {
                  'disease': 'Potato Late Blight',
                  'date': '2026-02-20',
                  'imageName': 'Disease 3.jpg',
                  'description': 'Dark, water-soaked patches on leaves and stems.',
                  'signs': ['Large dark spots', 'White fuzzy growth', 'Tuber rot'],
                  'prevention': ['Certified seed tubers', 'Destroy cull piles', 'Timely fungicide application'],
                  'chemicals': ['Revus Top', 'Orondis Ultra', 'Ranman'],
                  'risk': 0.92,
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolItem(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.primary, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12, 
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildHistoryCard(BuildContext context, Map<String, dynamic> data) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/history_detail',
          arguments: data,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[100]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'lib/assets/images/${data['imageName']}',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['disease'],
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Detected on ${data['date']}',
                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[500], fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Risk: ${(data['risk'] * 100).round()}%',
                      style: const TextStyle(
                        color: AppTheme.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingImage(BuildContext context, {required int index}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
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
        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.12),
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
    if (index == 3) {
      Navigator.pushNamed(context, '/agribot');
      return;
    }
    if (index == 4) {
      Navigator.pushNamed(context, '/community');
      return;
    }
    setState(() => _selectedIndex = index);
  }

  void onToolTap(int index) {
    if (index == 3) {
      Navigator.pushNamed(context, '/agribot');
      return;
    }
    if (index == 4) {
      Navigator.pushNamed(context, '/community');
      return;
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
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
