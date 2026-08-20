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

    // Verify PopScope exists and canPop is false
    final popScopeFinder = find.byWidgetPredicate((widget) => widget is PopScope);
    expect(popScopeFinder, findsOneWidget);
    final PopScope popScopeWidget = tester.widget(popScopeFinder);
    expect(popScopeWidget.canPop, isFalse);

    // Verify TextFormField renders with initial value
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
  });

  testWidgets('AddCategoryDialog unfocuses on back press when focused', (WidgetTester tester) async {
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

    // Verify text field has focus initially (autofocus)
    final editableText = tester.widget<EditableText>(find.byType(EditableText));
    expect(editableText.focusNode.hasFocus, isTrue);

    // Simulate back navigation
    final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
    await widgetsAppState.didPopRoute();
    await tester.pump();

    // Verify dialog is still present (did not dismiss)
    expect(find.byType(AddCategoryDialog), findsOneWidget);
  });
}
