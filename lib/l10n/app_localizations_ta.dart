// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class LTa extends L {
  LTa([String locale = 'ta']) : super(locale);

  @override
  String get tagline => 'ஒரு சின்னக் குருவி சொல்லிச் சென்றது.';

  @override
  String get emptyTitle => 'இடங்கள், சேமித்து.';

  @override
  String get emptyBody =>
      'யாராவது பரிந்துரைப்பதைத் திரைப்பிடிப்பு எடுத்துக் கொள்ளுங்கள் — ஒரு ரீல், ஒரு பதிவு, ஒரு செய்தி, பயண நூலின் ஒரு பக்கம். Wren பெயர்களைப் படித்து Apple Maps-இல் சேர்த்துவிடும்.';

  @override
  String get emptyNote =>
      'ஒரே இடம் உங்களிடம் ஏற்கெனவே உள்ள வழிகாட்டியில் சேரும். பல இடங்கள் புதிய ஒன்றை உருவாக்கும் — Apple Maps வழிகாட்டிகளை ஒன்றிணைக்க முடியாது.';

  @override
  String get emptyBodyAndroid =>
      'யாராவது பரிந்துரைப்பதைத் திரைப்பிடிப்பு எடுத்துக் கொள்ளுங்கள் — ஒரு ரீல், ஒரு பதிவு, ஒரு செய்தி, பயண நூலின் ஒரு பக்கம். Wren பெயர்களைப் படித்து அவற்றை உங்கள் ஃபோனின் வரைபட ஆப்ஸுக்கு அனுப்பிவிடும்.';

  @override
  String get emptyNoteAndroid =>
      'உங்களிடம் ஏற்கெனவே உள்ள பட்டியலையும் இது படிக்கும், எதுவும் அனுப்பப்படும் முன் ஒவ்வொரு இடத்தையும் காட்டும்.';

  @override
  String get addScreenshots => 'திரைப்பிடிப்புகளைச் சேர்க்கவும்';

  @override
  String get readingShort => 'படிக்கிறது…';

  @override
  String readingProgress(int done, int total) {
    return '$total-இல் $done படிக்கிறது…';
  }

  @override
  String get addToGuide => 'ஒரு வழிகாட்டியில் சேர்க்கவும்';

  @override
  String makeGuide(int count) {
    return 'வழிகாட்டி உருவாக்கவும் ($count)';
  }

  @override
  String get notFoundOnMap => 'வரைபடத்தில் கிடைக்கவில்லை';

  @override
  String get tapToSearchForIt => 'தேட தட்டவும்';

  @override
  String readAs(String text) {
    return 'இப்படிப் படிக்கப்பட்டது: “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count இடங்கள் கிடைக்கவில்லை. தேட தட்டவும்.',
      one: '1 இடம் கிடைக்கவில்லை. தேட தட்டவும்.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'இந்த இடங்கள் எங்கே உள்ளன?';

  @override
  String get regionDetected =>
      'தலைப்புகளிலிருந்து படிக்கப்பட்டது. தவறாக இருந்தால் மாற்றவும்.';

  @override
  String get regionNotDetected =>
      'இவை எங்கே உள்ளன என்பது திரைப்பிடிப்புகளில் இல்லை. நகரத்தைக் குறிப்பிட்டால் தேடல் மிகவும் துல்லியமாகும்.';

  @override
  String get cityOrRegion => 'நகரம் அல்லது பகுதி';

  @override
  String get cityExample => 'எ.கா. சென்னை';

  @override
  String get searchAnywhere => 'எங்கும் தேடு';

  @override
  String get findPlaces => 'இடங்களைக் கண்டுபிடி';

  @override
  String searchedIn(String region) {
    return '$region-இல் தேடப்பட்டது';
  }

  @override
  String get nameThisGuide => 'இந்த வழிகாட்டிக்குப் பெயரிடுங்கள்';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'இதே பெயரில் Apple Maps-இல் தோன்றும், அதில் $count இடங்கள் இருக்கும்.',
      one: 'இதே பெயரில் Apple Maps-இல் தோன்றும், அதில் 1 இடம் இருக்கும்.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'வழிகாட்டியின் பெயர்';

  @override
  String get guideNameExample => 'எ.கா. ரோம், அக்டோபர்';

  @override
  String get createGuide => 'வழிகாட்டியை உருவாக்கு';

  @override
  String get cancel => 'ரத்து செய்';

  @override
  String get guidesOfAnySize => 'எந்த அளவிலும் வழிகாட்டிகள்';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren ஒரு வழிகாட்டியில் இலவசமாக $limit இடங்கள் வரை சேமிக்கும். நீங்கள் $selected தேர்ந்தெடுத்துள்ளீர்கள் — $over அதிகம்.';
  }

  @override
  String get onePaymentKept =>
      'ஒரே கட்டணம், என்றென்றும் உங்களுடையது. சந்தா இல்லை.';

  @override
  String unlockFor(String price) {
    return '$price-க்குத் திறக்கவும்';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'அதற்குப் பதிலாக முதல் $limit சேமிக்கவும்';
  }

  @override
  String get restorePrevious => 'முந்தைய வாங்குதலை மீட்டெடுக்கவும்';

  @override
  String get restorePurchase => 'வாங்குதலை மீட்டெடுக்கவும்';

  @override
  String overFreeLimit(int over, int limit) {
    return 'இலவச வரம்பான $limit-ஐ விட $over அதிகம். திறக்கலாம், அல்லது முதல் $limit சேமிக்கலாம்.';
  }

  @override
  String get findThisPlace => 'இந்த இடத்தைக் கண்டுபிடி';

  @override
  String get searchAppleMaps => 'Apple Maps-இல் தேடு';

  @override
  String searchInRegion(String region) {
    return '$region-இல் தேடு';
  }

  @override
  String get searching => 'தேடுகிறது…';

  @override
  String get typeTwoCharacters =>
      'குறைந்தது இரண்டு எழுத்துகள் தட்டச்சு செய்யவும்.';

  @override
  String get nothingFound =>
      'எதுவும் கிடைக்கவில்லை. தெருவின் பெயரையோ, குறுகிய பெயரையோ முயற்சிக்கவும்.';

  @override
  String get rateLimited =>
      'Apple Maps தேடல்களைக் கட்டுப்படுத்துகிறது. சிறிது நேரம் காத்திருந்து மீண்டும் முயற்சிக்கவும்.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps தேடல்களைக் கட்டுப்படுத்துகிறது — இதுவரை $added சேர்க்கப்பட்டன, மீதியை சிறிது நேரத்தில் முயற்சிக்கவும்.';
  }

  @override
  String importSummary(int found) {
    return '$found கிடைத்தன';
  }

  @override
  String importSummaryIn(String region) {
    return '$region-இல்';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count பார்க்க வேண்டும்';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count படிக்க முடியவில்லை';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count திரைப்பிடிப்புகளில் படிக்கக்கூடியது எதுவும் இல்லை',
      one: '$count திரைப்பிடிப்பில் படிக்கக்கூடியது எதுவும் இல்லை',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Maps-ஐத் திறக்க முடியவில்லை';

  @override
  String get checkingAppleAccount => 'உங்கள் Apple கணக்கைச் சரிபார்க்கிறது…';

  @override
  String get restoredUnlocked =>
      'மீட்டெடுக்கப்பட்டது. எந்த அளவிலும் வழிகாட்டிகள் திறக்கப்பட்டுள்ளன.';

  @override
  String get noPreviousPurchase =>
      'இந்த Apple கணக்கில் முந்தைய வாங்குதல் எதுவும் கிடைக்கவில்லை.';

  @override
  String get purchaseDidNotComplete =>
      'வாங்குதல் நிறைவடையவில்லை, எனவே எதுவும் வசூலிக்கப்படவில்லை.';

  @override
  String alreadyInTheList(String name) {
    return '$name ஏற்கெனவே பட்டியலில் இருந்தது.';
  }

  @override
  String get ocrUnavailable =>
      'திரைப்பிடிப்புகளைப் படிக்க iPhone தேவை — இந்த தளத்தில் உரை அங்கீகாரம் இல்லை.';

  @override
  String get lookupUnavailable =>
      'இடங்களைத் தேட iPhone தேவை — இந்த தளத்தில் வரைபடத் தேடல் இல்லை.';

  @override
  String get compAccess => 'இலவச அணுகல்';

  @override
  String get code => 'குறியீடு';

  @override
  String get unlock => 'திற';

  @override
  String get compChecking => 'அந்தக் குறியீட்டைச் சரிபார்க்கிறது…';

  @override
  String get compEnabled => 'இலவச அணுகல் இயக்கப்பட்டது.';

  @override
  String get compRefused =>
      'அந்தக் குறியீடு அடையாளம் காணப்படவில்லை, அல்லது ஏற்கெனவே பயன்படுத்தப்பட்டுவிட்டது.';

  @override
  String get compTooOften =>
      'அதிக முறை முயற்சிக்கப்பட்டது. சில நிமிடங்கள் காத்திருந்து மீண்டும் முயற்சிக்கவும்.';

  @override
  String get compUnreachable =>
      'சேவையகத்தை அடைய முடியவில்லை. உங்கள் இணைப்பைச் சரிபார்த்து மீண்டும் முயற்சிக்கவும்.';

  @override
  String get compUntrusted =>
      'அந்தப் பதிலைச் சரிபார்க்க முடியவில்லை, எனவே எதுவும் திறக்கப்படவில்லை.';

  @override
  String get addPlaces => 'சேர்';

  @override
  String get fromFile => 'ஒரு கோப்பிலிருந்து';

  @override
  String get fromExistingGuide => 'ஏற்கெனவே உள்ள வழிகாட்டியிலிருந்து';

  @override
  String get importGuideTitle => 'ஏற்கெனவே உள்ள வழிகாட்டியில் சேர்க்கவும்';

  @override
  String get importGuideBody =>
      'Apple Maps-இல் வழிகாட்டியைத் திறந்து பங்கிடுங்கள், பிறகு இணைப்பை நகலெடு என்பதைத் தேர்ந்தெடுங்கள். அதைக் கீழே ஒட்டினால், அதில் ஏற்கெனவே உள்ள இடங்களை Wren படித்துக்கொள்ளும்.';

  @override
  String get guideLinkLabel => 'வழிகாட்டியின் இணைப்பு';

  @override
  String get readGuide => 'வழிகாட்டியைப் படி';

  @override
  String get importGuideNotALink =>
      'அது Apple Maps வழிகாட்டியின் இணைப்பு அல்ல. Maps-இல் வழிகாட்டியைத் திறந்து பங்கிட்டு, பிறகு இணைப்பை நகலெடு என்பதைத் தேர்ந்தெடுங்கள்.';

  @override
  String get importGuideNothing =>
      'அந்த வழிகாட்டியில் Wren சேர்க்கக்கூடியது எதுவும் இல்லை.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'அந்த வழிகாட்டியிலிருந்து $count இடங்கள் படிக்கப்பட்டன',
      one: 'அந்த வழிகாட்டியிலிருந்து 1 இடம் படிக்கப்பட்டது',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'அதில் உள்ள $count இடங்களை எடுத்துச் செல்ல முடியாது',
      one: 'அதில் உள்ள 1 இடத்தை எடுத்துச் செல்ல முடியாது',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count இடங்கள் ஏற்கெனவே இந்த வழிகாட்டியில் உள்ளன',
      one: '1 இடம் ஏற்கெனவே இந்த வழிகாட்டியில் உள்ளது',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '“$name” வழிகாட்டியிலிருந்து';
  }

  @override
  String get republishTitle => 'Maps புதிய வழிகாட்டி ஒன்றை உருவாக்கும்';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ஏற்கெனவே உள்ள வழிகாட்டியில் சேர்க்க Apple வழி தருவதில்லை, எனவே $count இடங்களையும் கொண்ட புதிய ஒன்றை Wren உருவாக்கும்.',
      one:
          'ஏற்கெனவே உள்ள வழிகாட்டியில் சேர்க்க Apple வழி தருவதில்லை, எனவே அந்த 1 இடத்தைக் கொண்ட புதிய ஒன்றை Wren உருவாக்கும்.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'புதிய வழிகாட்டியை வைத்துக்கொண்டு பழையதை நீக்குங்கள்.';

  @override
  String get republishKeepsPlaces =>
      'இந்த இடங்களை Wren வைத்திருக்கும், எனவே எதுவும் தவறாகப் போனால் வழிகாட்டியை மீண்டும் உருவாக்கலாம்.';

  @override
  String get makeCombinedGuide => 'ஒன்றிணைந்த வழிகாட்டியை உருவாக்கு';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'அந்தக் கோப்பிலிருந்து $count இடங்கள் படிக்கப்பட்டன',
      one: 'அந்தக் கோப்பிலிருந்து 1 இடம் படிக்கப்பட்டது',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count வரிசைகளில் பெயர் இல்லை',
      one: '1 வரிசையில் பெயர் இல்லை',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'அந்தக் கோப்பில் இடங்கள் இல்லை.';

  @override
  String get fileUnreadable =>
      'அந்தக் கோப்பை Wren படிக்க முடியவில்லை. CSV, KML, KMZ, GPX, GeoJSON மற்றும் Google Takeout கோப்புகளைப் படிக்கும்.';

  @override
  String lookingUpProgress(int done, int total) {
    return '$total-இல் $done தேடுகிறது…';
  }

  @override
  String get combineNeedsUnlock =>
      'ஒன்றிணைந்த வழிகாட்டியை உருவாக்க திறக்க வேண்டும்.';

  @override
  String get unlockCombineTitle =>
      'ஏற்கெனவே உள்ள உங்கள் வழிகாட்டியில் சேர்க்கவும்';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'உங்கள் வழிகாட்டியில் ஏற்கெனவே உள்ள $count இடங்களையும் புதிய இடங்களையும் ஒன்றாகக் கொண்ட ஒரே வழிகாட்டியை Wren உருவாக்கும்.',
      one:
          'உங்கள் வழிகாட்டியில் ஏற்கெனவே உள்ள 1 இடத்தையும் புதிய இடத்தையும் ஒன்றாகக் கொண்ட ஒரே வழிகாட்டியை Wren உருவாக்கும்.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'மற்றொரு செயலியிலிருந்து ஏற்றுமதி செய்யப்பட்ட பட்டியலையும் படிக்கும்: CSV, KML, KMZ, GPX, GeoJSON அல்லது Google Takeout.';

  @override
  String get clearList => 'பட்டியலைக் காலி செய்யவும்';

  @override
  String get clearListTitle => 'பட்டியலைக் காலி செய்யவும்';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren-இலிருந்து $count இடங்கள் அனைத்தையும் நீக்கவா? Apple Maps-இல் ஏற்கெனவே உருவாக்கிய வழிகாட்டிகள் பாதிக்கப்படாது.',
      one:
          'Wren-இலிருந்து அந்த ஒரு இடத்தை நீக்கவா? Apple Maps-இல் ஏற்கெனவே உருவாக்கிய வழிகாட்டிகள் பாதிக்கப்படாது.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'நீக்கு';

  @override
  String get listCleared => 'பட்டியல் காலி செய்யப்பட்டது.';

  @override
  String get expandingLink => 'அந்த இணைப்பைப் படிக்கிறது…';

  @override
  String get linkUnreachable =>
      'அந்த இணைப்பைப் படிக்க Apple-ஐ அடைய முடியவில்லை. உங்கள் இணைய இணைப்பைச் சரிபார்த்து மீண்டும் முயற்சிக்கவும்.';

  @override
  String get splitTitle => 'இது ஒன்றுக்கும் மேற்பட்ட வழிகாட்டிகளை உருவாக்கும்';

  @override
  String splitBody(int guides, int count) {
    return 'ஒரு வழிகாட்டி இணைப்பில் எத்தனை இடங்கள் இருக்கலாம் என்பதை Apple வரம்பிடுகிறது. Wren $guides வழிகாட்டிகளை உருவாக்கும்; வரிசை மாறாமல் இருக்க அவற்றுக்கு எண் இடப்படும், அவை அனைத்திலும் சேர்த்து $count இடங்கள் இருக்கும்.';
  }

  @override
  String splitConfirm(int guides) {
    return '$guides வழிகாட்டிகளை உருவாக்கு';
  }

  @override
  String splitProgress(int done, int total) {
    return '$total-இல் $done வழிகாட்டி திறக்கப்பட்டது. அடுத்ததை உருவாக்க தட்டவும்.';
  }

  @override
  String get sendPlacesTo => 'இடங்களை அனுப்பு';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count இடங்கள் அனுப்பத் தயார்',
      one: '1 இடம் அனுப்பத் தயார்',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count இடங்களுக்கு இருப்பிடம் இல்லை, அனுப்ப முடியாது',
      one: '1 இடத்திற்கு இருப்பிடம் இல்லை, அனுப்ப முடியாது',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'வேறு ஏதேனும் ஆப்';

  @override
  String get sendPlacesFailed => 'அந்த ஆப் கோப்பை ஏற்கவில்லை';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'கோப்பிலிருந்து $count இடங்கள் வைக்கப்பட்டன, வேறு வரைபட ஆப்புக்கு அனுப்பத் தயார்',
      one:
          'கோப்பிலிருந்து 1 இடம் வைக்கப்பட்டது, வேறு வரைபட ஆப்புக்கு அனுப்பத் தயார்',
    );
    return '$_temp0';
  }

  @override
  String get compExpiring =>
      'உங்கள் இலவச அணுகலை Wren உறுதிப்படுத்த முடியவில்லை. அதைத் தக்கவைக்க அடுத்த சில நாட்களில் இணையத்துடன் இணைக்கவும்.';
}
