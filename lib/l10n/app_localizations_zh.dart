import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get aboutFlauncher => '关于 LTvLauncher';

  @override
  String get addCategory => '添加类别';

  @override
  String get addSection => '添加分区';

  @override
  String get alphabetical => '按字母顺序';

  @override
  String get appCardHighlightAnimation => '应用卡片高亮动画';

  @override
  String get appInfo => '应用信息';

  @override
  String get appKeyClick => '按键提示音';

  @override
  String get applications => '应用';

  @override
  String get autoHideAppBar => '自动隐藏状态栏';

  @override
  String get backButtonAction => '返回键行为';

  @override
  String get category => '类别';

  @override
  String get categories => '类别';

  @override
  String get columnCount => '列数';

  @override
  String get date => '日期';

  @override
  String get dateAndTimeFormat => '日期和时间格式';

  @override
  String get delete => '删除';

  @override
  String get dialogOptionBackButtonActionDoNothing => '无操作';

  @override
  String get dialogOptionBackButtonActionShowScreensaver => '显示屏保';

  @override
  String get dialogOptionBackButtonActionShowClock => '显示时钟';

  @override
  String get dialogTextNoFileExplorer => '请安装文件管理器以选择图片。';

  @override
  String get dialogTitleBackButtonAction => '选择返回键行为';

  @override
  String disambiguateCategoryTitle(String title) {
    return '$title（类别）';
  }

  @override
  String formattedDate(String dateString) {
    return '格式化日期：$dateString';
  }

  @override
  String formattedTime(String timeString) {
    return '格式化时间：$timeString';
  }

  @override
  String get gradient => '渐变';

  @override
  String get favoriteApps => '收藏应用';

  @override
  String get grid => '网格';

  @override
  String get height => '高度';

  @override
  String get hide => '隐藏';

  @override
  String get hiddenApplications => '已隐藏应用';

  @override
  String get launcherSections => '分区';

  @override
  String get layout => '布局';

  @override
  String get loading => '加载中';

  @override
  String get manual => '手动';

  @override
  String get modifySection => '修改分区';

  @override
  String get mustNotBeEmpty => '不能为空';

  @override
  String get name => '名称';

  @override
  String get newSection => '新建分区';

  @override
  String get noDateFormatSpecified => '未指定日期格式';

  @override
  String get noTimeFormatSpecified => '未指定时间格式';

  @override
  String get nonTvApplications => '非电视应用';

  @override
  String get open => '打开';

  @override
  String get orSelectFormatSpecifiers => '或选择格式说明符';

  @override
  String get picture => '图片';

  @override
  String removeFrom(String name) {
    return '从$name中移除';
  }

  @override
  String get renameCategory => '重命名类别';

  @override
  String get reorder => '重新排序';

  @override
  String get row => '行';

  @override
  String get rowHeight => '行高';

  @override
  String get save => '保存';

  @override
  String get spacer => '间隔';

  @override
  String get spacerMaxHeightRequirement => '必须大于 0 且小于等于 500';

  @override
  String get statusBar => '状态栏';

  @override
  String get settings => '设置';

  @override
  String get show => '显示';

  @override
  String get showCategoryTitles => '显示类别标题';

  @override
  String get themes => '主题';

  @override
  String get hideHighlightOutlineOnHomescreen => '在主屏幕隐藏高亮边框';

  @override
  String get appSelectorTransitionAnimation => '应用选择器转场动画';

  @override
  String get sort => '排序';

  @override
  String get systemSettings => '系统设置';

  @override
  String textAboutDialog(String repoUrl) {
    return 'LTvLauncher 是一款基于 FLauncher 定制的开源 Android TV 桌面启动器。\n\n由 LeanBitLab 开发。\n源代码可在 $repoUrl 获取。';
  }

  @override
  String get textEmptyCategory => '此类别为空。';

  @override
  String get time => '时间';

  @override
  String get titleStatusBarSettingsPage => '选择状态栏中显示的内容';

  @override
  String get tvApplications => '电视应用';

  @override
  String get type => '类型';

  @override
  String get typeInTheDateFormat => '输入日期格式';

  @override
  String get typeInTheHourFormat => '输入时间格式';

  @override
  String get uninstall => '卸载';

  @override
  String get wallpaper => '壁纸';

  @override
  String get withEllipsisAddTo => '添加到…';

  @override
  String get timeBasedWallpaper => '按时间切换壁纸';

  @override
  String get pickDayWallpaper => '选择日间壁纸';

  @override
  String get pickNightWallpaper => '选择夜间壁纸';

  @override
  String get accessibility => '无障碍';

  @override
  String get defaultLauncherIsDefault => 'LTvLauncher 是默认桌面';

  @override
  String get defaultLauncherNotDefault => 'LTvLauncher 不是默认桌面';

  @override
  String get setAsDefaultLauncher => '设为默认桌面';

  @override
  String get defaultLauncherDescription => '设为默认桌面后，按 Home 键将始终返回 LTvLauncher。电视开机也会直接进入 LTvLauncher。';

  @override
  String get inputs => '输入源';

  @override
  String get inputSources => '输入源';

  @override
  String get backupAndRestore => '备份与恢复';

  @override
  String get exportBackup => '导出备份';

  @override
  String get importBackup => '导入备份';

  @override
  String exportSuccess(String path) {
    return '备份已成功导出到 $path';
  }

  @override
  String get importSuccess => '备份导入成功';

  @override
  String get importConfirm => '确定要导入备份吗？这将会覆盖你当前的设置和布局。';

  @override
  String importError(String error) {
    return '导入备份失败：$error';
  }

  @override
  String exportError(String error) {
    return '导出备份失败：$error';
  }

  @override
  String get shareBackup => '共享备份';

  @override
  String get shareBackupDescription => '与局域网中的其他设备共享备份';

  @override
  String get stopSharing => '停止共享';

  @override
  String get localNetworkSharingActive => '局域网共享已开启！';

  @override
  String get localNetworkSharingInstructions => '将另一台设备连接到同一 Wi-Fi 网络，并在浏览器中打开以下地址：';

  @override
  String get localNetworkSharingDetails => '你可以在此下载电视的设置/布局，或将备份文件上传回这台电视。';

  @override
  String failedToStartServer(String error) {
    return '启动共享服务失败：$error';
  }

  @override
  String get notificationBell => '通知铃铛';

  @override
  String get autoHideNotificationBell => '自动隐藏通知铃铛';

  @override
  String get continueWatching => '继续观看';

  @override
  String get showContinueWatchingOnHome => '在主页显示「继续观看」';

  @override
  String get permissionDeniedContinueWatching => '显示「继续观看」需要权限';

  @override
  String get interface => '界面';

  @override
  String get system => '系统';

  @override
  String get accentColor => '强调色';

  @override
  String get miscellaneous => '其他';

  @override
  String get brightnessScheduler => '亮度定时';

  @override
  String get screensaverSettings => '屏保设置';

  @override
  String get screensaverClockStyle => '屏保时钟样式';

  @override
  String get dataUsagePeriod => '数据使用周期';

  @override
  String get notificationAccess => '通知访问权限';

  @override
  String get granted => '已授予';

  @override
  String get permissionRequired => '需要权限';

  @override
  String get systemWidePopupAlert => '全局弹窗提醒';

  @override
  String get overlayPermissionRequired => '需要悬浮窗权限';

  @override
  String get enabled => '已启用';

  @override
  String get disabled => '已禁用';

  @override
  String get showAppNamesBelowIcons => '在图标下方显示应用名称';

  @override
  String get dataUsage => '数据使用';

  @override
  String get networkIndicator => '网络指示器';

  @override
  String get homeButtonFix => 'Home 键修复（Google TV）';

  @override
  String get appLanguage => '语言';

  @override
  String get systemDefault => '跟随系统';

  @override
  String get english => '英语';

  @override
  String get spanish => '西班牙语';

  @override
  String get ukrainian => '乌克兰语';

  @override
  String get chinese => '中文';

  @override
  String get french => '法语';

  @override
  String get german => '德语';

  @override
  String get japanese => '日语';

  @override
  String get portuguese => '葡萄牙语';

  @override
  String get russian => '俄语';

  @override
  String get italian => '意大利语';

  @override
  String get hindi => '印地语';

  @override
  String get korean => '韩语';

  @override
  String get arabic => '阿拉伯语';

  @override
  String get turkish => '土耳其语';

  @override
  String get hidePersistentNotifications => '隐藏常驻通知';

  @override
  String get hidePersistentNotificationsDesc => '隐藏后台服务和系统常驻通知';

  @override
  String get blockedNotificationApps => '已屏蔽的应用';

  @override
  String get blockAppNotifications => '屏蔽通知';

  @override
  String get unblockAppNotifications => '取消屏蔽通知';

  @override
  String get noBlockedApps => '暂无已屏蔽的应用';

  @override
  String get persistentNotification => '常驻';

  @override
  String get unblockAll => '全部取消屏蔽';

  @override
  String get weather => '天气';

  @override
  String get showWeatherWarnings => '显示降雨及天气预警';

  @override
  String get temperatureUnit => '温度单位';

  @override
  String get celsius => '摄氏度 (°C)';

  @override
  String get fahrenheit => '华氏度 (°F)';

  @override
  String get breezyWeatherSetupHint => '安装 Breezy Weather 并在其设置中开启“本地数据共享”/“Gadgetbridge”以显示天气和降雨预警。';
}
