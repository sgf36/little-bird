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
    return '$count तपासायची आहेत';
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
  String get reviewerAccess => 'परीक्षकाचा प्रवेश';

  @override
  String get code => 'कोड';

  @override
  String get unlock => 'अनलॉक करा';

  @override
  String get reviewerEnabled => 'परीक्षकाचा प्रवेश सुरू झाला.';

  @override
  String get codeNotRecognised => 'हा कोड ओळखता आला नाही.';
}
