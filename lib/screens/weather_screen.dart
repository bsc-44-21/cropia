import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TOP ROW (Temp + Location)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "23°",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
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
                        "Monday, 11 Feb",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 30),

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
                              )
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
                          )
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

              const SizedBox(height: 30),

              const Text(
                "Weekly Updates",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 170,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _WeeklyCard("26°", "11:19AM", weatherType: WeatherType.whiteWithSun),
                    const SizedBox(width: 12),
                    _WeeklyCard("22°", "12:00PM", weatherType: WeatherType.whiteCloudSun),
                    const SizedBox(width: 12),
                    _WeeklyCard("21°", "14:00PM", weatherType: WeatherType.sunny),
                    const SizedBox(width: 12),
                    _WeeklyCard("24°", "06:30AM", weatherType: WeatherType.darkCloudWithRain),
                    const SizedBox(width: 12),
                    _WeeklyCard("29°", "10:30PM", weatherType: WeatherType.whiteWithSun),
                  ],
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
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
      child: Icon(
        Icons.grain,
        color: color,
        size: 20,
      ),
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
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

enum WeatherType {
  whiteWithSun,
  whiteCloudSun,
  sunny,
  darkCloudWithRain,
}
  