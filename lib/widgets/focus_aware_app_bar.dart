import 'package:flauncher/widgets/settings/settings_panel.dart';
import 'package:flauncher/widgets/settings/inputs_panel.dart';
import 'package:flauncher/widgets/settings/notifications_panel.dart';
import 'package:flauncher/providers/tv_inputs_service.dart';
import 'package:flauncher/providers/notifications_service.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'daily_data_usage_widget.dart';
import 'date_time_widget.dart';
import 'network_widget.dart';
import 'weather_status_bar_widget.dart';

class FocusAwareAppBar extends StatefulWidget implements PreferredSizeWidget
{
  const FocusAwareAppBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FocusAwareAppBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class FocusAwareAppBarState extends State<FocusAwareAppBar>
{
  bool focused = false;
  late FocusNode _settingsFocusNode;
  late FocusNode _inputsFocusNode;
  late FocusNode _notificationsFocusNode;
  late FocusNode _weatherFocusNode;

  FocusNode get settingsFocusNode => _settingsFocusNode;
  FocusNode get inputsFocusNode => _inputsFocusNode;
  FocusNode get notificationsFocusNode => _notificationsFocusNode;
  FocusNode get weatherFocusNode => _weatherFocusNode;

  @override
  void initState() {
    super.initState();
    _settingsFocusNode = FocusNode();
    _inputsFocusNode = FocusNode();
    _notificationsFocusNode = FocusNode();
    _weatherFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _settingsFocusNode.dispose();
    _inputsFocusNode.dispose();
    _notificationsFocusNode.dispose();
    _weatherFocusNode.dispose();
    super.dispose();
  }

  void focusSettings() {
    _settingsFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<SettingsService, bool>(
      selector: (_, settings) => settings.autoHideAppBarEnabled,
      builder: (context, autoHide, widget) {
        if (autoHide) {
          return Focus(
            canRequestFocus: false,
            child: AnimatedContainer(
              curve: Curves.decelerate,
              duration: Duration(milliseconds: 150),
              height: focused ? kToolbarHeight : 0,
              child: widget!
            ),
            onFocusChange: (hasFocus) {
              this.setState(() {
                focused = hasFocus;
              });
            }
          );
        }

        return widget!;
      },
      child: RepaintBoundary(
        child: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          // Left side: Settings, Network indicator, WiFi usage
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Settings button (moved to left side)
              _FocusableIconButton(
                icon: Icons.settings_outlined,
                focusNode: _settingsFocusNode,
                onPressed: () => showDialog(context: context, builder: (_) => const SettingsPanel()),
              ),
              Selector<SettingsService, bool>(
                selector: (_, settings) => settings.showInputsWidgetInStatusBar,
                builder: (context, showInputs, _) => showInputs
                  ? Consumer<TvInputsService>(
                      builder: (context, tvInputsService, _) {
                        if (tvInputsService.hasInputs) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 16),
                              _FocusableIconButton(
                                icon: Icons.tv_outlined,
                                focusNode: _inputsFocusNode,
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (_) => const InputsPanel(),
                                ),
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    )
                  : const SizedBox.shrink(),
              ),
              Selector<SettingsService, (bool, bool)>(
                selector: (_, settings) => (
                  settings.showNotificationsWidgetInStatusBar,
                  settings.autoHideNotificationsWidget
                ),
                builder: (context, settingsState, _) {
                  final (showNotifications, autoHide) = settingsState;
                  return showNotifications
                    ? Consumer<NotificationsService>(
                        builder: (context, notificationsService, _) {
                          if (notificationsService.hasPermission) {
                            final count = notificationsService.notifications.length;
                            if (autoHide && count == 0) {
                              return const SizedBox.shrink();
                            }
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 16),
                                _FocusableIconButton(
                                  icon: count > 0 ? Icons.notifications_active_outlined : Icons.notifications_outlined,
                                  focusNode: _notificationsFocusNode,
                                  badgeCount: count,
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (_) => const NotificationsPanel(),
                                  ),
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      )
                    : const SizedBox.shrink();
                },
              ),
              const SizedBox(width: 16),
              // Network indicator (conditionally shown)
              Selector<SettingsService, bool>(
                selector: (_, settings) => settings.showNetworkIndicatorInStatusBar,
                builder: (context, showNetwork, _) => showNetwork
                  ? const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: NetworkWidget(),
                    )
                  : const SizedBox.shrink(),
              ),
              // Data usage widget
              Selector<SettingsService, bool>(
                selector: (_, settings) => settings.showDataWidgetInStatusBar,
                builder: (context, showData, _) => showData
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.12),
                          width: 1,
                        ),
                      ),
                      child: const DailyDataUsageWidget(),
                    )
                  : const SizedBox.shrink(),
              ),
            ],
          ),
          // Right side: Weather and Date/Time
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 32),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WeatherStatusBarWidget(focusNode: _weatherFocusNode),
                  const SizedBox(width: 12),
                  Selector<SettingsService,
                      ({
                        bool showDateInStatusBar,
                        bool showTimeInStatusBar,
                        String dateFormat,
                        String timeFormat })>(
                    selector: (context, service) => (
                    showDateInStatusBar: service.showDateInStatusBar,
                    showTimeInStatusBar: service.showTimeInStatusBar,
                    dateFormat: service.dateFormat,
                    timeFormat: service.timeFormat),
                    builder: (context, dateTimeSettings, _) {
                      // Define standard text style
                      const textStyle = TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        shadows: [
                          Shadow(color: Colors.black54, offset: Offset(0, 2), blurRadius: 4)
                        ],
                      );

                      if (!dateTimeSettings.showDateInStatusBar && !dateTimeSettings.showTimeInStatusBar) {
                        return const SizedBox.shrink();
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.12),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Date
                            if (dateTimeSettings.showDateInStatusBar)
                              DateTimeWidget(
                                dateTimeSettings.dateFormat,
                                key: const Key("statusbar_date"),
                                textStyle: textStyle,
                              ),
                            
                            if (dateTimeSettings.showDateInStatusBar && dateTimeSettings.showTimeInStatusBar)
                                const SizedBox(width: 12),

                            // Clock
                            if (dateTimeSettings.showTimeInStatusBar)
                              DateTimeWidget(
                                dateTimeSettings.timeFormat,
                                key: const Key("statusbar_clock"),
                                textStyle: textStyle.copyWith(fontWeight: FontWeight.bold),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable focusable icon button with consistent outline focus indicator
class _FocusableIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final FocusNode? focusNode;
  final int badgeCount;

  const _FocusableIconButton({required this.icon, required this.onPressed, this.focusNode, this.badgeCount = 0});

  @override
  State<_FocusableIconButton> createState() => _FocusableIconButtonState();
}

class _FocusableIconButtonState extends State<_FocusableIconButton> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) => widget.onPressed()),
        ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(onInvoke: (_) => widget.onPressed()),
      },
      child: Focus(
        focusNode: widget.focusNode,
        onFocusChange: (hasFocus) => setState(() => _focused = hasFocus),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(4),  // Match network indicator padding
            decoration: BoxDecoration(
              color: _focused ? Colors.black.withOpacity(0.3) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: _focused
                ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
                : null,
              boxShadow: _focused
                ? const [BoxShadow(color: Colors.black54, blurRadius: 8, spreadRadius: 1)]
                : null,
            ),
            child: widget.badgeCount > 0
              ? Badge(
                  label: Text(widget.badgeCount.toString(), style: const TextStyle(color: Colors.white)),
                  backgroundColor: Colors.red,
                  child: Icon(widget.icon,
                    shadows: const [
                      Shadow(color: Colors.black54, blurRadius: 8, offset: Offset(0, 2))
                    ],
                  ),
                )
              : Icon(widget.icon,
                  shadows: const [
                    Shadow(color: Colors.black54, blurRadius: 8, offset: Offset(0, 2))
                  ],
                ),
          ),
        ),
      ),
    );
  }
}