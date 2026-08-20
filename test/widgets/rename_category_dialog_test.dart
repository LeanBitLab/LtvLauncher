import 'package:flauncher/l10n/app_localizations.dart';
import 'package:flauncher/widgets/rename_category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AddCategoryDialog renders with PopScope and initial value', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: AddCategoryDialog(
            initialValue: 'Favorites',
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify PopScope exists
    expect(find.byWidgetPredicate((widget) => widget is PopScope), findsOneWidget);

    // Verify TextFormField renders with initial value
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
  });
}
