/*
 * FLauncher
 * Copyright (C) 2026 LeanBitLab
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

import 'package:flauncher/l10n/app_localizations.dart';
import 'package:flauncher/models/app.dart';
import 'package:flauncher/providers/apps_service.dart';
import 'package:flauncher/providers/notifications_service.dart';
import 'package:flauncher/widgets/settings/focusable_settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlockedNotificationsPage extends StatelessWidget {
  static const String routeName = "blocked_notifications_panel";

  const BlockedNotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Consumer2<NotificationsService, AppsService>(
      builder: (context, notificationsService, appsService, _) {
        final blockedPackages = notificationsService.blockedPackages;
        final apps = List<App>.from(appsService.applications)
          ..sort((a, b) {
            final aBlocked = blockedPackages.contains(a.packageName);
            final bBlocked = blockedPackages.contains(b.packageName);
            if (aBlocked != bBlocked) {
              return aBlocked ? -1 : 1; // Blocked apps first
            }
            return a.name.toLowerCase().compareTo(b.name.toLowerCase());
          });

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizations.blockedNotificationApps,
                    style: theme.textTheme.titleLarge,
                  ),
                  if (blockedPackages.isNotEmpty)
                    TextButton(
                      onPressed: () => notificationsService.unblockAllPackages(),
                      style: TextButton.styleFrom(
                        foregroundColor: theme.colorScheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      child: Text(localizations.unblockAll),
                    ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: apps.isEmpty
                  ? Center(
                      child: Text(
                        localizations.noBlockedApps,
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                      ),
                    )
                  : ListView.builder(
                      cacheExtent: 1000,
                      itemCount: apps.length,
                      itemBuilder: (context, index) {
                        final app = apps[index];
                        final isBlocked = blockedPackages.contains(app.packageName);

                        return FocusableSettingsTile(
                          autofocus: index == 0,
                          leading: FutureBuilder<dynamic>(
                            future: appsService.getAppIcon(app.packageName),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.memory(
                                    snapshot.data,
                                    width: 32,
                                    height: 32,
                                  ),
                                );
                              }
                              return const Icon(Icons.android, size: 32);
                            },
                          ),
                          title: Text(
                            app.name,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: isBlocked ? FontWeight.bold : FontWeight.normal,
                              color: isBlocked ? Colors.redAccent : null,
                            ),
                          ),
                          trailing: Icon(
                            isBlocked ? Icons.notifications_off : Icons.notifications_none,
                            color: isBlocked ? Colors.redAccent : Colors.grey,
                            size: 20,
                          ),
                          onPressed: () {
                            notificationsService.toggleBlockPackage(app.packageName);
                          },
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
