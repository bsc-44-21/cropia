import 'dart:io';

import 'package:flutter/material.dart';
import '../theme.dart';

class ResultsScreen extends StatelessWidget {
  final File image;
  final Map<String, dynamic> analysis;

  const ResultsScreen({Key? key, required this.image, required this.analysis})
    : super(key: key);

  Color _riskColor(double risk) {
    if (risk >= 0.75) return Colors.red.shade600;
    if (risk >= 0.4) return Colors.orange.shade600;
    return Colors.green.shade600;
  }

  @override
  Widget build(BuildContext context) {
    final disease = analysis['disease'] as String? ?? 'Unknown';
    final signs = (analysis['signs'] as List<dynamic>?)?.cast<String>() ?? [];
    final prevention =
        (analysis['prevention'] as List<dynamic>?)?.cast<String>() ?? [];
    final chemicals =
        (analysis['chemicals'] as List<dynamic>?)?.cast<String>() ?? [];
    final risk = (analysis['risk'] as double?) ?? 0.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(image, height: 200, fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _riskColor(risk),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          disease,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Risk: ${(risk * 100).round()}%',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.warning, color: Colors.white70, size: 36),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Signs & Symptoms',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            ...signs.map(
              (s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text('- $s'),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Prevention Measures',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            ...prevention.map(
              (p) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text('- $p'),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Recommended Chemicals',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            ...chemicals.map(
              (c) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text('- $c'),
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
              ),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
