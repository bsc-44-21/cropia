import 'package:flutter/material.dart';
import '../../theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const Color primaryGreen = Color(0xFF0B8F2F);
  static const Color lightGrey = Color(0xFFF1F1F1);
  static const Color darkText = Color(0xFF222222);
  static const Color hintGrey = Color(0xFF9E9E9E);

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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
<<<<<<< HEAD
            const Text(
              "Sign In",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
              textAlign: TextAlign.left,
            ),

            const SizedBox(height: 24),

            // Email Field
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: const TextStyle(color: hintGrey),
                filled: true,
                fillColor: lightGrey,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Password Field
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: const TextStyle(color: hintGrey),
                filled: true,
                fillColor: lightGrey,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
=======
            const SizedBox(height: 24),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
>>>>>>> a4d6842fd35c376147e912877059963073ab060e
            ),

            const SizedBox(height: 24),
<<<<<<< HEAD

            // Sign In Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text("OR", style: TextStyle(color: darkText)),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: lightGrey,
                  child: Icon(Icons.g_mobiledata, size: 30, color: Colors.red),
                ),
                SizedBox(width: 20),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: lightGrey,
                  child: Icon(Icons.facebook, color: Colors.blue),
                ),
              ],
            ),

            const SizedBox(height: 24),

            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: const Text(
                'Don’t have account? Create Account',
                style: TextStyle(color: darkText),
              ),
=======
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.white,
              ),
              onPressed: _attemptSignIn,
              child: const Text('Sign In'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              style: TextButton.styleFrom(foregroundColor: AppTheme.primary),
              child: const Text('Create account'),
>>>>>>> a4d6842fd35c376147e912877059963073ab060e
            ),
          ],
        ),
      ),
    );
  }
}
