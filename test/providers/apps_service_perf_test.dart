import 'package:drift/drift.dart';
import 'package:flauncher/database.dart';
import 'package:flauncher/models/app.dart';
import 'package:flauncher/models/category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';
import '../mocks.mocks.dart';

void main() {
  test('Performance test for _initDefaultCategories loop vs batch', () async {
    final database = MockFLauncherDatabase();

    final apps = List.generate(500, (i) => App(
      packageName: 'com.test.app$i',
      name: 'Test App $i',
      version: '1.0.$i',
      hidden: false,
    ));

    when(database.nextAppCategoryOrder(any)).thenAnswer((_) => Future.value(0));
    when(database.insertAppsCategories(any)).thenAnswer((_) => Future.value());

    final stopwatch = Stopwatch()..start();

    final tvAppsCategory = Category(id: 1, name: "TV Apps", type: CategoryType.grid, order: 1);

    // Simulate current loop logic for a large list
    for (final app in apps) {
       int index = await database.nextAppCategoryOrder(tvAppsCategory.id) ?? 0;
       await database.insertAppsCategories([
          AppsCategoriesCompanion.insert(
            categoryId: tvAppsCategory.id,
            appPackageName: app.packageName,
            order: index,
          )
       ]);
    }

    stopwatch.stop();
    print('Baseline logic took: ${stopwatch.elapsedMilliseconds} ms');
    print('Calls to insertAppsCategories: ${verify(database.insertAppsCategories(any)).callCount}');

    // Optimized Logic
    clearInteractions(database);
    when(database.nextAppCategoryOrder(any)).thenAnswer((_) => Future.value(0));
    when(database.insertAppsCategories(any)).thenAnswer((_) => Future.value());

    final stopwatchOptimized = Stopwatch()..start();

    int nextOrder = await database.nextAppCategoryOrder(tvAppsCategory.id) ?? 0;
    List<AppsCategoriesCompanion> batch = [];
    for (final app in apps) {
       batch.add(AppsCategoriesCompanion.insert(
            categoryId: tvAppsCategory.id,
            appPackageName: app.packageName,
            order: nextOrder,
       ));
       nextOrder++;
    }
    await database.insertAppsCategories(batch);

    stopwatchOptimized.stop();
    print('Optimized logic took: ${stopwatchOptimized.elapsedMilliseconds} ms');
    print('Calls to insertAppsCategories: ${verify(database.insertAppsCategories(any)).callCount}');
  });
}
