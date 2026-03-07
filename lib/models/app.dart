/*
 * FLauncher
 * Copyright (C) 2024 Oscar Rojas
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

class App
{
  final String name;

  final String packageName;

  final String version;

  bool hidden;

  bool sideloaded;

  Map<int, int> categoryOrders;

  String? action;

  DateTime? lastLaunchedAt; // For "Last Used" category sorting

  App({
    required this.packageName,
    required this.name,
    required this.version,
    required this.hidden,
    this.action = null
  }):
    categoryOrders = Map(),
    sideloaded = false;

  App.fromSystem(Map<dynamic, dynamic> data):
    packageName = data['packageName'],
    name = data['name'],
    version = data['version'],
    hidden = false,
    sideloaded = data['sideloaded'],
    categoryOrders = Map() {

    if (data.containsKey('action')) {
      action = data['action'];
    }
  }
}