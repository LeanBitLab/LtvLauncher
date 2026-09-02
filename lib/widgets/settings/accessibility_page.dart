import 'package:flauncher/flauncher_channel.dart';
import 'package:flauncher/l10n/app_localizations.dart';
import 'package:flauncher/providers/apps_service.dart';
import 'package:flauncher/providers/launcher_state.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'focusable_settings_tile.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AccessibilityPage extends StatefulWidget {
  static const String routeName = "accessibility";

  const AccessibilityPage({super.key});

  @override
  State<AccessibilityPage> createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> with WidgetsBindingObserver {
  bool _accessibilityEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshStatus();
    }
  }

  Future<void> _refreshStatus() async {
    final appsService = context.read<AppsService>();
    final launcherState = context.read<LauncherState>();
    await launcherState.refresh(appsService);

    final bool enabled = await FLauncherChannel().checkAccessibilityPermission();
    if (mounted) {
      setState(() {
        _accessibilityEnabled = enabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    LauncherState launcherState = context.watch<LauncherState>();
    SettingsService settingsService = context.watch<SettingsService>();
    bool isDefault = launcherState.isDefaultLauncher;

    return Column(
      children: [
        Text(localizations.accessibility, style: Theme.of(context).textTheme.titleLarge),
        const Divider(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FocusableSettingsTile(
                  autofocus: true,
                  leading: Icon(
                    isDefault ? Icons.check_circle : Icons.cancel,
                    color: isDefault ? Colors.green : Colors.redAccent,
                  ),
                  title: Text(
                    isDefault
                        ? localizations.defaultLauncherIsDefault
                        : localizations.defaultLauncherNotDefault,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: _refreshStatus,
                ),
                const SizedBox(height: 8),
                FocusableSettingsTile(
                  leading: const Icon(Icons.home),
                  title: Text(
                    localizations.setAsDefaultLauncher,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: () {
                    FLauncherChannel().openDefaultLauncherSettings();
                  },
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    localizations.defaultLauncherDescription,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white54,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                FocusableSettingsTile(
                  leading: Icon(
                    _accessibilityEnabled ? Icons.settings_accessibility : Icons.accessibility_new,
                    color: _accessibilityEnabled ? Colors.green : Colors.orange,
                  ),
                  title: Text(
                    localizations.homeButtonFix,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Text(
                    _accessibilityEnabled ? localizations.enabled : localizations.disabled,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _accessibilityEnabled ? Colors.green : Colors.orange,
                        ),
                  ),
                  onPressed: () async {
                    final success = await FLauncherChannel().requestAccessibilityPermission();
                    if (!success && context.mounted) {
                      _showAccessibilityPermissionGuide(context);
                    }
                  },
                ),
                const SizedBox(height: 8),
                FocusableSettingsTile(
                  leading: Icon(
                    Icons.power_settings_new,
                    color: settingsService.startOnBoot ? Colors.green : Colors.white54,
                  ),
                  title: Text(
                    localizations.startOnBoot,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Text(
                    settingsService.startOnBoot ? localizations.enabled : localizations.disabled,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: settingsService.startOnBoot ? Colors.green : Colors.white54,
                        ),
                  ),
                  onPressed: () => settingsService.setStartOnBoot(!settingsService.startOnBoot),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'If you are using Google TV, enable "Home Button Fix" under Accessibility settings to make the Home button open this launcher.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white54,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showAccessibilityPermissionGuide(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Accessibility Permission'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'On this device, the Accessibility settings screen could not be opened automatically.\n\n'
              'To enable Home Button Fix, you can grant permission manually by running this ADB command from a computer connected to the TV:',
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(4),
              ),
              child: SelectableText(
                'adb shell settings put secure enabled_accessibility_services $packageName/$packageName.LauncherAccessibilityService',
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
}
