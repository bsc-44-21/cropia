// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cropia/main.dart';

void main() {
  testWidgets('App loads and shows home UI', (WidgetTester tester) async {
    // Build the app and settle
    await tester.pumpWidget(const CropiaApp());
    await tester.pumpAndSettle();

    // AppBar title should be present
    expect(find.text('Cropia'), findsOneWidget);

    // Camera FAB should be present
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);
  });
}
