import 'package:flutter_test/flutter_test.dart';

import 'package:loady_overlay/loady_overlay.dart';

import 'package:flutter/material.dart';
import 'package:loady_overlay/src/loady_overlay_source.dart';
import 'package:mockito/mockito.dart';
// Replace with actual package path

// Mock navigator observer to track route changes
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('LoadyOverlay', () {
    late MockNavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    testWidgets('show() displays loading overlay', (WidgetTester tester) async {
      // Create a test app with a navigator and observer
      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [mockObserver],
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    LoadyOverlay.show(context);
                  },
                  child: const Text('Show Loading'),
                );
              },
            ),
          ),
        ),
      );

      // Find and tap the button to show loading
      await tester.tap(find.text('Show Loading'));

      // Use a shorter timeout and more explicit waiting
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));

      // Verify the default loading widget is displayed
      expect(find.byType(DefaultLoadyOverlayWidget), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('show() with custom config works', (WidgetTester tester) async {
      // Custom widget to test config
      final customWidget = Container(
        color: Colors.red,
        child: const Text('Custom Loading'),
      );

      // Create a test app with a custom loading config
      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [mockObserver],
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () => LoadyOverlay.show(
                    context,
                    config: LoadyOverlayConfig(
                      backgroundColor: Colors.green,
                      builder: (_) => customWidget,
                    ),
                  ),
                  child: const Text('Show Custom Loading'),
                );
              },
            ),
          ),
        ),
      );

      // Find and tap the button to show custom loading
      await tester.tap(find.text('Show Custom Loading'));

      // More extensive pumping to ensure overlay is rendered
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));

      // Print out all current widgets for debugging
      print('Current widgets:');
      tester.allWidgets.forEach((widget) {
        print('${widget.runtimeType}: $widget');
      });

      // Debug print for overlay finding
      print('Trying to find custom widget');

      // Try multiple ways of finding the widget
      final containerFinder = find.byType(Container);
      final customWidgetFinder = find.byWidget(customWidget);
      final redContainerFinder = find.byWidgetPredicate(
        (Widget widget) => widget is Container && widget.color == Colors.red,
        description: 'Red Container',
      );

      // Print out findings
      print('Container count: ${containerFinder.evaluate().length}');
      print('Custom widget count: ${customWidgetFinder.evaluate().length}');
      print('Red container count: ${redContainerFinder.evaluate().length}');

      // Verify custom widget is displayed using multiple approaches
      expect(customWidgetFinder, findsOneWidget,
          reason: 'Custom widget should be visible after show() is called');

      // Additional checks for the red container
      expect(redContainerFinder, findsOneWidget,
          reason: 'Red container should be visible after show() is called');

      // Optional: Check for text within the custom widget
      expect(find.text('Custom Loading'), findsOneWidget,
          reason: 'Custom loading text should be visible');
    });
    testWidgets('hide() removes loading overlay', (WidgetTester tester) async {
      // Create a test app with a navigator and observer
      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [mockObserver],
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    // Add print statements for debugging
                    print('Attempting to show overlay');
                    LoadyOverlay.show(context);
                    print('Show overlay called');

                    // Hide the overlay after a short delay
                    Future.delayed(const Duration(milliseconds: 200), () {
                      print('Attempting to hide overlay');
                      LoadyOverlay.hide(context);
                      print('Hide overlay called');
                    });
                  },
                  child: const Text('Show and Hide Loading'),
                );
              },
            ),
          ),
        ),
      );

      // Find and tap the button to show and then hide loading
      await tester.tap(find.text('Show and Hide Loading'));

      // More extensive pumping to ensure overlay is rendered
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));

      // Print out all current widgets for debugging
      print('Current widgets:');
      tester.allWidgets.forEach((widget) {
        print(widget.runtimeType);
      });

      // Try finding the overlay with more flexible matching
      final overlayFinder = find.byWidgetPredicate(
        (Widget widget) =>
            widget.runtimeType.toString() == 'DefaultLoadyOverlayWidget',
        description: 'DefaultLoadyOverlayWidget',
      );

      // Verify loading overlay is displayed
      expect(overlayFinder, findsOneWidget,
          reason: 'LoadyOverlay should be visible after show() is called');

      // Wait for hide method to be called
      await tester.pump(const Duration(milliseconds: 300));

      // Verify loading overlay is removed
      expect(overlayFinder, findsNothing,
          reason: 'LoadyOverlay should be removed after hide() is called');
    });

    testWidgets('hide() does nothing if no overlay is shown',
        (WidgetTester tester) async {
      // Create a test app
      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [mockObserver],
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    // Try to hide overlay without showing it first
                    LoadyOverlay.hide(context);
                  },
                  child: const Text('Try Hide Without Show'),
                );
              },
            ),
          ),
        ),
      );

      // Find and tap the button
      await tester.tap(find.text('Try Hide Without Show'));

      // Pump to process the hide method
      await tester.pump();

      // Verify no errors and no overlay is present
      expect(find.byType(DefaultLoadyOverlayWidget), findsNothing);
    });
  });
}
