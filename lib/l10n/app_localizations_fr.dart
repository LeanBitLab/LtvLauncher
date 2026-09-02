import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get aboutFlauncher => 'À propos de LTvLauncher';

  @override
  String get addCategory => 'Ajouter une catégorie';

  @override
  String get addSection => 'Ajouter une section';

  @override
  String get alphabetical => 'Alphabétique';

  @override
  String get appCardHighlightAnimation => 'Animation de surbrillance de la carte d\'application';

  @override
  String get appInfo => 'Infos sur l\'application';

  @override
  String get appKeyClick => 'Son de clic lors de l\'appui sur une touche';

  @override
  String get applications => 'Applications';

  @override
  String get autoHideAppBar => 'Masquer automatiquement la barre d\'état';

  @override
  String get backButtonAction => 'Action du bouton retour';

  @override
  String get category => 'Catégorie';

  @override
  String get categories => 'Catégories';

  @override
  String get columnCount => 'Nombre de colonnes';

  @override
  String get date => 'Date';

  @override
  String get dateAndTimeFormat => 'Format de la date et de l\'heure';

  @override
  String get delete => 'Supprimer';

  @override
  String get dialogOptionBackButtonActionDoNothing => 'Ne rien faire';

  @override
  String get dialogOptionBackButtonActionShowScreensaver => 'Afficher l\'écran de veille';

  @override
  String get dialogOptionBackButtonActionShowClock => 'Afficher l\'horloge';

  @override
  String get dialogTextNoFileExplorer => 'Veuillez installer un explorateur de fichiers pour sélectionner une image.';

  @override
  String get dialogTitleBackButtonAction => 'Choisir l\'action du bouton retour';

  @override
  String disambiguateCategoryTitle(String title) {
    return '$title (Catégorie)';
  }

  @override
  String formattedDate(String dateString) {
    return 'Date formatée : $dateString';
  }

  @override
  String formattedTime(String timeString) {
    return 'Heure formatée : $timeString';
  }

  @override
  String get gradient => 'Dégradé';

  @override
  String get favoriteApps => 'Applications favorites';

  @override
  String get grid => 'Grille';

  @override
  String get height => 'Hauteur';

  @override
  String get hide => 'Masquer';

  @override
  String get hiddenApplications => 'Applications masquées';

  @override
  String get launcherSections => 'Sections';

  @override
  String get layout => 'Disposition';

  @override
  String get loading => 'Chargement';

  @override
  String get manual => 'Manuel';

  @override
  String get modifySection => 'Modifier la section';

  @override
  String get mustNotBeEmpty => 'Ne doit pas être vide';

  @override
  String get name => 'Nom';

  @override
  String get newSection => 'Nouvelle section';

  @override
  String get noDateFormatSpecified => 'Aucun format de date spécifié';

  @override
  String get noTimeFormatSpecified => 'Aucun format d\'heure spécifié';

  @override
  String get nonTvApplications => 'Applications non TV';

  @override
  String get open => 'Ouvrir';

  @override
  String get orSelectFormatSpecifiers => 'Ou sélectionner les spécificateurs de format';

  @override
  String get picture => 'Image';

  @override
  String removeFrom(String name) {
    return 'Retirer de $name';
  }

  @override
  String get renameCategory => 'Renommer la catégorie';

  @override
  String get reorder => 'Réorganiser';

  @override
  String get row => 'Ligne';

  @override
  String get rowHeight => 'Hauteur de ligne';

  @override
  String get save => 'Enregistrer';

  @override
  String get spacer => 'Espace';

  @override
  String get spacerMaxHeightRequirement => 'Doit être supérieur à 0 et inférieur ou égal à 500';

  @override
  String get statusBar => 'Barre d\'état';

  @override
  String get settings => 'Paramètres';

  @override
  String get show => 'Afficher';

  @override
  String get showCategoryTitles => 'Afficher les titres des catégories';

  @override
  String get themes => 'Thèmes';

  @override
  String get hideHighlightOutlineOnHomescreen => 'Masquer le contour de surbrillance sur l\'écran d\'accueil';

  @override
  String get appSelectorTransitionAnimation => 'Animation de transition du sélecteur d\'application';

  @override
  String get sort => 'Trier';

  @override
  String get systemSettings => 'Paramètres système';

  @override
  String textAboutDialog(String repoUrl) {
    return 'LTvLauncher est un lanceur open-source personnalisé pour Android TV, basé sur FLauncher.\n\nDéveloppé par LeanBitLab.\nCode source disponible sur $repoUrl.';
  }

  @override
  String get textEmptyCategory => 'Cette catégorie est vide.';

  @override
  String get time => 'Heure';

  @override
  String get titleStatusBarSettingsPage => 'Choisir ce qu\'il faut afficher dans la barre d\'état';

  @override
  String get tvApplications => 'Applications TV';

  @override
  String get type => 'Type';

  @override
  String get typeInTheDateFormat => 'Saisir le format de date';

  @override
  String get typeInTheHourFormat => 'Saisir le format de l\'heure';

  @override
  String get uninstall => 'Désinstaller';

  @override
  String get wallpaper => 'Fond d\'écran';

  @override
  String get withEllipsisAddTo => 'Ajouter à...';

  @override
  String get timeBasedWallpaper => 'Fond d\'écran basé sur l\'heure';

  @override
  String get pickDayWallpaper => 'Choisir le fond d\'écran de jour';

  @override
  String get pickNightWallpaper => 'Choisir le fond d\'écran de nuit';

  @override
  String get accessibility => 'Accessibilité';

  @override
  String get defaultLauncherIsDefault => 'LTvLauncher est le lanceur par défaut';

  @override
  String get defaultLauncherNotDefault => 'LTvLauncher n\'est pas le lanceur par défaut';

  @override
  String get setAsDefaultLauncher => 'Définir comme lanceur par défaut';

  @override
  String get defaultLauncherDescription => 'Lorsqu\'il est défini comme lanceur par défaut, le bouton Accueil reviendra toujours à LTvLauncher. La TV démarrera également directement sur LTvLauncher.';

  @override
  String get inputs => 'Entrées';

  @override
  String get inputSources => 'Sources d\'entrée';

  @override
  String get backupAndRestore => 'Sauvegarde et restauration';

  @override
  String get exportBackup => 'Exporter la sauvegarde';

  @override
  String get importBackup => 'Importer la sauvegarde';

  @override
  String exportSuccess(String path) {
    return 'Sauvegarde exportée avec succès vers $path';
  }

  @override
  String get importSuccess => 'Sauvegarde importée avec succès';

  @override
  String get importConfirm => 'Voulez-vous vraiment importer la sauvegarde ? Cela remplacera vos paramètres et votre disposition actuels.';

  @override
  String importError(String error) {
    return 'Échec de l\'importation de la sauvegarde : $error';
  }

  @override
  String exportError(String error) {
    return 'Échec de l\'exportation de la sauvegarde : $error';
  }

  @override
  String get shareBackup => 'Partager la sauvegarde';

  @override
  String get shareBackupDescription => 'Partager la sauvegarde avec d\'autres appareils sur le réseau local';

  @override
  String get stopSharing => 'Arrêter le partage';

  @override
  String get localNetworkSharingActive => 'Le partage sur le réseau local est actif !';

  @override
  String get localNetworkSharingInstructions => 'Connectez un autre appareil au même réseau Wi-Fi et ouvrez l\'URL suivante dans un navigateur Web :';

  @override
  String get localNetworkSharingDetails => 'Ici, vous pouvez télécharger les paramètres/disposition de votre TV ou importer un fichier de sauvegarde vers cette TV.';

  @override
  String failedToStartServer(String error) {
    return 'Échec du démarrage du serveur de partage : $error';
  }

  @override
  String get notificationBell => 'Cloche de notification';

  @override
  String get autoHideNotificationBell => 'Masquer automatiquement la cloche de notification';

  @override
  String get continueWatching => 'Continuer à regarder';

  @override
  String get showContinueWatchingOnHome => 'Afficher Continuer à regarder sur l\'accueil';

  @override
  String get permissionDeniedContinueWatching => 'Autorisation requise pour afficher Continuer à regarder';

  @override
  String get interface => 'Interface';

  @override
  String get system => 'Système';

  @override
  String get accentColor => 'Couleur d\'accentuation';

  @override
  String get miscellaneous => 'Divers';

  @override
  String get brightnessScheduler => 'Planificateur de luminosité';

  @override
  String get screensaverSettings => 'Paramètres de l\'écran de veille';

  @override
  String get screensaverClockStyle => 'Style d\'horloge de l\'écran de veille';

  @override
  String get dataUsagePeriod => 'Période d\'utilisation des données';

  @override
  String get notificationAccess => 'Accès aux notifications';

  @override
  String get granted => 'Accordé';

  @override
  String get permissionRequired => 'Autorisation requise';

  @override
  String get systemWidePopupAlert => 'Alerte contextuelle à l\'échelle du système';

  @override
  String get overlayPermissionRequired => 'Autorisation de superposition requise';

  @override
  String get enabled => 'Activé';

  @override
  String get disabled => 'Désactivé';

  @override
  String get showAppNamesBelowIcons => 'Afficher les noms des applications sous les icônes';

  @override
  String get dataUsage => 'Utilisation des données';

  @override
  String get networkIndicator => 'Indicateur réseau';

  @override
  String get homeButtonFix => 'Correction du bouton Accueil (Google TV)';

  @override
  String get appLanguage => 'Langue';

  @override
  String get systemDefault => 'Système par défaut';

  @override
  String get english => 'Anglais';

  @override
  String get spanish => 'Espagnol';

  @override
  String get ukrainian => 'Ukrainien';

  @override
  String get chinese => 'Chinois';

  @override
  String get french => 'Français';

  @override
  String get german => 'Allemand';

  @override
  String get japanese => 'Japonais';

  @override
  String get portuguese => 'Portugais';

  @override
  String get russian => 'Russe';

  @override
  String get italian => 'Italien';

  @override
  String get hindi => 'Hindi';

  @override
  String get korean => 'Coréen';

  @override
  String get arabic => 'Arabe';

  @override
  String get turkish => 'Turc';

  @override
  String get hidePersistentNotifications => 'Masquer les notifications persistantes';

  @override
  String get hidePersistentNotificationsDesc => 'Masquer les notifications des services d\'arrière-plan et du système';

  @override
  String get blockedNotificationApps => 'Applications bloquées';

  @override
  String get blockAppNotifications => 'Bloquer les notifications';

  @override
  String get unblockAppNotifications => 'Débloquer les notifications';

  @override
  String get noBlockedApps => 'Aucune application bloquée';

  @override
  String get persistentNotification => 'Persistante';

  @override
  String get unblockAll => 'Tout débloquer';

  @override
  String get weather => 'Météo';

  @override
  String get showWeatherWarnings => 'Afficher les alertes météo et pluie';

  @override
  String get temperatureUnit => 'Unité de température';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get breezyWeatherSetupHint => 'Installez Breezy Weather et activez le \'Partage local des données\' / \'Gadgetbridge\' dans ses paramètres pour afficher la météo et les alertes de pluie.';
}
