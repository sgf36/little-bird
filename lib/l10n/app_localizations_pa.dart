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
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਵੇਖਣੀਆਂ ਹਨ',
      one: '$count ਵੇਖਣੀ ਹੈ',
    );
    return '$_temp0';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count ਪੜ੍ਹੀਆਂ ਨਹੀਂ ਗਈਆਂ';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਸਕ੍ਰੀਨਸ਼ਾਟਾਂ ਵਿੱਚ ਪੜ੍ਹਨ ਯੋਗ ਕੁਝ ਨਹੀਂ',
      one: '$count ਸਕ੍ਰੀਨਸ਼ਾਟ ਵਿੱਚ ਪੜ੍ਹਨ ਯੋਗ ਕੁਝ ਨਹੀਂ',
    );
    return '$_temp0';
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

  @override
  String get addPlaces => 'ਜੋੜੋ';

  @override
  String get fromFile => 'ਫ਼ਾਈਲ ਤੋਂ';

  @override
  String get fromExistingGuide => 'ਪਹਿਲਾਂ ਤੋਂ ਮੌਜੂਦ ਗਾਈਡ ਤੋਂ';

  @override
  String get importGuideTitle => 'ਪਹਿਲਾਂ ਤੋਂ ਮੌਜੂਦ ਗਾਈਡ ਵਿੱਚ ਜੋੜੋ';

  @override
  String get importGuideBody =>
      'Apple Maps ਵਿੱਚ ਗਾਈਡ ਖੋਲ੍ਹ ਕੇ ਸਾਂਝੀ ਕਰੋ, ਫਿਰ “ਲਿੰਕ ਕਾਪੀ ਕਰੋ” ਚੁਣੋ। ਉਸਨੂੰ ਹੇਠਾਂ ਪੇਸਟ ਕਰੋ, Wren ਉਸ ਵਿੱਚ ਪਹਿਲਾਂ ਤੋਂ ਮੌਜੂਦ ਥਾਵਾਂ ਪੜ੍ਹ ਲਵੇਗਾ।';

  @override
  String get guideLinkLabel => 'ਗਾਈਡ ਦਾ ਲਿੰਕ';

  @override
  String get readGuide => 'ਗਾਈਡ ਪੜ੍ਹੋ';

  @override
  String get importGuideNotALink =>
      'ਇਹ Apple Maps ਗਾਈਡ ਦਾ ਲਿੰਕ ਨਹੀਂ ਹੈ। ਗਾਈਡ ਨੂੰ Maps ਵਿੱਚ ਖੋਲ੍ਹੋ, ਸਾਂਝੀ ਕਰੋ, ਫਿਰ “ਲਿੰਕ ਕਾਪੀ ਕਰੋ” ਚੁਣੋ।';

  @override
  String get importGuideNothing =>
      'ਉਸ ਗਾਈਡ ਵਿੱਚ ਅਜਿਹਾ ਕੁਝ ਨਹੀਂ ਜੋ Wren ਜੋੜ ਸਕੇ।';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ਉਸ ਗਾਈਡ ਤੋਂ $count ਥਾਵਾਂ ਪੜ੍ਹੀਆਂ',
      one: 'ਉਸ ਗਾਈਡ ਤੋਂ 1 ਥਾਂ ਪੜ੍ਹੀ',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ਉਸ ਵਿੱਚੋਂ $count ਥਾਵਾਂ ਨਵੀਂ ਗਾਈਡ ਵਿੱਚ ਨਹੀਂ ਲਿਜਾਈਆਂ ਜਾ ਸਕਦੀਆਂ',
      one: 'ਉਸ ਵਿੱਚੋਂ 1 ਥਾਂ ਨਵੀਂ ਗਾਈਡ ਵਿੱਚ ਨਹੀਂ ਲਿਜਾਈ ਜਾ ਸਕਦੀ',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਥਾਵਾਂ ਪਹਿਲਾਂ ਹੀ ਇਸ ਗਾਈਡ ਵਿੱਚ',
      one: '1 ਥਾਂ ਪਹਿਲਾਂ ਹੀ ਇਸ ਗਾਈਡ ਵਿੱਚ',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '“$name” ਤੋਂ';
  }

  @override
  String get republishTitle => 'Maps ਨਵੀਂ ਗਾਈਡ ਬਣਾਉਂਦਾ ਹੈ';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ਪਹਿਲਾਂ ਤੋਂ ਮੌਜੂਦ ਗਾਈਡ ਵਿੱਚ ਕੁਝ ਜੋੜਨ ਦਾ ਕੋਈ ਰਾਹ Apple ਨਹੀਂ ਦਿੰਦਾ, ਇਸ ਲਈ Wren ਸਾਰੀਆਂ $count ਥਾਵਾਂ ਵਾਲੀ ਨਵੀਂ ਗਾਈਡ ਬਣਾਏਗਾ।',
      one:
          'ਪਹਿਲਾਂ ਤੋਂ ਮੌਜੂਦ ਗਾਈਡ ਵਿੱਚ ਕੁਝ ਜੋੜਨ ਦਾ ਕੋਈ ਰਾਹ Apple ਨਹੀਂ ਦਿੰਦਾ, ਇਸ ਲਈ Wren 1 ਥਾਂ ਵਾਲੀ ਨਵੀਂ ਗਾਈਡ ਬਣਾਏਗਾ।',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'ਨਵੀਂ ਗਾਈਡ ਰੱਖੋ ਅਤੇ ਪੁਰਾਣੀ ਮਿਟਾ ਦਿਓ।';

  @override
  String get republishKeepsPlaces =>
      'Wren ਇਹ ਥਾਵਾਂ ਸੰਭਾਲ ਰੱਖਦਾ ਹੈ, ਇਸ ਲਈ ਕੁਝ ਗ਼ਲਤ ਹੋ ਜਾਵੇ ਤਾਂ ਗਾਈਡ ਦੁਬਾਰਾ ਬਣਾਈ ਜਾ ਸਕਦੀ ਹੈ।';

  @override
  String get makeCombinedGuide => 'ਰਲਾਈ ਹੋਈ ਗਾਈਡ ਬਣਾਓ';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ਉਸ ਫ਼ਾਈਲ ਤੋਂ $count ਥਾਵਾਂ ਪੜ੍ਹੀਆਂ',
      one: 'ਉਸ ਫ਼ਾਈਲ ਤੋਂ 1 ਥਾਂ ਪੜ੍ਹੀ',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਕਤਾਰਾਂ ਵਿੱਚ ਨਾਂ ਨਹੀਂ ਸੀ',
      one: '1 ਕਤਾਰ ਵਿੱਚ ਨਾਂ ਨਹੀਂ ਸੀ',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'ਉਸ ਫ਼ਾਈਲ ਵਿੱਚ ਕੋਈ ਥਾਂ ਨਹੀਂ।';

  @override
  String get fileUnreadable =>
      'Wren ਉਹ ਫ਼ਾਈਲ ਨਹੀਂ ਪੜ੍ਹ ਸਕਿਆ। ਇਹ CSV, KML, KMZ, GPX, GeoJSON ਅਤੇ Google Takeout ਐਕਸਪੋਰਟ ਪੜ੍ਹਦਾ ਹੈ।';

  @override
  String lookingUpProgress(int done, int total) {
    return '$total ਵਿੱਚੋਂ $done ਲੱਭ ਰਿਹਾ ਹੈ…';
  }

  @override
  String get combineNeedsUnlock => 'ਰਲਾਈ ਹੋਈ ਗਾਈਡ ਬਣਾਉਣ ਲਈ ਅਨਲਾਕ ਚਾਹੀਦਾ ਹੈ।';

  @override
  String get unlockCombineTitle => 'ਆਪਣੀ ਪਹਿਲਾਂ ਤੋਂ ਮੌਜੂਦ ਗਾਈਡ ਵਿੱਚ ਜੋੜੋ';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren ਇੱਕੋ ਗਾਈਡ ਬਣਾਏਗਾ, ਜਿਸ ਵਿੱਚ ਤੁਹਾਡੀ ਗਾਈਡ ਦੀਆਂ $count ਥਾਵਾਂ ਅਤੇ ਨਵੀਆਂ ਥਾਵਾਂ, ਦੋਵੇਂ ਹੋਣਗੀਆਂ।',
      one:
          'Wren ਇੱਕੋ ਗਾਈਡ ਬਣਾਏਗਾ, ਜਿਸ ਵਿੱਚ ਤੁਹਾਡੀ ਗਾਈਡ ਦੀ 1 ਥਾਂ ਅਤੇ ਨਵੀਂ ਥਾਂ, ਦੋਵੇਂ ਹੋਣਗੀਆਂ।',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'ਕਿਸੇ ਹੋਰ ਐਪ ਤੋਂ ਐਕਸਪੋਰਟ ਕੀਤੀ ਸੂਚੀ ਵੀ ਪੜ੍ਹਦਾ ਹੈ: CSV, KML, KMZ, GPX, GeoJSON ਜਾਂ Google Takeout।';

  @override
  String get clearList => 'ਸੂਚੀ ਖ਼ਾਲੀ ਕਰੋ';

  @override
  String get clearListTitle => 'ਸੂਚੀ ਖ਼ਾਲੀ ਕਰੋ';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren ਤੋਂ ਸਾਰੀਆਂ $count ਥਾਵਾਂ ਹਟਾ ਦੇਣੀਆਂ ਹਨ? Apple Maps ਵਿੱਚ ਪਹਿਲਾਂ ਬਣਾਈਆਂ ਗਾਈਡਾਂ ਉੱਤੇ ਕੋਈ ਅਸਰ ਨਹੀਂ ਪੈਂਦਾ।',
      one:
          'Wren ਤੋਂ ਉਹ ਇੱਕ ਥਾਂ ਹਟਾ ਦੇਣੀ ਹੈ? Apple Maps ਵਿੱਚ ਪਹਿਲਾਂ ਬਣਾਈਆਂ ਗਾਈਡਾਂ ਉੱਤੇ ਕੋਈ ਅਸਰ ਨਹੀਂ ਪੈਂਦਾ।',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'ਹਟਾਓ';

  @override
  String get listCleared => 'ਸੂਚੀ ਖ਼ਾਲੀ ਹੋ ਗਈ।';

  @override
  String get expandingLink => 'ਉਹ ਲਿੰਕ ਪੜ੍ਹ ਰਿਹਾ ਹੈ…';

  @override
  String get linkUnreachable =>
      'ਉਹ ਲਿੰਕ ਪੜ੍ਹਨ ਲਈ Apple ਤੱਕ ਪਹੁੰਚ ਨਹੀਂ ਹੋ ਸਕੀ। ਆਪਣਾ ਕੁਨੈਕਸ਼ਨ ਵੇਖ ਕੇ ਫਿਰ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get splitTitle => 'ਇਸ ਨਾਲ ਇੱਕ ਤੋਂ ਵੱਧ ਗਾਈਡਾਂ ਬਣਨਗੀਆਂ';

  @override
  String splitBody(int guides, int count) {
    return 'ਇੱਕ ਗਾਈਡ ਦੇ ਲਿੰਕ ਵਿੱਚ ਕਿੰਨੀਆਂ ਥਾਵਾਂ ਆ ਸਕਦੀਆਂ ਹਨ, Apple ਇਸਦੀ ਹੱਦ ਰੱਖਦਾ ਹੈ। Wren $guides ਗਾਈਡਾਂ ਬਣਾਏਗਾ, ਤਰਤੀਬ ਬਣੀ ਰਹੇ ਇਸ ਲਈ ਉਹਨਾਂ ਉੱਤੇ ਨੰਬਰ ਹੋਣਗੇ, ਅਤੇ ਉਹਨਾਂ ਸਾਰੀਆਂ ਵਿੱਚ ਮਿਲਾ ਕੇ $count ਥਾਵਾਂ ਹੋਣਗੀਆਂ।';
  }

  @override
  String splitConfirm(int guides) {
    return '$guides ਗਾਈਡਾਂ ਬਣਾਓ';
  }

  @override
  String splitProgress(int done, int total) {
    return '$total ਵਿੱਚੋਂ $done ਗਾਈਡ ਖੁੱਲ੍ਹ ਗਈ। ਅਗਲੀ ਬਣਾਉਣ ਲਈ ਟੈਪ ਕਰੋ।';
  }

  @override
  String get compExpiring =>
      'Wren ਤੁਹਾਡੀ ਮੁਫ਼ਤ ਪਹੁੰਚ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਕਰ ਸਕਿਆ। ਇਸਨੂੰ ਬਰਕਰਾਰ ਰੱਖਣ ਲਈ ਅਗਲੇ ਕੁਝ ਦਿਨਾਂ ਵਿੱਚ ਇੰਟਰਨੈੱਟ ਨਾਲ ਕਨੈਕਟ ਕਰੋ।';
}
