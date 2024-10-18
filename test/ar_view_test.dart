import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ar_view/ar_view.dart'; // Import your AugmentedRealityView widget

void main() {
  testWidgets('BottomNavigationBar has two items', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AugmentedRealityView(),
      ),
    );

    // Check if the BottomNavigationBar contains two items
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byIcon(Icons.camera), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Shows CircularProgressIndicator when camera is initializing',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AugmentedRealityView(),
      ),
    );

    // Check if the CircularProgressIndicator is shown while the camera is initializing
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
