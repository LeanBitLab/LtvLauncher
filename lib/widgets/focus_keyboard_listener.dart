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

import 'package:flauncher/widgets/app_card_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FocusKeyboardListener extends StatefulWidget {
  final WidgetBuilder builder;
  final KeyEventResult Function(LogicalKeyboardKey)? onPressed;
  final KeyEventResult Function(LogicalKeyboardKey)? onLongPress;

  FocusKeyboardListener({
    Key? key,
    required this.builder,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  @override
  _FocusKeyboardListenerState createState() => _FocusKeyboardListenerState();
}

class _FocusKeyboardListenerState extends State<FocusKeyboardListener> {
  int? _keyDownAt;
  final Set<LogicalKeyboardKey> _handledKeys = {};

  @override
  Widget build(BuildContext context) => Focus(
        canRequestFocus: false,
        onKeyEvent: (_, keyEvent) => _handleKey(context, keyEvent),
        child: Builder(builder: widget.builder),
      );

  KeyEventResult _handleKey(BuildContext context, KeyEvent keyEvent) {
    if (keyEvent is KeyRepeatEvent) {
      final key = keyEvent.logicalKey;
      if (key == LogicalKeyboardKey.arrowLeft ||
          key == LogicalKeyboardKey.arrowRight ||
          key == LogicalKeyboardKey.arrowUp ||
          key == LogicalKeyboardKey.arrowDown) {
        final result = widget.onPressed?.call(key) ?? KeyEventResult.ignored;
        if (result == KeyEventResult.handled) {
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      }
    }

    switch (keyEvent.runtimeType) {
      case KeyDownEvent:
      case KeyRepeatEvent:
        return _keyDownEvent(context, keyEvent.logicalKey);
      case KeyUpEvent:
        return _keyUpEvent(context, keyEvent.logicalKey);
    }
    return KeyEventResult.handled;
  }

  KeyEventResult _keyDownEvent(BuildContext context, LogicalKeyboardKey key) {
    if (!AppCardKeys.longPressableKeys.contains(key)) {
      final result = widget.onPressed?.call(key) ?? KeyEventResult.ignored;
      if (result == KeyEventResult.handled) {
        _handledKeys.add(key);
      }
      return result;
    }
    if (_keyDownAt == null) {
      _keyDownAt = DateTime.now().millisecondsSinceEpoch;
      return KeyEventResult.handled;
    } else if (_longPress()) {
      _keyDownAt = null;
      return widget.onLongPress?.call(key) ?? KeyEventResult.ignored;
    }
    return KeyEventResult.handled;
  }

  KeyEventResult _keyUpEvent(BuildContext context, LogicalKeyboardKey key) {
    if (_handledKeys.remove(key)) {
      return KeyEventResult.handled;
    }
    if (_keyDownAt != null) {
      _keyDownAt = null;
      return widget.onPressed?.call(key) ?? KeyEventResult.ignored;
    }
    return KeyEventResult.ignored;
  }

  bool _longPress() => _keyDownAt != null && DateTime.now().millisecondsSinceEpoch - _keyDownAt! >= 500;
}
