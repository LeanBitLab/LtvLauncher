import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get aboutFlauncher => 'LTvLauncherについて';

  @override
  String get addCategory => 'カテゴリを追加';

  @override
  String get addSection => 'セクションを追加';

  @override
  String get alphabetical => 'アルファベット順';

  @override
  String get appCardHighlightAnimation => 'アプリカードのハイライトアニメーション';

  @override
  String get appInfo => 'アプリ情報';

  @override
  String get appKeyClick => 'キー押下時のクリック音';

  @override
  String get applications => 'アプリケーション';

  @override
  String get autoHideAppBar => 'ステータスバーを自動非表示';

  @override
  String get backButtonAction => '戻るボタンの動作';

  @override
  String get category => 'カテゴリ';

  @override
  String get categories => 'カテゴリ';

  @override
  String get columnCount => '列数';

  @override
  String get date => '日付';

  @override
  String get dateAndTimeFormat => '日付と時刻の形式';

  @override
  String get delete => '削除';

  @override
  String get dialogOptionBackButtonActionDoNothing => '何もしない';

  @override
  String get dialogOptionBackButtonActionShowScreensaver => 'スクリーンセーバーを表示';

  @override
  String get dialogOptionBackButtonActionShowClock => '時計を表示';

  @override
  String get dialogTextNoFileExplorer => '画像を選択するにはファイルエクスプローラーをインストールしてください。';

  @override
  String get dialogTitleBackButtonAction => '戻るボタンの動作を選択';

  @override
  String disambiguateCategoryTitle(String title) {
    return '$title (カテゴリ)';
  }

  @override
  String formattedDate(String dateString) {
    return '書式化された日付: $dateString';
  }

  @override
  String formattedTime(String timeString) {
    return '書式化された時刻: $timeString';
  }

  @override
  String get gradient => 'グラデーション';

  @override
  String get favoriteApps => 'お気に入りアプリ';

  @override
  String get grid => 'グリッド';

  @override
  String get height => '高さ';

  @override
  String get hide => '非表示';

  @override
  String get hiddenApplications => '非表示のアプリ';

  @override
  String get launcherSections => 'セクション';

  @override
  String get layout => 'レイアウト';

  @override
  String get loading => '読み込み中';

  @override
  String get manual => '手動';

  @override
  String get modifySection => 'セクションを変更';

  @override
  String get mustNotBeEmpty => '空にすることはできません';

  @override
  String get name => '名前';

  @override
  String get newSection => '新しいセクション';

  @override
  String get noDateFormatSpecified => '日付形式が指定されていません';

  @override
  String get noTimeFormatSpecified => '時刻形式が指定されていません';

  @override
  String get nonTvApplications => '非TVアプリ';

  @override
  String get open => '開く';

  @override
  String get orSelectFormatSpecifiers => 'または形式指定子を選択';

  @override
  String get picture => '画像';

  @override
  String removeFrom(String name) {
    return '$nameから削除';
  }

  @override
  String get renameCategory => 'カテゴリ名を変更';

  @override
  String get reorder => '並べ替え';

  @override
  String get row => '行';

  @override
  String get rowHeight => '行の高さ';

  @override
  String get save => '保存';

  @override
  String get spacer => 'スペーサー';

  @override
  String get spacerMaxHeightRequirement => '0より大きく500以下である必要があります';

  @override
  String get statusBar => 'ステータスバー';

  @override
  String get settings => '設定';

  @override
  String get show => '表示';

  @override
  String get showCategoryTitles => 'カテゴリタイトルを表示';

  @override
  String get themes => 'テーマ';

  @override
  String get hideHighlightOutlineOnHomescreen => 'ホーム画面でハイライトのアウトラインを非表示';

  @override
  String get appSelectorTransitionAnimation => 'アプリセレクターの遷移アニメーション';

  @override
  String get sort => '並べ替え';

  @override
  String get systemSettings => 'システム設定';

  @override
  String textAboutDialog(String repoUrl) {
    return 'LTvLauncherはFLauncherをベースにしたAndroid TV用のカスタムオープンソースランチャーです。\n\nLeanBitLabによって開発されています。\nソースコードは$repoUrlで入手できます。';
  }

  @override
  String get textEmptyCategory => 'このカテゴリは空です。';

  @override
  String get time => '時刻';

  @override
  String get titleStatusBarSettingsPage => 'ステータスバーに表示するものを選択';

  @override
  String get tvApplications => 'TVアプリ';

  @override
  String get type => '種類';

  @override
  String get typeInTheDateFormat => '日付形式を入力';

  @override
  String get typeInTheHourFormat => '時刻形式を入力';

  @override
  String get uninstall => 'アンインストール';

  @override
  String get wallpaper => '壁紙';

  @override
  String get withEllipsisAddTo => '追加...';

  @override
  String get timeBasedWallpaper => '時間ベースの壁紙';

  @override
  String get pickDayWallpaper => '昼の壁紙を選択';

  @override
  String get pickNightWallpaper => '夜の壁紙を選択';

  @override
  String get accessibility => 'アクセシビリティ';

  @override
  String get defaultLauncherIsDefault => 'LTvLauncherはデフォルトのランチャーです';

  @override
  String get defaultLauncherNotDefault => 'LTvLauncherはデフォルトのランチャーではありません';

  @override
  String get setAsDefaultLauncher => 'デフォルトのランチャーに設定';

  @override
  String get defaultLauncherDescription => 'デフォルトのランチャーに設定すると、ホームボタンは常にLTvLauncherに戻ります。TVの起動時も直接LTvLauncherが起動します。';

  @override
  String get inputs => '入力';

  @override
  String get inputSources => '入力ソース';

  @override
  String get backupAndRestore => 'バックアップと復元';

  @override
  String get exportBackup => 'バックアップをエクスポート';

  @override
  String get importBackup => 'バックアップをインポート';

  @override
  String exportSuccess(String path) {
    return 'バックアップが$pathに正常にエクスポートされました';
  }

  @override
  String get importSuccess => 'バックアップが正常にインポートされました';

  @override
  String get importConfirm => 'バックアップをインポートしますか？現在の設定とレイアウトが上書きされます。';

  @override
  String importError(String error) {
    return 'バックアップのインポートに失敗しました: $error';
  }

  @override
  String exportError(String error) {
    return 'バックアップのエクスポートに失敗しました: $error';
  }

  @override
  String get shareBackup => 'バックアップを共有';

  @override
  String get shareBackupDescription => 'ローカルネットワーク上の他のデバイスとバックアップを共有';

  @override
  String get stopSharing => '共有を停止';

  @override
  String get localNetworkSharingActive => 'ローカルネットワーク共有が有効です！';

  @override
  String get localNetworkSharingInstructions => '他のデバイスを同じWi-Fiネットワークに接続し、Webブラウザで次のURLを開きます：';

  @override
  String get localNetworkSharingDetails => 'ここでTVの設定/レイアウトをダウンロードするか、バックアップファイルをこのTVにアップロードできます。';

  @override
  String failedToStartServer(String error) {
    return '共有サーバーの起動に失敗しました: $error';
  }

  @override
  String get notificationBell => '通知ベル';

  @override
  String get autoHideNotificationBell => '通知ベルを自動非表示';

  @override
  String get continueWatching => '続きを見る';

  @override
  String get showContinueWatchingOnHome => 'ホームに「続きを見る」を表示';

  @override
  String get permissionDeniedContinueWatching => '「続きを見る」を表示するには権限が必要です';

  @override
  String get interface => 'インターフェース';

  @override
  String get system => 'システム';

  @override
  String get accentColor => 'アクセントカラー';

  @override
  String get miscellaneous => 'その他';

  @override
  String get brightnessScheduler => '明るさスケジューラー';

  @override
  String get screensaverSettings => 'スクリーンセーバー設定';

  @override
  String get screensaverClockStyle => 'スクリーンセーバー時計スタイル';

  @override
  String get dataUsagePeriod => 'データ使用期間';

  @override
  String get notificationAccess => '通知アクセス';

  @override
  String get granted => '許可済み';

  @override
  String get permissionRequired => '権限が必要です';

  @override
  String get systemWidePopupAlert => 'システム全体のポップアップアラート';

  @override
  String get overlayPermissionRequired => 'オーバーレイ権限が必要です';

  @override
  String get enabled => '有効';

  @override
  String get disabled => '無効';

  @override
  String get showAppNamesBelowIcons => 'アイコンの下にアプリ名を表示';

  @override
  String get dataUsage => 'データ使用量';

  @override
  String get networkIndicator => 'ネットワークインジケーター';

  @override
  String get homeButtonFix => 'ホームボタン修正 (Google TV)';

  @override
  String get appLanguage => '言語';

  @override
  String get systemDefault => 'システムのデフォルト';

  @override
  String get english => '英語';

  @override
  String get spanish => 'スペイン語';

  @override
  String get ukrainian => 'ウクライナ語';

  @override
  String get chinese => '中国語';

  @override
  String get french => 'フランス語';

  @override
  String get german => 'ドイツ語';

  @override
  String get japanese => '日本語';

  @override
  String get portuguese => 'ポルトガル語';

  @override
  String get russian => 'ロシア語';

  @override
  String get italian => 'イタリア語';

  @override
  String get hindi => 'ヒンディー語';

  @override
  String get korean => '韓国語';

  @override
  String get arabic => 'アラビア語';

  @override
  String get turkish => 'トルコ語';

  @override
  String get hidePersistentNotifications => '常駐通知を非表示';

  @override
  String get hidePersistentNotificationsDesc => 'バックグラウンドサービスやシステムの常駐通知を非表示';

  @override
  String get blockedNotificationApps => 'ブロックされたアプリ';

  @override
  String get blockAppNotifications => '通知をブロック';

  @override
  String get unblockAppNotifications => '通知のブロックを解除';

  @override
  String get noBlockedApps => 'ブロックされたアプリはありません';

  @override
  String get persistentNotification => '常駐';

  @override
  String get unblockAll => 'すべてブロック解除';

  @override
  String get weather => '天気';

  @override
  String get showWeatherWarnings => '天気と雨の警告を表示';

  @override
  String get temperatureUnit => '温度単位';

  @override
  String get celsius => '摂氏 (°C)';

  @override
  String get fahrenheit => '華氏 (°F)';

  @override
  String get breezyWeatherSetupHint => 'Breezy Weather をインストールし、設定で「ローカルデータ共有」/「Gadgetbridge」を有効にすると、天気と雨の警告が表示されます。';
}
