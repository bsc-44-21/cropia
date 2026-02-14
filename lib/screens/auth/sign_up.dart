import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(labelText: 'Full name'),
              ),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(labelText: 'Email')),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(labelText: 'Phone')),
              const SizedBox(height: 12),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
