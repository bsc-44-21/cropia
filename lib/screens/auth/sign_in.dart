import 'package:flutter/material.dart';
import '../../theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _attemptSignIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email == '123@gmail.com' && password == '12345') {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid credentials')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'lib/assets/images/Cropia Logo.jpg',
                  width: 120,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: AppTheme.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _attemptSignIn,
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'OR',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(
                        Icons.g_mobiledata,
                        size: 28,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 20),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(
                        Icons.facebook,
                        size: 28,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.primary,
                    ),
                    child: const Text("Don't have account? Create Account?"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
