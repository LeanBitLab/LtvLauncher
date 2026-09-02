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

import 'package:flauncher/l10n/app_localizations.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:flauncher/widgets/settings/focusable_settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppLanguagePage extends StatelessWidget {
  static const String routeName = "app_language_panel";

  const AppLanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Consumer<SettingsService>(
      builder: (context, service, _) {
        return Column(
          children: [
            Text(localizations.appLanguage, style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  _radioTile(context, service, localizations.systemDefault, "", autofocus: true),
                  _radioTile(context, service, localizations.english, "en"),
                  _radioTile(context, service, localizations.spanish, "es"),
                  _radioTile(context, service, localizations.ukrainian, "uk"),
                  _radioTile(context, service, localizations.chinese, "zh"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _radioTile(BuildContext context, SettingsService service, String label, String value, {bool autofocus = false}) {
    final isSelected = service.appLanguage == value;
    return FocusableSettingsTile(
      autofocus: autofocus && isSelected,
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: isSelected ? Theme.of(context).colorScheme.secondary : Colors.grey,
      ),
      title: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      onPressed: () => service.setAppLanguage(value),
    );
  }
}
