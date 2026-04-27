import 'package:flauncher/widgets/side_panel_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SidePanelDialog renders default state correctly', (WidgetTester tester) async {
    const testChild = Text('Test Content');

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SidePanelDialog(
            child: testChild,
          ),
        ),
      ),
    );

    // Verify child is rendered
    expect(find.text('Test Content'), findsOneWidget);

    // Verify Align is centerLeft
    final alignFinder = find.byType(Align).first;
    expect(alignFinder, findsOneWidget);
    final Align alignWidget = tester.widget(alignFinder);
    expect(alignWidget.alignment, Alignment.centerLeft);

    // Verify Material border radius (find the specific Material widget we created)
    final materialFinder = find.byType(Material);
    final Material materialWidget = tester.widgetList<Material>(materialFinder).firstWhere(
      (m) => m.elevation == 24,
    );
    expect(
      materialWidget.borderRadius,
      const BorderRadius.horizontal(
        right: Radius.circular(28),
        left: Radius.zero,
      ),
    );

    // Verify Container width (default is 250)
    // Find the container directly under the Material we verified above
    final containerFinder = find.descendant(
      of: find.byWidget(materialWidget),
      matching: find.byType(Container),
    ).first;
    final Container containerWidget = tester.widget(containerFinder);
    expect(containerWidget.constraints?.maxWidth, 250);
  });

  testWidgets('SidePanelDialog renders correctly when isRightSide is true', (WidgetTester tester) async {
    const testChild = Text('Test Content');

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SidePanelDialog(
            child: testChild,
            isRightSide: true,
          ),
        ),
      ),
    );

    // Verify child is rendered
    expect(find.text('Test Content'), findsOneWidget);

    // Verify Align is centerRight
    final alignFinder = find.byType(Align).first;
    expect(alignFinder, findsOneWidget);
    final Align alignWidget = tester.widget(alignFinder);
    expect(alignWidget.alignment, Alignment.centerRight);

    // Verify Material border radius (find the specific Material widget we created)
    final materialFinder = find.byType(Material);
    final Material materialWidget = tester.widgetList<Material>(materialFinder).firstWhere(
      (m) => m.elevation == 24,
    );
    expect(
      materialWidget.borderRadius,
      const BorderRadius.horizontal(
        right: Radius.zero,
        left: Radius.circular(28),
      ),
    );
  });


  testWidgets('SidePanelDialog respects custom width', (WidgetTester tester) async {
    const testChild = Text('Test Content');

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SidePanelDialog(
            child: testChild,
            width: 400.0,
          ),
        ),
      ),
    );

    // Verify child is rendered
    expect(find.text('Test Content'), findsOneWidget);

    // Verify Material widget
    final materialFinder = find.byType(Material);
    final Material materialWidget = tester.widgetList<Material>(materialFinder).firstWhere(
      (m) => m.elevation == 24,
    );

    // Verify Container width is 400.0
    final containerFinder = find.descendant(
      of: find.byWidget(materialWidget),
      matching: find.byType(Container),
    ).first;
    final Container containerWidget = tester.widget(containerFinder);
    expect(containerWidget.constraints?.maxWidth, 400.0);
  });

}
