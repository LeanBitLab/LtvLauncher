import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get aboutFlauncher => 'Про LTvLauncher';

  @override
  String get addCategory => 'Додати категорію';

  @override
  String get addSection => 'Додати розділ';

  @override
  String get alphabetical => 'За алфавітом';

  @override
  String get appCardHighlightAnimation => 'Анімація виділення картки застосунку';

  @override
  String get appInfo => 'Інформація про застосунок';

  @override
  String get appKeyClick => 'Звук клацання при натисканні клавіші';

  @override
  String get applications => 'Застосунки';

  @override
  String get autoHideAppBar => 'Автоматично приховувати рядок стану';

  @override
  String get backButtonAction => 'Дія кнопки «Назад»';

  @override
  String get category => 'Категорія';

  @override
  String get categories => 'Категорії';

  @override
  String get columnCount => 'Кількість стовпців';

  @override
  String get date => 'Дата';

  @override
  String get dateAndTimeFormat => 'Формат дати й часу';

  @override
  String get delete => 'Видалити';

  @override
  String get dialogOptionBackButtonActionDoNothing => 'Нічого не робити';

  @override
  String get dialogOptionBackButtonActionShowScreensaver => 'Показати заставку';

  @override
  String get dialogOptionBackButtonActionShowClock => 'Показати годинник';

  @override
  String get dialogTextNoFileExplorer => 'Будь ласка, встановіть файловий менеджер, щоб вибрати зображення.';

  @override
  String get dialogTitleBackButtonAction => 'Виберіть дію кнопки «Назад»';

  @override
  String disambiguateCategoryTitle(String title) {
    return '$title (Категорія)';
  }

  @override
  String formattedDate(String dateString) {
    return 'Формат дати: $dateString';
  }

  @override
  String formattedTime(String timeString) {
    return 'Формат часу: $timeString';
  }

  @override
  String get gradient => 'Градієнт';

  @override
  String get favoriteApps => 'Улюблені застосунки';

  @override
  String get grid => 'Сітка';

  @override
  String get height => 'Висота';

  @override
  String get hide => 'Приховати';

  @override
  String get hiddenApplications => 'Приховані застосунки';

  @override
  String get launcherSections => 'Розділи';

  @override
  String get layout => 'Розташування';

  @override
  String get loading => 'Завантаження';

  @override
  String get manual => 'Вручну';

  @override
  String get modifySection => 'Змінити розділ';

  @override
  String get mustNotBeEmpty => 'Не повинно бути порожнім';

  @override
  String get name => 'Назва';

  @override
  String get newSection => 'Новий розділ';

  @override
  String get noDateFormatSpecified => 'Формат дати не вказано';

  @override
  String get noTimeFormatSpecified => 'Формат часу не вказано';

  @override
  String get nonTvApplications => 'Застосунки не для ТБ';

  @override
  String get open => 'Відкрити';

  @override
  String get orSelectFormatSpecifiers => 'Або виберіть специфікатори формату';

  @override
  String get picture => 'Зображення';

  @override
  String removeFrom(String name) {
    return 'Видалити з $name';
  }

  @override
  String get renameCategory => 'Перейменувати категорію';

  @override
  String get reorder => 'Змінити порядок';

  @override
  String get row => 'Рядок';

  @override
  String get rowHeight => 'Висота рядка';

  @override
  String get save => 'Зберегти';

  @override
  String get spacer => 'Роздільник';

  @override
  String get spacerMaxHeightRequirement => 'Має бути більше 0 і не більше 500';

  @override
  String get statusBar => 'Рядок стану';

  @override
  String get settings => 'Налаштування';

  @override
  String get show => 'Показати';

  @override
  String get showCategoryTitles => 'Показувати назви категорій';

  @override
  String get themes => 'Теми';

  @override
  String get hideHighlightOutlineOnHomescreen => 'Приховати контур виділення на головному екрані';

  @override
  String get appSelectorTransitionAnimation => 'Анімація переходу вибору застосунку';

  @override
  String get sort => 'Сортування';

  @override
  String get systemSettings => 'Системні налаштування';

  @override
  String textAboutDialog(String repoUrl) {
    return 'LTvLauncher — це налаштований лаунчер з відкритим кодом для Android TV, створений на основі FLauncher.\n\nРозроблено LeanBitLab.\nВихідний код доступний за адресою $repoUrl.';
  }

  @override
  String get textEmptyCategory => 'Ця категорія порожня.';

  @override
  String get time => 'Час';

  @override
  String get titleStatusBarSettingsPage => 'Виберіть, що відображати в рядку стану';

  @override
  String get tvApplications => 'Застосунки для ТБ';

  @override
  String get type => 'Тип';

  @override
  String get typeInTheDateFormat => 'Введіть формат дати';

  @override
  String get typeInTheHourFormat => 'Введіть формат часу';

  @override
  String get uninstall => 'Видалити';

  @override
  String get wallpaper => 'Шпалери';

  @override
  String get withEllipsisAddTo => 'Додати до...';

  @override
  String get timeBasedWallpaper => 'Шпалери залежно від часу';

  @override
  String get pickDayWallpaper => 'Вибрати денні шпалери';

  @override
  String get pickNightWallpaper => 'Вибрати нічні шпалери';

  @override
  String get accessibility => 'Спеціальні можливості';

  @override
  String get defaultLauncherIsDefault => 'LTvLauncher є лаунчером за замовчуванням';

  @override
  String get defaultLauncherNotDefault => 'LTvLauncher не є лаунчером за замовчуванням';

  @override
  String get setAsDefaultLauncher => 'Встановити як лаунчер за замовчуванням';

  @override
  String get defaultLauncherDescription => 'Якщо встановлено як лаунчер за замовчуванням, кнопка «Домівка» завжди повертатиме до LTvLauncher. Телевізор також завантажуватиметься одразу в LTvLauncher.';

  @override
  String get inputs => 'Джерела сигналу';

  @override
  String get inputSources => 'Джерела сигналу';

  @override
  String get backupAndRestore => 'Резервне копіювання та відновлення';

  @override
  String get exportBackup => 'Експортувати резервну копію';

  @override
  String get importBackup => 'Імпортувати резервну копію';

  @override
  String exportSuccess(String path) {
    return 'Резервну копію успішно експортовано до $path';
  }

  @override
  String get importSuccess => 'Резервну копію успішно імпортовано';

  @override
  String get importConfirm => 'Ви впевнені, що хочете імпортувати резервну копію? Це замінить поточні налаштування та розташування.';

  @override
  String importError(String error) {
    return 'Не вдалося імпортувати резервну копію: $error';
  }

  @override
  String exportError(String error) {
    return 'Не вдалося експортувати резервну копію: $error';
  }

  @override
  String get shareBackup => 'Поділитися резервною копією';

  @override
  String get shareBackupDescription => 'Поділитися резервною копією з іншими пристроями в локальній мережі';

  @override
  String get stopSharing => 'Зупинити спільний доступ';

  @override
  String get localNetworkSharingActive => 'Спільний доступ у локальній мережі активний!';

  @override
  String get localNetworkSharingInstructions => 'Підключіть інший пристрій до тієї самої мережі Wi-Fi та відкрийте таку адресу у веббраузері:';

  @override
  String get localNetworkSharingDetails => 'Тут ви можете завантажити налаштування/розташування вашого ТБ або вивантажити файл резервної копії назад на цей телевізор.';

  @override
  String failedToStartServer(String error) {
    return 'Не вдалося запустити сервер спільного доступу: $error';
  }

  @override
  String get notificationBell => 'Дзвіночок сповіщень';

  @override
  String get autoHideNotificationBell => 'Автоматично приховувати дзвіночок сповіщень';

  @override
  String get continueWatching => 'Продовжити перегляд';

  @override
  String get showContinueWatchingOnHome => 'Показувати «Продовжити перегляд» на головному екрані';

  @override
  String get permissionDeniedContinueWatching => 'Потрібен дозвіл для показу «Продовжити перегляд»';

  @override
  String get interface => 'Інтерфейс';

  @override
  String get system => 'Система';

  @override
  String get accentColor => 'Акцентний колір';

  @override
  String get miscellaneous => 'Інше';

  @override
  String get brightnessScheduler => 'Розклад яскравості';

  @override
  String get screensaverSettings => 'Налаштування заставки';

  @override
  String get screensaverClockStyle => 'Стиль годинника заставки';

  @override
  String get dataUsagePeriod => 'Період використання даних';

  @override
  String get notificationAccess => 'Доступ до сповіщень';

  @override
  String get granted => 'Надано';

  @override
  String get permissionRequired => 'Потрібен дозвіл';

  @override
  String get systemWidePopupAlert => 'Спливне сповіщення в системі';

  @override
  String get overlayPermissionRequired => 'Потрібен дозвіл на накладання';

  @override
  String get enabled => 'Увімкнено';

  @override
  String get disabled => 'Вимкнено';

  @override
  String get showAppNamesBelowIcons => 'Показувати назви застосунків під іконками';

  @override
  String get dataUsage => 'Використання даних';

  @override
  String get networkIndicator => 'Індикатор мережі';

  @override
  String get homeButtonFix => 'Виправлення кнопки «Домівка» (Google TV)';

  @override
  String get appLanguage => 'Мова';

  @override
  String get systemDefault => 'Системна мова за замовчуванням';

  @override
  String get english => 'Англійська';

  @override
  String get spanish => 'Іспанська';

  @override
  String get ukrainian => 'Українська';

  @override
  String get chinese => 'Китайська';
}
