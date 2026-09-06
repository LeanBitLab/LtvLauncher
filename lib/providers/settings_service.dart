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

import 'dart:async';

import 'package:flauncher/widgets/settings/back_button_actions.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

const _appHighlightAnimationEnabledKey = "app_highlight_animation_enabled";
const _appKeyClickEnabledKey = "app_key_click_enabled";
const _autoHideAppBarKey = "auto_hide_app_bar";
const _gradientUuidKey = "gradient_uuid";
const _backButtonActionKey = "back_button_action";
const _dateFormatKey = "date_format";
const _showCategoryTitlesKey = "show_category_titles";
const _showAppNamesBelowIconsKey = "show_app_names_below_icons";
const _themesKey = "app_banner_shape";
const _hideHighlightOutlineOnHomescreenKey = "hide_highlight_outline_on_homescreen";
const _appSelectorTransitionAnimationEnabledKey = "app_selector_transition_animation_enabled";
const _showDateInStatusBarKey = "show_date_in_status_bar";
const _showTimeInStatusBarKey = "show_time_in_status_bar";
const _timeFormatKey = "time_format";
const _dataUsagePeriodKey = "wifi_usage_period";
const _showDataWidgetInStatusBarKey = "show_wifi_widget_in_status_bar";
const String _showNetworkIndicatorInStatusBarKey = "show_network_indicator_in_status_bar";
const String _accentColorKey = "accent_color";
const String _screensaverClockStyleKey = "screensaver_clock_style";
const String _timeBasedWallpaperEnabledKey = "time_based_wallpaper_enabled";
const String _showInputsWidgetInStatusBarKey = "show_inputs_widget_in_status_bar";
const String _showContinueWatchingKey = "show_continue_watching";
const String _startOnBootKey = "start_on_boot";
const String _showNotificationsWidgetInStatusBarKey = "show_notifications_widget_in_status_bar";
const String _autoHideNotificationsWidgetKey = "auto_hide_notifications_widget";
const String _appLanguageKey = "app_language";
const String _showWeatherInStatusBarKey = "show_weather_in_status_bar";
const String _showWeatherWarningsKey = "show_weather_warnings";
const String _temperatureUnitKey = "temperature_unit";

const String TEMPERATURE_UNIT_CELSIUS = "celsius";
const String TEMPERATURE_UNIT_FAHRENHEIT = "fahrenheit";

// WiFi usage period options
const String DATA_USAGE_DAILY = "daily";
const String DATA_USAGE_WEEKLY = "weekly";
const String DATA_USAGE_MONTHLY = "monthly";

// Accent color presets (hex values)
const String ACCENT_COLOR_PURPLE = "7C4DFF";
const String ACCENT_COLOR_TEAL = "00BFA5";
const String ACCENT_COLOR_BLUE = "2979FF";
const String ACCENT_COLOR_ORANGE = "FF6D00";
const String ACCENT_COLOR_PINK = "F50057";
const String ACCENT_COLOR_GREEN = "00C853";
const String ACCENT_COLOR_WHITE = "FFFFFF";
const String ACCENT_COLOR_YELLOW = "FFD600";
const String ACCENT_COLOR_RED = "D50000";
const String ACCENT_COLOR_CYAN = "00E5FF";
const String ACCENT_COLOR_INDIGO = "536DFE";
const String ACCENT_COLOR_LIME = "AEEA00";
const String ACCENT_COLOR_AMBER = "FFAB00";
const String ACCENT_COLOR_ROSE = "FF4081";
const String ACCENT_COLOR_ICE_BLUE = "80D8FF";

class SettingsService extends ChangeNotifier {
  static final defaultDateFormat = "EEEE d";
  static final defaultTimeFormat = "H:mm";
  final SharedPreferences _sharedPreferences;

