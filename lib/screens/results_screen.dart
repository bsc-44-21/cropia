import 'dart:io';

import 'package:flutter/material.dart';
import '../theme.dart';

class ResultsScreen extends StatelessWidget {
  final File image;
  final Map<String, dynamic> analysis;

  const ResultsScreen({Key? key, required this.image, required this.analysis})
    : super(key: key);

  Color _riskColor(double risk) {
    if (risk >= 0.75) return Colors.red.shade700;
    if (risk >= 0.4) return Colors.orange.shade700;
    return Colors.green.shade700;
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

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF8FAF8),
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
            Text(
              'Signs & Symptoms',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            ...signs.map(
              (s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        s,
                        style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Prevention Measures',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            ...prevention.map(
              (p) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        p,
                        style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Recommended Chemicals',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            ...chemicals.map(
              (c) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        c,
                        style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: () {
                final shareText = "Check out this disease detection result:\n"
                    "Disease: $disease\n"
                    "Risk: ${(risk * 100).round()}%\n"
                    "Signs: ${signs.take(2).join(', ')}...";
                
                Navigator.pushNamed(
                  context, 
                  '/community',
                  arguments: {
                    'sharedText': shareText,
                    'sharedImage': image.path,
                  },
                );
              },
              icon: const Icon(Icons.share),
              label: const Text('Share to Community', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
         ],
        ),
      ),
    );
  }
}
