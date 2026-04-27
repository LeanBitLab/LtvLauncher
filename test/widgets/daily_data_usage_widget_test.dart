import 'package:flauncher/providers/network_service.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:flauncher/widgets/daily_data_usage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../mocks.mocks.dart';

void main() {
  late MockNetworkService mockNetworkService;
  late MockSettingsService mockSettingsService;

  setUp(() {
    mockNetworkService = MockNetworkService();
    mockSettingsService = MockSettingsService();
    // Default fallback mock
    when(mockNetworkService.dailyDataUsage).thenReturn(0);
  });

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NetworkService>.value(value: mockNetworkService),
        ChangeNotifierProvider<SettingsService>.value(value: mockSettingsService),
      ],
      child: const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            body: DailyDataUsageWidget(),
          ),
        ),
      ),
    );
  }

  testWidgets('shows Grant Usage Permission button when permission is missing', (WidgetTester tester) async {
    when(mockNetworkService.hasUsageStatsPermission).thenReturn(false);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Grant Usage Permission'), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byIcon(Icons.data_usage), findsOneWidget);
  });

  testWidgets('calls requestPermission when button is tapped', (WidgetTester tester) async {
    when(mockNetworkService.hasUsageStatsPermission).thenReturn(false);
    when(mockNetworkService.requestPermission()).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Grant Usage Permission'));
    await tester.pumpAndSettle();

    verify(mockNetworkService.requestPermission()).called(1);
  });

  testWidgets('displays daily usage when permission granted and period is daily', (WidgetTester tester) async {
    when(mockNetworkService.hasUsageStatsPermission).thenReturn(true);
    when(mockSettingsService.dataUsagePeriod).thenReturn('daily');
    when(mockNetworkService.getDataUsageForPeriod('daily')).thenAnswer((_) async => 1024 * 1024 * 5); // 5 MB

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byType(RichText), findsOneWidget);
    final richText = tester.widget<RichText>(find.byType(RichText));
    final span = richText.text as TextSpan;
    expect((span.children![0] as TextSpan).text, 'Daily: ');
    expect((span.children![1] as TextSpan).text, '5.00 MB');
  });

  testWidgets('displays weekly usage when permission granted and period is weekly', (WidgetTester tester) async {
    when(mockNetworkService.hasUsageStatsPermission).thenReturn(true);
    when(mockSettingsService.dataUsagePeriod).thenReturn('weekly');
    when(mockNetworkService.getDataUsageForPeriod('weekly')).thenAnswer((_) async => 1024 * 1024 * 1024 * 2); // 2 GB

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byType(RichText), findsOneWidget);
    final richText = tester.widget<RichText>(find.byType(RichText));
    final span = richText.text as TextSpan;
    expect((span.children![0] as TextSpan).text, 'Weekly: ');
    expect((span.children![1] as TextSpan).text, '2.00 GB');
  });

  testWidgets('displays monthly usage when permission granted and period is monthly', (WidgetTester tester) async {
    when(mockNetworkService.hasUsageStatsPermission).thenReturn(true);
    when(mockSettingsService.dataUsagePeriod).thenReturn('monthly');
    when(mockNetworkService.getDataUsageForPeriod('monthly')).thenAnswer((_) async => 1024 * 500); // 500 KB

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byType(RichText), findsOneWidget);
    final richText = tester.widget<RichText>(find.byType(RichText));
    final span = richText.text as TextSpan;
    expect((span.children![0] as TextSpan).text, 'Monthly: ');
    expect((span.children![1] as TextSpan).text, '500.00 KB');
  });

  testWidgets('falls back to networkService.dailyDataUsage if future data is null', (WidgetTester tester) async {
    when(mockNetworkService.hasUsageStatsPermission).thenReturn(true);
    when(mockSettingsService.dataUsagePeriod).thenReturn('daily');
    // Provide a mocked future that completes but isn't instantly available
    when(mockNetworkService.getDataUsageForPeriod('daily')).thenAnswer((_) => Future.value(1024));
    when(mockNetworkService.dailyDataUsage).thenReturn(2048);

    await tester.pumpWidget(createWidgetUnderTest());

    // Wait for future to complete
    await tester.pumpAndSettle();

    expect(find.byType(RichText), findsOneWidget);
    final richText = tester.widget<RichText>(find.byType(RichText));
    final span = richText.text as TextSpan;
    expect((span.children![1] as TextSpan).text, '1.00 KB');
  });

  testWidgets('formats 0 bytes correctly', (WidgetTester tester) async {
    when(mockNetworkService.hasUsageStatsPermission).thenReturn(true);
    when(mockSettingsService.dataUsagePeriod).thenReturn('daily');
    when(mockNetworkService.getDataUsageForPeriod('daily')).thenAnswer((_) async => 0);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byType(RichText), findsOneWidget);
    final richText = tester.widget<RichText>(find.byType(RichText));
    final span = richText.text as TextSpan;
    expect((span.children![1] as TextSpan).text, '0 B');
  });
}
