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

//import 'dart:html';

import 'package:flauncher/providers/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

//import '../mocks.mocks.dart';

void main() async {
  SharedPreferencesStorePlatform.instance = InMemorySharedPreferencesStore.empty();
  final sharedPreferences = await SharedPreferences.getInstance();

  setUp(() async {
    await sharedPreferences.clear();
  });


  test("setUse24HourTimeFormat", () async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final settingsService = SettingsService(sharedPreferences);
    final expected = "XYZ";

    await settingsService.setDateTimeFormat("", expected);

    expect(settingsService.timeFormat, expected);
  });

  test("setDateTimeFormat sets both date and time format", () async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final settingsService = SettingsService(sharedPreferences);
    final expectedDate = "yyyy-MM-dd";
    final expectedTime = "HH:mm:ss";

    await settingsService.setDateTimeFormat(expectedDate, expectedTime);

    expect(settingsService.dateFormat, expectedDate);
    expect(settingsService.timeFormat, expectedTime);
  });

  test("setDateTimeFormat notifies listeners", () async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final settingsService = SettingsService(sharedPreferences);

    bool notified = false;
    settingsService.addListener(() {
      notified = true;
    });

    await settingsService.setDateTimeFormat("yyyy-MM-dd", "HH:mm:ss");
    expect(notified, isTrue);
  });

  test("setGradientUuid", () async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final settingsService = SettingsService(sharedPreferences);

    await settingsService.setGradientUuid("4730aa2d-1a90-49a6-9942-ffe82f470e26");

    expect(sharedPreferences.getString("gradient_uuid"), "4730aa2d-1a90-49a6-9942-ffe82f470e26");
  });


  group("getGradientUuid", () {
    test("without uuid from shared preferences", () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      final settingsService = SettingsService(sharedPreferences);

      final gradientUuid = settingsService.gradientUuid;

      expect(gradientUuid, null);
    });

    test("with uuid from shared preferences", () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      sharedPreferences.setString("gradient_uuid", "4730aa2d-1a90-49a6-9942-ffe82f470e26");
      final settingsService = SettingsService(sharedPreferences);

      final gradientUuid = settingsService.gradientUuid;

      expect(gradientUuid, "4730aa2d-1a90-49a6-9942-ffe82f470e26");
    });
  });

  group("getDateFormat", ()  {
    test("with default", () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final settingsService = SettingsService(sharedPreferences);
      expect(settingsService.dateFormat, SettingsService.defaultDateFormat);
    });

    test("with value set", () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final settingsService = SettingsService(sharedPreferences);
      final expected = "XYZ";

      await settingsService.setDateTimeFormat(expected, "");

      expect(settingsService.dateFormat, expected);
    });
  });

  group("showInputsWidgetInStatusBar", () {
    test("default is true", () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final settingsService = SettingsService(sharedPreferences);
      expect(settingsService.showInputsWidgetInStatusBar, isTrue);
    });

    test("sets and gets value", () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final settingsService = SettingsService(sharedPreferences);
      await settingsService.setShowInputsWidgetInStatusBar(false);
      expect(settingsService.showInputsWidgetInStatusBar, isFalse);
    });

    test("notifies listeners", () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final settingsService = SettingsService(sharedPreferences);
      bool notified = false;
      settingsService.addListener(() {
        notified = true;
      });
      await settingsService.setShowInputsWidgetInStatusBar(false);
      expect(notified, isTrue);
    });
  });

  group("appLanguage and appLocale", () {
    test("default appLanguage is empty string and appLocale is null", () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final settingsService = SettingsService(sharedPreferences);
      expect(settingsService.appLanguage, "");
      expect(settingsService.appLocale, isNull);
    });

    test("sets and gets appLanguage and appLocale", () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final settingsService = SettingsService(sharedPreferences);
      await settingsService.setAppLanguage("es");
      expect(settingsService.appLanguage, "es");
      expect(settingsService.appLocale, equals(const Locale("es")));
    });

    test("setAppLanguage notifies listeners", () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final settingsService = SettingsService(sharedPreferences);
      bool notified = false;
      settingsService.addListener(() {
        notified = true;
      });
      await settingsService.setAppLanguage("en");
      expect(notified, isTrue);
    });
  });

  group("exportSettingsMap and importSettingsMap", () {
    test("exports complete settings map and restores across another instance", () async {
      final sp1 = await SharedPreferences.getInstance();
      await sp1.clear();
      final service1 = SettingsService(sp1);

      await service1.setAccentColor(ACCENT_COLOR_TEAL);
      await service1.setAppHighlightAnimationEnabled(false);
      await service1.setAppKeyClickEnabled(false);
      await service1.setAutoHideAppBarEnabled(true);
      await service1.setThemes("legacy");
      await service1.setAppLanguage("fr");
      await service1.setScreensaverClockStyle("analog");
      await service1.setShowContinueWatching(false);

      final exported = service1.exportSettingsMap();
      expect(exported["accent_color"], ACCENT_COLOR_TEAL);
      expect(exported["app_highlight_animation_enabled"], false);
      expect(exported["app_banner_shape"], "legacy");
      expect(exported["app_language"], "fr");
      expect(exported["screensaver_clock_style"], "analog");
      expect(exported["show_continue_watching"], false);

      // Now create a target instance
      final service2 = SettingsService(sp1);
      await service2.importSettingsMap(exported);

      expect(service2.accentColorHex, ACCENT_COLOR_TEAL);
      expect(service2.appHighlightAnimationEnabled, isFalse);
      expect(service2.appKeyClickEnabled, isFalse);
      expect(service2.autoHideAppBarEnabled, isTrue);
      expect(service2.themes, "legacy");
      expect(service2.appLanguage, "fr");
      expect(service2.screensaverClockStyle, "analog");
      expect(service2.showContinueWatching, isFalse);
    });
  });
}
