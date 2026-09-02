import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flauncher/widgets/side_panel_dialog.dart';
import 'package:flauncher/widgets/settings/focusable_settings_tile.dart';
import 'package:flauncher/providers/tv_inputs_service.dart';
import 'package:flauncher/models/tv_input.dart';
import 'package:flauncher/l10n/app_localizations.dart';

class InputsPanel extends StatelessWidget {
  const InputsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black54, // Dim background
      body: Stack(
        children: [
          // Tap outside to close
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(color: Colors.transparent),
          ),
          SidePanelDialog(
            width: 350,
            isRightSide: false,
            child: Consumer<TvInputsService>(
              builder: (context, tvInputsService, _) {
                final List<TvInput> inputs = tvInputsService.inputs;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      child: Text(
                        localizations.inputSources,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: inputs.isEmpty
                          ? Center(
                              child: Text(
                                "No inputs detected",
                                style: theme.textTheme.bodyMedium,
                              ),
                            )
                          : ListView.builder(
                              cacheExtent: 1000,
                              itemCount: inputs.length,
                              itemBuilder: (context, index) {
                                final input = inputs[index];
                                IconData iconData;
                                switch (input.type) {
                                  case TvInputType.hdmi:
                                    iconData = Icons.settings_input_hdmi;
                                    break;
                                  case TvInputType.tuner:
                                    iconData = Icons.settings_input_antenna_outlined;
                                    break;
                                  case TvInputType.av:
                                    iconData = Icons.settings_input_component_outlined;
                                    break;
                                  default:
                                    iconData = Icons.input_outlined;
                                }

                                return FocusableSettingsTile(
                                  leading: Icon(iconData, color: theme.colorScheme.primary),
                                  title: Text(
                                    input.label,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  autofocus: index == 0,
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    await tvInputsService.switchInput(input.id);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
