import 'package:flauncher/l10n/app_localizations.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:flauncher/widgets/settings/app_language_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

void main() {
  late SettingsService settingsService;
  late SharedPreferences sharedPreferences;

  setUp(() async {
    SharedPreferencesStorePlatform.instance = InMemorySharedPreferencesStore.empty();
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    settingsService = SettingsService(sharedPreferences);
  });

  Widget buildSubject() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: ChangeNotifierProvider<SettingsService>.value(
        value: settingsService,
        child: const Scaffold(
          body: AppLanguagePage(),
        ),
      ),
    );
  }

  testWidgets('renders all language options', (WidgetTester tester) async {
    await tester.pumpWidget(buildSubject());
    await tester.pumpAndSettle();

    expect(find.text('Language'), findsOneWidget);
    expect(find.text('System Default'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Spanish'), findsOneWidget);
    expect(find.text('Ukrainian'), findsOneWidget);
    expect(find.text('Chinese'), findsOneWidget);
  });

  testWidgets('tapping Spanish option updates appLanguage preference to es', (WidgetTester tester) async {
    await tester.pumpWidget(buildSubject());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Spanish'));
    await tester.pumpAndSettle();

    expect(settingsService.appLanguage, 'es');
    expect(settingsService.appLocale, equals(const Locale('es')));
  });

  testWidgets('tapping Chinese option updates appLanguage preference to zh', (WidgetTester tester) async {
    await tester.pumpWidget(buildSubject());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Chinese'));
    await tester.pumpAndSettle();

    expect(settingsService.appLanguage, 'zh');
    expect(settingsService.appLocale, equals(const Locale('zh')));
  });
}
