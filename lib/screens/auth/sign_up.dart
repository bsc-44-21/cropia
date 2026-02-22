import 'package:flutter/material.dart';
import '../../theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const Color primaryGreen = Color(0xFF0B8F2F);
  static const Color lightGrey = Color(0xFFF1F1F1);
  static const Color darkText = Color(0xFF222222);
  static const Color hintGrey = Color(0xFF9E9E9E);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _attemptSignUp() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email == '123@gmail.com' && password == '12345') {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Use email 123@gmail.com and password 12345'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
<<<<<<< HEAD
              const SizedBox(height: 60),

              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),

              const SizedBox(height: 24),

              buildField("Full Name"),
              buildField("Email"),
              buildField("Phone Number"),
              buildField("Password", obscure: true),

              const SizedBox(height: 24),

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
                    'Create Account',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
=======
              const SizedBox(height: 12),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
>>>>>>> a4d6842fd35c376147e912877059963073ab060e
              ),

              const SizedBox(height: 20),
<<<<<<< HEAD

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: const Text(
                    "Already have account? Sign In",
                    style: TextStyle(color: darkText),
                  ),
                ),
=======
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.white,
                ),
                onPressed: _attemptSignUp,
                child: const Text('Create Account'),
>>>>>>> a4d6842fd35c376147e912877059963073ab060e
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(String hint, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
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
    );
  }
}
