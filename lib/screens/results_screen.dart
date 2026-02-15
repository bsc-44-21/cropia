import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart' as pdf;
import 'package:path_provider/path_provider.dart';

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
            ElevatedButton.icon(
              onPressed: () async {
                final summary = _buildSummary(
                  disease,
                  signs,
                  prevention,
                  chemicals,
                  risk,
                );
                await _exportPdf(context, summary);
              },
              icon: const Icon(Icons.download),
              label: const Text('Download PDF'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
              ),
            ),
            const SizedBox(height: 12),
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

  String _buildSummary(
    String disease,
    List<String> signs,
    List<String> prevention,
    List<String> chemicals,
    double risk,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('Disease: $disease');
    buffer.writeln('Risk: ${(risk * 100).round()}%');
    buffer.writeln('\nSigns & Symptoms:');
    for (final s in signs) buffer.writeln('- $s');
    buffer.writeln('\nPrevention Measures:');
    for (final p in prevention) buffer.writeln('- $p');
    buffer.writeln('\nRecommended Chemicals:');
    for (final c in chemicals) buffer.writeln('- $c');
    return buffer.toString();
  }

  Future<void> _exportPdf(BuildContext context, String summary) async {
    try {
      final pdfDoc = pw.Document();
      final imageBytes = await image.readAsBytes();
      final pwImage = pw.MemoryImage(imageBytes);

      pdfDoc.addPage(
        pw.MultiPage(
          pageFormat: pdf.PdfPageFormat.a4,
          build: (pw.Context ctx) => [
            pw.Center(
              child: pw.Image(
                pwImage,
                width: 400,
                height: 300,
                fit: pw.BoxFit.cover,
              ),
            ),
            pw.SizedBox(height: 12),
            pw.Text(summary),
          ],
        ),
      );

      // Try to save into the device Downloads folder (Android). Fall back to temp dir.
      Directory targetDir;
      try {
        final dirs = await getExternalStorageDirectories(
          type: StorageDirectory.downloads,
        );
        if (dirs != null && dirs.isNotEmpty) {
          targetDir = dirs.first;
        } else {
          targetDir = await getTemporaryDirectory();
        }
      } catch (_) {
        targetDir = await getTemporaryDirectory();
      }

      final file = File(
        '${targetDir.path}/cropia_result_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await file.writeAsBytes(await pdfDoc.save());

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Saved PDF to ${file.path}')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error exporting PDF: $e')));
    }
  }
}
