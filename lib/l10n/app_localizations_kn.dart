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
    return '$count ಸ್ಕ್ರೀನ್‌ಶಾಟ್‌ಗಳಲ್ಲಿ ಓದುವಂತಹದ್ದು ಏನೂ ಇಲ್ಲ';
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
  String get reviewerAccess => 'ಪರಿಶೀಲಕರ ಪ್ರವೇಶ';

  @override
  String get code => 'ಕೋಡ್';

  @override
  String get unlock => 'ಅನ್‌ಲಾಕ್ ಮಾಡಿ';

  @override
  String get reviewerEnabled => 'ಪರಿಶೀಲಕರ ಪ್ರವೇಶ ಆನ್ ಆಗಿದೆ.';

  @override
  String get codeNotRecognised => 'ಆ ಕೋಡ್ ಗುರುತಿಸಲಾಗಲಿಲ್ಲ.';
}
