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

        
