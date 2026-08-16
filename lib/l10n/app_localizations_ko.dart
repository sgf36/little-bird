// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class LKo extends L {
  LKo([String locale = 'ko']) : super(locale);

  @override
  String get tagline => '작은 새가 알려줬어요.';

  @override
  String get emptyTitle => '장소를, 담아두다.';

  @override
  String get emptyBody =>
      '추천받은 것을 스크린샷으로 남기세요 — 릴스, 게시물, 메시지, 여행 안내서의 한 페이지. Wren이 이름을 읽어 지도에 넣어줍니다.';

  @override
  String get emptyNote =>
      '한 곳은 이미 가지고 있는 가이드에 추가됩니다. 여러 곳이면 새 가이드가 만들어집니다 — 지도는 가이드를 합칠 수 없습니다.';

  @override
  String get addScreenshots => '스크린샷 추가';

  @override
  String get readingShort => '읽는 중…';

  @override
  String readingProgress(int done, int total) {
    return '$total개 중 $done개 읽는 중…';
  }

  @override
  String get addToGuide => '가이드에 추가';

  @override
  String makeGuide(int count) {
    return '가이드 만들기($count)';
  }

  @override
  String get notFoundOnMap => '지도에서 찾지 못함';

  @override
  String get tapToSearchForIt => '탭하여 검색';

  @override
  String readAs(String text) {
    return '이렇게 읽음: “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count곳을 찾지 못했습니다. 탭하여 검색하세요.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => '이 장소들은 어디에 있나요?';

  @override
  String get regionDetected => '캡션에서 읽었습니다. 맞지 않으면 바꿔주세요.';

  @override
  String get regionNotDetected =>
      '스크린샷에 어디인지 나와 있지 않았습니다. 도시를 입력하면 검색이 훨씬 정확해집니다.';

  @override
  String get cityOrRegion => '도시 또는 지역';

  @override
  String get cityExample => '예: 서울';

  @override
  String get searchAnywhere => '전 지역에서 검색';

  @override
  String get findPlaces => '장소 찾기';

  @override
  String searchedIn(String region) {
    return '$region에서 검색함';
  }

  @override
  String get nameThisGuide => '이 가이드의 이름 정하기';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '이 이름으로 지도에 표시되며, 장소 $count곳이 담깁니다.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => '가이드 이름';

  @override
  String get guideNameExample => '예: 로마, 10월';

  @override
  String get createGuide => '가이드 만들기';

  @override
  String get cancel => '취소';

  @override
  String get guidesOfAnySize => '개수 제한 없는 가이드';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren은 가이드 하나에 최대 $limit곳까지 무료로 저장합니다. 지금 $selected곳을 선택해 $over곳 초과했습니다.';
  }

  @override
  String get onePaymentKept => '한 번 결제하면 계속 사용합니다. 구독이 아닙니다.';

  @override
  String unlockFor(String price) {
    return '$price에 잠금 해제';
  }

  @override
  String saveFirstInstead(int limit) {
    return '대신 처음 $limit곳만 저장';
  }

  @override
  String get restorePrevious => '이전 구입 복원';

  @override
  String get restorePurchase => '구입 복원';

  @override
  String overFreeLimit(int over, int limit) {
    return '무료 한도 $limit곳보다 $over곳 많습니다. 잠금을 해제하거나 처음 $limit곳만 저장할 수 있습니다.';
  }

  @override
  String get findThisPlace => '이 장소 찾기';

  @override
  String get searchAppleMaps => '지도에서 검색';

  @override
  String searchInRegion(String region) {
    return '$region에서 검색';
  }

  @override
  String get searching => '검색 중…';

  @override
  String get typeTwoCharacters => '두 글자 이상 입력하세요.';

  @override
  String get nothingFound => '찾지 못했습니다. 도로명이나 더 짧은 이름으로 시도해 보세요.';

  @override
  String get rateLimited => '지도가 검색을 제한하고 있습니다. 잠시 기다렸다가 다시 시도하세요.';

  @override
  String rateLimitedDuringImport(int added) {
    return '지도가 검색을 제한하고 있습니다 — 지금까지 $added곳을 추가했습니다. 나머지는 잠시 후에 시도하세요.';
  }

  @override
  String importSummary(int found) {
    return '$found곳 찾음';
  }

  @override
  String importSummaryIn(String region) {
    return '($region)';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count곳 확인 필요';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count곳 읽지 못함';
  }

  @override
  String nothingReadable(int count) {
    return '스크린샷 $count장에서 읽을 수 있는 내용이 없습니다';
  }

  @override
  String get couldNotOpenMaps => '지도를 열지 못했습니다';

  @override
  String get checkingAppleAccount => 'Apple 계정 확인 중…';

  @override
  String get restoredUnlocked => '복원했습니다. 개수 제한 없는 가이드가 잠금 해제되었습니다.';

  @override
  String get noPreviousPurchase => '이 Apple 계정에서 이전 구입 내역을 찾지 못했습니다.';

  @override
  String get purchaseDidNotComplete => '구입이 완료되지 않아 결제된 금액이 없습니다.';

  @override
  String alreadyInTheList(String name) {
    return '$name은(는) 이미 목록에 있었습니다.';
  }

  @override
  String get ocrUnavailable =>
      '스크린샷을 읽으려면 iPhone이 필요합니다 — 이 플랫폼에는 텍스트 인식이 없습니다.';

  @override
  String get lookupUnavailable =>
      '장소를 검색하려면 iPhone이 필요합니다 — 이 플랫폼에는 지도 검색이 없습니다.';

  @override
  String get compAccess => '무료 이용 권한';

  @override
  String get code => '코드';

  @override
  String get unlock => '잠금 해제';

  @override
  String get compChecking => '코드 확인 중…';

  @override
  String get compEnabled => '무료 이용 권한을 사용합니다.';

  @override
  String get compRefused => '인식되지 않는 코드이거나, 이미 사용된 코드입니다.';

  @override
  String get compTooOften => '시도가 너무 많습니다. 몇 분 기다렸다가 다시 시도하세요.';

  @override
  String get compUnreachable => '서버에 연결하지 못했습니다. 연결 상태를 확인하고 다시 시도하세요.';

  @override
  String get compUntrusted => '응답을 확인할 수 없어 잠금을 해제하지 않았습니다.';
}