  late bool _appHighlightAnimationEnabled;
  late bool _appKeyClickEnabled;
  late bool _autoHideAppBarEnabled;
  late bool _showCategoryTitles;
  late bool _showAppNamesBelowIcons;
  late String _themes;
  late bool _hideHighlightOutlineOnHomescreen;
  late bool _appSelectorTransitionAnimationEnabled;
  late bool _showDateInStatusBar;
  late bool _showTimeInStatusBar;
  late String? _gradientUuid;
  late String _backButtonAction;
  late String _dateFormat;
  late String _timeFormat;
  late String _dataUsagePeriod;
  late bool _showDataWidgetInStatusBar;
  late bool _showNetworkIndicatorInStatusBar;
  late String _accentColorHex;
  late String _screensaverClockStyle;
  late bool _timeBasedWallpaperEnabled;
  late bool _showInputsWidgetInStatusBar;
  late bool _showContinueWatching;
  late bool _startOnBoot;
  late bool _showNotificationsWidgetInStatusBar;
  late bool _autoHideNotificationsWidget;
  late String _appLanguage;
  late bool _showWeatherInStatusBar;
  late bool _showWeatherWarnings;
  late String _temperatureUnit;

  bool get appHighlightAnimationEnabled => _appHighlightAnimationEnabled;

  bool get appKeyClickEnabled => _appKeyClickEnabled;

  bool get autoHideAppBarEnabled => _autoHideAppBarEnabled;

  bool get showCategoryTitles => _showCategoryTitles;

  bool get showAppNamesBelowIcons => _showAppNamesBelowIcons;

  String get themes => _themes;

  bool get hideHighlightOutlineOnHomescreen => _hideHighlightOutlineOnHomescreen;

  bool get appSelectorTransitionAnimationEnabled => _appSelectorTransitionAnimationEnabled;

  bool get showDateInStatusBar => _showDateInStatusBar;

  bool get showTimeInStatusBar => _showTimeInStatusBar;

  String? get gradientUuid => _gradientUuid;

  String get backButtonAction => _backButtonAction;

  String get dateFormat => _dateFormat;

  String get timeFormat => _timeFormat;

  String get dataUsagePeriod => _dataUsagePeriod;

  bool get showDataWidgetInStatusBar => _showDataWidgetInStatusBar;

  bool get showNetworkIndicatorInStatusBar => _showNetworkIndicatorInStatusBar;

  bool get showInputsWidgetInStatusBar => _showInputsWidgetInStatusBar;
  bool get showContinueWatching => _showContinueWatching;
  bool get startOnBoot => _startOnBoot;
  bool get showNotificationsWidgetInStatusBar => _showNotificationsWidgetInStatusBar;
  bool get autoHideNotificationsWidget => _autoHideNotificationsWidget;
  bool get showWeatherInStatusBar => _showWeatherInStatusBar;
  bool get showWeatherWarnings => _showWeatherWarnings;
  String get temperatureUnit => _temperatureUnit;
  bool get useFahrenheit => _temperatureUnit == TEMPERATURE_UNIT_FAHRENHEIT;

  String get appLanguage => _appLanguage;

  Locale? get appLocale {
    if (_appLanguage.isEmpty) {
      return null;
    }
    return Locale(_appLanguage);
  }

  String get accentColorHex => _accentColorHex;

  String get screensaverClockStyle => _screensaverClockStyle;

  Color get accentColor {
    final hex = accentColorHex;
    return Color(int.parse("0xFF$hex"));
  }

  SettingsService(this._sharedPreferences) {
    reload();
  }

