import 'package:flutter_test/flutter_test.dart';
import 'package:flauncher/database.dart';
import 'package:flauncher/providers/apps_service.dart';
import 'package:flauncher/flauncher_channel.dart';
import 'package:mockito/mockito.dart';
import 'package:flauncher/models/app.dart';
import 'package:flauncher/models/category.dart';

import 'mocks.mocks.dart';

void main() {
  late FLauncherDatabase database;
  late MockFLauncherChannel mockChannel;
  late AppsService appsService;

  setUp(() async {
    database = FLauncherDatabase.inMemory();
    mockChannel = MockFLauncherChannel();

    // Minimal mock for getApplications to avoid crash in _refreshState
    when(mockChannel.getApplications()).thenAnswer((_) async => []);

    appsService = AppsService(mockChannel, database);
    // Wait for initialization
    while (!appsService.initialized) {
      await Future.delayed(Duration(milliseconds: 10));
    }
  });

  tearDown(() async {
    await database.close();
  });

  test('Test addAllToCategory functionality', () async {
    const int numApps = 10;
    int categoryId = await appsService.addCategory("Test Category", shouldNotifyListeners: false);
    Category category = appsService.categories.firstWhere((c) => c.id == categoryId);

    List<App> appsToAdd = List.generate(numApps, (i) => App(
      packageName: 'com.example.app$i',
      name: 'App $i',
      version: '1.0.0',
      hidden: false,
    ));

    await appsService.addAllToCategory(appsToAdd, category);

    expect(category.applications.length, numApps);
    for (int i = 0; i < numApps; i++) {
      expect(appsToAdd[i].categoryOrders[category.id], i);
      expect(category.applications[i].packageName, appsToAdd[i].packageName);
    }

    final dbAppsCategories = await database.getAppsCategories();
    expect(dbAppsCategories.length, numApps);
  });
}
