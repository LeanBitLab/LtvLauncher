import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get aboutFlauncher => 'Informazioni su LTvLauncher';

  @override
  String get addCategory => 'Aggiungi categoria';

  @override
  String get addSection => 'Aggiungi sezione';

  @override
  String get alphabetical => 'Alfabetico';

  @override
  String get appCardHighlightAnimation => 'Animazione evidenziazione scheda app';

  @override
  String get appInfo => 'Info app';

  @override
  String get appKeyClick => 'Suono clic alla pressione del tasto';

  @override
  String get applications => 'Applicazioni';

  @override
  String get autoHideAppBar => 'Nascondi automaticamente barra di stato';

  @override
  String get backButtonAction => 'Azione pulsante Indietro';

  @override
  String get category => 'Categoria';

  @override
  String get categories => 'Categorie';

  @override
  String get columnCount => 'Numero di colonne';

  @override
  String get date => 'Data';

  @override
  String get dateAndTimeFormat => 'Formato data e ora';

  @override
  String get delete => 'Elimina';

  @override
  String get dialogOptionBackButtonActionDoNothing => 'Non fare nulla';

  @override
  String get dialogOptionBackButtonActionShowScreensaver => 'Mostra salvaschermo';

  @override
  String get dialogOptionBackButtonActionShowClock => 'Mostra orologio';

  @override
  String get dialogTextNoFileExplorer => 'Installa un file manager per selezionare un\'immagine.';

  @override
  String get dialogTitleBackButtonAction => 'Scegli l\'azione del pulsante Indietro';

  @override
  String disambiguateCategoryTitle(String title) {
    return '$title (Categoria)';
  }

  @override
  String formattedDate(String dateString) {
    return 'Data formattata: $dateString';
  }

  @override
  String formattedTime(String timeString) {
    return 'Ora formattata: $timeString';
  }

  @override
  String get gradient => 'Sfumatura';

  @override
  String get favoriteApps => 'App preferite';

  @override
  String get grid => 'Griglia';

  @override
  String get height => 'Altezza';

  @override
  String get hide => 'Nascondi';

  @override
  String get hiddenApplications => 'App nascoste';

  @override
  String get launcherSections => 'Sezioni';

  @override
  String get layout => 'Layout';

  @override
  String get loading => 'Caricamento';

  @override
  String get manual => 'Manuale';

  @override
  String get modifySection => 'Modifica sezione';

  @override
  String get mustNotBeEmpty => 'Non può essere vuoto';

  @override
  String get name => 'Nome';

  @override
  String get newSection => 'Nuova sezione';

  @override
  String get noDateFormatSpecified => 'Nessun formato data specificato';

  @override
  String get noTimeFormatSpecified => 'Nessun formato ora specificato';

  @override
  String get nonTvApplications => 'App non TV';

  @override
  String get open => 'Apri';

  @override
  String get orSelectFormatSpecifiers => 'Oppure seleziona specificatori di formato';

  @override
  String get picture => 'Immagine';

  @override
  String removeFrom(String name) {
    return 'Rimuovi da $name';
  }

  @override
  String get renameCategory => 'Rinomina categoria';

  @override
  String get reorder => 'Riordina';

  @override
  String get row => 'Riga';

  @override
  String get rowHeight => 'Altezza riga';

  @override
  String get save => 'Salva';

  @override
  String get spacer => 'Spaziatore';

  @override
  String get spacerMaxHeightRequirement => 'Deve essere maggiore di 0 e minore o uguale a 500';

  @override
  String get statusBar => 'Barra di stato';

  @override
  String get settings => 'Impostazioni';

  @override
  String get show => 'Mostra';

  @override
  String get showCategoryTitles => 'Mostra titoli delle categorie';

  @override
  String get themes => 'Temi';

  @override
  String get hideHighlightOutlineOnHomescreen => 'Nascondi contorno evidenziazione nella schermata Home';

  @override
  String get appSelectorTransitionAnimation => 'Animazione transizione selettore app';

  @override
  String get sort => 'Ordina';

  @override
  String get systemSettings => 'Impostazioni di sistema';

  @override
  String textAboutDialog(String repoUrl) {
    return 'LTvLauncher è un launcher open-source personalizzato per Android TV, basato su FLauncher.\n\nSviluppato da LeanBitLab.\nCodice sorgente disponibile su $repoUrl.';
  }

  @override
  String get textEmptyCategory => 'Questa categoria è vuota.';

  @override
  String get time => 'Ora';

  @override
  String get titleStatusBarSettingsPage => 'Scegli cosa mostrare nella barra di stato';

  @override
  String get tvApplications => 'App TV';

  @override
  String get type => 'Tipo';

  @override
  String get typeInTheDateFormat => 'Inserisci il formato data';

  @override
  String get typeInTheHourFormat => 'Inserisci il formato ora';

  @override
  String get uninstall => 'Disinstalla';

  @override
  String get wallpaper => 'Sfondo';

  @override
  String get withEllipsisAddTo => 'Aggiungi a...';

  @override
  String get timeBasedWallpaper => 'Sfondo basato sull\'ora';

  @override
  String get pickDayWallpaper => 'Scegli sfondo diurno';

  @override
  String get pickNightWallpaper => 'Scegli sfondo notturno';

  @override
  String get accessibility => 'Accessibilità';

  @override
  String get defaultLauncherIsDefault => 'LTvLauncher è il launcher predefinito';

  @override
  String get defaultLauncherNotDefault => 'LTvLauncher non è il launcher predefinito';

  @override
  String get setAsDefaultLauncher => 'Imposta come launcher predefinito';

  @override
  String get defaultLauncherDescription => 'Quando impostato come launcher predefinito, il pulsante Home tornerà sempre a LTvLauncher. La TV si avvierà direttamente su LTvLauncher.';

  @override
  String get inputs => 'Ingressi';

  @override
  String get inputSources => 'Sorgenti di ingresso';

  @override
  String get backupAndRestore => 'Backup e Ripristino';

  @override
  String get exportBackup => 'Esporta Backup';

  @override
  String get importBackup => 'Importa Backup';

  @override
  String exportSuccess(String path) {
    return 'Backup esportato con successo in $path';
  }

  @override
  String get importSuccess => 'Backup importato con successo';

  @override
  String get importConfirm => 'Sei sicuro di voler importare il backup? Questo sovrascriverà le tue impostazioni e il layout attuali.';

  @override
  String importError(String error) {
    return 'Impossibile importare il backup: $error';
  }

  @override
  String exportError(String error) {
    return 'Impossibile esportare il backup: $error';
  }

  @override
  String get shareBackup => 'Condividi Backup';

  @override
  String get shareBackupDescription => 'Condividi il backup con altri dispositivi sulla rete locale';

  @override
  String get stopSharing => 'Interrompi condivisione';

  @override
  String get localNetworkSharingActive => 'La condivisione sulla rete locale è attiva!';

  @override
  String get localNetworkSharingInstructions => 'Collega un altro dispositivo alla stessa rete Wi-Fi e apri il seguente URL in un browser web:';

  @override
  String get localNetworkSharingDetails => 'Qui puoi scaricare le impostazioni/layout della tua TV o caricare un file di backup su questa TV.';

  @override
  String failedToStartServer(String error) {
    return 'Impossibile avviare il server di condivisione: $error';
  }

  @override
  String get notificationBell => 'Campanella notifiche';

  @override
  String get autoHideNotificationBell => 'Nascondi automaticamente campanella notifiche';

  @override
  String get continueWatching => 'Continua a guardare';

  @override
  String get showContinueWatchingOnHome => 'Mostra Continua a guardare nella Home';

  @override
  String get permissionDeniedContinueWatching => 'Autorizzazione richiesta per mostrare Continua a guardare';

  @override
  String get interface => 'Interfaccia';

  @override
  String get system => 'Sistema';

  @override
  String get accentColor => 'Colore primario';

  @override
  String get miscellaneous => 'Varie';

  @override
  String get brightnessScheduler => 'Pianificatore luminosità';

  @override
  String get screensaverSettings => 'Impostazioni salvaschermo';

  @override
  String get screensaverClockStyle => 'Stile orologio salvaschermo';

  @override
  String get dataUsagePeriod => 'Periodo utilizzo dati';

  @override
  String get notificationAccess => 'Accesso notifiche';

  @override
  String get granted => 'Concesso';

  @override
  String get permissionRequired => 'Autorizzazione richiesta';

  @override
  String get systemWidePopupAlert => 'Avviso popup di sistema';

  @override
  String get overlayPermissionRequired => 'Autorizzazione sovrapposizione richiesta';

  @override
  String get enabled => 'Abilitato';

  @override
  String get disabled => 'Disabilitato';

  @override
  String get showAppNamesBelowIcons => 'Mostra nomi app sotto le icone';

  @override
  String get dataUsage => 'Utilizzo dati';

  @override
  String get networkIndicator => 'Indicatore di rete';

  @override
  String get homeButtonFix => 'Fix pulsante Home (Google TV)';

  @override
  String get appLanguage => 'Lingua';

  @override
  String get systemDefault => 'Predefinito di sistema';

  @override
  String get english => 'Inglese';

  @override
  String get spanish => 'Spagnolo';

  @override
  String get ukrainian => 'Ucraino';

  @override
  String get chinese => 'Cinese';

  @override
  String get french => 'Francese';

  @override
  String get german => 'Tedesco';

  @override
  String get japanese => 'Giapponese';

  @override
  String get portuguese => 'Portoghese';

  @override
  String get russian => 'Russo';

  @override
  String get italian => 'Italiano';

  @override
  String get hindi => 'Hindi';

  @override
  String get korean => 'Coreano';

  @override
  String get arabic => 'Arabo';

  @override
  String get turkish => 'Turco';

  @override
  String get hidePersistentNotifications => 'Nascondi notifiche persistenti';

  @override
  String get hidePersistentNotificationsDesc => 'Nascondi le notifiche dei servizi in background e di sistema';

  @override
  String get blockedNotificationApps => 'App bloccate';

  @override
  String get blockAppNotifications => 'Blocca notifiche';

  @override
  String get unblockAppNotifications => 'Sblocca notifiche';

  @override
  String get noBlockedApps => 'Nessuna app bloccata';

  @override
  String get persistentNotification => 'Persistente';

  @override
  String get unblockAll => 'Sblocca tutto';
}
