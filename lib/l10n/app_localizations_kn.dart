// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class LKn extends L {
  LKn([String locale = 'kn']) : super(locale);

  @override
  String get tagline => 'ಒಂದು ಪುಟ್ಟ ಹಕ್ಕಿ ಹೇಳಿತು.';

  @override
  String get emptyTitle => 'ಸ್ಥಳಗಳು, ಜೋಪಾನ.';

  @override
  String get emptyBody =>
      'ಯಾರಾದರೂ ಸೂಚಿಸಿದ್ದನ್ನು ಸ್ಕ್ರೀನ್‌ಶಾಟ್ ತೆಗೆದುಕೊಳ್ಳಿ — ಒಂದು ರೀಲ್, ಒಂದು ಪೋಸ್ಟ್, ಒಂದು ಸಂದೇಶ, ಪ್ರವಾಸ ಪುಸ್ತಕದ ಒಂದು ಪುಟ. Wren ಹೆಸರುಗಳನ್ನು ಓದಿ ಅವನ್ನು Apple Maps‌ನಲ್ಲಿ ಇರಿಸುತ್ತದೆ.';

  @override
  String get emptyNote =>
      'ಒಂದೇ ಸ್ಥಳ ನಿಮ್ಮಲ್ಲಿ ಈಗಾಗಲೇ ಇರುವ ಮಾರ್ಗದರ್ಶಿಗೆ ಸೇರುತ್ತದೆ. ಹಲವು ಸ್ಥಳಗಳು ಹೊಸದನ್ನು ಸೃಷ್ಟಿಸುತ್ತವೆ — Apple Maps ಮಾರ್ಗದರ್ಶಿಗಳನ್ನು ಒಗ್ಗೂಡಿಸಲಾರದು.';

  @override
  String get addScreenshots => 'ಸ್ಕ್ರೀನ್‌ಶಾಟ್‌ಗಳನ್ನು ಸೇರಿಸಿ';

  @override
  String get readingShort => 'ಓದುತ್ತಿದೆ…';

  @override
  String readingProgress(int done, int total) {
    return '$totalರಲ್ಲಿ $done ಓದುತ್ತಿದೆ…';
  }

  @override
  String get addToGuide => 'ಮಾರ್ಗದರ್ಶಿಗೆ ಸೇರಿಸಿ';

  @override
  String makeGuide(int count) {
    return 'ಮಾರ್ಗದರ್ಶಿ ರಚಿಸಿ ($count)';
  }

  @override
  String get notFoundOnMap => 'ನಕ್ಷೆಯಲ್ಲಿ ಸಿಗಲಿಲ್ಲ';

  @override
  String get tapToSearchForIt => 'ಹುಡುಕಲು ಟ್ಯಾಪ್ ಮಾಡಿ';

  @override
  String readAs(String text) {
    return 'ಹೀಗೆ ಓದಲಾಗಿದೆ: “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ಸ್ಥಳಗಳು ಸಿಗಲಿಲ್ಲ. ಹುಡುಕಲು ಟ್ಯಾಪ್ ಮಾಡಿ.',
      one: '1 ಸ್ಥಳ ಸಿಗಲಿಲ್ಲ. ಹುಡುಕಲು ಟ್ಯಾಪ್ ಮಾಡಿ.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'ಈ ಸ್ಥಳಗಳು ಎಲ್ಲಿವೆ?';

  @override
  String get regionDetected => 'ಶೀರ್ಷಿಕೆಗಳಿಂದ ಓದಲಾಗಿದೆ. ತಪ್ಪಿದ್ದರೆ ಬದಲಾಯಿಸಿ.';

  @override
  String get regionNotDetected =>
      'ಇವು ಎಲ್ಲಿವೆ ಎಂದು ಸ್ಕ್ರೀನ್‌ಶಾಟ್‌ಗಳಲ್ಲಿ ಇರಲಿಲ್ಲ. ನಗರ ಕೊಟ್ಟರೆ ಹುಡುಕಾಟ ಬಹಳ ನಿಖರವಾಗುತ್ತದೆ.';

  @override
  String get cityOrRegion => 'ನಗರ ಅಥವಾ ಪ್ರದೇಶ';

  @override
  String get cityExample => 'ಉದಾ. ಬೆಂಗಳೂರು';

  @override
  String get searchAnywhere => 'ಎಲ್ಲೆಡೆ ಹುಡುಕಿ';

  @override
  String get findPlaces => 'ಸ್ಥಳಗಳನ್ನು ಹುಡುಕಿ';

  @override
  String searchedIn(String region) {
    return '$regionನಲ್ಲಿ ಹುಡುಕಲಾಗಿದೆ';
  }

  @override
  String get nameThisGuide => 'ಈ ಮಾರ್ಗದರ್ಶಿಗೆ ಹೆಸರಿಡಿ';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ಇದೇ ಹೆಸರಿನಲ್ಲಿ Apple Maps‌ನಲ್ಲಿ ಕಾಣಿಸುತ್ತದೆ, ಅದರಲ್ಲಿ $count ಸ್ಥಳಗಳು ಇರುತ್ತವೆ.',
      one:
          'ಇದೇ ಹೆಸರಿನಲ್ಲಿ Apple Maps‌ನಲ್ಲಿ ಕಾಣಿಸುತ್ತದೆ, ಅದರಲ್ಲಿ 1 ಸ್ಥಳ ಇರುತ್ತದೆ.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'ಮಾರ್ಗದರ್ಶಿಯ ಹೆಸರು';

  @override
  String get guideNameExample => 'ಉದಾ. ರೋಮ್, ಅಕ್ಟೋಬರ್';

  @override
  String get createGuide => 'ಮಾರ್ಗದರ್ಶಿ ರಚಿಸಿ';

  @override
  String get cancel => 'ರದ್ದುಮಾಡಿ';

  @override
  String get guidesOfAnySize => 'ಯಾವುದೇ ಗಾತ್ರದ ಮಾರ್ಗದರ್ಶಿಗಳು';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren ಒಂದು ಮಾರ್ಗದರ್ಶಿಯಲ್ಲಿ ಉಚಿತವಾಗಿ $limit ಸ್ಥಳಗಳವರೆಗೆ ಉಳಿಸುತ್ತದೆ. ನೀವು $selected ಆಯ್ಕೆ ಮಾಡಿದ್ದೀರಿ — $over ಹೆಚ್ಚು.';
  }

  @override
  String get onePaymentKept =>
      'ಒಮ್ಮೆ ಪಾವತಿ, ಶಾಶ್ವತವಾಗಿ ನಿಮ್ಮದು. ಚಂದಾದಾರಿಕೆ ಇಲ್ಲ.';

  @override
  String unlockFor(String price) {
    return '$priceಗೆ ಅನ್‌ಲಾಕ್ ಮಾಡಿ';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'ಬದಲಿಗೆ ಮೊದಲ $limit ಉಳಿಸಿ';
  }

  @override
  String get restorePrevious => 'ಹಿಂದಿನ ಖರೀದಿಯನ್ನು ಮರಳಿ ಪಡೆಯಿರಿ';

  @override
  String get restorePurchase => 'ಖರೀದಿಯನ್ನು ಮರಳಿ ಪಡೆಯಿರಿ';

  @override
  String overFreeLimit(int over, int limit) {
    return 'ಉಚಿತ ಮಿತಿ $limitಕ್ಕಿಂತ $over ಹೆಚ್ಚು. ಅನ್‌ಲಾಕ್ ಮಾಡಬಹುದು, ಅಥವಾ ಮೊದಲ $limit ಉಳಿಸಬಹುದು.';
  }

  @override
  String get findThisPlace => 'ಈ ಸ್ಥಳವನ್ನು ಹುಡುಕಿ';

  @override
  String get searchAppleMaps => 'Apple Maps‌ನಲ್ಲಿ ಹುಡುಕಿ';

  @override
  String searchInRegion(String region) {
    return '$regionನಲ್ಲಿ ಹುಡುಕಿ';
  }

  @override
  String get searching => 'ಹುಡುಕುತ್ತಿದೆ…';

  @override
  String get typeTwoCharacters => 'ಕನಿಷ್ಠ ಎರಡು ಅಕ್ಷರ ಟೈಪ್ ಮಾಡಿ.';

  @override
  String get nothingFound =>
      'ಏನೂ ಸಿಗಲಿಲ್ಲ. ರಸ್ತೆಯ ಹೆಸರು, ಅಥವಾ ಚಿಕ್ಕ ಹೆಸರು ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get rateLimited =>
      'Apple Maps ಹುಡುಕಾಟಗಳನ್ನು ಮಿತಿಗೊಳಿಸುತ್ತಿದೆ. ಸ್ವಲ್ಪ ತಡೆದು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps ಹುಡುಕಾಟಗಳನ್ನು ಮಿತಿಗೊಳಿಸುತ್ತಿದೆ — ಇಲ್ಲಿಯವರೆಗೆ $added ಸೇರಿಸಲಾಗಿದೆ, ಉಳಿದವನ್ನು ಸ್ವಲ್ಪ ಹೊತ್ತಿನಲ್ಲಿ ಪ್ರಯತ್ನಿಸಿ.';
  }

  @override
  String importSummary(int found) {
    return '$found ಸಿಕ್ಕವು';
  }

  @override
  String importSummaryIn(String region) {
    return '$regionನಲ್ಲಿ';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count ನೋಡಬೇಕು';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count ಓದಲಾಗಲಿಲ್ಲ';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ಸ್ಕ್ರೀನ್‌ಶಾಟ್‌ಗಳಲ್ಲಿ ಓದುವಂತಹದ್ದು ಏನೂ ಇಲ್ಲ',
      one: '$count ಸ್ಕ್ರೀನ್‌ಶಾಟ್‌ನಲ್ಲಿ ಓದುವಂತಹದ್ದು ಏನೂ ಇಲ್ಲ',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Maps ತೆರೆಯಲಾಗಲಿಲ್ಲ';

  @override
  String get checkingAppleAccount => 'ನಿಮ್ಮ Apple ಖಾತೆಯನ್ನು ಪರಿಶೀಲಿಸುತ್ತಿದೆ…';

  @override
  String get restoredUnlocked =>
      'ಮರಳಿ ಪಡೆಯಲಾಗಿದೆ. ಯಾವುದೇ ಗಾತ್ರದ ಮಾರ್ಗದರ್ಶಿಗಳು ಅನ್‌ಲಾಕ್ ಆಗಿವೆ.';

  @override
  String get noPreviousPurchase => 'ಈ Apple ಖಾತೆಯಲ್ಲಿ ಹಿಂದಿನ ಖರೀದಿ ಸಿಗಲಿಲ್ಲ.';

  @override
  String get purchaseDidNotComplete =>
      'ಖರೀದಿ ಪೂರ್ಣಗೊಳ್ಳಲಿಲ್ಲ, ಹಾಗಾಗಿ ಏನೂ ವಿಧಿಸಲಾಗಿಲ್ಲ.';

  @override
  String alreadyInTheList(String name) {
    return '$name ಈಗಾಗಲೇ ಪಟ್ಟಿಯಲ್ಲಿತ್ತು.';
  }

  @override
  String get ocrUnavailable =>
      'ಸ್ಕ್ರೀನ್‌ಶಾಟ್ ಓದಲು iPhone ಬೇಕು — ಈ ವೇದಿಕೆಯಲ್ಲಿ ಪಠ್ಯ ಗುರುತಿಸುವಿಕೆ ಇಲ್ಲ.';

  @override
  String get lookupUnavailable =>
      'ಸ್ಥಳ ಹುಡುಕಲು iPhone ಬೇಕು — ಈ ವೇದಿಕೆಯಲ್ಲಿ ನಕ್ಷೆ ಹುಡುಕಾಟ ಇಲ್ಲ.';

  @override
  String get compAccess => 'ಉಚಿತ ಪ್ರವೇಶ';

  @override
  String get code => 'ಕೋಡ್';

  @override
  String get unlock => 'ಅನ್‌ಲಾಕ್ ಮಾಡಿ';

  @override
  String get compChecking => 'ಆ ಕೋಡ್ ಪರಿಶೀಲಿಸುತ್ತಿದೆ…';

  @override
  String get compEnabled => 'ಉಚಿತ ಪ್ರವೇಶ ಆನ್ ಆಗಿದೆ.';

  @override
  String get compRefused =>
      'ಆ ಕೋಡ್ ಗುರುತಿಸಲಾಗಲಿಲ್ಲ, ಅಥವಾ ಅದನ್ನು ಈಗಾಗಲೇ ಬಳಸಲಾಗಿದೆ.';

  @override
  String get compTooOften =>
      'ಬಹಳ ಪ್ರಯತ್ನಗಳಾದವು. ಕೆಲವು ನಿಮಿಷ ಕಾದು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get compUnreachable =>
      'ಸರ್ವರ್ ತಲುಪಲಾಗಲಿಲ್ಲ. ನಿಮ್ಮ ಸಂಪರ್ಕ ಪರಿಶೀಲಿಸಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get compUntrusted =>
      'ಆ ಉತ್ತರವನ್ನು ಪರಿಶೀಲಿಸಲಾಗಲಿಲ್ಲ, ಹಾಗಾಗಿ ಏನೂ ಅನ್‌ಲಾಕ್ ಆಗಿಲ್ಲ.';

  @override
  String get addPlaces => 'ಸೇರಿಸಿ';

  @override
  String get fromFile => 'ಫೈಲ್‌ನಿಂದ';

  @override
  String get fromExistingGuide => 'ಈಗಾಗಲೇ ಇರುವ ಮಾರ್ಗದರ್ಶಿಯಿಂದ';

  @override
  String get importGuideTitle => 'ಈಗಾಗಲೇ ಇರುವ ಮಾರ್ಗದರ್ಶಿಗೆ ಸೇರಿಸಿ';

  @override
  String get importGuideBody =>
      'Apple Maps‌ನಲ್ಲಿ ಮಾರ್ಗದರ್ಶಿಯನ್ನು ತೆರೆದು ಹಂಚಿಕೊಳ್ಳಿ, ನಂತರ ಲಿಂಕ್ ನಕಲಿಸಿ ಎಂಬುದನ್ನು ಆಯ್ಕೆ ಮಾಡಿ. ಅದನ್ನು ಕೆಳಗೆ ಅಂಟಿಸಿದರೆ, ಅದರಲ್ಲಿ ಈಗಾಗಲೇ ಇರುವ ಸ್ಥಳಗಳನ್ನು Wren ಓದುತ್ತದೆ.';

  @override
  String get guideLinkLabel => 'ಮಾರ್ಗದರ್ಶಿಯ ಲಿಂಕ್';

  @override
  String get readGuide => 'ಮಾರ್ಗದರ್ಶಿ ಓದಿ';

  @override
  String get importGuideNotALink =>
      'ಅದು Apple Maps ಮಾರ್ಗದರ್ಶಿಯ ಲಿಂಕ್ ಅಲ್ಲ. Maps‌ನಲ್ಲಿ ಮಾರ್ಗದರ್ಶಿಯನ್ನು ತೆರೆದು ಹಂಚಿಕೊಳ್ಳಿ, ನಂತರ ಲಿಂಕ್ ನಕಲಿಸಿ ಎಂಬುದನ್ನು ಆಯ್ಕೆ ಮಾಡಿ.';

  @override
  String get importGuideNothing =>
      'ಆ ಮಾರ್ಗದರ್ಶಿಯಲ್ಲಿ Wren ಸೇರಿಸಬಹುದಾದದ್ದು ಏನೂ ಇಲ್ಲ.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ಆ ಮಾರ್ಗದರ್ಶಿಯಿಂದ $count ಸ್ಥಳಗಳನ್ನು ಓದಲಾಯಿತು',
      one: 'ಆ ಮಾರ್ಗದರ್ಶಿಯಿಂದ 1 ಸ್ಥಳ ಓದಲಾಯಿತು',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ಅದರಲ್ಲಿನ $count ಸ್ಥಳಗಳನ್ನು ಸಾಗಿಸಲಾಗದು',
      one: 'ಅದರಲ್ಲಿನ 1 ಸ್ಥಳವನ್ನು ಸಾಗಿಸಲಾಗದು',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ಸ್ಥಳಗಳು ಈಗಾಗಲೇ ಈ ಮಾರ್ಗದರ್ಶಿಯಲ್ಲಿವೆ',
      one: '1 ಸ್ಥಳ ಈಗಾಗಲೇ ಈ ಮಾರ್ಗದರ್ಶಿಯಲ್ಲಿದೆ',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '“$name” ಮಾರ್ಗದರ್ಶಿಯಿಂದ';
  }

  @override
  String get republishTitle => 'Maps ಹೊಸ ಮಾರ್ಗದರ್ಶಿ ರಚಿಸುತ್ತದೆ';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ಈಗಾಗಲೇ ಇರುವ ಮಾರ್ಗದರ್ಶಿಗೆ ಸೇರಿಸಲು Apple ದಾರಿ ಕೊಡುವುದಿಲ್ಲ, ಹಾಗಾಗಿ $count ಸ್ಥಳಗಳನ್ನೂ ಒಳಗೊಂಡ ಹೊಸದನ್ನು Wren ರಚಿಸುತ್ತದೆ.',
      one:
          'ಈಗಾಗಲೇ ಇರುವ ಮಾರ್ಗದರ್ಶಿಗೆ ಸೇರಿಸಲು Apple ದಾರಿ ಕೊಡುವುದಿಲ್ಲ, ಹಾಗಾಗಿ ಆ 1 ಸ್ಥಳವನ್ನು ಒಳಗೊಂಡ ಹೊಸದನ್ನು Wren ರಚಿಸುತ್ತದೆ.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'ಹೊಸ ಮಾರ್ಗದರ್ಶಿಯನ್ನು ಇಟ್ಟುಕೊಂಡು ಹಳೆಯದನ್ನು ಅಳಿಸಿ.';

  @override
  String get republishKeepsPlaces =>
      'ಈ ಸ್ಥಳಗಳನ್ನು Wren ಉಳಿಸಿಕೊಳ್ಳುತ್ತದೆ, ಹಾಗಾಗಿ ಏನಾದರೂ ತಪ್ಪಾದರೆ ಮಾರ್ಗದರ್ಶಿಯನ್ನು ಮತ್ತೆ ರಚಿಸಬಹುದು.';

  @override
  String get makeCombinedGuide => 'ಒಗ್ಗೂಡಿಸಿದ ಮಾರ್ಗದರ್ಶಿ ರಚಿಸಿ';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ಆ ಫೈಲ್‌ನಿಂದ $count ಸ್ಥಳಗಳನ್ನು ಓದಲಾಯಿತು',
      one: 'ಆ ಫೈಲ್‌ನಿಂದ 1 ಸ್ಥಳ ಓದಲಾಯಿತು',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ಸಾಲುಗಳಲ್ಲಿ ಹೆಸರಿರಲಿಲ್ಲ',
      one: '1 ಸಾಲಿನಲ್ಲಿ ಹೆಸರಿರಲಿಲ್ಲ',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'ಆ ಫೈಲ್‌ನಲ್ಲಿ ಸ್ಥಳಗಳಿಲ್ಲ.';

  @override
  String get fileUnreadable =>
      'ಆ ಫೈಲ್ ಅನ್ನು Wren ಓದಲಾಗಲಿಲ್ಲ. ಇದು CSV, KML, KMZ, GPX, GeoJSON ಮತ್ತು Google Takeout ಫೈಲ್‌ಗಳನ್ನು ಓದುತ್ತದೆ.';

  @override
  String lookingUpProgress(int done, int total) {
    return '$totalರಲ್ಲಿ $done ಹುಡುಕುತ್ತಿದೆ…';
  }

  @override
  String get combineNeedsUnlock =>
      'ಒಗ್ಗೂಡಿಸಿದ ಮಾರ್ಗದರ್ಶಿ ರಚಿಸಲು ಅನ್‌ಲಾಕ್ ಬೇಕು.';

  @override
  String get unlockCombineTitle => 'ಈಗಾಗಲೇ ಇರುವ ನಿಮ್ಮ ಮಾರ್ಗದರ್ಶಿಗೆ ಸೇರಿಸಿ';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ನಿಮ್ಮ ಮಾರ್ಗದರ್ಶಿಯಲ್ಲಿ ಈಗಾಗಲೇ ಇರುವ $count ಸ್ಥಳಗಳನ್ನೂ ಹೊಸ ಸ್ಥಳಗಳನ್ನೂ ಒಳಗೊಂಡ ಒಂದೇ ಮಾರ್ಗದರ್ಶಿಯನ್ನು Wren ರಚಿಸುತ್ತದೆ.',
      one:
          'ನಿಮ್ಮ ಮಾರ್ಗದರ್ಶಿಯಲ್ಲಿ ಈಗಾಗಲೇ ಇರುವ 1 ಸ್ಥಳವನ್ನೂ ಹೊಸ ಸ್ಥಳವನ್ನೂ ಒಳಗೊಂಡ ಒಂದೇ ಮಾರ್ಗದರ್ಶಿಯನ್ನು Wren ರಚಿಸುತ್ತದೆ.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'ಬೇರೆ ಅಪ್ಲಿಕೇಶನ್‌ನಿಂದ ಎಕ್ಸ್‌ಪೋರ್ಟ್ ಮಾಡಿದ ಪಟ್ಟಿಯನ್ನೂ ಓದುತ್ತದೆ: CSV, KML, KMZ, GPX, GeoJSON ಅಥವಾ Google Takeout.';

  @override
  String get clearList => 'ಪಟ್ಟಿಯನ್ನು ಖಾಲಿ ಮಾಡಿ';

  @override
  String get clearListTitle => 'ಪಟ್ಟಿಯನ್ನು ಖಾಲಿ ಮಾಡಿ';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren‌ನಿಂದ $count ಸ್ಥಳಗಳನ್ನೂ ತೆಗೆಯಬೇಕೇ? Apple Maps‌ನಲ್ಲಿ ಈಗಾಗಲೇ ರಚಿಸಿದ ಮಾರ್ಗದರ್ಶಿಗಳಿಗೆ ಏನೂ ಆಗುವುದಿಲ್ಲ.',
      one:
          'Wren‌ನಿಂದ ಆ ಒಂದು ಸ್ಥಳವನ್ನು ತೆಗೆಯಬೇಕೇ? Apple Maps‌ನಲ್ಲಿ ಈಗಾಗಲೇ ರಚಿಸಿದ ಮಾರ್ಗದರ್ಶಿಗಳಿಗೆ ಏನೂ ಆಗುವುದಿಲ್ಲ.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'ತೆಗೆಯಿರಿ';

  @override
  String get listCleared => 'ಪಟ್ಟಿ ಖಾಲಿಯಾಗಿದೆ.';

  @override
  String get expandingLink => 'ಆ ಲಿಂಕ್ ಓದುತ್ತಿದೆ…';

  @override
  String get linkUnreachable =>
      'ಆ ಲಿಂಕ್ ಓದಲು Apple ತಲುಪಲಾಗಲಿಲ್ಲ. ನಿಮ್ಮ ಸಂಪರ್ಕ ಪರಿಶೀಲಿಸಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get splitTitle =>
      'ಇದರಿಂದ ಒಂದಕ್ಕಿಂತ ಹೆಚ್ಚು ಮಾರ್ಗದರ್ಶಿಗಳು ರಚನೆಯಾಗುತ್ತವೆ';

  @override
  String splitBody(int guides, int count) {
    return 'ಒಂದು ಮಾರ್ಗದರ್ಶಿಯ ಲಿಂಕ್‌ನಲ್ಲಿ ಎಷ್ಟು ಸ್ಥಳಗಳು ಇರಬಹುದು ಎಂಬುದನ್ನು Apple ಮಿತಿಗೊಳಿಸುತ್ತದೆ. Wren $guides ಮಾರ್ಗದರ್ಶಿಗಳನ್ನು ರಚಿಸುತ್ತದೆ, ಕ್ರಮ ಉಳಿಯುವಂತೆ ಅವಕ್ಕೆ ಸಂಖ್ಯೆ ಇರುತ್ತದೆ, ಅವೆಲ್ಲದರಲ್ಲಿ ಸೇರಿ $count ಸ್ಥಳಗಳು ಇರುತ್ತವೆ.';
  }

  @override
  String splitConfirm(int guides) {
    return '$guides ಮಾರ್ಗದರ್ಶಿಗಳನ್ನು ರಚಿಸಿ';
  }

  @override
  String splitProgress(int done, int total) {
    return '$totalರಲ್ಲಿ $done ಮಾರ್ಗದರ್ಶಿ ತೆರೆಯಲಾಯಿತು. ಮುಂದಿನದನ್ನು ರಚಿಸಲು ಟ್ಯಾಪ್ ಮಾಡಿ.';
  }

  @override
  String get sendPlacesTo => 'ಸ್ಥಳಗಳನ್ನು ಕಳುಹಿಸಿ';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ಸ್ಥಳಗಳು ಕಳುಹಿಸಲು ಸಿದ್ಧ',
      one: '1 ಸ್ಥಳ ಕಳುಹಿಸಲು ಸಿದ್ಧ',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ಸ್ಥಳಗಳಿಗೆ ಸ್ಥಾನವಿಲ್ಲ, ಕಳುಹಿಸಲಾಗದು',
      one: '1 ಸ್ಥಳಕ್ಕೆ ಸ್ಥಾನವಿಲ್ಲ, ಕಳುಹಿಸಲಾಗದು',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'ಬೇರೆ ಯಾವುದೇ ಆ್ಯಪ್';

  @override
  String get sendPlacesFailed => 'ಆ ಆ್ಯಪ್ ಫೈಲ್ ಸ್ವೀಕರಿಸಲಿಲ್ಲ';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ಫೈಲ್‌ನಿಂದ $count ಸ್ಥಳಗಳು ಉಳಿಸಲಾಗಿವೆ, ಬೇರೆ ನಕ್ಷೆ ಆ್ಯಪ್‌ಗೆ ಕಳುಹಿಸಲು ಸಿದ್ಧ',
      one: 'ಫೈಲ್‌ನಿಂದ 1 ಸ್ಥಳ ಉಳಿಸಲಾಗಿದೆ, ಬೇರೆ ನಕ್ಷೆ ಆ್ಯಪ್‌ಗೆ ಕಳುಹಿಸಲು ಸಿದ್ಧ',
    );
    return '$_temp0';
  }
}
