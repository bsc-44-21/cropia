import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF2E7D32); // Cropia green
  static const Color black = Colors.black;
  static const Color white = Colors.white;
}

class AppIconButton extends StatelessWidget {
  final IconData activeIcon;
  final IconData inactiveIcon;
  final bool active;
  final VoidCallback onPressed;
  final double activeSize;
  final double inactiveSize;

  const AppIconButton({
    super.key,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.active,
    required this.onPressed,
    this.activeSize = 28,
    this.inactiveSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        active ? activeIcon : inactiveIcon,
        color: active ? AppTheme.primary : AppTheme.black,
        size: active ? activeSize : inactiveSize,
      ),
      onPressed: onPressed,
    );
  }
}
