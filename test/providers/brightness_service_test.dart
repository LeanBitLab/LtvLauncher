import 'package:flauncher/providers/brightness_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('me.efesser.flauncher/method');

  setUp(() async {
    SharedPreferencesStorePlatform.instance = InMemorySharedPreferencesStore.empty();
  });

  group('BrightnessService requestPermission', () {
    test('handles successful permission request', () async {
      bool methodCalled = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'requestWriteSettingsPermission') {
            methodCalled = true;
            return null;
          }
          if (methodCall.method == 'checkWriteSettingsPermission') {
            return true;
          }
          return null;
        },
      );

      final sharedPreferences = await SharedPreferences.getInstance();
      final service = BrightnessService(sharedPreferences);

      await service.requestPermission();
      expect(methodCalled, isTrue);
    });

    test('catches and handles PlatformException', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'requestWriteSettingsPermission') {
            throw PlatformException(code: 'ERROR', message: 'Test error');
          }
          if (methodCall.method == 'checkWriteSettingsPermission') {
            return true;
          }
          return null;
        },
      );

      final sharedPreferences = await SharedPreferences.getInstance();
      final service = BrightnessService(sharedPreferences);

      // Should not throw
      await service.requestPermission();
    });
  });
}
