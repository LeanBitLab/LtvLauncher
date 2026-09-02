import 'dart:async';
import 'dart:developer' as developer;
import 'package:flauncher/flauncher_channel.dart';
import 'package:flauncher/models/weather_data.dart';
import 'package:flutter/foundation.dart';

class WeatherService extends ChangeNotifier {
  final FLauncherChannel _channel;
  StreamSubscription<dynamic>? _subscription;

  WeatherData? _weatherData;
  bool _isBreezyInstalled = false;
  bool _initialized = false;

  WeatherService(this._channel) {
    _init();
  }

  WeatherData? get weatherData => _weatherData;
  bool get isBreezyInstalled => _isBreezyInstalled;
  bool get initialized => _initialized;
  bool get hasWeather => _weatherData != null;

  Future<void> _init() async {
    try {
      _isBreezyInstalled = await _channel.isBreezyWeatherInstalled();
      final latestJson = await _channel.getLatestWeatherData();
      if (latestJson != null && latestJson.isNotEmpty) {
        _processWeatherJson(latestJson);
      }

      _subscription = _channel.addWeatherChangedListener((event) {
        if (event is String && event.isNotEmpty) {
          _processWeatherJson(event);
        }
      });
    } catch (e, stack) {
      developer.log("Error initializing WeatherService", error: e, stackTrace: stack);
    } finally {
      _initialized = true;
      notifyListeners();
    }
  }

  void _processWeatherJson(String jsonString) {
    try {
      _weatherData = WeatherData.fromJsonString(jsonString);
      notifyListeners();
    } catch (e, stack) {
      developer.log("Failed to parse weather JSON", error: e, stackTrace: stack);
    }
  }

  Future<bool> openBreezyWeather() async {
    try {
      return await _channel.openBreezyWeather();
    } catch (e) {
      return false;
    }
  }

  Future<void> refresh() async {
    _isBreezyInstalled = await _channel.isBreezyWeatherInstalled();
    final latestJson = await _channel.getLatestWeatherData();
    if (latestJson != null && latestJson.isNotEmpty) {
      _processWeatherJson(latestJson);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
