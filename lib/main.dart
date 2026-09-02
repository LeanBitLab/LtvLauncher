/*
 * FLauncher
 * Copyright (C) 2021  Étienne Fesser
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

import 'dart:async';

import 'package:flauncher/database.dart';
import 'package:flauncher/flauncher_channel.dart';
import 'package:flauncher/providers/apps_service.dart';
import 'package:flauncher/providers/launcher_state.dart';
import 'package:flauncher/providers/network_service.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:flauncher/providers/brightness_service.dart';
import 'package:flauncher/providers/wallpaper_service.dart';
import 'package:flauncher/providers/tv_inputs_service.dart';
import 'package:flauncher/providers/notifications_service.dart';
import 'package:flauncher/providers/watch_next_service.dart';
import 'package:flauncher/providers/weather_service.dart';
import 'package:flauncher/providers/backup_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'flauncher_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();

  // Configure LRU Image Cache bounds to preserve RAM on Android TV devices
  PaintingBinding.instance.imageCache.maximumSizeBytes = 50 * 1024 * 1024; // 50MB max RAM
  PaintingBinding.instance.imageCache.maximumSize = 100; // max 100 images

  // Global Error Boundary & Crash Protection
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('FLauncher Error Boundary: ${details.exception}');
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: const Color(0xFF1E1E1E),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 48),
              const SizedBox(height: 12),
              const Text(
                'Something went wrong',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                details.exceptionAsString(),
                style: const TextStyle(color: Colors.white70, fontSize: 11),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  };

  final sharedPreferences = await SharedPreferences.getInstance();
  final fLauncherChannel = FLauncherChannel();
  final fLauncherDatabase = FLauncherDatabase(connect());

  runApp(MultiProvider(
      providers: [
        Provider<BackupService>(
          create: (_) => BackupService(fLauncherDatabase, sharedPreferences),
        ),
        ChangeNotifierProvider(
            create: (_) => SettingsService(sharedPreferences),
            lazy: false),
        ChangeNotifierProvider(create: (_) => AppsService(fLauncherChannel, fLauncherDatabase)),
        ChangeNotifierProvider(create: (_) => LauncherState()),
        ChangeNotifierProvider(create: (_) => NetworkService(fLauncherChannel)),
        ChangeNotifierProvider(
            create: (context) {
              SettingsService settingsService = Provider.of(context, listen: false);
              return WallpaperService(fLauncherChannel, settingsService);
            }
        ),
        ChangeNotifierProvider(
            create: (_) => BrightnessService(sharedPreferences),
            lazy: false),
        ChangeNotifierProvider(create: (_) => TvInputsService(fLauncherChannel)),
        ChangeNotifierProvider(create: (_) => NotificationsService(fLauncherChannel)),
        ChangeNotifierProvider(create: (_) => WatchNextService(fLauncherChannel)),
        ChangeNotifierProvider(create: (_) => WeatherService(fLauncherChannel)),
      ],
      child: FLauncherApp()
    )
  );
}