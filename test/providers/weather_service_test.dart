import 'dart:async';
import 'package:flauncher/models/weather_data.dart';
import 'package:flauncher/providers/weather_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFLauncherChannel mockChannel;
  late StreamController<dynamic> weatherStreamController;
  late WeatherService weatherService;

  const validWeatherJson = '''
  {
    "timestamp": 1690000000,
    "location": "Berlin",
    "currentTemp": 18,
    "currentConditionCode": 800,
    "currentCondition": "Sunny",
    "forecasts": [
      {
        "conditionCode": 500,
        "precipProbability": 70,
        "minTemp": 14,
        "maxTemp": 20
      }
    ]
  }
  ''';

  setUp(() {
    mockChannel = MockFLauncherChannel();
    weatherStreamController = StreamController<dynamic>.broadcast();

    when(mockChannel.isBreezyWeatherInstalled()).thenAnswer((_) async => true);
    when(mockChannel.getLatestWeatherData()).thenAnswer((_) async => validWeatherJson);
    when(mockChannel.addWeatherChangedListener(any)).thenAnswer((invocation) {
      final void Function(dynamic) listener = invocation.positionalArguments[0];
      return weatherStreamController.stream.listen(listener);
    });
    when(mockChannel.openBreezyWeather()).thenAnswer((_) async => true);
  });

  tearDown(() {
    weatherStreamController.close();
  });

  group('WeatherService', () {
    test('initializes with cached data and Breezy installed status', () async {
      weatherService = WeatherService(mockChannel);
      while (!weatherService.initialized) {
        await Future.delayed(Duration.zero);
      }

      expect(weatherService.isBreezyInstalled, true);
      expect(weatherService.hasWeather, true);
      expect(weatherService.weatherData?.location, "Berlin");
      expect(weatherService.weatherData?.currentTemp, 18);
      expect(weatherService.weatherData?.hasWarning, true);
      expect(weatherService.weatherData?.warningType, WeatherWarningType.rain);
      expect(weatherService.weatherData?.warningText, "70% Rain today");
    });

    test('updates weather data when stream emits new json', () async {
      weatherService = WeatherService(mockChannel);
      while (!weatherService.initialized) {
        await Future.delayed(Duration.zero);
      }

      int notifyCount = 0;
      weatherService.addListener(() {
        notifyCount++;
      });

      const updatedJson = '''
      {
        "location": "Munich",
        "currentTemp": 24,
        "currentConditionCode": 800,
        "currentCondition": "Clear",
        "forecasts": []
      }
      ''';

      weatherStreamController.add(updatedJson);
      await Future.delayed(Duration.zero);

      expect(notifyCount, greaterThanOrEqualTo(1));
      expect(weatherService.weatherData?.location, "Munich");
      expect(weatherService.weatherData?.currentTemp, 24);
      expect(weatherService.weatherData?.hasWarning, false);
    });

    test('openBreezyWeather calls channel method', () async {
      weatherService = WeatherService(mockChannel);
      while (!weatherService.initialized) {
        await Future.delayed(Duration.zero);
      }

      final success = await weatherService.openBreezyWeather();
      expect(success, true);
      verify(mockChannel.openBreezyWeather()).called(1);
    });
  });
}
