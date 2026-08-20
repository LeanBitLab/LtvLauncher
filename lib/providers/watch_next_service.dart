import 'dart:async';
import 'dart:developer';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flauncher/flauncher_channel.dart';
import '../models/watch_next_program.dart';

class WatchNextService extends ChangeNotifier with WidgetsBindingObserver {
  final FLauncherChannel _channel;
  List<WatchNextProgram> _programs = [];
  bool _initialized = false;
  bool _hasPermission = true;
  Timer? _refreshTimer;
  int _callCount = 0;
  bool _isFetching = false;
  bool _hasPendingRefresh = false;

  bool get _isTest => Platform.environment.containsKey('FLUTTER_TEST');

  WatchNextService(this._channel) {
    if (!_isTest) {
      WidgetsBinding.instance.addObserver(this);
    }
    _init();
  }

  List<WatchNextProgram> get programs => List.unmodifiable(_programs);
  bool get initialized => _initialized;
  bool get hasPermission => _hasPermission;

  Future<void> _init() async {
    await refresh();
    _initialized = true;
    notifyListeners();

    _startPeriodicTimer();
  }

  void _startPeriodicTimer() {
    _refreshTimer?.cancel();
    // Refresh every 30 seconds to keep EPG/Playback progress up to date
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) => refresh());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) {
      _refreshTimer?.cancel();
      _refreshTimer = null;
    } else if (state == AppLifecycleState.resumed) {
      refresh();
      _startPeriodicTimer();
    }
  }

  Future<void> refresh() async {
    if (_isFetching) {
      _hasPendingRefresh = true;
      return;
    }
    _isFetching = true;

    final int callSnapshot = ++_callCount;
    try {
      final bool hasPermission = await checkPermission();
      if (callSnapshot != _callCount) return;

      _hasPermission = hasPermission;
      if (!hasPermission) {
        if (_programs.isNotEmpty) {
          _programs = [];
        }
        if (callSnapshot == _callCount) notifyListeners();
        return;
      }

      List<Map<dynamic, dynamic>> list;
      try {
        list = await _channel.getWatchNextPrograms();
      } catch (e) {
        if (kReleaseMode) {
          rethrow;
        } else {
          list = const [];
        }
      }
      if (callSnapshot != _callCount) return;

      if (!kReleaseMode && !_isTest && list.isEmpty) {
        list = _getMockPrograms();
      }

      // Phase 1: Emit programs immediately with cached posters where available
      final List<WatchNextProgram> newPrograms = [];
      for (final map in list) {
        final program = WatchNextProgram.fromMap(map);
        // Reuse existing poster bytes if same program already loaded
        final existing = _findExisting(program.id);
        if (existing != null && existing.posterBytes != null) {
          program.posterBytes = existing.posterBytes;
        }
        newPrograms.add(program);
      }
      _programs = newPrograms;
      if (callSnapshot == _callCount) notifyListeners();

      // Phase 2: Fetch missing posters concurrently with 5s timeout, then notify again
      final needsPoster = newPrograms.where(
        (p) => p.posterArtUri.isNotEmpty && p.posterBytes == null
      ).toList();
      if (needsPoster.isNotEmpty) {
        await Future.wait(
          needsPoster.map((p) async {
            try {
              p.posterBytes = await _channel.getWatchNextPoster(p.posterArtUri);
            } catch (e) {
              log('Failed to fetch poster for ${p.title}', name: 'WatchNextService', error: e);
            }
          }),
        ).timeout(
          const Duration(seconds: 5),
          onTimeout: () => [],
        );
        if (callSnapshot == _callCount) notifyListeners();
      }
    } catch (e) {
      log('Failed to refresh watch next programs', name: 'WatchNextService', error: e);
    } finally {
      _isFetching = false;
      if (_hasPendingRefresh) {
        _hasPendingRefresh = false;
        refresh();
      }
    }
  }

  List<Map<dynamic, dynamic>> _getMockPrograms() {
    return [
      {
        'id': 9991,
        'packageName': 'com.google.android.youtube',
        'title': 'Mock Video 1 (YouTube)',
        'description': 'Description for mock video 1',
        'watchNextType': 0,
        'lastEngagementTime': DateTime.now().millisecondsSinceEpoch,
        'playbackPosition': 500000,
        'duration': 1000000,
        'intentUri': 'https://www.youtube.com',
        'posterArtUri': '',
      },
      {
        'id': 9992,
        'packageName': 'com.netflix.mediaclient',
        'title': 'Mock Show 2 (Netflix)',
        'description': 'S1 E2 • Episode Title',
        'watchNextType': 1,
        'lastEngagementTime': DateTime.now().millisecondsSinceEpoch - 100000,
        'playbackPosition': 200000,
        'duration': 1800000,
        'intentUri': 'https://www.netflix.com',
        'posterArtUri': '',
      },
    ];
  }

  WatchNextProgram? _findExisting(int id) {
    for (final p in _programs) {
      if (p.id == id) return p;
    }
    return null;
  }

  Future<bool> checkPermission() async {
    if (!kReleaseMode && !_isTest) return true;
    return await _channel.checkWatchNextPermission();
  }

  Future<bool> requestPermission() async {
    if (!kReleaseMode && !_isTest) return true;
    final bool granted = await _channel.requestWatchNextPermission();
    if (granted) {
      await refresh();
    }
    return granted;
  }

  Future<bool> launch(WatchNextProgram program) async {
    if (program.intentUri.isNotEmpty) {
      return await _channel.launchWatchNextProgram(program.intentUri);
    } else if (program.packageName.isNotEmpty) {
      try {
        await _channel.launchApp(program.packageName);
        return true;
      } catch (e) {
        log('Failed to launch app ${program.packageName}', name: 'WatchNextService', error: e);
        return false;
      }
    }
    return false;
  }

  @override
  void dispose() {
    if (!_isTest) {
      WidgetsBinding.instance.removeObserver(this);
    }
    _refreshTimer?.cancel();
    super.dispose();
  }
}
