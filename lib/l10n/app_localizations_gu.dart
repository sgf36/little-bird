// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class LGu extends L {
  LGu([String locale = 'gu']) : super(locale);

  @override
  String get tagline => 'એક નાનકડા પંખીએ કહ્યું.';

  @override
  String get emptyTitle => 'જગ્યાઓ, સાચવેલી.';

  @override
  String get emptyBody =>
      'કોઈ તમને જે સૂચવે તેનો સ્ક્રીનશૉટ લઈ લો — રીલ, પોસ્ટ, સંદેશ, કે પ્રવાસ-પુસ્તકનું પાનું. Wren નામ વાંચી લે છે અને તેમને Apple Maps માં મૂકે છે.';

  @override
  String get emptyNote =>
      'એક જ જગ્યા તમારી પાસે પહેલેથી હોય તે માર્ગદર્શિકામાં ઉમેરાય છે. અનેક જગ્યાઓથી નવી બને છે — Apple Maps માર્ગદર્શિકાઓ ભેગી કરી શકતું નથી.';

  @override
  String get addScreenshots => 'સ્ક્રીનશૉટ ઉમેરો';

  @override
  String get readingShort => 'વાંચી રહ્યું છે…';

  @override
  String readingProgress(int done, int total) {
    return '$total માંથી $done વાંચી રહ્યું છે…';
  }

  @override
  String get addToGuide => 'માર્ગદર્શિકામાં ઉમેરો';

  @override
  String makeGuide(int count) {
    return 'માર્ગદર્શિકા બનાવો ($count)';
  }

  @override
  String get notFoundOnMap => 'નકશા પર મળી નહીં';

  @override
  String get tapToSearchForIt => 'શોધવા માટે ટૅપ કરો';

  @override
  String readAs(String text) {
    return 'આ રીતે વંચાયું: “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count જગ્યાઓ મળી નહીં. શોધવા માટે ટૅપ કરો.',
      one: '૧ જગ્યા મળી નહીં. શોધવા માટે ટૅપ કરો.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'આ જગ્યાઓ ક્યાં છે?';

  @override
  String get regionDetected => 'કૅપ્શનમાંથી વંચાયું. ખોટું હોય તો બદલો.';

  @override
  String get regionNotDetected =>
      'સ્ક્રીનશૉટમાં એ ક્યાં છે તે લખ્યું નહોતું. શહેર આપવાથી શોધ ઘણી વધુ સચોટ થાય છે.';

  @override
  String get cityOrRegion => 'શહેર કે પ્રદેશ';

  @override
  String get cityExample => 'દા.ત. અમદાવાદ';

  @override
  String get searchAnywhere => 'બધે શોધો';

  @override
  String get findPlaces => 'જગ્યાઓ શોધો';

  @override
  String searchedIn(String region) {
    return '$region માં શોધ્યું';
  }

  @override
  String get nameThisGuide => 'આ માર્ગદર્શિકાને નામ આપો';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'તે Apple Maps માં આ જ નામે દેખાશે, તેમાં $count જગ્યાઓ હશે.',
      one: 'તે Apple Maps માં આ જ નામે દેખાશે, તેમાં ૧ જગ્યા હશે.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'માર્ગદર્શિકાનું નામ';

  @override
  String get guideNameExample => 'દા.ત. રોમ, ઑક્ટોબર';

  @override
  String get createGuide => 'માર્ગદર્શિકા બનાવો';

  @override
  String get cancel => 'રદ કરો';

  @override
  String get guidesOfAnySize => 'કોઈ પણ કદની માર્ગદર્શિકા';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren એક માર્ગદર્શિકામાં મફતમાં $limit જગ્યાઓ સુધી સાચવે છે. તમે $selected પસંદ કરી છે — $over વધારે.';
  }

  @override
  String get onePaymentKept =>
      'એક જ વારની ચુકવણી, કાયમ માટે તમારી. કોઈ સબ્સ્ક્રિપ્શન નહીં.';

  @override
  String unlockFor(String price) {
    return '$price માં અનલૉક કરો';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'તેના બદલે પહેલી $limit સાચવો';
  }

  @override
  String get restorePrevious => 'અગાઉની ખરીદી પુનઃસ્થાપિત કરો';

  @override
  String get restorePurchase => 'ખરીદી પુનઃસ્થાપિત કરો';

  @override
  String overFreeLimit(int over, int limit) {
    return 'મફત મર્યાદા $limit કરતાં $over વધારે. તમે અનલૉક કરી શકો, અથવા પહેલી $limit સાચવી શકો.';
  }

  @override
  String get findThisPlace => 'આ જગ્યા શોધો';

  @override
  String get searchAppleMaps => 'Apple Maps માં શોધો';

  @override
  String searchInRegion(String region) {
    return '$region માં શોધો';
  }

  @override
  String get searching => 'શોધી રહ્યું છે…';

  @override
  String get typeTwoCharacters => 'ઓછામાં ઓછા બે અક્ષર લખો.';

  @override
  String get nothingFound =>
      'કશું મળ્યું નહીં. શેરીનું નામ, કે ટૂંકું નામ અજમાવો.';

  @override
  String get rateLimited =>
      'Apple Maps શોધ પર મર્યાદા મૂકી રહ્યું છે. થોડું થોભીને ફરી પ્રયાસ કરો.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps શોધ પર મર્યાદા મૂકી રહ્યું છે — અત્યાર સુધીમાં $added ઉમેરાઈ, બાકીની થોડી વારે અજમાવો.';
  }

  @override
  String importSummary(int found) {
    return '$found મળી';
  }

  @override
  String importSummaryIn(String region) {
    return '$region માં';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count તપાસવાની છે';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count વાંચી શકાઈ નહીં';
  }

  @override
  String nothingReadable(int count) {
    return '$count સ્ક્રીનશૉટમાં વાંચવા જેવું કશું નથી';
  }

  @override
  String get couldNotOpenMaps => 'Maps ખોલી શકાયું નહીં';

  @override
  String get checkingAppleAccount => 'તમારું Apple ખાતું તપાસી રહ્યું છે…';

  @override
  String get restoredUnlocked =>
      'પુનઃસ્થાપિત થયું. કોઈ પણ કદની માર્ગદર્શિકા અનલૉક છે.';

  @override
  String get noPreviousPurchase => 'આ Apple ખાતા પર અગાઉની કોઈ ખરીદી મળી નહીં.';

  @override
  String get purchaseDidNotComplete =>
      'ખરીદી પૂરી થઈ નહીં, એટલે કશું વસૂલાયું નથી.';

  @override
  String alreadyInTheList(String name) {
    return '$name પહેલેથી જ યાદીમાં હતું.';
  }

  @override
  String get ocrUnavailable =>
      'સ્ક્રીનશૉટ વાંચવા માટે iPhone જોઈએ — આ પ્લૅટફૉર્મ પર લખાણ ઓળખ નથી.';

  @override
  String get lookupUnavailable =>
      'જગ્યા શોધવા માટે iPhone જોઈએ — આ પ્લૅટફૉર્મ પર નકશામાં શોધ નથી.';

  @override
  String get compAccess => 'સૌજન્ય પહોંચ';

  @override
  String get code => 'કોડ';

  @override
  String get unlock => 'અનલૉક કરો';

  @override
  String get compChecking => 'એ કોડ તપાસી રહ્યું છે…';

  @override
  String get compEnabled => 'સૌજન્ય પહોંચ ચાલુ થઈ.';

  @override
  String get compRefused => 'એ કોડ ઓળખાયો નહીં, અથવા તે વપરાઈ ચૂક્યો છે.';

  @override
  String get compTooOften =>
      'બહુ વધારે પ્રયાસ થયા. થોડી મિનિટ થોભીને ફરી પ્રયાસ કરો.';

  @override
  String get compUnreachable =>
      'સર્વર સુધી પહોંચી શકાયું નહીં. તમારું જોડાણ તપાસીને ફરી પ્રયાસ કરો.';

  @override
  String get compUntrusted =>
      'એ જવાબની ખાતરી થઈ શકી નહીં, એટલે કશું અનલૉક થયું નથી.';
}
