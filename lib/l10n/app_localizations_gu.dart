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
  String get emptyBodyAndroid =>
      'Open a list of places you already keep — a file exported from another map app, or a Google Takeout archive. CSV, KML, KMZ, GPX and GeoJSON are all read.';

  @override
  String get emptyNoteAndroid =>
      'Nothing leaves until you have looked at it. Wren then hands the list to a map app on the phone.';

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

  @override
  String get addPlaces => 'ઉમેરો';

  @override
  String get fromFile => 'ફાઇલમાંથી';

  @override
  String get fromExistingGuide => 'હયાત માર્ગદર્શિકામાંથી';

  @override
  String get importGuideTitle => 'હયાત માર્ગદર્શિકામાં ઉમેરો';

  @override
  String get importGuideBody =>
      'Apple Maps માં માર્ગદર્શિકા ખોલીને શેર કરો, પછી “લિંક કૉપિ કરો” પસંદ કરો. તેને નીચે પેસ્ટ કરો, Wren તેમાં પહેલેથી હોય તે જગ્યાઓ વાંચી લેશે.';

  @override
  String get guideLinkLabel => 'માર્ગદર્શિકાની લિંક';

  @override
  String get readGuide => 'માર્ગદર્શિકા વાંચો';

  @override
  String get importGuideNotALink =>
      'આ Apple Maps માર્ગદર્શિકાની લિંક નથી. માર્ગદર્શિકા Maps માં ખોલો, શેર કરો, પછી “લિંક કૉપિ કરો” પસંદ કરો.';

  @override
  String get importGuideNothing =>
      'એ માર્ગદર્શિકામાં Wren ઉમેરી શકે એવું કશું નથી.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'એ માર્ગદર્શિકામાંથી $count જગ્યાઓ વંચાઈ',
      one: 'એ માર્ગદર્શિકામાંથી ૧ જગ્યા વંચાઈ',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'તેમાંની $count જગ્યાઓ નવી માર્ગદર્શિકામાં લઈ જઈ શકાતી નથી',
      one: 'તેમાંની ૧ જગ્યા નવી માર્ગદર્શિકામાં લઈ જઈ શકાતી નથી',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count જગ્યાઓ પહેલેથી આ માર્ગદર્શિકામાં',
      one: '૧ જગ્યા પહેલેથી આ માર્ગદર્શિકામાં',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '“$name” માંથી';
  }

  @override
  String get republishTitle => 'Maps નવી માર્ગદર્શિકા બનાવે છે';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'પહેલેથી હોય તે માર્ગદર્શિકામાં ઉમેરવાનો કોઈ રસ્તો Apple આપતું નથી, એટલે Wren બધી $count જગ્યાઓ વાળી નવી માર્ગદર્શિકા બનાવશે.',
      one:
          'પહેલેથી હોય તે માર્ગદર્શિકામાં ઉમેરવાનો કોઈ રસ્તો Apple આપતું નથી, એટલે Wren ૧ જગ્યા વાળી નવી માર્ગદર્શિકા બનાવશે.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'નવી માર્ગદર્શિકા રાખો અને જૂની ભૂંસી નાખો.';

  @override
  String get republishKeepsPlaces =>
      'Wren આ જગ્યાઓ સાચવી રાખે છે, એટલે કંઈ ખોટું થાય તો માર્ગદર્શિકા ફરી બનાવી શકાય.';

  @override
  String get makeCombinedGuide => 'સંયુક્ત માર્ગદર્શિકા બનાવો';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'એ ફાઇલમાંથી $count જગ્યાઓ વંચાઈ',
      one: 'એ ફાઇલમાંથી ૧ જગ્યા વંચાઈ',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count પંક્તિઓમાં નામ નહોતું',
      one: '૧ પંક્તિમાં નામ નહોતું',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'એ ફાઇલમાં કોઈ જગ્યા નથી.';

  @override
  String get fileUnreadable =>
      'Wren એ ફાઇલ વાંચી શક્યું નહીં. તે CSV, KML, KMZ, GPX, GeoJSON અને Google Takeout એક્સપોર્ટ વાંચે છે.';

  @override
  String lookingUpProgress(int done, int total) {
    return '$total માંથી $done શોધી રહ્યું છે…';
  }

  @override
  String get combineNeedsUnlock =>
      'સંયુક્ત માર્ગદર્શિકા બનાવવા માટે અનલૉક જરૂરી છે.';

  @override
  String get unlockCombineTitle => 'તમારી હયાત માર્ગદર્શિકામાં ઉમેરો';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren એક જ માર્ગદર્શિકા બનાવશે, જેમાં તમારી માર્ગદર્શિકાની $count જગ્યાઓ અને નવી જગ્યાઓ, બંને હશે.',
      one:
          'Wren એક જ માર્ગદર્શિકા બનાવશે, જેમાં તમારી માર્ગદર્શિકાની ૧ જગ્યા અને નવી જગ્યા, બંને હશે.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'બીજી ઍપમાંથી એક્સપોર્ટ કરેલી યાદી પણ વાંચે છે: CSV, KML, KMZ, GPX, GeoJSON કે Google Takeout.';

  @override
  String get clearList => 'યાદી ખાલી કરો';

  @override
  String get clearListTitle => 'યાદી ખાલી કરો';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren માંથી બધી $count જગ્યાઓ દૂર કરવી છે? Apple Maps માં પહેલેથી બનેલી માર્ગદર્શિકાઓ પર કોઈ અસર થતી નથી.',
      one:
          'Wren માંથી એ એક જગ્યા દૂર કરવી છે? Apple Maps માં પહેલેથી બનેલી માર્ગદર્શિકાઓ પર કોઈ અસર થતી નથી.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'દૂર કરો';

  @override
  String get listCleared => 'યાદી ખાલી થઈ.';

  @override
  String get expandingLink => 'એ લિંક વાંચી રહ્યું છે…';

  @override
  String get linkUnreachable =>
      'એ લિંક વાંચવા માટે Apple સુધી પહોંચી શકાયું નહીં. તમારું જોડાણ તપાસીને ફરી પ્રયાસ કરો.';

  @override
  String get splitTitle => 'આનાથી એકથી વધુ માર્ગદર્શિકા બનશે';

  @override
  String splitBody(int guides, int count) {
    return 'એક માર્ગદર્શિકાની લિંક કેટલી જગ્યાઓ સમાવી શકે તેની મર્યાદા Apple રાખે છે. Wren $guides માર્ગદર્શિકા બનાવશે, ક્રમ જળવાય એ માટે તેમના પર નંબર હશે, અને તે બધીમાં મળીને $count જગ્યાઓ હશે.';
  }

  @override
  String splitConfirm(int guides) {
    return '$guides માર્ગદર્શિકા બનાવો';
  }

  @override
  String splitProgress(int done, int total) {
    return '$total માંથી $done માર્ગદર્શિકા ખૂલી. પછીની બનાવવા ટૅપ કરો.';
  }

  @override
  String get sendPlacesTo => 'સ્થળો મોકલો';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count સ્થળો મોકલવા તૈયાર',
      one: '1 સ્થળ મોકલવા તૈયાર',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count સ્થળોનું સ્થાન નથી, મોકલી શકાય નહીં',
      one: '1 સ્થળનું સ્થાન નથી, મોકલી શકાય નહીં',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'કોઈ પણ બીજી ઍપ';

  @override
  String get sendPlacesFailed => 'તે ઍપે ફાઇલ સ્વીકારી નહીં';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ફાઇલમાંથી $count સ્થળો રાખ્યાં, બીજી નકશા ઍપમાં મોકલવા તૈયાર',
      one: 'ફાઇલમાંથી 1 સ્થળ રાખ્યું, બીજી નકશા ઍપમાં મોકલવા તૈયાર',
    );
    return '$_temp0';
  }
}
