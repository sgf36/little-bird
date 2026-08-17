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
}
