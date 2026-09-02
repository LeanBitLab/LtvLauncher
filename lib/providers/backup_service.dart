import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flauncher/database.dart';
import 'package:flauncher/models/app.dart';
import 'package:flauncher/models/category.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackupService {
  final FLauncherDatabase _database;
  final SharedPreferences _sharedPreferences;

  BackupService(this._database, this._sharedPreferences);

  /// Gets the path to the backup file.
  /// Tries Downloads folder first, falls back to external files directory.
  Future<File> getBackupFile() async {
    Directory? dir;
    try {
      dir = await getDownloadsDirectory();
    } catch (_) {
      // Ignored, fallback below
    }
    if (dir == null) {
      try {
        dir = await getExternalStorageDirectory();
      } catch (_) {
        // Ignored, fallback below
      }
    }
    if (dir == null) {
      try {
        dir = await getApplicationDocumentsDirectory();
      } catch (_) {
        // Ignored
      }
    }
    if (dir == null) {
      throw const FileSystemException("Could not find any suitable directory for backup");
    }
    return File(path.join(dir.path, 'ltv_backup.json'));
  }

  Future<Directory> getBackupDirectory() async {
    final file = await getBackupFile();
    return file.parent;
  }

  /// Discovers all possible directories where backup files may reside:
  /// - App private and external storage
  /// - Standard Android /sdcard/Download directories
  /// - Mounted USB drives (/storage/*)
  Future<List<Directory>> getSearchDirectories() async {
    final Set<String> paths = {};
    final List<Directory> dirs = [];

    void addDir(Directory? dir) {
      if (dir != null && paths.add(dir.path)) {
        dirs.add(dir);
      }
    }

    try {
      addDir(await getDownloadsDirectory());
    } catch (_) {}
    try {
      addDir(await getExternalStorageDirectory());
    } catch (_) {}
    try {
      addDir(await getApplicationDocumentsDirectory());
    } catch (_) {}

    final standardPaths = [
      '/storage/emulated/0/Download',
      '/storage/emulated/0/Downloads',
      '/sdcard/Download',
      '/sdcard/Downloads',
      '/storage/emulated/0',
      '/sdcard',
    ];

    for (final p in standardPaths) {
      final d = Directory(p);
      if (d.existsSync()) {
        addDir(d);
      }
    }

    // Scan mounted USB drives and external volumes in /storage
    try {
      final storageDir = Directory('/storage');
      if (storageDir.existsSync()) {
        for (final entity in storageDir.listSync()) {
          if (entity is Directory) {
            final name = path.basename(entity.path);
            if (name != 'self' && name != 'emulated' && name != 'knox-emulated') {
              addDir(entity);
              final usbDownload = Directory(path.join(entity.path, 'Download'));
              if (usbDownload.existsSync()) {
                addDir(usbDownload);
              }
            }
          }
        }
      }
    } catch (_) {}

    return dirs;
  }

  /// Gets the list of available backup files across all search locations.
  Future<List<BackupFileEntry>> getBackupFiles() async {
    final List<Directory> searchDirs = await getSearchDirectories();
    final List<BackupFileEntry> entries = [];
    final Set<String> seenPaths = {};

    for (final dir in searchDirs) {
      if (!await dir.exists()) continue;
      try {
        await for (final entity in dir.list()) {
          if (entity is File && seenPaths.add(entity.path)) {
            final name = path.basename(entity.path);
            if ((name.startsWith('ltv_backup') || name.startsWith('flauncher_backup')) && name.endsWith('.json')) {
              try {
                final lastModified = await entity.lastModified();
                final size = await entity.length();
                entries.add(BackupFileEntry(
                  file: entity,
                  name: name,
                  lastModified: lastModified,
                  size: size,
                ));
              } catch (_) {}
            }
          }
        }
      } catch (_) {}
    }

    // Sort by modification date (newest first)
    entries.sort((a, b) => b.lastModified.compareTo(a.lastModified));
    return entries;
  }

  /// Exports categories, apps, spacers, and settings to a JSON file.
  Future<String> exportBackup([SettingsService? settingsService]) async {
    final Directory dir = await getBackupDirectory();
    final now = DateTime.now();
    final timestamp = "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_"
        "${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";
    final filename = 'ltv_backup_$timestamp.json';
    final File file = File(path.join(dir.path, filename));

    // 1. Fetch complete settings
    final Map<String, dynamic> settingsMap = {};
    if (settingsService != null) {
      settingsMap.addAll(settingsService.exportSettingsMap());
    }
    final Set<String> keys = _sharedPreferences.getKeys();
    for (final key in keys) {
      final value = _sharedPreferences.get(key);
      if (value != null) {
        settingsMap[key] = value;
      }
    }

    // 2. Fetch database tables
    final List<Category> categories = await _database.getCategories();
    final List<App> apps = await _database.getApplications();
    final List<AppCategory> appsCategories = await _database.getAppsCategories();
    final List<LauncherSpacer> spacers = await _database.getLauncherSpacers();

    // 3. Serialize everything
    final Map<String, dynamic> backupData = {
      "version": 1,
      "settings": settingsMap,
      "apps": apps.map((a) => {
        "packageName": a.packageName,
        "name": a.name,
        "version": a.version,
        "hidden": a.hidden,
        "lastLaunchedAt": a.lastLaunchedAt?.millisecondsSinceEpoch,
      }).toList(),
      "categories": categories.map((c) => {
        "id": c.id,
        "name": c.name,
        "sort": c.sort.index,
        "type": c.type.index,
        "rowHeight": c.rowHeight,
        "columnsCount": c.columnsCount,
        "order": c.order,
      }).toList(),
      "appsCategories": appsCategories.map((ac) => {
        "categoryId": ac.categoryId,
        "appPackageName": ac.appPackageName,
        "order": ac.order,
      }).toList(),
      "spacers": spacers.map((s) => {
        "id": s.id,
        "height": s.height,
        "order": s.order,
      }).toList(),
    };

    final String jsonStr = const JsonEncoder.withIndent('  ').convert(backupData);
    await file.writeAsString(jsonStr);

    // Also attempt writing a copy to public Download folder if accessible
    try {
      final downloadDir = Directory('/storage/emulated/0/Download');
      if (downloadDir.existsSync() && downloadDir.path != dir.path) {
        final publicFile = File(path.join(downloadDir.path, filename));
        await publicFile.writeAsString(jsonStr);
      }
    } catch (_) {}

    return file.path;
  }

  /// Imports categories, apps, spacers, and settings from the JSON file.
  /// If [file] is not provided, tries to import the latest backup file.
  Future<void> importBackup([File? file, SettingsService? settingsService]) async {
    File? backupFile = file;
    if (backupFile == null) {
      final List<BackupFileEntry> backups = await getBackupFiles();
      if (backups.isEmpty) {
        throw FileNotFoundException("No backup files found");
      }
      backupFile = backups.first.file;
    }
    if (!await backupFile.exists()) {
      throw FileNotFoundException("Backup file not found at ${backupFile.path}");
    }

    final String jsonStr = await backupFile.readAsString();
    final Map<String, dynamic> backupData = json.decode(jsonStr) as Map<String, dynamic>;

    if (backupData["version"] != 1) {
      throw FormatException("Invalid backup file version");
    }

    // 1. Restore SharedPreferences
    final Map<String, dynamic> settingsMap = Map<String, dynamic>.from(backupData["settings"] as Map);
    if (settingsService != null) {
      await settingsService.importSettingsMap(settingsMap);
    } else {
      for (final entry in settingsMap.entries) {
        final key = entry.key;
        final value = entry.value;
        if (value is bool) {
          await _sharedPreferences.setBool(key, value);
        } else if (value is int) {
          await _sharedPreferences.setInt(key, value);
        } else if (value is double) {
          await _sharedPreferences.setDouble(key, value);
        } else if (value is String) {
          await _sharedPreferences.setString(key, value);
        } else if (value is List) {
          await _sharedPreferences.setStringList(key, value.cast<String>());
        }
      }
    }

    // 2. Restore database tables in a single transaction
    await _database.transaction(() async {
      // Clear existing records
      await _database.customStatement('DELETE FROM apps_categories;');
      await _database.customStatement('DELETE FROM launcher_spacers;');
      await _database.customStatement('DELETE FROM categories;');
      await _database.customStatement('DELETE FROM apps;');

      // Insert Apps
      final List<dynamic> appsJson = backupData["apps"] as List;
      final List<AppsCompanion> appsCompanions = appsJson.map((a) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(a as Map);
        final int? lla = map["lastLaunchedAt"] as int?;
        return AppsCompanion(
          packageName: Value(map["packageName"] as String),
          name: Value(map["name"] as String),
          version: Value(map["version"] as String),
          hidden: Value(map["hidden"] as bool),
          lastLaunchedAt: Value(lla != null ? DateTime.fromMillisecondsSinceEpoch(lla) : null),
        );
      }).toList();
      await _database.batch((batch) {
        batch.insertAll(_database.apps, appsCompanions);
      });

      // Insert Categories
      final List<dynamic> categoriesJson = backupData["categories"] as List;
      final List<CategoriesCompanion> categoriesCompanions = categoriesJson.map((c) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(c as Map);
        return CategoriesCompanion(
          id: Value(map["id"] as int),
          name: Value(map["name"] as String),
          sort: Value(CategorySort.values[map["sort"] as int]),
          type: Value(CategoryType.values[map["type"] as int]),
          rowHeight: Value(map["rowHeight"] as int),
          columnsCount: Value(map["columnsCount"] as int),
          order: Value(map["order"] as int),
        );
      }).toList();
      await _database.batch((batch) {
        batch.insertAll(_database.categories, categoriesCompanions);
      });

      // Insert AppsCategories
      final List<dynamic> appsCategoriesJson = backupData["appsCategories"] as List;
      final List<AppsCategoriesCompanion> appsCategoriesCompanions = appsCategoriesJson.map((ac) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(ac as Map);
        return AppsCategoriesCompanion(
          categoryId: Value(map["categoryId"] as int),
          appPackageName: Value(map["appPackageName"] as String),
          order: Value(map["order"] as int),
        );
      }).toList();
      await _database.batch((batch) {
        batch.insertAll(_database.appsCategories, appsCategoriesCompanions);
      });

      // Insert Spacers
      final List<dynamic> spacersJson = backupData["spacers"] as List;
      final List<LauncherSpacersCompanion> spacersCompanions = spacersJson.map((s) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(s as Map);
        return LauncherSpacersCompanion(
          id: Value(map["id"] as int),
          height: Value(map["height"] as int),
          order: Value(map["order"] as int),
        );
      }).toList();
      await _database.batch((batch) {
        batch.insertAll(_database.launcherSpacers, spacersCompanions);
      });
    });
  }
}

class BackupFileEntry {
  final File file;
  final String name;
  final DateTime lastModified;
  final int size;

  BackupFileEntry({
    required this.file,
    required this.name,
    required this.lastModified,
    required this.size,
  });
}

class FileNotFoundException implements Exception {
  final String message;
  FileNotFoundException(this.message);
  @override
  String toString() => message;
}
