import 'package:collection/collection.dart';
import 'package:flauncher/l10n/app_localizations.dart';
import 'package:flauncher/providers/apps_service.dart';
import 'package:flauncher/providers/notifications_service.dart';
import 'package:flauncher/widgets/settings/focusable_settings_tile.dart';
import 'package:flauncher/widgets/side_panel_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class NotificationsPanel extends StatelessWidget {
  const NotificationsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black54, // Dim background
      body: Stack(
        children: [
          // Tap outside to close
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(color: Colors.transparent),
          ),
          SidePanelDialog(
            width: 420,
            isRightSide: false,
            child: Consumer2<NotificationsService, AppsService>(
              builder: (context, notificationsService, appsService, _) {
                final List<NotificationItem> notifications = notificationsService.notifications;
                final bool hasClearable = notifications.any((n) => n.isClearable);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notifications",
                            style: theme.textTheme.titleLarge,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  notificationsService.hidePersistentNotifications
                                      ? Icons.notifications_paused
                                      : Icons.notifications_paused_outlined,
                                  size: 20,
                                  color: notificationsService.hidePersistentNotifications
                                      ? theme.colorScheme.primary
                                      : Colors.grey,
                                ),
                                tooltip: localizations.hidePersistentNotifications,
                                onPressed: () {
                                  notificationsService.setHidePersistentNotifications(
                                    !notificationsService.hidePersistentNotifications,
                                  );
                                },
                              ),
                              if (hasClearable)
                                TextButton.icon(
                                  onPressed: () async {
                                    await notificationsService.dismissAll();
                                  },
                                  icon: const Icon(Icons.clear_all, size: 18),
                                  label: const Text("Clear All"),
                                  style: TextButton.styleFrom(
                                    foregroundColor: theme.colorScheme.primary,
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: notifications.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.notifications_off_outlined,
                                    size: 64,
                                    color: theme.hintColor.withOpacity(0.3),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "All caught up!",
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.hintColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                final notification = notifications[index];
                                final app = appsService.applications.firstWhereOrNull(
                                  (a) => a.packageName == notification.packageName,
                                );
                                final appName = app?.name ?? notification.packageName;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                  child: Material(
                                    color: theme.cardColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(12),
                                    clipBehavior: Clip.antiAlias,
                                    child: Focus(
                                      onKeyEvent: (node, event) {
                                        if (event is KeyDownEvent &&
                                            event.logicalKey == LogicalKeyboardKey.arrowLeft &&
                                            notification.isClearable) {
                                          notificationsService.dismiss(notification.key);
                                          return KeyEventResult.handled;
                                        }
                                        return KeyEventResult.ignored;
                                      },
                                      child: FocusableSettingsTile(
                                        autofocus: index == 0,
                                        leading: FutureBuilder<dynamic>(
                                          future: appsService.getAppIcon(notification.packageName),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return ClipRRect(
                                                borderRadius: BorderRadius.circular(6),
                                                child: Image.memory(
                                                  snapshot.data,
                                                  width: 36,
                                                  height: 36,
                                                ),
                                              );
                                            }
                                            return const Icon(Icons.android, size: 36);
                                          },
                                        ),
                                        title: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    appName,
                                                    style: theme.textTheme.labelMedium?.copyWith(
                                                      color: theme.colorScheme.primary,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                if (!notification.isClearable) ...[
                                                  const SizedBox(width: 6),
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white10,
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                    child: Text(
                                                      localizations.persistentNotification,
                                                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            if (notification.title.isNotEmpty)
                                              Text(
                                                notification.title,
                                                style: theme.textTheme.bodyMedium?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            if (notification.text.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 2.0),
                                                child: Text(
                                                  notification.text,
                                                  style: theme.textTheme.bodySmall?.copyWith(
                                                    color: theme.hintColor,
                                                  ),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                          ],
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (notification.isClearable)
                                              IconButton(
                                                icon: const Icon(Icons.close, size: 18),
                                                tooltip: "Dismiss",
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                                onPressed: () => notificationsService.dismiss(notification.key),
                                              ),
                                            IconButton(
                                              icon: const Icon(Icons.block, size: 18),
                                              tooltip: "${localizations.blockAppNotifications} ($appName)",
                                              padding: EdgeInsets.zero,
                                              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                              onPressed: () => notificationsService.blockPackage(notification.packageName),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          if (app != null) {
                                            Navigator.of(context).pop();
                                            appsService.launchApp(app);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
