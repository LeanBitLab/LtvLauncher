import 'dart:io';
import 'package:flauncher/providers/apps_service.dart';
import 'package:flauncher/providers/backup_service.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:flauncher/widgets/settings/focusable_settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flauncher/l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

class BackupRestorePage extends StatelessWidget {
  static const String routeName = "backup_restore_panel";

  const BackupRestorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(localizations.backupAndRestore, style: Theme.of(context).textTheme.titleLarge),
        const Divider(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FocusableSettingsTile(
                  autofocus: true,
                  leading: const Icon(Icons.upload_file),
                  title: Text(localizations.exportBackup, style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () => _export(context, localizations),
                ),
                FocusableSettingsTile(
                  leading: const Icon(Icons.download_done),
                  title: Text(localizations.importBackup, style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () => _confirmImport(context, localizations),
                ),
                FocusableSettingsTile(
                  leading: const Icon(Icons.share),
                  title: Text(localizations.shareBackup, style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () => _share(context, localizations),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _share(BuildContext context, AppLocalizations localizations) async {
    try {
      final pathStr = await context.read<BackupService>().exportBackup();
      await Share.shareXFiles([XFile(pathStr)], text: 'LTvLauncher Backup');
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Share Failed"),
            content: Text("Failed to share backup: $e"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _export(BuildContext context, AppLocalizations localizations) async {
    try {
      final path = await context.read<BackupService>().exportBackup();
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Export Success"),
            content: Text(localizations.exportSuccess(path)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Export Failed"),
            content: Text(localizations.exportError(e.toString())),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String _formatDate(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} "
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  Future<void> _confirmImport(BuildContext context, AppLocalizations localizations) async {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(localizations.importBackup),
          content: Container(
            width: 400,
            constraints: const BoxConstraints(maxHeight: 300),
            child: FutureBuilder<List<BackupFileEntry>>(
              future: context.read<BackupService>().getBackupFiles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return Text(
                    "Error loading backups: ${snapshot.error}",
                    style: const TextStyle(color: Colors.red),
                  );
                }
                final entries = snapshot.data ?? [];
                if (entries.isEmpty) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: Text("No backup files found."),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        child: const Text("OK"),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return FocusableSettingsTile(
                      leading: const Icon(Icons.settings_backup_restore),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${_formatDate(entry.lastModified)} (${_formatSize(entry.size)})",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        _confirmFileImport(context, localizations, entry);
                      },
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmFileImport(
      BuildContext context, AppLocalizations localizations, BackupFileEntry entry) async {
    final backupService = context.read<BackupService>();
    final settingsService = context.read<SettingsService>();
    final appsService = context.read<AppsService>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(localizations.importBackup),
        content: Text(localizations.importConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              try {
                await backupService.importBackup(entry.file);
                settingsService.reload();
                await appsService.refreshState();
              } catch (_) {}
            },
            child: const Text("Import"),
          ),
        ],
      ),
    );
  }
}
