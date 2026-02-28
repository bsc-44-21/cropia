import 'package:flutter/material.dart';
import '../theme.dart';

class HistoryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> historyData;

  const HistoryDetailScreen({Key? key, required this.historyData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final disease = historyData['disease'] as String? ?? 'Unknown';
    final date = historyData['date'] as String? ?? 'Unknown Date';
    final signs = (historyData['signs'] as List<dynamic>?)?.cast<String>() ?? [];
    final prevention =
        (historyData['prevention'] as List<dynamic>?)?.cast<String>() ?? [];
    final chemicals =
        (historyData['chemicals'] as List<dynamic>?)?.cast<String>() ?? [];
    final risk = (historyData['risk'] as double?) ?? 0.0;
    final imageName = historyData['imageName'] as String? ?? 'Disease 1.jpg';

    Color _riskColor(double risk) {
      if (risk >= 0.75) return Colors.red.shade600;
      if (risk >= 0.4) return Colors.orange.shade600;
      return Colors.green.shade600;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('History Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'lib/assets/images/$imageName',
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  );
                },
              ),
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
                        const SizedBox(height: 4),
                        Text(
                          'Detected on: $date',
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Risk Level: ${(risk * 100).round()}%',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.history, color: Colors.white70, size: 36),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('Signs & Symptoms'),
            const SizedBox(height: 8),
            ...signs.map((s) => _buildListItem(s)),
            const SizedBox(height: 20),
            _buildSectionHeader('Prevention Measures'),
            const SizedBox(height: 8),
            ...prevention.map((p) => _buildListItem(p)),
            const SizedBox(height: 20),
            _buildSectionHeader('Recommended Chemicals'),
            const SizedBox(height: 8),
            ...chemicals.map((c) => _buildListItem(c)),
            const SizedBox(height: 30),
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
                    'sharedImage': imageName,
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
