// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class LHi extends L {
  LHi([String locale = 'hi']) : super(locale);

  @override
  String get tagline => 'एक चिड़िया ने बताया।';

  @override
  String get emptyTitle => 'जगहें, संभाल कर।';

  @override
  String get emptyBody =>
      'जो कोई आपको बताए, उसका स्क्रीनशॉट ले लीजिए — रील, पोस्ट, मैसेज, या गाइडबुक का कोई पन्ना। Wren नाम पढ़ लेता है और उन्हें Apple Maps में डाल देता है।';

  @override
  String get emptyNote =>
      'एक जगह आपकी पहले से मौजूद गाइड में जुड़ जाती है। कई जगहें नई गाइड बनाती हैं — Apple Maps गाइड आपस में नहीं मिला सकता।';

  @override
  String get addScreenshots => 'स्क्रीनशॉट जोड़ें';

  @override
  String get readingShort => 'पढ़ा जा रहा है…';

  @override
  String readingProgress(int done, int total) {
    return '$total में से $done पढ़े जा रहे हैं…';
  }

  @override
  String get addToGuide => 'किसी गाइड में जोड़ें';

  @override
  String makeGuide(int count) {
    return 'गाइड बनाएँ ($count)';
  }

  @override
  String get notFoundOnMap => 'नक्शे पर नहीं मिला';

  @override
  String get tapToSearchForIt => 'खोजने के लिए टैप करें';

  @override
  String readAs(String text) {
    return 'इस रूप में पढ़ा गया: “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count जगहें नहीं मिलीं। खोजने के लिए टैप करें।',
      one: '1 जगह नहीं मिली। खोजने के लिए टैप करें।',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'ये जगहें कहाँ हैं?';

  @override
  String get regionDetected => 'कैप्शन से पढ़ा गया। गलत हो तो बदल दीजिए।';

  @override
  String get regionNotDetected =>
      'स्क्रीनशॉट में यह नहीं लिखा था कि ये कहाँ हैं। शहर बताने से खोज कहीं ज़्यादा सही होती है।';

  @override
  String get cityOrRegion => 'शहर या इलाका';

  @override
  String get cityExample => 'जैसे मुंबई';

  @override
  String get searchAnywhere => 'हर जगह खोजें';

  @override
  String get findPlaces => 'जगहें खोजें';

  @override
  String searchedIn(String region) {
    return '$region में खोजा गया';
  }

  @override
  String get nameThisGuide => 'इस गाइड को नाम दीजिए';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'यह Apple Maps में इसी नाम से दिखेगी, इसमें $count जगहें होंगी।',
      one: 'यह Apple Maps में इसी नाम से दिखेगी, इसमें 1 जगह होगी।',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'गाइड का नाम';

  @override
  String get guideNameExample => 'जैसे रोम, अक्टूबर';

  @override
  String get createGuide => 'गाइड बनाएँ';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get guidesOfAnySize => 'किसी भी आकार की गाइड';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren एक गाइड में मुफ़्त में $limit जगहें तक सहेजता है। आपने $selected चुनी हैं — $over ज़्यादा।';
  }

  @override
  String get onePaymentKept =>
      'एक बार का भुगतान, हमेशा के लिए आपका। कोई सदस्यता नहीं।';

  @override
  String unlockFor(String price) {
    return '$price में अनलॉक करें';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'इसके बजाय पहली $limit सहेजें';
  }

  @override
  String get restorePrevious => 'पहले की खरीद बहाल करें';

  @override
  String get restorePurchase => 'खरीद बहाल करें';

  @override
  String overFreeLimit(int over, int limit) {
    return 'मुफ़्त सीमा $limit से $over ज़्यादा। आप अनलॉक कर सकते हैं, या पहली $limit सहेज सकते हैं।';
  }

  @override
  String get findThisPlace => 'यह जगह खोजें';

  @override
  String get searchAppleMaps => 'Apple Maps में खोजें';

  @override
  String searchInRegion(String region) {
    return '$region में खोजें';
  }

  @override
  String get searching => 'खोजा जा रहा है…';

  @override
  String get typeTwoCharacters => 'कम से कम दो अक्षर लिखिए।';

  @override
  String get nothingFound => 'कुछ नहीं मिला। सड़क का नाम, या छोटा नाम आज़माइए।';

  @override
  String get rateLimited =>
      'Apple Maps खोजों पर रोक लगा रहा है। थोड़ा रुककर फिर कोशिश कीजिए।';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps खोजों पर रोक लगा रहा है — अब तक $added जुड़ीं, बाकी थोड़ी देर में आज़माइए।';
  }

  @override
  String importSummary(int found) {
    return '$found मिलीं';
  }

  @override
  String importSummaryIn(String region) {
    return '$region में';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count देखनी हैं';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count पढ़ी नहीं गईं';
  }

  @override
  String nothingReadable(int count) {
    return '$count स्क्रीनशॉट में पढ़ने लायक कुछ नहीं';
  }

  @override
  String get couldNotOpenMaps => 'Maps नहीं खुल सका';

  @override
  String get checkingAppleAccount => 'आपका Apple खाता जाँचा जा रहा है…';

  @override
  String get restoredUnlocked => 'बहाल हो गया। किसी भी आकार की गाइड अनलॉक हैं।';

  @override
  String get noPreviousPurchase =>
      'इस Apple खाते पर पहले की कोई खरीद नहीं मिली।';

  @override
  String get purchaseDidNotComplete =>
      'खरीद पूरी नहीं हुई, इसलिए कुछ भी नहीं लिया गया।';

  @override
  String alreadyInTheList(String name) {
    return '$name पहले से सूची में था।';
  }

  @override
  String get ocrUnavailable =>
      'स्क्रीनशॉट पढ़ने के लिए iPhone चाहिए — इस प्लैटफ़ॉर्म पर टेक्स्ट पहचान नहीं है।';

  @override
  String get lookupUnavailable =>
      'जगह खोजने के लिए iPhone चाहिए — इस प्लैटफ़ॉर्म पर नक्शे में खोज नहीं है।';

  @override
  String get reviewerAccess => 'समीक्षक पहुँच';

  @override
  String get code => 'कोड';

  @override
  String get unlock => 'अनलॉक करें';

  @override
  String get reviewerEnabled => 'समीक्षक पहुँच चालू हो गई।';

  @override
  String get codeNotRecognised => 'यह कोड पहचाना नहीं गया।';
}
