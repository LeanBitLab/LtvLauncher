import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get aboutFlauncher => 'About LTvLauncher';

  @override
  String get addCategory => 'Add category';

  @override
  String get addSection => 'Add section';

  @override
  String get alphabetical => 'Alphabetical';

  @override
  String get appCardHighlightAnimation => 'App card highlight animation';

  @override
  String get appInfo => 'Application info';

  @override
  String get appKeyClick => 'Click sound on key press';

  @override
  String get applications => 'Applications';

  @override
  String get autoHideAppBar => 'Automatically hide status bar';

  @override
  String get backButtonAction => 'Back button action';

  @override
  String get category => 'Category';

  @override
  String get categories => 'Categories';

  @override
  String get columnCount => 'Column count';

  @override
  String get date => 'Date';

  @override
  String get dateAndTimeFormat => 'Date and time format';

  @override
  String get delete => 'Delete';

  @override
  String get dialogOptionBackButtonActionDoNothing => 'Do nothing';

  @override
  String get dialogOptionBackButtonActionShowScreensaver => 'Show screensaver';

  @override
  String get dialogOptionBackButtonActionShowClock => 'Show clock';

  @override
  String get dialogTextNoFileExplorer => 'Please install a file explorer in order to pick a picture.';

  @override
  String get dialogTitleBackButtonAction => 'Choose the back button action';

  @override
  String disambiguateCategoryTitle(String title) {
    return '$title (Category)';
  }

  @override
  String formattedDate(String dateString) {
    return 'Formatted date: $dateString';
  }

  @override
  String formattedTime(String timeString) {
    return 'Formatted time: $timeString';
  }

  @override
  String get gradient => 'Gradient';

  @override
  String get favoriteApps => 'Favorite Apps';

  @override
  String get grid => 'Grid';

  @override
  String get height => 'Height';

  @override
  String get hide => 'Hide';

  @override
  String get hiddenApplications => 'Hidden Apps';

  @override
  String get launcherSections => 'Sections';

  @override
  String get layout => 'Layout';

  @override
  String get loading => 'Loading';

  @override
  String get manual => 'Manual';

  @override
  String get modifySection => 'Modify section';

  @override
  String get mustNotBeEmpty => 'Must not be empty';

  @override
  String get name => 'Name';

  @override
  String get newSection => 'New section';

  @override
  String get noDateFormatSpecified => 'No date format specified';

  @override
  String get noTimeFormatSpecified => 'No time format specified';

  @override
  String get nonTvApplications => 'Non-TV Apps';

  @override
  String get open => 'Open';

  @override
  String get orSelectFormatSpecifiers => 'Or select format specifiers';

  @override
  String get picture => 'Picture';

  @override
  String removeFrom(String name) {
    return 'Remove from $name';
  }

  @override
  String get renameCategory => 'Rename category';

  @override
  String get reorder => 'Reorder';

  @override
  String get row => 'Row';

  @override
  String get rowHeight => 'Row height';

  @override
  String get save => 'Save';

  @override
  String get spacer => 'Spacer';

  @override
  String get spacerMaxHeightRequirement => 'Must be greater than 0 and less than or equal to 500';

  @override
  String get statusBar => 'Status bar';

  @override
  String get settings => 'Settings';

  @override
  String get show => 'Show';

  @override
  String get showCategoryTitles => 'Show category titles';

  @override
  String get themes => 'Themes';

  @override
  String get hideHighlightOutlineOnHomescreen => 'Hide highlight outline on homescreen';

  @override
  String get appSelectorTransitionAnimation => 'App selector transition animation';

  @override
  String get sort => 'Sort';

  @override
  String get systemSettings => 'System settings';

  @override
  String textAboutDialog(String repoUrl) {
    return 'LTvLauncher is a customized open-source launcher for Android TV, based on FLauncher.\n\nDeveloped by LeanBitLab.\nSource code available at $repoUrl.';
  }

  @override
  String get textEmptyCategory => 'This category is empty.';

  @override
  String get time => 'Time';

  @override
  String get titleStatusBarSettingsPage => 'Choose what to display in the status bar';

  @override
  String get tvApplications => 'TV Apps';

  @override
  String get type => 'Type';

  @override
  String get typeInTheDateFormat => 'Type in the date format';

  @override
  String get typeInTheHourFormat => 'Type in the hour format';

  @override
  String get uninstall => 'Uninstall';

  @override
  String get wallpaper => 'Wallpaper';

  @override
  String get withEllipsisAddTo => 'Add to...';

  @override
  String get timeBasedWallpaper => 'Time based wallpaper';

  @override
  String get pickDayWallpaper => 'Pick day wallpaper';

  @override
  String get pickNightWallpaper => 'Pick night wallpaper';

  @override
  String get accessibility => 'Accessibility';

  @override
  String get defaultLauncherIsDefault => 'LTvLauncher is the default launcher';

  @override
  String get defaultLauncherNotDefault => 'LTvLauncher is not the default launcher';

  @override
  String get setAsDefaultLauncher => 'Set as default launcher';

  @override
  String get defaultLauncherDescription => 'When set as the default launcher, the Home button will always return to LTvLauncher. The TV will also boot directly into LTvLauncher.';

  @override
  String get inputs => 'Inputs';

  @override
  String get inputSources => 'Input Sources';

  @override
  String get backupAndRestore => 'Backup & Restore';

  @override
  String get exportBackup => 'Export Backup';

  @override
  String get importBackup => 'Import Backup';

  @override
  String exportSuccess(String path) {
    return 'Backup exported successfully to $path';
  }

  @override
  String get importSuccess => 'Backup imported successfully';

  @override
  String get importConfirm => 'Are you sure you want to import the backup? This will overwrite your current settings and layout.';

  @override
  String importError(String error) {
    return 'Failed to import backup: $error';
  }

  @override
  String exportError(String error) {
    return 'Failed to export backup: $error';
  }

  @override
  String get shareBackup => 'Share Backup';

  @override
  String get shareBackupDescription => 'Share backup with other devices on local network';

  @override
  String get stopSharing => 'Stop Sharing';

  @override
  String get localNetworkSharingActive => 'Local network sharing is active!';

  @override
  String get localNetworkSharingInstructions => 'Connect another device to the same Wi-Fi network and open the following URL in a web browser:';

  @override
  String get localNetworkSharingDetails => 'Here you can download your TV settings/layout or upload a backup file back to this TV.';

  @override
  String failedToStartServer(String error) {
    return 'Failed to start sharing server: $error';
  }

  @override
  String get notificationBell => 'Notification Bell';

  @override
  String get autoHideNotificationBell => 'Auto-hide Notification Bell';

  @override
  String get continueWatching => 'Continue Watching';

  @override
  String get showContinueWatchingOnHome => 'Show Continue Watching on Home';

  @override
  String get permissionDeniedContinueWatching => 'Permission required to show Continue Watching';

  @override
  String get interface => 'Interface';

  @override
  String get system => 'System';

  @override
  String get accentColor => 'Accent Color';

  @override
  String get miscellaneous => 'Miscellaneous';

  @override
  String get brightnessScheduler => 'Brightness Scheduler';

  @override
  String get screensaverSettings => 'Screensaver Settings';

  @override
  String get screensaverClockStyle => 'Screensaver Clock Style';

  @override
  String get dataUsagePeriod => 'Data Usage Period';

  @override
  String get notificationAccess => 'Notification Access';

  @override
  String get granted => 'Granted';

  @override
  String get permissionRequired => 'Permission Required';

  @override
  String get systemWidePopupAlert => 'System-wide Popup Alert';

  @override
  String get overlayPermissionRequired => 'Overlay Permission Required';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get showAppNamesBelowIcons => 'Show App Names Below Icons';

  @override
  String get dataUsage => 'Data Usage';

  @override
  String get networkIndicator => 'Network Indicator';

  @override
  String get homeButtonFix => 'Home Button Fix (Google TV)';

  @override
  String get appLanguage => 'Language';

  @override
  String get systemDefault => 'System Default';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Spanish';

  @override
  String get ukrainian => 'Ukrainian';

  @override
  String get chinese => 'Chinese';

  @override
  String get french => 'French';

  @override
  String get german => 'German';

  @override
  String get japanese => 'Japanese';

  @override
  String get portuguese => 'Portuguese';

  @override
  String get russian => 'Russian';

  @override
  String get italian => 'Italian';

  @override
  String get hindi => 'Hindi';

  @override
  String get korean => 'Korean';

  @override
  String get arabic => 'Arabic';

  @override
  String get turkish => 'Turkish';

  @override
  String get hidePersistentNotifications => 'Hide Persistent Notifications';

  @override
  String get hidePersistentNotificationsDesc => 'Hide ongoing background service and system notifications';

  @override
  String get blockedNotificationApps => 'Blocked Apps';

  @override
  String get blockAppNotifications => 'Block Notifications';

  @override
  String get unblockAppNotifications => 'Unblock Notifications';

  @override
  String get noBlockedApps => 'No blocked apps';

  @override
  String get persistentNotification => 'Persistent';

  @override
  String get unblockAll => 'Unblock All';

  @override
  String get weather => 'Weather';

  @override
  String get showWeatherWarnings => 'Show Weather & Rain Warnings';

  @override
  String get temperatureUnit => 'Temperature Unit';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get breezyWeatherSetupHint => 'Install Breezy Weather and enable \'Local data sharing\' / \'Gadgetbridge\' in its settings to see weather and rain warnings.';
}
