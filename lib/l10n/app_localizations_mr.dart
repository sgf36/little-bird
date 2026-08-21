// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class LMr extends L {
  LMr([String locale = 'mr']) : super(locale);

  @override
  String get tagline => 'एका चिमणीने सांगितलं.';

  @override
  String get emptyTitle => 'ठिकाणं, जपून.';

  @override
  String get emptyBody =>
      'कोणी सुचवलेल्या गोष्टीचा स्क्रीनशॉट घ्या — रील, पोस्ट, संदेश किंवा प्रवासी पुस्तकाचं पान. Wren नावं वाचतो आणि ती Apple Maps मध्ये ठेवतो.';

  @override
  String get emptyNote =>
      'एकच ठिकाण तुमच्याकडे आधीपासून असलेल्या मार्गदर्शिकेत जोडलं जातं. अनेक ठिकाणांची नवी मार्गदर्शिका होते — Apple Maps मार्गदर्शिका एकत्र करू शकत नाही.';

  @override
  String get emptyBodyAndroid =>
      'कोणी सुचवलेल्या गोष्टीचा स्क्रीनशॉट घ्या — रील, पोस्ट, संदेश किंवा प्रवासी पुस्तकाचं पान. Wren नावं वाचतो आणि ती तुमच्या फोनवरील नकाशा ॲपला पाठवतो.';

  @override
  String get emptyNoteAndroid =>
      'तुमच्याकडे आधीच असलेली यादीही ते वाचते, आणि काहीही पाठवण्याआधी प्रत्येक ठिकाण दाखवते.';

  @override
  String get addScreenshots => 'स्क्रीनशॉट जोडा';

  @override
  String get readingShort => 'वाचत आहे…';

  @override
  String readingProgress(int done, int total) {
    return '$total पैकी $done वाचत आहे…';
  }

  @override
  String get addToGuide => 'मार्गदर्शिकेत जोडा';

  @override
  String makeGuide(int count) {
    return 'मार्गदर्शिका तयार करा ($count)';
  }

  @override
  String get notFoundOnMap => 'नकाशावर सापडलं नाही';

  @override
  String get tapToSearchForIt => 'शोधण्यासाठी टॅप करा';

  @override
  String readAs(String text) {
    return 'असं वाचलं गेलं: “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ठिकाणं सापडली नाहीत. शोधण्यासाठी टॅप करा.',
      one: '१ ठिकाण सापडलं नाही. शोधण्यासाठी टॅप करा.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'ही ठिकाणं कुठे आहेत?';

  @override
  String get regionDetected => 'मथळ्यांतून वाचलं. चुकीचं असल्यास बदला.';

  @override
  String get regionNotDetected =>
      'स्क्रीनशॉटमध्ये ही कुठे आहेत ते लिहिलेलं नव्हतं. शहर दिल्यास शोध खूपच अचूक होतो.';

  @override
  String get cityOrRegion => 'शहर किंवा प्रदेश';

  @override
  String get cityExample => 'उदा. मुंबई';

  @override
  String get searchAnywhere => 'सगळीकडे शोधा';

  @override
  String get findPlaces => 'ठिकाणं शोधा';

  @override
  String searchedIn(String region) {
    return '$region मध्ये शोधलं';
  }

  @override
  String get nameThisGuide => 'या मार्गदर्शिकेला नाव द्या';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ती Apple Maps मध्ये याच नावाने दिसेल, त्यात $count ठिकाणं असतील.',
      one: 'ती Apple Maps मध्ये याच नावाने दिसेल, त्यात १ ठिकाण असेल.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'मार्गदर्शिकेचं नाव';

  @override
  String get guideNameExample => 'उदा. रोम, ऑक्टोबर';

  @override
  String get createGuide => 'मार्गदर्शिका तयार करा';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get guidesOfAnySize => 'कितीही मोठ्या मार्गदर्शिका';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren एका मार्गदर्शिकेत मोफत $limit ठिकाणांपर्यंत जतन करतो. तुम्ही $selected निवडली आहेत — $over जास्त.';
  }

  @override
  String get onePaymentKept => 'एकदाच पैसे, कायमचं तुमचं. वर्गणी नाही.';

  @override
  String unlockFor(String price) {
    return '$price मध्ये अनलॉक करा';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'त्याऐवजी पहिली $limit जतन करा';
  }

  @override
  String get restorePrevious => 'आधीची खरेदी परत मिळवा';

  @override
  String get restorePurchase => 'खरेदी परत मिळवा';

  @override
  String overFreeLimit(int over, int limit) {
    return 'मोफत मर्यादा $limit पेक्षा $over जास्त. तुम्ही अनलॉक करू शकता, किंवा पहिली $limit जतन करू शकता.';
  }

  @override
  String get findThisPlace => 'हे ठिकाण शोधा';

  @override
  String get searchAppleMaps => 'Apple Maps मध्ये शोधा';

  @override
  String searchInRegion(String region) {
    return '$region मध्ये शोधा';
  }

  @override
  String get searching => 'शोधत आहे…';

  @override
  String get typeTwoCharacters => 'किमान दोन अक्षरं टाइप करा.';

  @override
  String get nothingFound =>
      'काहीच सापडलं नाही. रस्त्याचं नाव, किंवा लहान नाव वापरून पाहा.';

  @override
  String get rateLimited =>
      'Apple Maps शोधांवर मर्यादा घालत आहे. थोडं थांबून पुन्हा प्रयत्न करा.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps शोधांवर मर्यादा घालत आहे — आतापर्यंत $added जोडली, बाकीची थोड्या वेळाने पाहा.';
  }

  @override
  String importSummary(int found) {
    return '$found सापडली';
  }

  @override
  String importSummaryIn(String region) {
    return '$region मध्ये';
  }

  @override
  String importSummaryNeedLook(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count तपासायची आहेत',
      one: '$count तपासायची आहे',
    );
    return '$_temp0';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count वाचता आली नाहीत';
  }

  @override
  String nothingReadable(int count) {
    return '$count स्क्रीनशॉटमध्ये वाचण्यासारखं काहीच नाही';
  }

  @override
  String get couldNotOpenMaps => 'Maps उघडता आलं नाही';

  @override
  String get checkingAppleAccount => 'तुमचं Apple खातं तपासत आहे…';

  @override
  String get restoredUnlocked =>
      'परत मिळालं. कितीही मोठ्या मार्गदर्शिका अनलॉक झाल्या आहेत.';

  @override
  String get noPreviousPurchase =>
      'या Apple खात्यावर आधीची कोणतीही खरेदी सापडली नाही.';

  @override
  String get purchaseDidNotComplete =>
      'खरेदी पूर्ण झाली नाही, त्यामुळे काहीही आकारलं गेलं नाही.';

  @override
  String alreadyInTheList(String name) {
    return '$name आधीपासूनच यादीत होतं.';
  }

  @override
  String get ocrUnavailable =>
      'स्क्रीनशॉट वाचण्यासाठी iPhone लागतो — या प्लॅटफॉर्मवर मजकूर ओळख नाही.';

  @override
  String get lookupUnavailable =>
      'ठिकाणं शोधण्यासाठी iPhone लागतो — या प्लॅटफॉर्मवर नकाशावरचा शोध नाही.';

  @override
  String get compAccess => 'मोफत प्रवेश';

  @override
  String get code => 'कोड';

  @override
  String get unlock => 'अनलॉक करा';

  @override
  String get compChecking => 'तो कोड तपासत आहे…';

  @override
  String get compEnabled => 'मोफत प्रवेश सुरू झाला.';

  @override
  String get compRefused =>
      'हा कोड ओळखता आला नाही, किंवा तो आधीच वापरला गेला आहे.';

  @override
  String get compTooOften =>
      'खूप वेळा प्रयत्न झाले. काही मिनिटं थांबून पुन्हा प्रयत्न करा.';

  @override
  String get compUnreachable =>
      'सर्व्हरशी संपर्क होऊ शकला नाही. तुमचं कनेक्शन तपासून पुन्हा प्रयत्न करा.';

  @override
  String get compUntrusted =>
      'त्या उत्तराची खात्री करता आली नाही, त्यामुळे काहीही अनलॉक झालं नाही.';

  @override
  String get addPlaces => 'जोडा';

  @override
  String get fromFile => 'फाइलमधून';

  @override
  String get fromExistingGuide => 'आधीच्या मार्गदर्शिकेतून';

  @override
  String get importGuideTitle => 'आधीच्या मार्गदर्शिकेत जोडा';

  @override
  String get importGuideBody =>
      'Apple Maps मध्ये मार्गदर्शिका उघडून ती शेअर करा, नंतर “लिंक कॉपी करा” निवडा. ती खाली पेस्ट करा, Wren त्यात आधीपासून असलेली ठिकाणं वाचून घेईल.';

  @override
  String get guideLinkLabel => 'मार्गदर्शिकेची लिंक';

  @override
  String get readGuide => 'मार्गदर्शिका वाचा';

  @override
  String get importGuideNotALink =>
      'ही Apple Maps मार्गदर्शिकेची लिंक नाही. मार्गदर्शिका Maps मध्ये उघडा, शेअर करा, नंतर “लिंक कॉपी करा” निवडा.';

  @override
  String get importGuideNothing =>
      'त्या मार्गदर्शिकेत Wren जोडू शकेल असं काहीच नाही.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'त्या मार्गदर्शिकेतून $count ठिकाणं वाचली',
      one: 'त्या मार्गदर्शिकेतून १ ठिकाण वाचलं',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'त्यातली $count ठिकाणं नव्या मार्गदर्शिकेत नेता येत नाहीत',
      one: 'त्यातलं १ ठिकाण नव्या मार्गदर्शिकेत नेता येत नाही',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ठिकाणं आधीपासून या मार्गदर्शिकेत',
      one: '१ ठिकाण आधीपासून या मार्गदर्शिकेत',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '“$name” मधून';
  }

  @override
  String get republishTitle => 'Maps नवी मार्गदर्शिका तयार करतं';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'आधीपासून असलेल्या मार्गदर्शिकेत भर घालण्याचा कोणताही मार्ग Apple देत नाही, म्हणून Wren सगळी $count ठिकाणं असलेली नवी मार्गदर्शिका तयार करेल.',
      one:
          'आधीपासून असलेल्या मार्गदर्शिकेत भर घालण्याचा कोणताही मार्ग Apple देत नाही, म्हणून Wren १ ठिकाण असलेली नवी मार्गदर्शिका तयार करेल.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'नवी मार्गदर्शिका ठेवा आणि जुनी काढून टाका.';

  @override
  String get republishKeepsPlaces =>
      'Wren ही ठिकाणं जपून ठेवतो, म्हणून काही चुकलं तर मार्गदर्शिका पुन्हा तयार करता येते.';

  @override
  String get makeCombinedGuide => 'एकत्रित मार्गदर्शिका तयार करा';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'त्या फाइलमधून $count ठिकाणं वाचली',
      one: 'त्या फाइलमधून १ ठिकाण वाचलं',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ओळींमध्ये नाव नव्हतं',
      one: '१ ओळीत नाव नव्हतं',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'त्या फाइलमध्ये एकही ठिकाण नाही.';

  @override
  String get fileUnreadable =>
      'Wren ती फाइल वाचू शकला नाही. तो CSV, KML, KMZ, GPX, GeoJSON आणि Google Takeout एक्सपोर्ट वाचतो.';

  @override
  String lookingUpProgress(int done, int total) {
    return '$total पैकी $done शोधत आहे…';
  }

  @override
  String get combineNeedsUnlock =>
      'एकत्रित मार्गदर्शिका तयार करण्यासाठी अनलॉक आवश्यक आहे.';

  @override
  String get unlockCombineTitle => 'तुमच्या आधीच्या मार्गदर्शिकेत जोडा';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren एकच मार्गदर्शिका तयार करेल, ज्यात तुमच्या मार्गदर्शिकेतली $count ठिकाणं आणि नवी ठिकाणं, दोन्ही असतील.',
      one:
          'Wren एकच मार्गदर्शिका तयार करेल, ज्यात तुमच्या मार्गदर्शिकेतलं १ ठिकाण आणि नवं ठिकाण, दोन्ही असतील.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'दुसऱ्या ॲपमधून एक्सपोर्ट केलेली यादीही वाचतो: CSV, KML, KMZ, GPX, GeoJSON किंवा Google Takeout.';

  @override
  String get clearList => 'यादी रिकामी करा';

  @override
  String get clearListTitle => 'यादी रिकामी करा';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren मधून सगळी $count ठिकाणं काढून टाकायची? Apple Maps मध्ये आधीच तयार केलेल्या मार्गदर्शिकांवर काहीही परिणाम होत नाही.',
      one:
          'Wren मधून ते एक ठिकाण काढून टाकायचं? Apple Maps मध्ये आधीच तयार केलेल्या मार्गदर्शिकांवर काहीही परिणाम होत नाही.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'काढा';

  @override
  String get listCleared => 'यादी रिकामी झाली.';

  @override
  String get expandingLink => 'ती लिंक वाचत आहे…';

  @override
  String get linkUnreachable =>
      'ती लिंक वाचण्यासाठी Apple शी संपर्क होऊ शकला नाही. तुमचं कनेक्शन तपासून पुन्हा प्रयत्न करा.';

  @override
  String get splitTitle => 'यातून एकापेक्षा जास्त मार्गदर्शिका तयार होतील';

  @override
  String splitBody(int guides, int count) {
    return 'एका मार्गदर्शिकेच्या लिंकमध्ये किती ठिकाणं येऊ शकतात यावर Apple मर्यादा ठेवतं. Wren $guides मार्गदर्शिका तयार करेल, क्रम टिकावा म्हणून त्यांना क्रमांक दिले जातील, आणि त्या सगळ्यांत मिळून $count ठिकाणं असतील.';
  }

  @override
  String splitConfirm(int guides) {
    return '$guides मार्गदर्शिका तयार करा';
  }

  @override
  String splitProgress(int done, int total) {
    return '$total पैकी $done मार्गदर्शिका उघडली. पुढची तयार करण्यासाठी टॅप करा.';
  }

  @override
  String get sendPlacesTo => 'ठिकाणे पाठवा';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ठिकाणे पाठवायला तयार',
      one: '1 ठिकाण पाठवायला तयार',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ठिकाणांना स्थान नाही, ती पाठवता येणार नाहीत',
      one: '1 ठिकाणाला स्थान नाही, ते पाठवता येणार नाही',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'दुसरे कोणतेही ॲप';

  @override
  String get sendPlacesFailed => 'त्या ॲपने फाइल घेतली नाही';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'फाइलमधून $count ठिकाणे ठेवली, दुसऱ्या नकाशा ॲपला पाठवायला तयार',
      one: 'फाइलमधून 1 ठिकाण ठेवले, दुसऱ्या नकाशा ॲपला पाठवायला तयार',
    );
    return '$_temp0';
  }

  @override
  String get compExpiring =>
      'Wren तुमचा मोफत प्रवेश सत्यापित करू शकले नाही. तो टिकवण्यासाठी पुढील काही दिवसांत इंटरनेटशी कनेक्ट करा.';
}
