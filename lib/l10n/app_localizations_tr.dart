import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get aboutFlauncher => 'LTvLauncher Hakkında';

  @override
  String get addCategory => 'Kategori ekle';

  @override
  String get addSection => 'Bölüm ekle';

  @override
  String get alphabetical => 'Alfabetik';

  @override
  String get appCardHighlightAnimation => 'Uygulama kartı vurgulama animasyonu';

  @override
  String get appInfo => 'Uygulama bilgisi';

  @override
  String get appKeyClick => 'Tuşa basıldığında tıklama sesi';

  @override
  String get applications => 'Uygulamalar';

  @override
  String get autoHideAppBar => 'Durum çubuğunu otomatik gizle';

  @override
  String get backButtonAction => 'Geri düğmesi eylemi';

  @override
  String get category => 'Kategori';

  @override
  String get categories => 'Kategoriler';

  @override
  String get columnCount => 'Sütun sayısı';

  @override
  String get date => 'Tarih';

  @override
  String get dateAndTimeFormat => 'Tarih ve saat biçimi';

  @override
  String get delete => 'Sil';

  @override
  String get dialogOptionBackButtonActionDoNothing => 'Hiçbir şey yapma';

  @override
  String get dialogOptionBackButtonActionShowScreensaver => 'Ekran koruyucuyu göster';

  @override
  String get dialogOptionBackButtonActionShowClock => 'Saati göster';

  @override
  String get dialogTextNoFileExplorer => 'Resim seçmek için lütfen bir dosya gezgini yükleyin.';

  @override
  String get dialogTitleBackButtonAction => 'Geri düğmesi eylemini seçin';

  @override
  String disambiguateCategoryTitle(String title) {
    return '${title} (Kategori)';
  }

  @override
  String formattedDate(String dateString) {
    return 'Biçimlendirilmiş tarih: ${dateString}';
  }

  @override
  String formattedTime(String timeString) {
    return 'Biçimlendirilmiş saat: ${timeString}';
  }

  @override
  String get gradient => 'Gradyan';

  @override
  String get favoriteApps => 'Favori Uygulamalar';

  @override
  String get grid => 'Izgara';

  @override
  String get height => 'Yükseklik';

  @override
  String get hide => 'Gizle';

  @override
  String get hiddenApplications => 'Gizli Uygulamalar';

  @override
  String get launcherSections => 'Bölümler';

  @override
  String get layout => 'Düzen';

  @override
  String get loading => 'Yükleniyor';

  @override
  String get manual => 'Manuel';

  @override
  String get modifySection => 'Bölümü değiştir';

  @override
  String get mustNotBeEmpty => 'Boş bırakılamaz';

  @override
  String get name => 'Ad';

  @override
  String get newSection => 'Yeni bölüm';

  @override
  String get noDateFormatSpecified => 'Tarih biçimi belirtilmedi';

  @override
  String get noTimeFormatSpecified => 'Saat biçimi belirtilmedi';

  @override
  String get nonTvApplications => 'TV Dışı Uygulamalar';

  @override
  String get open => 'Aç';

  @override
  String get orSelectFormatSpecifiers => 'Veya biçim belirteçlerini seçin';

  @override
  String get picture => 'Resim';

  @override
  String removeFrom(String name) {
    return '${name} öğesinden kaldır';
  }

  @override
  String get renameCategory => 'Kategoriyi yeniden adlandır';

  @override
  String get reorder => 'Yeniden sırala';

  @override
  String get row => 'Satır';

  @override
  String get rowHeight => 'Satır yüksekliği';

  @override
  String get save => 'Kaydet';

  @override
  String get spacer => 'Ayırıcı';

  @override
  String get spacerMaxHeightRequirement => '0\'dan büyük ve 500\'den küçük veya eşit olmalıdır';

  @override
  String get statusBar => 'Durum çubuğu';

  @override
  String get settings => 'Ayarlar';

  @override
  String get show => 'Göster';

  @override
  String get showCategoryTitles => 'Kategori başlıklarını göster';

  @override
  String get themes => 'Temalar';

  @override
  String get hideHighlightOutlineOnHomescreen => 'Ana ekranda vurgu anahattını gizle';

  @override
  String get appSelectorTransitionAnimation => 'Uygulama seçici geçiş animasyonu';

  @override
  String get sort => 'Sırala';

  @override
  String get systemSettings => 'Sistem ayarları';

  @override
  String textAboutDialog(String repoUrl) {
    return 'LTvLauncher, FLauncher tabanlı, Android TV için özelleştirilmiş açık kaynaklı bir başlatıcıdır.\n\nLeanBitLab tarafından geliştirilmiştir.\nKaynak kodu ${repoUrl} adresinde mevcuttur.';
  }

  @override
  String get textEmptyCategory => 'Bu kategori boş.';

  @override
  String get time => 'Saat';

  @override
  String get titleStatusBarSettingsPage => 'Durum çubuğunda neyin görüntüleneceğini seçin';

  @override
  String get tvApplications => 'TV Uygulamaları';

  @override
  String get type => 'Tür';

  @override
  String get typeInTheDateFormat => 'Tarih biçimini yazın';

  @override
  String get typeInTheHourFormat => 'Saat biçimini yazın';

  @override
  String get uninstall => 'Kaldır';

  @override
  String get wallpaper => 'Duvar kağıdı';

  @override
  String get withEllipsisAddTo => 'Şuraya ekle...';

  @override
  String get timeBasedWallpaper => 'Zamana dayalı duvar kağıdı';

  @override
  String get pickDayWallpaper => 'Gündüz duvar kağıdını seç';

  @override
  String get pickNightWallpaper => 'Gece duvar kağıdını seç';

  @override
  String get accessibility => 'Erişilebilirlik';

  @override
  String get defaultLauncherIsDefault => 'LTvLauncher varsayılan başlatıcıdır';

  @override
  String get defaultLauncherNotDefault => 'LTvLauncher varsayılan başlatıcı değildir';

  @override
  String get setAsDefaultLauncher => 'Varsayılan başlatıcı olarak ayarla';

  @override
  String get defaultLauncherDescription => 'Varsayılan başlatıcı olarak ayarlandığında, Ana Sayfa düğmesi her zaman LTvLauncher\'a döner. TV de doğrudan LTvLauncher\'da başlar.';

  @override
  String get inputs => 'Girişler';

  @override
  String get inputSources => 'Giriş Kaynakları';

  @override
  String get backupAndRestore => 'Yedekleme ve Geri Yükleme';

  @override
  String get exportBackup => 'Yedeği Dışa Aktar';

  @override
  String get importBackup => 'Yedeği İçe Aktar';

  @override
  String exportSuccess(String path) {
    return 'Yedek başarıyla ${path} konumuna dışa aktarıldı';
  }

  @override
  String get importSuccess => 'Yedek başarıyla içe aktarıldı';

  @override
  String get importConfirm => 'Yedeği içe aktarmak istediğinizden emin misiniz? Bu işlem mevcut ayarlarınızın ve düzeninizin üzerine yazacaktır.';

  @override
  String importError(String error) {
    return 'Yedek içe aktarılamadı: ${error}';
  }

  @override
  String exportError(String error) {
    return 'Yedek dışa aktarılamadı: ${error}';
  }

  @override
  String get shareBackup => 'Yedeği Paylaş';

  @override
  String get shareBackupDescription => 'Yedeği yerel ağdaki diğer cihazlarla paylaş';

  @override
  String get stopSharing => 'Paylaşımı Durdur';

  @override
  String get localNetworkSharingActive => 'Yerel ağ paylaşımı etkin!';

  @override
  String get localNetworkSharingInstructions => 'Başka bir cihazı aynı Wi-Fi ağına bağlayın ve bir web tarayıcısında aşağıdaki URL\'yi açın:';

  @override
  String get localNetworkSharingDetails => 'Buradan TV ayarlarınızı/düzeninizi indirebilir veya bir yedek dosyasını bu TV\'ye geri yükleyebilirsiniz.';

  @override
  String failedToStartServer(String error) {
    return 'Paylaşım sunucusu başlatılamadı: ${error}';
  }

  @override
  String get notificationBell => 'Bildirim Zili';

  @override
  String get autoHideNotificationBell => 'Bildirim Zilini otomatik gizle';

  @override
  String get continueWatching => 'İzlemeye Devam Et';

  @override
  String get showContinueWatchingOnHome => 'Ana Ekranda İzlemeye Devam Et\'i göster';

  @override
  String get permissionDeniedContinueWatching => 'İzlemeye Devam Et\'i göstermek için izin gerekli';

  @override
  String get interface => 'Arayüz';

  @override
  String get system => 'Sistem';

  @override
  String get accentColor => 'Vurgu Rengi';

  @override
  String get miscellaneous => 'Çeşitli';

  @override
  String get brightnessScheduler => 'Parlaklık Zamanlayıcısı';

  @override
  String get screensaverSettings => 'Ekran Koruyucu Ayarları';

  @override
  String get screensaverClockStyle => 'Ekran Koruyucu Saat Stili';

  @override
  String get dataUsagePeriod => 'Veri Kullanım Dönemi';

  @override
  String get notificationAccess => 'Bildirim Erişimi';

  @override
  String get granted => 'Verildi';

  @override
  String get permissionRequired => 'İzin Gerekli';

  @override
  String get systemWidePopupAlert => 'Sistem Geneli Açılır Pencere Uyarısı';

  @override
  String get overlayPermissionRequired => 'Kaplama İzni Gerekli';

  @override
  String get enabled => 'Etkin';

  @override
  String get disabled => 'Devre Dışı';

  @override
  String get showAppNamesBelowIcons => 'Uygulama adlarını simgelerin altında göster';

  @override
  String get dataUsage => 'Veri Kullanımı';

  @override
  String get networkIndicator => 'Ağ Göstergesi';

  @override
  String get homeButtonFix => 'Ana Sayfa Düğmesi Düzeltmesi (Google TV)';

  @override
  String get appLanguage => 'Dil';

  @override
  String get systemDefault => 'Sistem Varsayılanı';

  @override
  String get english => 'İngilizce';

  @override
  String get spanish => 'İspanyolca';

  @override
  String get ukrainian => 'Ukraynaca';

  @override
  String get chinese => 'Çince';

  @override
  String get french => 'Fransızca';

  @override
  String get german => 'Almanca';

  @override
  String get japanese => 'Japonca';

  @override
  String get portuguese => 'Portekizce';

  @override
  String get russian => 'Rusça';

  @override
  String get italian => 'İtalyanca';

  @override
  String get hindi => 'Hintçe';

  @override
  String get korean => 'Korece';

  @override
  String get arabic => 'Arapça';

  @override
  String get turkish => 'Türkçe';
}
