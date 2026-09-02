/*
 * FLauncher
 * Copyright (C) 2024 LeanBitLab
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flauncher/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flauncher/providers/notifications_service.dart';
import 'focusable_settings_tile.dart';
import 'brightness_settings_page.dart';
import 'date_time_format_page.dart';
import 'back_button_action_page.dart';
import 'data_usage_period_page.dart';
import 'screensaver_clock_style_page.dart';
import 'backup_restore_page.dart';
import 'app_language_page.dart';
import 'blocked_notifications_page.dart';


class GeneralSettingsPage extends StatelessWidget {
  static const String routeName = "general_settings_panel";

  const GeneralSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(localizations.system, style: Theme.of(context).textTheme.titleLarge),
        const Divider(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FocusableSettingsTile(
                  autofocus: true,
                  leading: const Icon(Icons.language),
                  title: Text(localizations.appLanguage, style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () => Navigator.of(context).pushNamed(AppLanguagePage.routeName),
                ),
                FocusableSettingsTile(
                  leading: const Icon(Icons.brightness_6),
                  title: Text(localizations.brightnessScheduler, style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () => Navigator.of(context).pushNamed(BrightnessSettingsPage.routeName),
                ),
                FocusableSettingsTile(
                  leading: const Icon(Icons.screenshot_monitor),
                  title: Text(localizations.screensaverSettings, style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () => _openScreensaverSettings(),
                ),
                FocusableSettingsTile(
                  leading: const Icon(Icons.watch_later_outlined),
                  title: Text(localizations.screensaverClockStyle, style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () => Navigator.of(context).pushNamed(ScreensaverClockStylePage.routeName),
                ),
                FocusableSettingsTile(
                  leading: const Icon(Icons.date_range),
                  title: Text(localizations.dateAndTimeFormat, style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () => Navigator.of(context).pushNamed(DateTimeFormatPage.routeName),
                ),
                FocusableSettingsTile(
                  leading: const Icon(Icons.arrow_back),
                  title: Text(localizations.backButtonAction, style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () => Navigator.of(context).pushNamed(BackButtonActionPage.routeName),
                ),
                FocusableSettingsTile(
                  leading: const Icon(Icons.data_usage),
                  title: Text(localizations.dataUsagePeriod, style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () => Navigator.of(context).pushNamed(DataUsagePeriodPage.routeName),
                ),
                FocusableSettingsTile(
                  leading: const Icon(Icons.settings_backup_restore),
                  title: Text(localizations.backupAndRestore, style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () => Navigator.of(context).pushNamed(BackupRestorePage.routeName),
                ),
                Consumer<NotificationsService>(
                  builder: (context, service, _) {
                    return Column(
                      children: [
                        FocusableSettingsTile(
                          leading: const Icon(Icons.notifications_active_outlined),
                          title: Text(localizations.notificationAccess, style: Theme.of(context).textTheme.bodyMedium),
                          trailing: Text(
                            service.hasPermission ? localizations.granted : localizations.permissionRequired,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: service.hasPermission ? Colors.green : Colors.orange,
                            ),
                          ),
                          onPressed: () async {
                            if (!service.hasPermission) {
                              final success = await service.requestPermission();
                              if (!success && context.mounted) {
                                _showNotificationPermissionGuide(context);
                              }
                            } else {
                              await service.checkPermission();
                            }
                          },
                        ),
                        if (service.hasPermission) ...[
                          FocusableSettingsTile(
                            leading: const Icon(Icons.notifications_paused_outlined),
                            title: Text(localizations.hidePersistentNotifications, style: Theme.of(context).textTheme.bodyMedium),
                            trailing: Text(
                              service.hidePersistentNotifications ? localizations.enabled : localizations.disabled,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: service.hidePersistentNotifications ? Colors.green : Colors.grey,
                              ),
                            ),
                            onPressed: () => service.setHidePersistentNotifications(!service.hidePersistentNotifications),
                          ),
                          FocusableSettingsTile(
                            leading: const Icon(Icons.block),
                            title: Text(localizations.blockedNotificationApps, style: Theme.of(context).textTheme.bodyMedium),
                            trailing: Text(
                              service.blockedPackages.isEmpty ? '0' : '${service.blockedPackages.length}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: service.blockedPackages.isNotEmpty ? Colors.orange : Colors.grey,
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pushNamed(BlockedNotificationsPage.routeName),
                          ),
                          FocusableSettingsTile(
                            leading: const Icon(Icons.picture_in_picture_alt_outlined),
                            title: Text(localizations.systemWidePopupAlert, style: Theme.of(context).textTheme.bodyMedium),
                            trailing: Text(
                              !service.hasOverlayPermission
                                  ? localizations.overlayPermissionRequired
                                  : (service.systemPopupEnabled ? localizations.enabled : localizations.disabled),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: !service.hasOverlayPermission
                                    ? Colors.orange
                                    : (service.systemPopupEnabled ? Colors.green : Colors.grey),
                              ),
                            ),
                            onPressed: () async {
                              await service.checkOverlayPermission();
                              if (!service.hasOverlayPermission) {
                                final success = await service.requestOverlayPermission();
                                if (!success && context.mounted) {
                                  _showOverlayPermissionGuide(context);
                                }
                              } else {
                                await service.setSystemPopupEnabled(!service.systemPopupEnabled);
                              }
                            },
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showNotificationPermissionGuide(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification Access'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'On this device, the Notification Access settings screen could not be opened automatically.\n\n'
              'To enable notifications, you can grant permission manually by running this ADB command from a computer connected to the TV:',
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(4),
              ),
              child: SelectableText(
                'adb shell cmd notification allow_listener $packageName/$packageName.LauncherNotificationListenerService',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showOverlayPermissionGuide(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Overlay Permission'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'On this device, the Overlay Permission settings screen could not be opened automatically.\n\n'
              'To enable overlay popups, you can grant permission manually by running this ADB command from a computer connected to the TV:',
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(4),
              ),
              child: SelectableText(
                'adb shell appops set $packageName SYSTEM_ALERT_WINDOW allow',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _openScreensaverSettings() async {
    const platform = MethodChannel('me.efesser.flauncher/method');
    platform.invokeMethod('openScreensaverSettings');
  }
}