  void reload() {
    _appHighlightAnimationEnabled = _sharedPreferences.getBool(_appHighlightAnimationEnabledKey) ?? true;
    _appKeyClickEnabled = _sharedPreferences.getBool(_appKeyClickEnabledKey) ?? true;
    _autoHideAppBarEnabled = _sharedPreferences.getBool(_autoHideAppBarKey) ?? false;
    _showCategoryTitles = _sharedPreferences.getBool(_showCategoryTitlesKey) ?? true;
    _showAppNamesBelowIcons = _sharedPreferences.getBool(_showAppNamesBelowIconsKey) ?? false;
    _themes = _sharedPreferences.getString(_themesKey) ?? "modern";
    _hideHighlightOutlineOnHomescreen = _sharedPreferences.getBool(_hideHighlightOutlineOnHomescreenKey) ?? false;
    _appSelectorTransitionAnimationEnabled = _sharedPreferences.getBool(_appSelectorTransitionAnimationEnabledKey) ?? true;
    _showDateInStatusBar = _sharedPreferences.getBool(_showDateInStatusBarKey) ?? true;
    _showTimeInStatusBar = _sharedPreferences.getBool(_showTimeInStatusBarKey) ?? true;
    _gradientUuid = _sharedPreferences.getString(_gradientUuidKey);
    _backButtonAction = _sharedPreferences.getString(_backButtonActionKey) ?? BACK_BUTTON_ACTION_NOTHING;
    _dateFormat = _sharedPreferences.getString(_dateFormatKey) ?? defaultDateFormat;
    _timeFormat = _sharedPreferences.getString(_timeFormatKey) ?? defaultTimeFormat;
    _dataUsagePeriod = _sharedPreferences.getString(_dataUsagePeriodKey) ?? DATA_USAGE_DAILY;
    _showDataWidgetInStatusBar = _sharedPreferences.getBool(_showDataWidgetInStatusBarKey) ?? true;
    _showNetworkIndicatorInStatusBar = _sharedPreferences.getBool(_showNetworkIndicatorInStatusBarKey) ?? true;
    _accentColorHex = _sharedPreferences.getString(_accentColorKey) ?? ACCENT_COLOR_PURPLE;
    _screensaverClockStyle = _sharedPreferences.getString(_screensaverClockStyleKey) ?? "minimal";
    _timeBasedWallpaperEnabled = _sharedPreferences.getBool(_timeBasedWallpaperEnabledKey) ?? false;
    _showInputsWidgetInStatusBar = _sharedPreferences.getBool(_showInputsWidgetInStatusBarKey) ?? true;
    _showContinueWatching = _sharedPreferences.getBool(_showContinueWatchingKey) ?? true;
    _startOnBoot = _sharedPreferences.getBool(_startOnBootKey) ?? false;
    _showNotificationsWidgetInStatusBar = _sharedPreferences.getBool(_showNotificationsWidgetInStatusBarKey) ?? true;
    _autoHideNotificationsWidget = _sharedPreferences.getBool(_autoHideNotificationsWidgetKey) ?? false;
    _appLanguage = _sharedPreferences.getString(_appLanguageKey) ?? "";
    _showWeatherInStatusBar = _sharedPreferences.getBool(_showWeatherInStatusBarKey) ?? true;
    _showWeatherWarnings = _sharedPreferences.getBool(_showWeatherWarningsKey) ?? true;
    _temperatureUnit = _sharedPreferences.getString(_temperatureUnitKey) ?? TEMPERATURE_UNIT_CELSIUS;
    notifyListeners();
  }

  Map<String, dynamic> exportSettingsMap() {
    return {
      _appHighlightAnimationEnabledKey: _appHighlightAnimationEnabled,
      _appKeyClickEnabledKey: _appKeyClickEnabled,
      _autoHideAppBarKey: _autoHideAppBarEnabled,
      _showCategoryTitlesKey: _showCategoryTitles,
      _showAppNamesBelowIconsKey: _showAppNamesBelowIcons,
      _themesKey: _themes,
      _hideHighlightOutlineOnHomescreenKey: _hideHighlightOutlineOnHomescreen,
      _appSelectorTransitionAnimationEnabledKey: _appSelectorTransitionAnimationEnabled,
      _showDateInStatusBarKey: _showDateInStatusBar,
      _showTimeInStatusBarKey: _showTimeInStatusBar,
      if (_gradientUuid != null) _gradientUuidKey: _gradientUuid,
      _backButtonActionKey: _backButtonAction,
      _dateFormatKey: _dateFormat,
      _timeFormatKey: _timeFormat,
      _dataUsagePeriodKey: _dataUsagePeriod,
      _showDataWidgetInStatusBarKey: _showDataWidgetInStatusBar,
      _showNetworkIndicatorInStatusBarKey: _showNetworkIndicatorInStatusBar,
      _accentColorKey: _accentColorHex,
      _screensaverClockStyleKey: _screensaverClockStyle,
      _timeBasedWallpaperEnabledKey: _timeBasedWallpaperEnabled,
      _showInputsWidgetInStatusBarKey: _showInputsWidgetInStatusBar,
      _showContinueWatchingKey: _showContinueWatching,
      _startOnBootKey: _startOnBoot,
      _showNotificationsWidgetInStatusBarKey: _showNotificationsWidgetInStatusBar,
      _autoHideNotificationsWidgetKey: _autoHideNotificationsWidget,
      _appLanguageKey: _appLanguage,
      _showWeatherInStatusBarKey: _showWeatherInStatusBar,
      _showWeatherWarningsKey: _showWeatherWarnings,
      _temperatureUnitKey: _temperatureUnit,
    };
  }

