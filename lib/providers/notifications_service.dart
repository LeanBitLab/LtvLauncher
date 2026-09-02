import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flauncher/flauncher_channel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationItem {
  final String key;
  final String packageName;
  final String title;
  final String text;
  final bool isClearable;

  NotificationItem({
    required this.key,
    required this.packageName,
    required this.title,
    required this.text,
    required this.isClearable,
  });

  factory NotificationItem.fromMap(Map<dynamic, dynamic> map) {
    return NotificationItem(
      key: map['key'] as String? ?? '',
      packageName: map['packageName'] as String? ?? '',
      title: map['title'] as String? ?? '',
      text: map['text'] as String? ?? '',
      isClearable: map['isClearable'] as bool? ?? false,
    );
  }
}

class NotificationsService extends ChangeNotifier with WidgetsBindingObserver {
  final FLauncherChannel _channel;
  Map<String, int> _notificationCounts = {};
  List<NotificationItem> _notifications = [];
  List<Map<dynamic, dynamic>> _rawList = [];
  bool _hasPermission = false;
  bool _hasOverlayPermission = false;
  bool _systemPopupEnabled = false;
  bool _hidePersistentNotifications = false;
  Set<String> _blockedPackages = {};
  bool _initialized = false;
  StreamSubscription? _subscription;
  int _callCount = 0;
  SharedPreferences? _prefs;

  NotificationsService(this._channel) {
    _init();
    WidgetsBinding.instance.addObserver(this);
  }

  Map<String, int> get notificationCounts => Map.unmodifiable(_notificationCounts);
  List<NotificationItem> get notifications => List.unmodifiable(_notifications);
  bool get hasPermission => _hasPermission;
  bool get hasOverlayPermission => _hasOverlayPermission;
  bool get systemPopupEnabled => _systemPopupEnabled;
  bool get hidePersistentNotifications => _hidePersistentNotifications;
  Set<String> get blockedPackages => Set.unmodifiable(_blockedPackages);
  bool get initialized => _initialized;

  bool isPackageBlocked(String packageName) => _blockedPackages.contains(packageName);

  int getNotificationCount(String packageName) {
    return _notificationCounts[packageName] ?? 0;
  }

  Future<void> _init() async {
    final localCallCount = ++_callCount;
    _prefs = await SharedPreferences.getInstance();
    if (localCallCount != _callCount) return;

    _systemPopupEnabled = _prefs?.getBool('system_notifications_popup') ?? false;
    _hidePersistentNotifications = _prefs?.getBool('hide_persistent_notifications') ?? false;
    final blockedList = _prefs?.getStringList('blocked_notification_packages') ?? [];
    _blockedPackages = blockedList.toSet();

    final bool allowed = await _channel.checkNotificationListenerPermission();
    if (localCallCount != _callCount) return;

    _hasPermission = allowed;

    final bool overlayAllowed = await _channel.checkOverlayPermission();
    if (localCallCount != _callCount) return;

    _hasOverlayPermission = overlayAllowed;

    if (_hasPermission) {
      final List<Map<dynamic, dynamic>> list = await _channel.getActiveNotifications();
      if (localCallCount != _callCount) return;

      _updateNotificationCounts(list);

      _subscription = _channel.addNotificationsChangedListener((eventList) {
        _updateNotificationCounts(eventList);
      });
    }

    _initialized = true;
    notifyListeners();
  }

  Future<void> checkPermission() async {
    final localCallCount = ++_callCount;
    final bool allowed = await _channel.checkNotificationListenerPermission();
    if (localCallCount != _callCount) return;

    if (_hasPermission != allowed) {
      _hasPermission = allowed;
      notifyListeners();
    }
  }

  Future<void> refreshNotifications() async {
    if (!_hasPermission) return;

    final localCallCount = ++_callCount;
    final List<Map<dynamic, dynamic>> list = await _channel.getActiveNotifications();
    if (localCallCount != _callCount) return;

    _updateNotificationCounts(list);
  }

  void _updateNotificationCounts(List<Map<dynamic, dynamic>> list) {
    _rawList = list;
    _processNotifications();
  }

