// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class LPa extends L {
  LPa([String locale = 'pa']) : super(locale);

  @override
  String get tagline => 'ਇੱਕ ਨਿੱਕੀ ਚਿੜੀ ਨੇ ਦੱਸਿਆ।';

  @override
  String get emptyTitle => 'ਥਾਵਾਂ, ਸੰਭਾਲ ਕੇ।';

  @override
  String get emptyBody =>
      'ਜੋ ਕੋਈ ਤੁਹਾਨੂੰ ਦੱਸੇ, ਉਸਦਾ ਸਕ੍ਰੀਨਸ਼ਾਟ ਲੈ ਲਵੋ — ਇੱਕ ਰੀਲ, ਇੱਕ ਪੋਸਟ, ਇੱਕ ਸੁਨੇਹਾ, ਜਾਂ ਸਫ਼ਰਨਾਮੇ ਦਾ ਇੱਕ ਸਫ਼ਾ। Wren ਨਾਂ ਪੜ੍ਹ ਲੈਂਦਾ ਹੈ ਅਤੇ ਉਹਨਾਂ ਨੂੰ Apple Maps ਵਿੱਚ ਪਾ ਦਿੰਦਾ ਹੈ।';

  @override
  String get emptyNote =>
      'ਇੱਕੋ ਥਾਂ ਤੁਹਾਡੀ ਪਹਿਲਾਂ ਤੋਂ ਮੌਜੂਦ ਗਾਈਡ ਵਿੱਚ ਜੁੜ ਜਾਂਦੀ ਹੈ। ਕਈ ਥਾਵਾਂ ਨਵੀਂ ਬਣਾਉਂਦੀਆਂ ਹਨ — Apple Maps ਗਾਈਡਾਂ ਨੂੰ ਰਲਾ ਨਹੀਂ ਸਕਦਾ।';

  @override
  String get addScreenshots => 'ਸਕ੍ਰੀਨਸ਼ਾਟ ਜੋੜੋ';

  @override
  String get readingShort => 'ਪੜ੍ਹ ਰਿਹਾ ਹੈ…';

  @override
  String readingProgress(int done, int total) {
    return '$total ਵਿੱਚੋਂ $done ਪੜ੍ਹ ਰਿਹਾ ਹੈ…';
  }

  @override
  String get addToGuide => 'ਕਿਸੇ ਗਾਈਡ ਵਿੱਚ ਜੋੜੋ';

  @override
  String makeGuide(int count) {
    return 'ਗਾਈਡ ਬਣਾਓ ($count)';
  }

  @override
  String get notFoundOnMap => 'ਨਕਸ਼ੇ ਉੱਤੇ ਨਹੀਂ ਮਿਲੀ';

  @override
  String get tapToSearchForIt => 'ਲੱਭਣ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String readAs(String text) {
    return 'ਇਸ ਤਰ੍ਹਾਂ ਪੜ੍ਹਿਆ ਗਿਆ: “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਥਾਵਾਂ ਨਹੀਂ ਮਿਲੀਆਂ। ਲੱਭਣ ਲਈ ਟੈਪ ਕਰੋ।',
      one: '1 ਥਾਂ ਨਹੀਂ ਮਿਲੀ। ਲੱਭਣ ਲਈ ਟੈਪ ਕਰੋ।',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'ਇਹ ਥਾਵਾਂ ਕਿੱਥੇ ਹਨ?';

  @override
  String get regionDetected => 'ਸੁਰਖ਼ੀਆਂ ਵਿੱਚੋਂ ਪੜ੍ਹਿਆ। ਗ਼ਲਤ ਹੋਵੇ ਤਾਂ ਬਦਲ ਦਿਓ।';

  @override
  String get regionNotDetected =>
      'ਸਕ੍ਰੀਨਸ਼ਾਟਾਂ ਵਿੱਚ ਇਹ ਨਹੀਂ ਲਿਖਿਆ ਸੀ ਕਿ ਇਹ ਕਿੱਥੇ ਹਨ। ਸ਼ਹਿਰ ਦੱਸਣ ਨਾਲ ਖੋਜ ਕਿਤੇ ਵੱਧ ਸਹੀ ਹੁੰਦੀ ਹੈ।';

  @override
  String get cityOrRegion => 'ਸ਼ਹਿਰ ਜਾਂ ਇਲਾਕਾ';

  @override
  String get cityExample => 'ਜਿਵੇਂ ਅੰਮ੍ਰਿਤਸਰ';

  @override
  String get searchAnywhere => 'ਹਰ ਥਾਂ ਖੋਜੋ';

  @override
  String get findPlaces => 'ਥਾਵਾਂ ਲੱਭੋ';

  @override
  String searchedIn(String region) {
    return '$region ਵਿੱਚ ਖੋਜਿਆ';
  }

  @override
  String get nameThisGuide => 'ਇਸ ਗਾਈਡ ਨੂੰ ਨਾਂ ਦਿਓ';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ਇਹ Apple Maps ਵਿੱਚ ਇਸੇ ਨਾਂ ਨਾਲ ਦਿਸੇਗੀ, ਇਸ ਵਿੱਚ $count ਥਾਵਾਂ ਹੋਣਗੀਆਂ।',
      one: 'ਇਹ Apple Maps ਵਿੱਚ ਇਸੇ ਨਾਂ ਨਾਲ ਦਿਸੇਗੀ, ਇਸ ਵਿੱਚ 1 ਥਾਂ ਹੋਵੇਗੀ।',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'ਗਾਈਡ ਦਾ ਨਾਂ';

  @override
  String get guideNameExample => 'ਜਿਵੇਂ ਰੋਮ, ਅਕਤੂਬਰ';

  @override
  String get createGuide => 'ਗਾਈਡ ਬਣਾਓ';

  @override
  String get cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get guidesOfAnySize => 'ਕਿਸੇ ਵੀ ਆਕਾਰ ਦੀਆਂ ਗਾਈਡਾਂ';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren ਇੱਕ ਗਾਈਡ ਵਿੱਚ ਮੁਫ਼ਤ $limit ਥਾਵਾਂ ਤੱਕ ਸੰਭਾਲਦਾ ਹੈ। ਤੁਸੀਂ $selected ਚੁਣੀਆਂ ਹਨ — $over ਵੱਧ।';
  }

  @override
  String get onePaymentKept =>
      'ਇੱਕ ਵਾਰ ਦੀ ਅਦਾਇਗੀ, ਸਦਾ ਲਈ ਤੁਹਾਡੀ। ਕੋਈ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਨਹੀਂ।';

  @override
  String unlockFor(String price) {
    return '$price ਵਿੱਚ ਅਨਲਾਕ ਕਰੋ';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'ਇਸਦੀ ਥਾਂ ਪਹਿਲੀਆਂ $limit ਸੰਭਾਲੋ';
  }

  @override
  String get restorePrevious => 'ਪਹਿਲਾਂ ਦੀ ਖ਼ਰੀਦ ਬਹਾਲ ਕਰੋ';

  @override
  String get restorePurchase => 'ਖ਼ਰੀਦ ਬਹਾਲ ਕਰੋ';

  @override
  String overFreeLimit(int over, int limit) {
    return 'ਮੁਫ਼ਤ ਹੱਦ $limit ਤੋਂ $over ਵੱਧ। ਤੁਸੀਂ ਅਨਲਾਕ ਕਰ ਸਕਦੇ ਹੋ, ਜਾਂ ਪਹਿਲੀਆਂ $limit ਸੰਭਾਲ ਸਕਦੇ ਹੋ।';
  }

  @override
  String get findThisPlace => 'ਇਹ ਥਾਂ ਲੱਭੋ';

  @override
  String get searchAppleMaps => 'Apple Maps ਵਿੱਚ ਖੋਜੋ';

  @override
  String searchInRegion(String region) {
    return '$region ਵਿੱਚ ਖੋਜੋ';
  }

  @override
  String get searching => 'ਖੋਜ ਰਿਹਾ ਹੈ…';

  @override
  String get typeTwoCharacters => 'ਘੱਟੋ-ਘੱਟ ਦੋ ਅੱਖਰ ਲਿਖੋ।';

  @override
  String get nothingFound => 'ਕੁਝ ਨਹੀਂ ਮਿਲਿਆ। ਗਲੀ ਦਾ ਨਾਂ, ਜਾਂ ਛੋਟਾ ਨਾਂ ਅਜ਼ਮਾਓ।';

  @override
  String get rateLimited =>
      'Apple Maps ਖੋਜਾਂ ਉੱਤੇ ਹੱਦ ਲਾ ਰਿਹਾ ਹੈ। ਥੋੜ੍ਹਾ ਰੁਕ ਕੇ ਫਿਰ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps ਖੋਜਾਂ ਉੱਤੇ ਹੱਦ ਲਾ ਰਿਹਾ ਹੈ — ਹੁਣ ਤੱਕ $added ਜੁੜੀਆਂ, ਬਾਕੀ ਥੋੜ੍ਹੀ ਦੇਰ ਬਾਅਦ ਅਜ਼ਮਾਓ।';
  }

  @override
  String importSummary(int found) {
    return '$found ਮਿਲੀਆਂ';
  }

  @override
  String importSummaryIn(String region) {
    return '$region ਵਿੱਚ';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count ਵੇਖਣੀਆਂ ਹਨ';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count ਪੜ੍ਹੀਆਂ ਨਹੀਂ ਗਈਆਂ';
  }

  @override
  String nothingReadable(int count) {
    return '$count ਸਕ੍ਰੀਨਸ਼ਾਟਾਂ ਵਿੱਚ ਪੜ੍ਹਨ ਯੋਗ ਕੁਝ ਨਹੀਂ';
  }

  @override
  String get couldNotOpenMaps => 'Maps ਨਹੀਂ ਖੁੱਲ੍ਹ ਸਕਿਆ';

  @override
  String get checkingAppleAccount => 'ਤੁਹਾਡਾ Apple ਖਾਤਾ ਵੇਖ ਰਿਹਾ ਹੈ…';

  @override
  String get restoredUnlocked =>
      'ਬਹਾਲ ਹੋ ਗਿਆ। ਕਿਸੇ ਵੀ ਆਕਾਰ ਦੀਆਂ ਗਾਈਡਾਂ ਅਨਲਾਕ ਹਨ।';

  @override
  String get noPreviousPurchase =>
      'ਇਸ Apple ਖਾਤੇ ਉੱਤੇ ਪਹਿਲਾਂ ਦੀ ਕੋਈ ਖ਼ਰੀਦ ਨਹੀਂ ਮਿਲੀ।';

  @override
  String get purchaseDidNotComplete =>
      'ਖ਼ਰੀਦ ਪੂਰੀ ਨਹੀਂ ਹੋਈ, ਇਸ ਲਈ ਕੁਝ ਵੀ ਨਹੀਂ ਲਿਆ ਗਿਆ।';

  @override
  String alreadyInTheList(String name) {
    return '$name ਪਹਿਲਾਂ ਹੀ ਸੂਚੀ ਵਿੱਚ ਸੀ।';
  }

  @override
  String get ocrUnavailable =>
      'ਸਕ੍ਰੀਨਸ਼ਾਟ ਪੜ੍ਹਨ ਲਈ iPhone ਚਾਹੀਦਾ ਹੈ — ਇਸ ਪਲੇਟਫ਼ਾਰਮ ਉੱਤੇ ਲਿਖਤ ਪਛਾਣ ਨਹੀਂ ਹੈ।';

  @override
  String get lookupUnavailable =>
      'ਥਾਂ ਲੱਭਣ ਲਈ iPhone ਚਾਹੀਦਾ ਹੈ — ਇਸ ਪਲੇਟਫ਼ਾਰਮ ਉੱਤੇ ਨਕਸ਼ੇ ਵਿੱਚ ਖੋਜ ਨਹੀਂ ਹੈ।';

  @override
  String get compAccess => 'ਮੁਫ਼ਤ ਪਹੁੰਚ';

  @override
  String get code => 'ਕੋਡ';

  @override
  String get unlock => 'ਅਨਲਾਕ ਕਰੋ';

  @override
  String get compChecking => 'ਉਹ ਕੋਡ ਵੇਖ ਰਿਹਾ ਹੈ…';

  @override
  String get compEnabled => 'ਮੁਫ਼ਤ ਪਹੁੰਚ ਚਾਲੂ ਹੋ ਗਈ।';

  @override
  String get compRefused =>
      'ਉਹ ਕੋਡ ਪਛਾਣਿਆ ਨਹੀਂ ਗਿਆ, ਜਾਂ ਉਹ ਪਹਿਲਾਂ ਹੀ ਵਰਤਿਆ ਜਾ ਚੁੱਕਾ ਹੈ।';

  @override
  String get compTooOften =>
      'ਬਹੁਤ ਵਾਰ ਕੋਸ਼ਿਸ਼ ਹੋ ਗਈ। ਕੁਝ ਮਿੰਟ ਰੁਕ ਕੇ ਫਿਰ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get compUnreachable =>
      'ਸਰਵਰ ਤੱਕ ਪਹੁੰਚ ਨਹੀਂ ਹੋ ਸਕੀ। ਆਪਣਾ ਕੁਨੈਕਸ਼ਨ ਵੇਖ ਕੇ ਫਿਰ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get compUntrusted =>
      'ਉਸ ਜਵਾਬ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋ ਸਕੀ, ਇਸ ਲਈ ਕੁਝ ਵੀ ਅਨਲਾਕ ਨਹੀਂ ਹੋਇਆ।';
}
