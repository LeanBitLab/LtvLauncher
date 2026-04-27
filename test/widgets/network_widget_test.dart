import 'package:flauncher/providers/network_service.dart';
import 'package:flauncher/widgets/network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import '../mocks.mocks.dart';

void main() {
  late MockNetworkService mockNetworkService;

  setUp(() {
    mockNetworkService = MockNetworkService();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: ChangeNotifierProvider<NetworkService>.value(
          value: mockNetworkService,
          child: const NetworkWidget(),
        ),
      ),
    );
  }

  testWidgets('renders link_off icon and red color when network state is Unknown', (WidgetTester tester) async {
    when(mockNetworkService.networkType).thenReturn(NetworkType.Unknown);
    when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Unknown);
    when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);

    await tester.pumpWidget(createWidgetUnderTest());

    final iconFinder = find.byType(Icon);
    expect(iconFinder, findsOneWidget);

    final iconWidget = tester.widget<Icon>(iconFinder);
    expect(iconWidget.icon, Icons.link_off);
    expect(iconWidget.color, Colors.red);
  });

  group('Wifi Network', () {
    testWidgets('renders signal_wifi_0_bar when signal is 0', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Wifi);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Unknown);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.signal_wifi_0_bar), findsOneWidget);
    });

    testWidgets('renders signal_wifi_1_bar when signal is 1', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Wifi);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Unknown);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(1);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.network_wifi_1_bar), findsOneWidget);
    });

    testWidgets('renders signal_wifi_2_bar when signal is 2', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Wifi);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Unknown);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(2);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.network_wifi_2_bar), findsOneWidget);
    });

    testWidgets('renders signal_wifi_3_bar when signal is 3', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Wifi);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Unknown);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(3);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.network_wifi_3_bar), findsOneWidget);
    });

    testWidgets('renders signal_wifi_4_bar when signal is 4 or higher', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Wifi);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Unknown);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(4);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.signal_wifi_4_bar), findsOneWidget);
    });
  });

  group('Cellular Network', () {
    testWidgets('renders g_mobiledata for GPRS/EDGE/CDMA', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Cellular);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Gprs);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.g_mobiledata), findsOneWidget);
    });

    testWidgets('renders e_mobiledata for EDGE', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Cellular);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Edge);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.e_mobiledata), findsOneWidget);
    });

    testWidgets('renders h_mobiledata for HSPA/HSDPA/HSUPA', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Cellular);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Hspa);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.h_mobiledata), findsOneWidget);
    });

    testWidgets('renders h_plus_mobiledata for HSPAP', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Cellular);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Hspap);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.h_plus_mobiledata), findsOneWidget);
    });

    testWidgets('renders three_g_mobiledata for UMTS/TD_SCDMA', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Cellular);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Umts);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.three_g_mobiledata), findsOneWidget);
    });

    testWidgets('renders four_g_mobiledata_outlined for LTE', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Cellular);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Lte);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.four_g_mobiledata_outlined), findsOneWidget);
    });

    testWidgets('renders five_g for NR', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Cellular);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Nr);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.five_g), findsOneWidget);
    });

    testWidgets('renders question_mark for other cellular types', (WidgetTester tester) async {
      when(mockNetworkService.networkType).thenReturn(NetworkType.Cellular);
      when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Unknown);
      when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.question_mark), findsOneWidget);
    });
  });

  testWidgets('renders vpn_key when network type is VPN', (WidgetTester tester) async {
    when(mockNetworkService.networkType).thenReturn(NetworkType.Vpn);
    when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Unknown);
    when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byIcon(Icons.vpn_key), findsOneWidget);
  });

  testWidgets('renders lan when network type is Wired', (WidgetTester tester) async {
    when(mockNetworkService.networkType).thenReturn(NetworkType.Wired);
    when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Unknown);
    when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byIcon(Icons.lan), findsOneWidget);
  });

  testWidgets('tapping the widget opens wifi settings', (WidgetTester tester) async {
    when(mockNetworkService.networkType).thenReturn(NetworkType.Unknown);
    when(mockNetworkService.cellularNetworkType).thenReturn(CellularNetworkType.Unknown);
    when(mockNetworkService.wirelessNetworkSignalLevel).thenReturn(0);
    when(mockNetworkService.openWifiSettings()).thenAnswer((_) => Future.value());

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    verify(mockNetworkService.openWifiSettings()).called(1);
  });
}