  Future<void> importSettingsMap(Map<String, dynamic> settingsMap) async {
    for (final entry in settingsMap.entries) {
      final key = entry.key;
      final value = entry.value;
      if (value is bool) {
        await _sharedPreferences.setBool(key, value);
      } else if (value is int) {
        await _sharedPreferences.setInt(key, value);
      } else if (value is double) {
        await _sharedPreferences.setDouble(key, value);
      } else if (value is String) {
        await _sharedPreferences.setString(key, value);
      } else if (value is List) {
        await _sharedPreferences.setStringList(key, value.cast<String>());
      }
    }
    reload();
  }

  Future<void> setAppLanguage(String value) async {
    await _sharedPreferences.setString(_appLanguageKey, value);
    _appLanguage = value;
    notifyListeners();
  }

  Future<void> setAppHighlightAnimationEnabled(bool value) async {
    await _sharedPreferences.setBool(_appHighlightAnimationEnabledKey, value);
    _appHighlightAnimationEnabled = value;
    notifyListeners();
  }

  Future<void> setAppKeyClickEnabled(bool value) async {
    await _sharedPreferences.setBool(_appKeyClickEnabledKey, value);
    _appKeyClickEnabled = value;
    notifyListeners();
  }

  Future<void> setAutoHideAppBarEnabled(bool value) async {
    await _sharedPreferences.setBool(_autoHideAppBarKey, value);
    _autoHideAppBarEnabled = value;
    notifyListeners();
  }

  Future<void> setGradientUuid(String value) async {
    await _sharedPreferences.setString(_gradientUuidKey, value);
    _gradientUuid = value;
    notifyListeners();
  }

  Future<void> setBackButtonAction(String value) async {
    await _sharedPreferences.setString(_backButtonActionKey, value);
    _backButtonAction = value;
    notifyListeners();
  }

  Future<void> setDateTimeFormat(String dateFormatString, String timeFormatString) async {
    await Future.wait([
      _sharedPreferences.setString(_dateFormatKey, dateFormatString),
      _sharedPreferences.setString(_timeFormatKey, timeFormatString)
    ]);
    _dateFormat = dateFormatString;
    _timeFormat = timeFormatString;
    notifyListeners();
  }

  Future<void> setShowCategoryTitles(bool show) async {
    await _sharedPreferences.setBool(_showCategoryTitlesKey, show);
    _showCategoryTitles = show;
    notifyListeners();
  }

  Future<void> setShowAppNamesBelowIcons(bool show) async {
    await _sharedPreferences.setBool(_showAppNamesBelowIconsKey, show);
    _showAppNamesBelowIcons = show;
    notifyListeners();
  }

  Future<void> setThemes(String shape) async {
    await _sharedPreferences.setString(_themesKey, shape);
    _themes = shape;
    notifyListeners();
  }

  Future<void> setHideHighlightOutlineOnHomescreen(bool enabled) async {
    await _sharedPreferences.setBool(_hideHighlightOutlineOnHomescreenKey, enabled);
    _hideHighlightOutlineOnHomescreen = enabled;
    notifyListeners();
  }

