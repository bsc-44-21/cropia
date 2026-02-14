import 'package:flutter/material.dart';

class DetectScreen extends StatelessWidget {
  const DetectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disease Detection')),
      body: const Center(
        child: Text('Detect screen — camera & upload placeholder'),
      ),
    );
  }
}
