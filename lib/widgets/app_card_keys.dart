/*
 * FLauncher
 * Copyright (C) 2026 LeanBitLab
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

import 'package:flutter/services.dart';

abstract class AppCardKeys {
  static const List<LogicalKeyboardKey> validationKeys = [
    LogicalKeyboardKey.select,
    LogicalKeyboardKey.enter,
    LogicalKeyboardKey.numpadEnter,
    LogicalKeyboardKey.gameButtonA,
    LogicalKeyboardKey.gameButtonSelect,
    LogicalKeyboardKey.gameButtonStart,
    LogicalKeyboardKey.space,
    LogicalKeyboardKey.accept,
  ];

  static const List<LogicalKeyboardKey> longPressableKeys = [
    LogicalKeyboardKey.select,
    LogicalKeyboardKey.enter,
    LogicalKeyboardKey.numpadEnter,
    LogicalKeyboardKey.gameButtonA,
    LogicalKeyboardKey.gameButtonSelect,
    LogicalKeyboardKey.space,
  ];

  static const List<LogicalKeyboardKey> cancelKeys = [
    LogicalKeyboardKey.escape,
    LogicalKeyboardKey.goBack,
    LogicalKeyboardKey.gameButtonB,
  ];

  static bool isArrowKey(LogicalKeyboardKey? key) {
    return key == LogicalKeyboardKey.arrowLeft ||
        key == LogicalKeyboardKey.arrowUp ||
        key == LogicalKeyboardKey.arrowRight ||
        key == LogicalKeyboardKey.arrowDown;
  }
}
