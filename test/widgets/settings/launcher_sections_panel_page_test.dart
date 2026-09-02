/*
 * FLauncher
 * Copyright (C) 2021  Étienne Fesser
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'package:flauncher/models/category.dart';
import 'package:flauncher/providers/apps_service.dart';
import 'package:flauncher/widgets/settings/launcher_sections_panel_page.dart';
import 'package:flauncher/widgets/settings/launcher_section_panel_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flauncher/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../mocks.dart';
import '../../mocks.mocks.dart';

void main() {
  setUpAll(() async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = Size(1280, 720);
    binding.window.devicePixelRatioTestValue = 1.0;
    // Scale-down the font size because the font 'Ahem' used when running tests is much wider than Roboto
    binding.platformDispatcher.textScaleFactorTestValue = 0.8;
  });

  testWidgets("Categories are displayed", (tester) async {
    final appsService = MockAppsService();
    when(appsService.launcherSections).thenReturn([
      fakeCategory(name: "Favorites"),
      fakeCategory(name: "Applications"),
    ]);

    await _pumpWidgetWithProviders(tester, appsService);

    expect(find.text("Favorites"), findsOneWidget);
    expect(find.text("Applications"), findsOneWidget);
  });

  testWidgets("'Arrow down' change category order", (tester) async {
    final appsService = MockAppsService();
    when(appsService.launcherSections).thenReturn([
      fakeCategory(name: "Favorites"),
      fakeCategory(name: "Applications"),
    ]);
    await _pumpWidgetWithProviders(tester, appsService);

    // Explicitly request focus on the Focus node of the widget
    Focus.of(tester.element(find.text("Favorites"))).requestFocus();
    await tester.pumpAndSettle();

    // Enter move state and move down
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pumpAndSettle();

    verify(appsService.moveSectionInMemory(0, 1));
  });

  testWidgets("'Settings' opens LauncherSectionPanelPage", (tester) async {
    final appsService = MockAppsService();
    when(appsService.launcherSections).thenReturn([
      fakeCategory(name: "Favorites"),
      fakeCategory(name: "Applications"),
    ]);
    await _pumpWidgetWithProviders(tester, appsService);

    // Tap to open it
    await tester.tap(find.text("Favorites"));
    await tester.pumpAndSettle();

    expect(find.byKey(Key("LauncherSectionPanelPage")), findsOneWidget);
  });

  testWidgets("'Add Section' opens LauncherSectionPanelPage", (tester) async {
    final appsService = MockAppsService();
    when(appsService.launcherSections).thenReturn([
      fakeCategory(name: "Favorites"),
      fakeCategory(name: "Applications"),
    ]);
    await _pumpWidgetWithProviders(tester, appsService);

    // Tap "Add section" (lowercase s)
    await tester.tap(find.text("Add section"));
    await tester.pumpAndSettle();

    expect(find.byKey(Key("LauncherSectionPanelPage")), findsOneWidget);
  });

  testWidgets("Can navigate down past 6 sections using D-pad down", (tester) async {
    final appsService = MockAppsService();
    final List<LauncherSection> sections = List.generate(10, (i) => fakeCategory(name: "Section $i", order: i));
    when(appsService.launcherSections).thenReturn(sections);
    await _pumpWidgetWithProviders(tester, appsService);

    // Request focus on Section 0
    Focus.of(tester.element(find.text("Section 0"))).requestFocus();
    await tester.pumpAndSettle();

    // Navigate down through all 10 sections
    for (int i = 0; i < 9; i++) {
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
    }

    // Section 9 should now be visible and in the tree
    expect(find.text("Section 9"), findsOneWidget);
  });
}

Future<void> _pumpWidgetWithProviders(WidgetTester tester, AppsService appsService) async {
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppsService>.value(value: appsService),
      ],
      builder: (_, __) => MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        routes: {
          LauncherSectionPanelPage.routeName: (_) => Container(key: Key("LauncherSectionPanelPage")),
        },
        home: Scaffold(body: LauncherSectionsPanelPage()),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
