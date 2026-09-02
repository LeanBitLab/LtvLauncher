import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get aboutFlauncher => 'Sobre o LTvLauncher';

  @override
  String get addCategory => 'Adicionar categoria';

  @override
  String get addSection => 'Adicionar seção';

  @override
  String get alphabetical => 'Alfabético';

  @override
  String get appCardHighlightAnimation => 'Animação de destaque do cartão do app';

  @override
  String get appInfo => 'Informações do app';

  @override
  String get appKeyClick => 'Som de clique ao pressionar tecla';

  @override
  String get applications => 'Aplicativos';

  @override
  String get autoHideAppBar => 'Ocultar barra de status automaticamente';

  @override
  String get backButtonAction => 'Ação do botão voltar';

  @override
  String get category => 'Categoria';

  @override
  String get categories => 'Categorias';

  @override
  String get columnCount => 'Contagem de colunas';

  @override
  String get date => 'Data';

  @override
  String get dateAndTimeFormat => 'Formato de data e hora';

  @override
  String get delete => 'Excluir';

  @override
  String get dialogOptionBackButtonActionDoNothing => 'Não fazer nada';

  @override
  String get dialogOptionBackButtonActionShowScreensaver => 'Mostrar protetor de tela';

  @override
  String get dialogOptionBackButtonActionShowClock => 'Mostrar relógio';

  @override
  String get dialogTextNoFileExplorer => 'Por favor, instale um explorador de arquivos para escolher uma imagem.';

  @override
  String get dialogTitleBackButtonAction => 'Escolha a ação do botão voltar';

  @override
  String disambiguateCategoryTitle(String title) {
    return '$title (Categoria)';
  }

  @override
  String formattedDate(String dateString) {
    return 'Data formatada: $dateString';
  }

  @override
  String formattedTime(String timeString) {
    return 'Hora formatada: $timeString';
  }

  @override
  String get gradient => 'Gradiente';

  @override
  String get favoriteApps => 'Apps favoritos';

  @override
  String get grid => 'Grade';

  @override
  String get height => 'Altura';

  @override
  String get hide => 'Ocultar';

  @override
  String get hiddenApplications => 'Apps ocultos';

  @override
  String get launcherSections => 'Seções';

  @override
  String get layout => 'Layout';

  @override
  String get loading => 'Carregando';

  @override
  String get manual => 'Manual';

  @override
  String get modifySection => 'Modificar seção';

  @override
  String get mustNotBeEmpty => 'Não pode estar vazio';

  @override
  String get name => 'Nome';

  @override
  String get newSection => 'Nova seção';

  @override
  String get noDateFormatSpecified => 'Nenhum formato de data especificado';

  @override
  String get noTimeFormatSpecified => 'Nenhum formato de hora especificado';

  @override
  String get nonTvApplications => 'Apps não-TV';

  @override
  String get open => 'Abrir';

  @override
  String get orSelectFormatSpecifiers => 'Ou selecione especificadores de formato';

  @override
  String get picture => 'Imagem';

  @override
  String removeFrom(String name) {
    return 'Remover de $name';
  }

  @override
  String get renameCategory => 'Renomear categoria';

  @override
  String get reorder => 'Reordenar';

  @override
  String get row => 'Linha';

  @override
  String get rowHeight => 'Altura da linha';

  @override
  String get save => 'Salvar';

  @override
  String get spacer => 'Espaçador';

  @override
  String get spacerMaxHeightRequirement => 'Deve ser maior que 0 e menor ou igual a 500';

  @override
  String get statusBar => 'Barra de status';

  @override
  String get settings => 'Configurações';

  @override
  String get show => 'Mostrar';

  @override
  String get showCategoryTitles => 'Mostrar títulos das categorias';

  @override
  String get themes => 'Temas';

  @override
  String get hideHighlightOutlineOnHomescreen => 'Ocultar contorno de destaque na tela inicial';

  @override
  String get appSelectorTransitionAnimation => 'Animação de transição do seletor de apps';

  @override
  String get sort => 'Ordenar';

  @override
  String get systemSettings => 'Configurações do sistema';

  @override
  String textAboutDialog(String repoUrl) {
    return 'O LTvLauncher é um launcher open-source personalizado para Android TV, baseado no FLauncher.\n\nDesenvolvido por LeanBitLab.\nCódigo-fonte disponível em $repoUrl.';
  }

  @override
  String get textEmptyCategory => 'Esta categoria está vazia.';

  @override
  String get time => 'Hora';

  @override
  String get titleStatusBarSettingsPage => 'Escolha o que exibir na barra de status';

  @override
  String get tvApplications => 'Apps de TV';

  @override
  String get type => 'Tipo';

  @override
  String get typeInTheDateFormat => 'Digite o formato de data';

  @override
  String get typeInTheHourFormat => 'Digite o formato de hora';

  @override
  String get uninstall => 'Desinstalar';

  @override
  String get wallpaper => 'Papel de parede';

  @override
  String get withEllipsisAddTo => 'Adicionar a...';

  @override
  String get timeBasedWallpaper => 'Papel de parede baseado no tempo';

  @override
  String get pickDayWallpaper => 'Escolher papel de parede diurno';

  @override
  String get pickNightWallpaper => 'Escolher papel de parede noturno';

  @override
  String get accessibility => 'Acessibilidade';

  @override
  String get defaultLauncherIsDefault => 'LTvLauncher é o launcher padrão';

  @override
  String get defaultLauncherNotDefault => 'LTvLauncher não é o launcher padrão';

  @override
  String get setAsDefaultLauncher => 'Definir como launcher padrão';

  @override
  String get defaultLauncherDescription => 'Quando definido como launcher padrão, o botão Home sempre retornará ao LTvLauncher. A TV também iniciará diretamente no LTvLauncher.';

  @override
  String get inputs => 'Entradas';

  @override
  String get inputSources => 'Fontes de entrada';

  @override
  String get backupAndRestore => 'Backup e Restauração';

  @override
  String get exportBackup => 'Exportar Backup';

  @override
  String get importBackup => 'Importar Backup';

  @override
  String exportSuccess(String path) {
    return 'Backup exportado com sucesso para $path';
  }

  @override
  String get importSuccess => 'Backup importado com sucesso';

  @override
  String get importConfirm => 'Tem certeza de que deseja importar o backup? Isso substituirá suas configurações e layout atuais.';

  @override
  String importError(String error) {
    return 'Falha ao importar backup: $error';
  }

  @override
  String exportError(String error) {
    return 'Falha ao exportar backup: $error';
  }

  @override
  String get shareBackup => 'Compartilhar Backup';

  @override
  String get shareBackupDescription => 'Compartilhar backup com outros dispositivos na rede local';

  @override
  String get stopSharing => 'Parar Compartilhamento';

  @override
  String get localNetworkSharingActive => 'O compartilhamento na rede local está ativo!';

  @override
  String get localNetworkSharingInstructions => 'Conecte outro dispositivo à mesma rede Wi-Fi e abra a seguinte URL em um navegador da web:';

  @override
  String get localNetworkSharingDetails => 'Aqui você pode baixar as configurações/layout da sua TV ou enviar um arquivo de backup de volta para esta TV.';

  @override
  String failedToStartServer(String error) {
    return 'Falha ao iniciar o servidor de compartilhamento: $error';
  }

  @override
  String get notificationBell => 'Sino de Notificação';

  @override
  String get autoHideNotificationBell => 'Ocultar Sino de Notificação automaticamente';

  @override
  String get continueWatching => 'Continuar assistindo';

  @override
  String get showContinueWatchingOnHome => 'Mostrar Continuar assistindo na tela inicial';

  @override
  String get permissionDeniedContinueWatching => 'Permissão necessária para mostrar Continuar assistindo';

  @override
  String get interface => 'Interface';

  @override
  String get system => 'Sistema';

  @override
  String get accentColor => 'Cor de destaque';

  @override
  String get miscellaneous => 'Diversos';

  @override
  String get brightnessScheduler => 'Agendador de brilho';

  @override
  String get screensaverSettings => 'Configurações do protetor de tela';

  @override
  String get screensaverClockStyle => 'Estilo de relógio do protetor de tela';

  @override
  String get dataUsagePeriod => 'Período de uso de dados';

  @override
  String get notificationAccess => 'Acesso a notificações';

  @override
  String get granted => 'Concedido';

  @override
  String get permissionRequired => 'Permissão Necessária';

  @override
  String get systemWidePopupAlert => 'Alerta pop-up de todo o sistema';

  @override
  String get overlayPermissionRequired => 'Permissão de sobreposição necessária';

  @override
  String get enabled => 'Ativado';

  @override
  String get disabled => 'Desativado';

  @override
  String get showAppNamesBelowIcons => 'Mostrar nomes dos apps abaixo dos ícones';

  @override
  String get dataUsage => 'Uso de dados';

  @override
  String get networkIndicator => 'Indicador de rede';

  @override
  String get homeButtonFix => 'Correção do botão Home (Google TV)';

  @override
  String get appLanguage => 'Idioma';

  @override
  String get systemDefault => 'Padrão do sistema';

  @override
  String get english => 'Inglês';

  @override
  String get spanish => 'Espanhol';

  @override
  String get ukrainian => 'Ucraniano';

  @override
  String get chinese => 'Chinês';

  @override
  String get french => 'Francês';

  @override
  String get german => 'Alemão';

  @override
  String get japanese => 'Japonês';

  @override
  String get portuguese => 'Português';

  @override
  String get russian => 'Russo';

  @override
  String get italian => 'Italiano';

  @override
  String get hindi => 'Hindi';

  @override
  String get korean => 'Coreano';

  @override
  String get arabic => 'Árabe';

  @override
  String get turkish => 'Turco';

  @override
  String get hidePersistentNotifications => 'Ocultar notificações persistentes';

  @override
  String get hidePersistentNotificationsDesc => 'Ocultar notificações de serviços em segundo plano e do sistema';

  @override
  String get blockedNotificationApps => 'Aplicativos bloqueados';

  @override
  String get blockAppNotifications => 'Bloquear notificações';

  @override
  String get unblockAppNotifications => 'Desbloquear notificações';

  @override
  String get noBlockedApps => 'Nenhum aplicativo bloqueado';

  @override
  String get persistentNotification => 'Persistente';

  @override
  String get unblockAll => 'Desbloquear tudo';
}
