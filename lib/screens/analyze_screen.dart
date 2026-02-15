import 'dart:io';

import 'package:flutter/material.dart';

import '../theme.dart';
import 'results_screen.dart';

class AnalyzeScreen extends StatefulWidget {
  final File image;
  const AnalyzeScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _lineController;
  late final AnimationController _percentController;
  late final Animation<double> _lineAnimation;
  late final Animation<double> _percentAnimation;
  bool _navigatedToResults = false;

  @override
  void initState() {
    super.initState();

    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _lineAnimation = CurvedAnimation(
      parent: _lineController,
      curve: Curves.easeInOut,
    );

    _percentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _percentAnimation =
        Tween<double>(begin: 0, end: 100).animate(
          CurvedAnimation(parent: _percentController, curve: Curves.easeOut),
        )..addListener(() {
          setState(() {});
        });

    _percentController.addStatusListener((status) async {
      if (status == AnimationStatus.completed && !_navigatedToResults) {
        _navigatedToResults = true;

        // simulated analysis result
        final result = {
          'disease': 'Early Leaf Spot',
          'signs': [
            'Yellow spots on leaves',
            'Dark lesions with concentric rings',
          ],
          'prevention': ['Improve air circulation', 'Avoid overhead watering'],
          'chemicals': ['Azoxystrobin', 'Chlorothalonil'],
          'risk': 0.68,
        };

        // navigate to results and replace this screen
        if (mounted) {
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) =>
                  ResultsScreen(image: widget.image, analysis: result),
            ),
          );
        }
      }
    });

    _percentController.forward();
  }

  @override
  void dispose() {
    _lineController.dispose();
    _percentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percent = _percentAnimation.value;

    return Scaffold(
      appBar: AppBar(title: const Text('Analyzing')),
      body: Column(
        children: [
          // smaller image area so controls are visible
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final height = constraints.maxHeight;
                    const lineHeight = 3.0;
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: Image.file(widget.image, fit: BoxFit.cover),
                        ),
                        AnimatedBuilder(
                          animation: _lineAnimation,
                          builder: (context, child) {
                            final top =
                                (_lineAnimation.value) * (height - lineHeight);
                            return Positioned(
                              left: 0,
                              right: 0,
                              top: top,
                              child: IgnorePointer(
                                child: Container(
                                  height: lineHeight,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        AppTheme.primary.withOpacity(0.95),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Analysis'),
                    Text('${percent.round()}%'),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: (percent / 100).clamp(0.0, 1.0)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
