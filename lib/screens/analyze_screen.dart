import 'dart:io';

import 'package:flutter/material.dart';

class AnalyzeScreen extends StatefulWidget {
  final File image;
  final double targetSeverity; // 0.0 - 1.0

  const AnalyzeScreen({
    Key? key,
    required this.image,
    this.targetSeverity = 0.68,
  }) : super(key: key);

  @override
  State<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _lineController;
  late final AnimationController _percentController;
  late final Animation<double> _lineAnimation;
  late final Animation<double> _percentAnimation;

  @override
  void initState() {
    super.initState();

    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _percentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _percentAnimation =
        Tween<double>(begin: 0, end: widget.targetSeverity * 100).animate(
          CurvedAnimation(parent: _percentController, curve: Curves.easeOut),
        )..addListener(() {
          setState(() {});
        });

    _lineAnimation = CurvedAnimation(
      parent: _lineController,
      curve: Curves.easeInOut,
    );

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
    return Scaffold(
      appBar: AppBar(title: const Text('Analyzing')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final height = constraints.maxHeight;
                    final lineHeight = 3.0;
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
                                        Colors.green.withOpacity(0.9),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        // optional center label
                        Positioned(
                          bottom: 12,
                          left: 12,
                          right: 12,
                          child: Container(),
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
                    Text('${_percentAnimation.value.round()}%'),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: _percentAnimation.value / 100),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