  Future<void> setAppSelectorTransitionAnimationEnabled(bool enabled) async {
    await _sharedPreferences.setBool(_appSelectorTransitionAnimationEnabledKey, enabled);
    _appSelectorTransitionAnimationEnabled = enabled;
    notifyListeners();
  }

  Future<void> setShowDateInStatusBar(bool show) async {
    await _sharedPreferences.setBool(_showDateInStatusBarKey, show);
    _showDateInStatusBar = show;
    notifyListeners();
  }

  Future<void> setShowTimeInStatusBar(bool show) async {
    await _sharedPreferences.setBool(_showTimeInStatusBarKey, show);
    _showTimeInStatusBar = show;
    notifyListeners();
  }

  Future<void> setDataUsagePeriod(String period) async {
    await _sharedPreferences.setString(_dataUsagePeriodKey, period);
    _dataUsagePeriod = period;
    notifyListeners();
  }

  Future<void> setShowDataWidgetInStatusBar(bool show) async {
    await _sharedPreferences.setBool(_showDataWidgetInStatusBarKey, show);
    _showDataWidgetInStatusBar = show;
    notifyListeners();
  }

  Future<void> setShowNetworkIndicatorInStatusBar(bool show) async {
    await _sharedPreferences.setBool(_showNetworkIndicatorInStatusBarKey, show);
    _showNetworkIndicatorInStatusBar = show;
    notifyListeners();
  }

  Future<void> setAccentColor(String colorHex) async {
    await _sharedPreferences.setString(_accentColorKey, colorHex);
    _accentColorHex = colorHex;
    notifyListeners();
  }

  Future<void> setScreensaverClockStyle(String style) async {
    await _sharedPreferences.setString(_screensaverClockStyleKey, style);
    _screensaverClockStyle = style;
    notifyListeners();
  }

  bool get timeBasedWallpaperEnabled => _timeBasedWallpaperEnabled;

  Future<void> setTimeBasedWallpaperEnabled(bool enabled) async {
    await _sharedPreferences.setBool(_timeBasedWallpaperEnabledKey, enabled);
    _timeBasedWallpaperEnabled = enabled;
    notifyListeners();
  }

  Future<void> setShowInputsWidgetInStatusBar(bool show) async {
    await _sharedPreferences.setBool(_showInputsWidgetInStatusBarKey, show);
    _showInputsWidgetInStatusBar = show;
    notifyListeners();
  }

  Future<void> setShowContinueWatching(bool show) async {
    await _sharedPreferences.setBool(_showContinueWatchingKey, show);
    _showContinueWatching = show;
    notifyListeners();
  }

  Future<void> setStartOnBoot(bool enabled) async {
    await _sharedPreferences.setBool(_startOnBootKey, enabled);
    _startOnBoot = enabled;
    notifyListeners();
  }

  Future<void> setShowNotificationsWidgetInStatusBar(bool show) async {
    await _sharedPreferences.setBool(_showNotificationsWidgetInStatusBarKey, show);
    _showNotificationsWidgetInStatusBar = show;
    notifyListeners();
  }

  Future<void> setAutoHideNotificationsWidget(bool value) async {
    await _sharedPreferences.setBool(_autoHideNotificationsWidgetKey, value);
    _autoHideNotificationsWidget = value;
    notifyListeners();
  }

  Future<void> setShowWeatherInStatusBar(bool show) async {
    await _sharedPreferences.setBool(_showWeatherInStatusBarKey, show);
    _showWeatherInStatusBar = show;
    notifyListeners();
  }

  Future<void> setShowWeatherWarnings(bool show) async {
    await _sharedPreferences.setBool(_showWeatherWarningsKey, show);
    _showWeatherWarnings = show;
    notifyListeners();
  }

  Future<void> setTemperatureUnit(String unit) async {
    await _sharedPreferences.setString(_temperatureUnitKey, unit);
    _temperatureUnit = unit;
    notifyListeners();
  }
}
