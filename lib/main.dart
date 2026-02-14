import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/home_screen.dart';
import 'screens/detect_screen.dart';
import 'screens/weather_screen.dart';
import 'screens/agribot_screen.dart';
import 'screens/community_screen.dart';
import 'screens/tasks_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/auth/sign_in.dart';
import 'screens/auth/sign_up.dart';

void main() {
  runApp(const CropiaApp());
}

class CropiaApp extends StatelessWidget {
  const CropiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cropia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primary),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/detect': (context) => const DetectScreen(),
        '/weather': (context) => const WeatherScreen(),
        '/agribot': (context) => const AgriBotScreen(),
        '/community': (context) => const CommunityScreen(),
        '/tasks': (context) => const TasksScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}
