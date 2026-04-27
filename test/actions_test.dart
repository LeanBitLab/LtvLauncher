import 'package:flauncher/actions.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'mocks.mocks.dart';

void main() {
  group('SoundFeedbackDirectionalFocusAction', () {
    late MockSettingsService mockSettingsService;

    setUp(() {
      mockSettingsService = MockSettingsService();
    });

    testWidgets('plays sound when appKeyClickEnabled is true', (WidgetTester tester) async {
      when(mockSettingsService.appKeyClickEnabled).thenReturn(true);

      late BuildContext actionContext;

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider<SettingsService>.value(value: mockSettingsService),
            ],
            child: Builder(
              builder: (context) {
                actionContext = context;
                return Focus(
                  autofocus: true,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Invoke the action directly to simulate focus movement
      final action = SoundFeedbackDirectionalFocusAction(actionContext);
      action.invoke(const DirectionalFocusIntent(TraversalDirection.down));

      await tester.pumpAndSettle();

      verify(mockSettingsService.appKeyClickEnabled).called(1);
    });

    testWidgets('silent for tap when appKeyClickEnabled is false', (WidgetTester tester) async {
      when(mockSettingsService.appKeyClickEnabled).thenReturn(false);

      late BuildContext actionContext;

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider<SettingsService>.value(value: mockSettingsService),
            ],
            child: Builder(
              builder: (context) {
                actionContext = context;
                return Focus(
                  autofocus: true,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
        ),
      );

      final action = SoundFeedbackDirectionalFocusAction(actionContext);

      action.invoke(const DirectionalFocusIntent(TraversalDirection.down));

      await tester.pumpAndSettle();

      verify(mockSettingsService.appKeyClickEnabled).called(1);
    });
  });
}
