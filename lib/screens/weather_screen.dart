import 'package:flutter/material.dart';

const Color _creopiaGreen = Color(0xFF2E7D32);

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Header
              const Text(
                'Weather Forecast 🌤️',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Plan your farming activities wisely',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),

              const SizedBox(height: 20),
              Divider(color: Colors.grey[300], height: 1),
              const SizedBox(height: 20),

              /// TOP ROW (Temp + Location)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "23°",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: _creopiaGreen,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Chikanda, Zomba",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Partly Cloudy",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Monday, 11 Feb",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Weather Alert Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Rainy day expected. Plan harvest accordingly.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// 🌤 MODERN WEATHER ICON (Centered & Realistic) - KEPT INTACT
              Center(
                child: SizedBox(
                  height: 200,
                  width: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      /// SUN WITH GLOW
                      Positioned(
                        top: 15,
                        left: 45,
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.orange.shade300,
                                Colors.orange.shade500,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.4),
                                blurRadius: 25,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// CLOUD
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              /// Cloud circles
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _cloudCircle(60),
                                  _cloudCircle(85),
                                  _cloudCircle(65),
                                ],
                              ),

                              /// Base cloud
                              Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          /// RAIN DROPS
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _rainDrop(Colors.blue.shade400),
                              _rainDrop(Colors.blue.shade500),
                              _rainDrop(Colors.blue.shade400),
                              _rainDrop(Colors.blue.shade300),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// WEATHER STATS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _WeatherInfo(
                    icon: Icons.air,
                    value: "15 km",
                    label: "Wind now",
                  ),
                  _WeatherInfo(
                    icon: Icons.water_drop,
                    value: "46%",
                    label: "Humidity",
                  ),
                  _WeatherInfo(
                    icon: Icons.umbrella,
                    value: "87%",
                    label: "Precipitation",
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Divider
              Divider(color: Colors.grey[300], height: 1),
              const SizedBox(height: 20),

              // Weekly Updates Header with See All
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Weekly Updates",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                    ),
                    child: const Text(
                      'See All',
                      style: TextStyle(color: _creopiaGreen, fontSize: 13),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 170,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _WeeklyCard(
                      "26°",
                      "11:19AM",
                      weatherType: WeatherType.whiteWithSun,
                    ),
                    const SizedBox(width: 12),
                    _WeeklyCard(
                      "22°",
                      "12:00PM",
                      weatherType: WeatherType.whiteCloudSun,
                    ),
                    const SizedBox(width: 12),
                    _WeeklyCard(
                      "21°",
                      "14:00PM",
                      weatherType: WeatherType.sunny,
                    ),
                    const SizedBox(width: 12),
                    _WeeklyCard(
                      "24°",
                      "06:30AM",
                      weatherType: WeatherType.darkCloudWithRain,
                    ),
                    const SizedBox(width: 12),
                    _WeeklyCard(
                      "29°",
                      "10:30PM",
                      weatherType: WeatherType.whiteWithSun,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
    );
  }

  /// Cloud Circle Builder
  static Widget _cloudCircle(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        shape: BoxShape.circle,
      ),
    );
  }

  /// Rain Drop Builder
  static Widget _rainDrop(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Icon(Icons.grain, color: color, size: 20),
    );
  }
}

/// Weather Info Widget
class _WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _WeatherInfo({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Icon(icon, color: _creopiaGreen, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}

enum WeatherType { whiteWithSun, whiteCloudSun, sunny, darkCloudWithRain }

/// Weekly Card with different cloud types - Darker background
class _WeeklyCard extends StatelessWidget {
  final String temp;
  final String time;
  final WeatherType weatherType;

  const _WeeklyCard(this.temp, this.time, {required this.weatherType});

  Widget _getWeatherIcon() {
    switch (weatherType) {
      case WeatherType.whiteWithSun:
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.cloud, size: 32, color: Colors.grey[300]),
            Positioned(
              top: -8,
              right: -8,
              child: Icon(Icons.wb_sunny, size: 18, color: Colors.orange[400]),
            ),
          ],
        );

      case WeatherType.whiteCloudSun:
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.cloud, size: 32, color: Colors.grey[300]),
            Positioned(
              top: -5,
              left: -5,
              child: Icon(Icons.wb_sunny, size: 16, color: Colors.orange[300]),
            ),
          ],
        );

      case WeatherType.sunny:
        return Icon(Icons.wb_sunny, size: 28, color: Colors.orange[400]);

      case WeatherType.darkCloudWithRain:
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Icon(Icons.cloud, size: 32, color: Colors.grey[700]),
            Positioned(
              bottom: -8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.grain, size: 12, color: Colors.blue[500]),
                  const SizedBox(width: 2),
                  Icon(Icons.grain, size: 14, color: Colors.blue[400]),
                  const SizedBox(width: 2),
                  Icon(Icons.grain, size: 12, color: Colors.blue[500]),
                ],
              ),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: _creopiaGreen.withOpacity(0.2), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            temp,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: _creopiaGreen,
            ),
          ),
          const SizedBox(height: 8),
          _getWeatherIcon(),
          const SizedBox(height: 12),
          Text(
            time,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
