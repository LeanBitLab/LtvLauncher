/*
 * FLauncher
 * Copyright (C) 2024 Oscar Rojas
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

import 'package:flauncher/providers/weather_service.dart';
import 'package:flauncher/widgets/rounded_switch_list_tile.dart';
import 'package:flauncher/widgets/settings/focusable_settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flauncher/l10n/app_localizations.dart';

import '../../providers/settings_service.dart';

class StatusBarPanelPage extends StatelessWidget {
  static const String routeName = "status_bar_panel";

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    SettingsService settingsService = Provider.of(context);

    return Column(
        children: [
          Text(localizations.statusBar, style: Theme.of(context).textTheme.titleLarge),
          Divider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                RoundedSwitchListTile(
                  autofocus: true,
                  value: settingsService.autoHideAppBarEnabled,
                  onChanged: (value) => settingsService.setAutoHideAppBarEnabled(value),
                  title: Text(localizations.autoHideAppBar, style: Theme.of(context).textTheme.bodyMedium),
                  secondary: Icon(Icons.visibility_off_outlined),
                ),
                Divider(),
                RoundedSwitchListTile(
                  value: settingsService.showDateInStatusBar,
                  onChanged: (value) => settingsService.setShowDateInStatusBar(value),
                  title: Text(localizations.date),
                  secondary: Icon(Icons.calendar_today_outlined)
                ),
                RoundedSwitchListTile(
                  value: settingsService.showTimeInStatusBar,
                  onChanged: (value) => settingsService.setShowTimeInStatusBar(value),
                  title: Text(localizations.time),
                  secondary: Icon(Icons.watch_later_outlined)
                ),
                RoundedSwitchListTile(
                  value: settingsService.showDataWidgetInStatusBar,
                  onChanged: (value) => settingsService.setShowDataWidgetInStatusBar(value),
                  title: Text(localizations.dataUsage),
                  secondary: Icon(Icons.data_usage)
                ),
                RoundedSwitchListTile(
                  value: settingsService.showNetworkIndicatorInStatusBar,
                  onChanged: (value) => settingsService.setShowNetworkIndicatorInStatusBar(value),
                  title: Text(localizations.networkIndicator),
                  secondary: Icon(Icons.signal_wifi_4_bar)
                ),
                RoundedSwitchListTile(
                  value: settingsService.showInputsWidgetInStatusBar,
                  onChanged: (value) => settingsService.setShowInputsWidgetInStatusBar(value),
                  title: Text(localizations.inputs),
                  secondary: Icon(Icons.tv_outlined),
                ),
                RoundedSwitchListTile(
                  value: settingsService.showNotificationsWidgetInStatusBar,
                  onChanged: (value) => settingsService.setShowNotificationsWidgetInStatusBar(value),
                  title: Text(localizations.notificationBell),
                  secondary: Icon(Icons.notifications_outlined),
                ),
                if (settingsService.showNotificationsWidgetInStatusBar)
                  RoundedSwitchListTile(
                    value: settingsService.autoHideNotificationsWidget,
                    onChanged: (value) => settingsService.setAutoHideNotificationsWidget(value),
                    title: Text(localizations.autoHideNotificationBell),
                    secondary: Icon(Icons.notifications_paused_outlined),
                  ),
                Divider(),
                RoundedSwitchListTile(
                  value: settingsService.showWeatherInStatusBar,
                  onChanged: (value) => settingsService.setShowWeatherInStatusBar(value),
                  title: Text(localizations.weather),
                  secondary: Icon(Icons.wb_sunny_outlined),
                ),
                if (settingsService.showWeatherInStatusBar) ...[
                  RoundedSwitchListTile(
                    value: settingsService.showWeatherWarnings,
                    onChanged: (value) => settingsService.setShowWeatherWarnings(value),
                    title: Text(localizations.showWeatherWarnings),
                    secondary: Icon(Icons.thunderstorm_outlined),
                  ),
                  FocusableSettingsTile(
                    leading: const Icon(Icons.thermostat_outlined),
                    title: Text(
                      "${localizations.temperatureUnit}: ${settingsService.useFahrenheit ? localizations.fahrenheit : localizations.celsius}",
                    ),
                    onPressed: () {
                      final next = settingsService.useFahrenheit
                          ? TEMPERATURE_UNIT_CELSIUS
                          : TEMPERATURE_UNIT_FAHRENHEIT;
                      settingsService.setTemperatureUnit(next);
                    },
                  ),
                  Consumer<WeatherService>(
                    builder: (context, weatherService, _) {
                      if (!weatherService.hasWeather) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.info_outline, size: 20, color: Colors.white70),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    localizations.breezyWeatherSetupHint,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      );
  }
}
