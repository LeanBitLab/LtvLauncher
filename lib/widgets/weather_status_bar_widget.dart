import 'package:flauncher/models/weather_data.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:flauncher/providers/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeatherStatusBarWidget extends StatefulWidget {
  final FocusNode? focusNode;

  const WeatherStatusBarWidget({Key? key, this.focusNode}) : super(key: key);

  @override
  State<WeatherStatusBarWidget> createState() => _WeatherStatusBarWidgetState();
}

class _WeatherStatusBarWidgetState extends State<WeatherStatusBarWidget> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Selector<SettingsService, (bool, bool, bool)>(
      selector: (_, settings) => (
        settings.showWeatherInStatusBar,
        settings.showWeatherWarnings,
        settings.useFahrenheit,
      ),
      builder: (context, settingsTuple, _) {
        final (showWeather, showWarnings, useFahrenheit) = settingsTuple;
        if (!showWeather) return const SizedBox.shrink();

        return Consumer<WeatherService>(
          builder: (context, weatherService, _) {
            final weather = weatherService.weatherData;
            if (weather == null) return const SizedBox.shrink();

            final bool isWarning = showWarnings && weather.hasWarning;
            final icon = weather.getConditionIcon(isWarning: isWarning);
            final tempText = weather.formatTemperature(useFahrenheit: useFahrenheit);

            String displayText;
            if (isWarning && weather.warningText != null) {
              displayText = "${weather.warningText} • $tempText";
            } else if (weather.currentCondition != null && weather.currentCondition!.isNotEmpty) {
              displayText = "$tempText • ${weather.currentCondition}";
            } else {
              displayText = tempText;
            }

            final theme = Theme.of(context);
            final warningColor = isWarning ? Colors.amberAccent : Colors.white;

            return Actions(
              actions: <Type, Action<Intent>>{
                ActivateIntent: CallbackAction<ActivateIntent>(
                  onInvoke: (_) => weatherService.openBreezyWeather(),
                ),
                ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
                  onInvoke: (_) => weatherService.openBreezyWeather(),
                ),
              },
              child: Focus(
                focusNode: widget.focusNode,
                onFocusChange: (hasFocus) => setState(() => _focused = hasFocus),
                child: InkWell(
                  onTap: () => weatherService.openBreezyWeather(),
                  borderRadius: BorderRadius.circular(14),
                  focusColor: Colors.transparent,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _focused
                          ? theme.colorScheme.primary.withOpacity(0.2)
                          : Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _focused
                            ? theme.colorScheme.primary
                            : (isWarning ? Colors.amber.withOpacity(0.4) : Colors.white.withOpacity(0.12)),
                        width: _focused ? 2 : 1,
                      ),
                      boxShadow: _focused
                          ? [
                              BoxShadow(
                                color: theme.colorScheme.primary.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 1,
                              )
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          size: 18,
                          color: warningColor,
                          shadows: const [
                            Shadow(color: Colors.black54, offset: Offset(0, 2), blurRadius: 4)
                          ],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          displayText,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isWarning ? FontWeight.bold : FontWeight.w500,
                            color: warningColor,
                            shadows: const [
                              Shadow(color: Colors.black54, offset: Offset(0, 2), blurRadius: 4)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
