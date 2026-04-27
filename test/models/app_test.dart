/*
 * FLauncher
 * Copyright (C) 2024 Jules
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

import 'package:flutter_test/flutter_test.dart';
import 'package:flauncher/models/app.dart';

void main() {
  group('App', () {
    test('default constructor correctly initializes fields', () {
      final app = App(
        packageName: 'com.example.app',
        name: 'Example App',
        version: '1.2.3',
        hidden: false,
        action: 'android.intent.action.MAIN',
      );

      expect(app.packageName, 'com.example.app');
      expect(app.name, 'Example App');
      expect(app.version, '1.2.3');
      expect(app.hidden, isFalse);
      expect(app.action, 'android.intent.action.MAIN');
      expect(app.sideloaded, isFalse);
      expect(app.categoryOrders, isEmpty);
      expect(app.lastLaunchedAt, isNull);
    });

    test('default constructor handles null action', () {
      final app = App(
        packageName: 'com.example.app',
        name: 'Example App',
        version: '1.2.3',
        hidden: true,
      );

      expect(app.action, isNull);
      expect(app.hidden, isTrue);
    });

    test('App.fromSystem constructor correctly maps data with action', () {
      final data = {
        'packageName': 'com.system.app',
        'name': 'System App',
        'version': '2.0.0',
        'sideloaded': true,
        'action': 'custom.action',
      };

      final app = App.fromSystem(data);

      expect(app.packageName, 'com.system.app');
      expect(app.name, 'System App');
      expect(app.version, '2.0.0');
      expect(app.hidden, isFalse);
      expect(app.sideloaded, isTrue);
      expect(app.action, 'custom.action');
      expect(app.categoryOrders, isEmpty);
    });

    test('App.fromSystem constructor correctly maps data without action', () {
      final data = {
        'packageName': 'com.system.app',
        'name': 'System App',
        'version': '2.0.0',
        'sideloaded': false,
      };

      final app = App.fromSystem(data);

      expect(app.packageName, 'com.system.app');
      expect(app.action, isNull);
    });

    test('mutable fields can be updated', () {
      final app = App(
        packageName: 'com.example.app',
        name: 'Example App',
        version: '1.0.0',
        hidden: false,
      );

      app.hidden = true;
      app.sideloaded = true;
      final now = DateTime.now();
      app.lastLaunchedAt = now;
      app.categoryOrders[1] = 5;

      expect(app.hidden, isTrue);
      expect(app.sideloaded, isTrue);
      expect(app.lastLaunchedAt, now);
      expect(app.categoryOrders[1], 5);
    });
  });
}
