import 'package:flutter/material.dart';
import '../theme.dart';
import '../main.dart'; // Import themeNotifier

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  String? _profileImage; // Simulated profile image state

  void _changeProfileImage() {
    setState(() {
      // Simulation: toggle between an icon-based avatar and a colored one
      _profileImage = _profileImage == null ? "active" : null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile picture updated successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, _) {
        bool isDark = currentTheme == ThemeMode.dark;
        
        return Scaffold(
          backgroundColor: isDark ? null : const Color(0xFFF8FAF8),
          appBar: AppBar(
            title: const Text("Profile & Settings", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: isDark ? Colors.grey[900] : Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileHeader(isDark),
                const SizedBox(height: 20),
                _buildSettingsSection(
                  "Account Settings",
                  [
                    _buildToggleItem(
                      Icons.notifications_outlined,
                      "Push Notifications",
                      _notificationsEnabled,
                      (val) => setState(() => _notificationsEnabled = val),
                    ),
                    _buildMenuItem(Icons.lock_outline, "Privacy & Security", () {}),
                  ],
                  isDark,
                ),
                const SizedBox(height: 20),
                _buildSettingsSection(
                  "App Settings",
                  [
                    _buildToggleItem(
                      Icons.dark_mode_outlined,
                      "Dark Mode",
                      isDark,
                      (val) {
                        themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
                      },
                    ),
                    _buildMenuItem(Icons.language_outlined, "Language", () {}, trailingText: "English"),
                  ],
                  isDark,
                ),
                const SizedBox(height: 20),
                _buildSettingsSection(
                  "Information & Support",
                  [
                    _buildMenuItem(Icons.help_outline, "User Guide", () {}),
                    _buildMenuItem(Icons.policy_outlined, "Privacy Policy", () {}),
                    _buildMenuItem(Icons.info_outline, "Terms & Conditions", () {}),
                  ],
                  isDark,
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[50],
                        foregroundColor: Colors.red,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Log Out", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text("Cropia v1.0.4", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(bool isDark) {
    return Container(
      width: double.infinity,
      color: isDark ? Colors.grey[900] : Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: _profileImage == null 
                  ? AppTheme.primary.withOpacity(0.1)
                  : Colors.orange[200],
                child: Icon(
                  _profileImage == null ? Icons.person : Icons.face, 
                  size: 50, 
                  color: _profileImage == null ? AppTheme.primary : Colors.brown,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _changeProfileImage,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
                    child: const Icon(Icons.edit, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Chikondi Phiri",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "+265 991 234 567 • Lilongwe, Malawi",
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[500]),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {String? trailingText}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppTheme.primary, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(trailingText, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
          const SizedBox(width: 4),
          Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
        ],
      ),
    );
  }

  Widget _buildToggleItem(IconData icon, String title, bool value, Function(bool) onChanged) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primary, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primary,
      ),
    );
  }
}