  void _processNotifications() {
    final Map<String, int> newCounts = {};
    final List<NotificationItem> newNotifications = [];

    for (final item in _rawList) {
      final String? pkg = item['packageName'] as String?;
      final int? count = item['count'] as int?;
      if (pkg == null) continue;

      if (_blockedPackages.contains(pkg)) {
        continue;
      }

      if (count != null) {
        newCounts[pkg] = count;
        for (int i = 0; i < count; i++) {
          newNotifications.add(NotificationItem(
            key: '${pkg}_$i',
            packageName: pkg,
            title: 'Notification',
            text: 'Content',
            isClearable: true,
          ));
        }
      } else {
        final notification = NotificationItem.fromMap(item);
        if (_hidePersistentNotifications && !notification.isClearable) {
          continue;
        }
        newNotifications.add(notification);
        if (notification.isClearable) {
          newCounts[pkg] = (newCounts[pkg] ?? 0) + 1;
        }
      }
    }

    // Direct comparison to avoid unnecessary notifies
    bool changed = false;
    if (_notificationCounts.length != newCounts.length) {
      changed = true;
    } else {
      for (final key in newCounts.keys) {
        if (_notificationCounts[key] != newCounts[key]) {
          changed = true;
          break;
        }
      }
    }

    if (!changed) {
      if (_notifications.length != newNotifications.length) {
        changed = true;
      } else {
        for (int i = 0; i < _notifications.length; i++) {
          if (_notifications[i].key != newNotifications[i].key ||
              _notifications[i].title != newNotifications[i].title ||
              _notifications[i].text != newNotifications[i].text ||
              _notifications[i].isClearable != newNotifications[i].isClearable) {
            changed = true;
            break;
          }
        }
      }
    }

    if (changed || !_initialized) {
      _notificationCounts = newCounts;
      _notifications = newNotifications;
      notifyListeners();
    }
  }

  Future<void> setHidePersistentNotifications(bool hide) async {
    _hidePersistentNotifications = hide;
    await _prefs?.setBool('hide_persistent_notifications', hide);
    _processNotifications();
  }

  Future<void> toggleBlockPackage(String packageName) async {
    if (_blockedPackages.contains(packageName)) {
      _blockedPackages.remove(packageName);
    } else {
      _blockedPackages.add(packageName);
    }
    await _prefs?.setStringList('blocked_notification_packages', _blockedPackages.toList());
    _processNotifications();
  }

  Future<void> blockPackage(String packageName) async {
    if (!_blockedPackages.contains(packageName)) {
      _blockedPackages.add(packageName);
      await _prefs?.setStringList('blocked_notification_packages', _blockedPackages.toList());
      _processNotifications();
    }
  }

  Future<void> unblockPackage(String packageName) async {
    if (_blockedPackages.contains(packageName)) {
      _blockedPackages.remove(packageName);
      await _prefs?.setStringList('blocked_notification_packages', _blockedPackages.toList());
      _processNotifications();
    }
  }

  Future<void> unblockAllPackages() async {
    if (_blockedPackages.isNotEmpty) {
      _blockedPackages.clear();
      await _prefs?.setStringList('blocked_notification_packages', []);
      _processNotifications();
    }
  }

  Future<bool> requestPermission() async {
    return await _channel.requestNotificationListenerPermission();
  }

  Future<void> checkOverlayPermission() async {
    final localCallCount = ++_callCount;
    final bool allowed = await _channel.checkOverlayPermission();
    if (localCallCount != _callCount) return;

    if (_hasOverlayPermission != allowed) {
      _hasOverlayPermission = allowed;
      notifyListeners();
    }
  }

  Future<bool> requestOverlayPermission() async {
    return await _channel.requestOverlayPermission();
  }

  Future<void> setSystemPopupEnabled(bool enabled) async {
    _systemPopupEnabled = enabled;
    await _prefs?.setBool('system_notifications_popup', enabled);
    notifyListeners();
  }

  Future<void> dismiss(String key) async {
    final bool success = await _channel.dismissNotification(key);
    if (success) {
      await refreshNotifications();
    }
  }

  Future<void> dismissAll() async {
    final bool success = await _channel.dismissAllNotifications();
    if (success) {
      await refreshNotifications();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkPermission();
      checkOverlayPermission();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    super.dispose();
  }
}
