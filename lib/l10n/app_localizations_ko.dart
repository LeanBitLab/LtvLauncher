import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get aboutFlauncher => 'LTvLauncher 정보';

  @override
  String get addCategory => '카테고리 추가';

  @override
  String get addSection => '섹션 추가';

  @override
  String get alphabetical => '알파벳순';

  @override
  String get appCardHighlightAnimation => '앱 카드 하이라이트 애니메이션';

  @override
  String get appInfo => '앱 정보';

  @override
  String get appKeyClick => '키 누름 시 클릭 소리';

  @override
  String get applications => '애플리케이션';

  @override
  String get autoHideAppBar => '상태 표시줄 자동 숨기기';

  @override
  String get backButtonAction => '뒤로 버튼 동작';

  @override
  String get category => '카테고리';

  @override
  String get categories => '카테고리';

  @override
  String get columnCount => '열 수';

  @override
  String get date => '날짜';

  @override
  String get dateAndTimeFormat => '날짜 및 시간 형식';

  @override
  String get delete => '삭제';

  @override
  String get dialogOptionBackButtonActionDoNothing => '아무 작업 안 함';

  @override
  String get dialogOptionBackButtonActionShowScreensaver => '화면 보호기 표시';

  @override
  String get dialogOptionBackButtonActionShowClock => '시계 표시';

  @override
  String get dialogTextNoFileExplorer => '사진을 선택하려면 파일 탐색기를 설치하세요.';

  @override
  String get dialogTitleBackButtonAction => '뒤로 버튼 동작 선택';

  @override
  String disambiguateCategoryTitle(String title) {
    return '$title (카테고리)';
  }

  @override
  String formattedDate(String dateString) {
    return '포맷된 날짜: $dateString';
  }

  @override
  String formattedTime(String timeString) {
    return '포맷된 시간: $timeString';
  }

  @override
  String get gradient => '그라데이션';

  @override
  String get favoriteApps => '즐겨찾는 앱';

  @override
  String get grid => '그리드';

  @override
  String get height => '높이';

  @override
  String get hide => '숨기기';

  @override
  String get hiddenApplications => '숨겨진 앱';

  @override
  String get launcherSections => '섹션';

  @override
  String get layout => '레이아웃';

  @override
  String get loading => '로딩 중';

  @override
  String get manual => '수동';

  @override
  String get modifySection => '섹션 수정';

  @override
  String get mustNotBeEmpty => '비워둘 수 없습니다';

  @override
  String get name => '이름';

  @override
  String get newSection => '새 섹션';

  @override
  String get noDateFormatSpecified => '날짜 형식이 지정되지 않음';

  @override
  String get noTimeFormatSpecified => '시간 형식이 지정되지 않음';

  @override
  String get nonTvApplications => '비 TV 앱';

  @override
  String get open => '열기';

  @override
  String get orSelectFormatSpecifiers => '또는 형식 지정자 선택';

  @override
  String get picture => '사진';

  @override
  String removeFrom(String name) {
    return '$name에서 제거';
  }

  @override
  String get renameCategory => '카테고리 이름 변경';

  @override
  String get reorder => '재정렬';

  @override
  String get row => '행';

  @override
  String get rowHeight => '행 높이';

  @override
  String get save => '저장';

  @override
  String get spacer => '간격';

  @override
  String get spacerMaxHeightRequirement => '0보다 크고 500 이하여야 합니다';

  @override
  String get statusBar => '상태 표시줄';

  @override
  String get settings => '설정';

  @override
  String get show => '표시';

  @override
  String get showCategoryTitles => '카테고리 제목 표시';

  @override
  String get themes => '테마';

  @override
  String get hideHighlightOutlineOnHomescreen => '홈 화면에서 하이라이트 윤곽선 숨기기';

  @override
  String get appSelectorTransitionAnimation => '앱 선택기 전환 애니메이션';

  @override
  String get sort => '정렬';

  @override
  String get systemSettings => '시스템 설정';

  @override
  String textAboutDialog(String repoUrl) {
    return 'LTvLauncher는 FLauncher를 기반으로 한 Android TV용 맞춤형 오픈 소스 런처입니다.\n\nLeanBitLab에서 개발했습니다.\n소스 코드는 $repoUrl에서 사용할 수 있습니다.';
  }

  @override
  String get textEmptyCategory => '이 카테고리는 비어 있습니다.';

  @override
  String get time => '시간';

  @override
  String get titleStatusBarSettingsPage => '상태 표시줄에 표시할 내용 선택';

  @override
  String get tvApplications => 'TV 앱';

  @override
  String get type => '유형';

  @override
  String get typeInTheDateFormat => '날짜 형식 입력';

  @override
  String get typeInTheHourFormat => '시간 형식 입력';

  @override
  String get uninstall => '제거';

  @override
  String get wallpaper => '배경화면';

  @override
  String get withEllipsisAddTo => '추가...';

  @override
  String get timeBasedWallpaper => '시간 기반 배경화면';

  @override
  String get pickDayWallpaper => '주간 배경화면 선택';

  @override
  String get pickNightWallpaper => '야간 배경화면 선택';

  @override
  String get accessibility => '접근성';

  @override
  String get defaultLauncherIsDefault => 'LTvLauncher가 기본 런처입니다';

  @override
  String get defaultLauncherNotDefault => 'LTvLauncher가 기본 런처가 아닙니다';

  @override
  String get setAsDefaultLauncher => '기본 런처로 설정';

  @override
  String get defaultLauncherDescription => '기본 런처로 설정하면 홈 버튼은 항상 LTvLauncher로 돌아갑니다. TV도 직접 LTvLauncher로 부팅됩니다.';

  @override
  String get inputs => '입력';

  @override
  String get inputSources => '입력 소스';

  @override
  String get backupAndRestore => '백업 및 복원';

  @override
  String get exportBackup => '백업 내보내기';

  @override
  String get importBackup => '백업 가져오기';

  @override
  String exportSuccess(String path) {
    return '백업이 $path로 성공적으로 내보내졌습니다';
  }

  @override
  String get importSuccess => '백업을 성공적으로 가져왔습니다';

  @override
  String get importConfirm => '백업을 가져오시겠습니까? 현재 설정 및 레이아웃을 덮어씁니다.';

  @override
  String importError(String error) {
    return '백업 가져오기 실패: $error';
  }

  @override
  String exportError(String error) {
    return '백업 내보내기 실패: $error';
  }

  @override
  String get shareBackup => '백업 공유';

  @override
  String get shareBackupDescription => '로컬 네트워크의 다른 기기와 백업 공유';

  @override
  String get stopSharing => '공유 중지';

  @override
  String get localNetworkSharingActive => '로컬 네트워크 공유가 활성화되었습니다!';

  @override
  String get localNetworkSharingInstructions => '다른 기기를 동일한 Wi-Fi 네트워크에 연결하고 웹 브라우저에서 다음 URL을 엽니다.';

  @override
  String get localNetworkSharingDetails => '여기에서 TV 설정/레이아웃을 다운로드하거나 이 TV로 백업 파일을 업로드할 수 있습니다.';

  @override
  String failedToStartServer(String error) {
    return '공유 서버 시작 실패: $error';
  }

  @override
  String get notificationBell => '알림 벨';

  @override
  String get autoHideNotificationBell => '알림 벨 자동 숨기기';

  @override
  String get continueWatching => '계속 시청';

  @override
  String get showContinueWatchingOnHome => '홈에서 계속 시청 표시';

  @override
  String get permissionDeniedContinueWatching => '계속 시청을 표시하려면 권한이 필요합니다';

  @override
  String get interface => '인터페이스';

  @override
  String get system => '시스템';

  @override
  String get accentColor => '강조 색상';

  @override
  String get miscellaneous => '기타';

  @override
  String get brightnessScheduler => '밝기 스케줄러';

  @override
  String get screensaverSettings => '화면 보호기 설정';

  @override
  String get screensaverClockStyle => '화면 보호기 시계 스타일';

  @override
  String get dataUsagePeriod => '데이터 사용 기간';

  @override
  String get notificationAccess => '알림 액세스';

  @override
  String get granted => '부여됨';

  @override
  String get permissionRequired => '권한 필요';

  @override
  String get systemWidePopupAlert => '시스템 전체 팝업 알림';

  @override
  String get overlayPermissionRequired => '오버레이 권한 필요';

  @override
  String get enabled => '사용 설정됨';

  @override
  String get disabled => '사용 중지됨';

  @override
  String get showAppNamesBelowIcons => '아이콘 아래에 앱 이름 표시';

  @override
  String get dataUsage => '데이터 사용량';

  @override
  String get networkIndicator => '네트워크 표시기';

  @override
  String get homeButtonFix => '홈 버튼 수정 (Google TV)';

  @override
  String get appLanguage => '언어';

  @override
  String get systemDefault => '시스템 기본값';

  @override
  String get english => '영어';

  @override
  String get spanish => '스페인어';

  @override
  String get ukrainian => '우크라이나어';

  @override
  String get chinese => '중국어';

  @override
  String get french => '프랑스어';

  @override
  String get german => '독일어';

  @override
  String get japanese => '일본어';

  @override
  String get portuguese => '포르투갈어';

  @override
  String get russian => '러시아어';

  @override
  String get italian => '이탈리아어';

  @override
  String get hindi => '힌디어';

  @override
  String get korean => '한국어';

  @override
  String get arabic => '아랍어';

  @override
  String get turkish => '터키어';

  @override
  String get hidePersistentNotifications => '고정 알림 숨기기';

  @override
  String get hidePersistentNotificationsDesc => '백그라운드 서비스 및 시스템 고정 알림 숨기기';

  @override
  String get blockedNotificationApps => '차단된 앱';

  @override
  String get blockAppNotifications => '알림 차단';

  @override
  String get unblockAppNotifications => '알림 차단 해제';

  @override
  String get noBlockedApps => '차단된 앱이 없습니다';

  @override
  String get persistentNotification => '고정';

  @override
  String get unblockAll => '모두 차단 해제';
}
