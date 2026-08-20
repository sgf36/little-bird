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
  String get emptyBodyAndroid =>
      'Screenshot what people tell you about — a reel, a post, a message, a page of a guidebook. Wren reads the names and sends them to the map app on your phone.';

  @override
  String get emptyNoteAndroid =>
      'It also reads a list you already have, and shows you every place before anything leaves.';

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
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count देखनी हैं',
      one: '$count देखनी है',
    );
    return '$_temp0';
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
  String get compAccess => 'मुफ़्त पहुँच';

  @override
  String get code => 'कोड';

  @override
  String get unlock => 'अनलॉक करें';

  @override
  String get compChecking => 'वह कोड जाँचा जा रहा है…';

  @override
  String get compEnabled => 'मुफ़्त पहुँच चालू हो गई।';

  @override
  String get compRefused =>
      'यह कोड पहचाना नहीं गया, या पहले से इस्तेमाल हो चुका है।';

  @override
  String get compTooOften =>
      'बहुत बार कोशिश हो गई। कुछ मिनट रुककर फिर कोशिश कीजिए।';

  @override
  String get compUnreachable =>
      'सर्वर तक नहीं पहुँचा जा सका। अपना कनेक्शन जाँचकर फिर कोशिश कीजिए।';

  @override
  String get compUntrusted =>
      'उस जवाब की पुष्टि नहीं हो सकी, इसलिए कुछ भी अनलॉक नहीं हुआ।';

  @override
  String get addPlaces => 'जोड़ें';

  @override
  String get fromFile => 'फ़ाइल से';

  @override
  String get fromExistingGuide => 'पहले से मौजूद गाइड से';

  @override
  String get importGuideTitle => 'पहले से मौजूद गाइड में जोड़ें';

  @override
  String get importGuideBody =>
      'Apple Maps में गाइड खोलिए और उसे शेयर कीजिए, फिर “लिंक कॉपी करें” चुनिए। उसे नीचे पेस्ट कीजिए और Wren उसमें पहले से मौजूद जगहें पढ़ लेगा।';

  @override
  String get guideLinkLabel => 'गाइड का लिंक';

  @override
  String get readGuide => 'गाइड पढ़ें';

  @override
  String get importGuideNotALink =>
      'यह Apple Maps गाइड का लिंक नहीं है। गाइड को Maps में खोलिए, उसे शेयर कीजिए, फिर “लिंक कॉपी करें” चुनिए।';

  @override
  String get importGuideNothing =>
      'उस गाइड में ऐसा कुछ नहीं है जिसे Wren जोड़ सके।';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'उस गाइड से $count जगहें पढ़ीं',
      one: 'उस गाइड से 1 जगह पढ़ी',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'उसमें की $count जगहें नई गाइड में नहीं जा सकतीं',
      one: 'उसमें की 1 जगह नई गाइड में नहीं जा सकती',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count जगहें पहले से इस गाइड में',
      one: '1 जगह पहले से इस गाइड में',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '“$name” से';
  }

  @override
  String get republishTitle => 'Maps नई गाइड बनाता है';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple पहले से मौजूद गाइड में जोड़ने का कोई रास्ता नहीं देता, इसलिए Wren सभी $count जगहों वाली नई गाइड बनाएगा।',
      one:
          'Apple पहले से मौजूद गाइड में जोड़ने का कोई रास्ता नहीं देता, इसलिए Wren 1 जगह वाली नई गाइड बनाएगा।',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'नई गाइड रखिए और पुरानी हटा दीजिए।';

  @override
  String get republishKeepsPlaces =>
      'Wren इन जगहों को रखता है, इसलिए कुछ गलत हो जाए तो गाइड फिर बना सकते हैं।';

  @override
  String get makeCombinedGuide => 'संयुक्त गाइड बनाएँ';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'उस फ़ाइल से $count जगहें पढ़ीं',
      one: 'उस फ़ाइल से 1 जगह पढ़ी',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count पंक्तियों में नाम नहीं था',
      one: '1 पंक्ति में नाम नहीं था',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'उस फ़ाइल में कोई जगह नहीं।';

  @override
  String get fileUnreadable =>
      'Wren वह फ़ाइल नहीं पढ़ सका। वह CSV, KML, KMZ, GPX, GeoJSON और Google Takeout एक्सपोर्ट पढ़ता है।';

  @override
  String lookingUpProgress(int done, int total) {
    return '$total में से $done खोजे जा रहे हैं…';
  }

  @override
  String get combineNeedsUnlock => 'संयुक्त गाइड बनाने के लिए अनलॉक चाहिए।';

  @override
  String get unlockCombineTitle => 'अपनी पहले से मौजूद गाइड में जोड़ें';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren एक ही गाइड बनाएगा, जिसमें आपकी गाइड की $count जगहें और नई जगहें, दोनों होंगी।',
      one:
          'Wren एक ही गाइड बनाएगा, जिसमें आपकी गाइड की 1 जगह और नई जगह, दोनों होंगी।',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'किसी दूसरे ऐप से एक्सपोर्ट की गई सूची भी पढ़ता है: CSV, KML, KMZ, GPX, GeoJSON या Google Takeout।';

  @override
  String get clearList => 'सूची खाली करें';

  @override
  String get clearListTitle => 'सूची खाली करें';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren से सभी $count जगहें हटा दें? Apple Maps में पहले बनाई गई गाइड पर कोई असर नहीं पड़ता।',
      one:
          'Wren से वह एक जगह हटा दें? Apple Maps में पहले बनाई गई गाइड पर कोई असर नहीं पड़ता।',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'हटाएँ';

  @override
  String get listCleared => 'सूची खाली हो गई।';

  @override
  String get expandingLink => 'वह लिंक पढ़ा जा रहा है…';

  @override
  String get linkUnreachable =>
      'उस लिंक को पढ़ने के लिए Apple तक नहीं पहुँचा जा सका। अपना कनेक्शन जाँचकर फिर कोशिश कीजिए।';

  @override
  String get splitTitle => 'इससे एक से ज़्यादा गाइड बनेंगी';

  @override
  String splitBody(int guides, int count) {
    return 'Apple यह सीमित रखता है कि एक गाइड लिंक में कितनी जगहें आ सकती हैं। Wren $guides गाइड बनाएगा, क्रम बना रहे इसलिए उन पर नंबर होंगे, और उन सबमें मिलाकर $count जगहें होंगी।';
  }

  @override
  String splitConfirm(int guides) {
    return '$guides गाइड बनाएँ';
  }

  @override
  String splitProgress(int done, int total) {
    return '$total में से $done गाइड खुल गई। अगली बनाने के लिए टैप करें।';
  }

  @override
  String get sendPlacesTo => 'जगहें भेजें';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count जगहें भेजने के लिए तैयार',
      one: '1 जगह भेजने के लिए तैयार',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count जगहों की लोकेशन नहीं है, इसलिए भेजी नहीं जा सकतीं',
      one: '1 जगह की लोकेशन नहीं है, इसलिए भेजी नहीं जा सकती',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'कोई दूसरा ऐप';

  @override
  String get sendPlacesFailed => 'उस ऐप ने फ़ाइल नहीं ली';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'फ़ाइल से $count जगहें रखी गईं, दूसरे मैप ऐप में भेजने के लिए तैयार',
      one: 'फ़ाइल से 1 जगह रखी गई, दूसरे मैप ऐप में भेजने के लिए तैयार',
    );
    return '$_temp0';
  }
}
