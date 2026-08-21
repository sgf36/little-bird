// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class LBn extends L {
  LBn([String locale = 'bn']) : super(locale);

  @override
  String get tagline => 'একটা ছোট্ট পাখি বলে গেল।';

  @override
  String get emptyTitle => 'জায়গা, তুলে রাখা।';

  @override
  String get emptyBody =>
      'কেউ যা বলল তার স্ক্রিনশট নিন — একটা রিল, একটা পোস্ট, একটা বার্তা, ভ্রমণ-গাইডের একটা পাতা। Wren নামগুলো পড়ে নেয় আর Apple Maps-এ রেখে দেয়।';

  @override
  String get emptyNote =>
      'একটা জায়গা আপনার আগের কোনো গাইডেই যোগ হয়। কয়েকটা হলে নতুন গাইড তৈরি হয় — Apple Maps গাইড একসঙ্গে জুড়তে পারে না।';

  @override
  String get emptyBodyAndroid =>
      'কেউ যা বলল তার স্ক্রিনশট নিন — একটা রিল, একটা পোস্ট, একটা বার্তা, ভ্রমণ-গাইডের একটা পাতা। Wren নামগুলো পড়ে নেয় আর সেগুলো ফোনের ম্যাপ অ্যাপে পাঠিয়ে দেয়।';

  @override
  String get emptyNoteAndroid =>
      'এটি আপনার কাছে থাকা তালিকাও পড়ে নেয়, আর কিছু পাঠানোর আগে প্রতিটি জায়গা দেখিয়ে দেয়।';

  @override
  String get addScreenshots => 'স্ক্রিনশট যোগ করুন';

  @override
  String get readingShort => 'পড়া হচ্ছে…';

  @override
  String readingProgress(int done, int total) {
    return '$totalটির মধ্যে $doneটি পড়া হচ্ছে…';
  }

  @override
  String get addToGuide => 'একটি গাইডে যোগ করুন';

  @override
  String makeGuide(int count) {
    return 'গাইড তৈরি করুন ($count)';
  }

  @override
  String get notFoundOnMap => 'মানচিত্রে পাওয়া যায়নি';

  @override
  String get tapToSearchForIt => 'খুঁজতে ট্যাপ করুন';

  @override
  String readAs(String text) {
    return 'যেভাবে পড়া হয়েছে: “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি জায়গা পাওয়া যায়নি। খুঁজতে ট্যাপ করুন।',
      one: '১টি জায়গা পাওয়া যায়নি। খুঁজতে ট্যাপ করুন।',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'এই জায়গাগুলো কোথায়?';

  @override
  String get regionDetected => 'ক্যাপশন থেকে পড়া হয়েছে। ভুল হলে বদলে দিন।';

  @override
  String get regionNotDetected =>
      'স্ক্রিনশটে লেখা ছিল না এগুলো কোথায়। শহরের নাম দিলে খোঁজা অনেক বেশি নিখুঁত হয়।';

  @override
  String get cityOrRegion => 'শহর বা অঞ্চল';

  @override
  String get cityExample => 'যেমন ঢাকা';

  @override
  String get searchAnywhere => 'সব জায়গায় খুঁজুন';

  @override
  String get findPlaces => 'জায়গা খুঁজুন';

  @override
  String searchedIn(String region) {
    return '$region-এ খোঁজা হয়েছে';
  }

  @override
  String get nameThisGuide => 'এই গাইডের নাম দিন';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'এই নামেই Apple Maps-এ দেখা যাবে, ভেতরে $countটি জায়গা থাকবে।',
      one: 'এই নামেই Apple Maps-এ দেখা যাবে, ভেতরে ১টি জায়গা থাকবে।',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'গাইডের নাম';

  @override
  String get guideNameExample => 'যেমন রোম, অক্টোবর';

  @override
  String get createGuide => 'গাইড তৈরি করুন';

  @override
  String get cancel => 'বাতিল';

  @override
  String get guidesOfAnySize => 'যেকোনো আকারের গাইড';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren একটি গাইডে বিনামূল্যে $limitটি পর্যন্ত জায়গা রাখে। আপনি $selectedটি বেছেছেন — $overটি বেশি।';
  }

  @override
  String get onePaymentKept =>
      'একবারের খরচ, চিরকালের জন্য আপনার। কোনো সাবস্ক্রিপশন নেই।';

  @override
  String unlockFor(String price) {
    return '$price-এ আনলক করুন';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'বরং প্রথম $limitটি রাখুন';
  }

  @override
  String get restorePrevious => 'আগের কেনা ফিরিয়ে আনুন';

  @override
  String get restorePurchase => 'কেনা ফিরিয়ে আনুন';

  @override
  String overFreeLimit(int over, int limit) {
    return 'বিনামূল্যের সীমা $limit-এর চেয়ে $overটি বেশি। আনলক করতে পারেন, বা প্রথম $limitটি রাখতে পারেন।';
  }

  @override
  String get findThisPlace => 'এই জায়গাটি খুঁজুন';

  @override
  String get searchAppleMaps => 'Apple Maps-এ খুঁজুন';

  @override
  String searchInRegion(String region) {
    return '$region-এ খুঁজুন';
  }

  @override
  String get searching => 'খোঁজা হচ্ছে…';

  @override
  String get typeTwoCharacters => 'অন্তত দুটি অক্ষর লিখুন।';

  @override
  String get nothingFound =>
      'কিছুই পাওয়া যায়নি। রাস্তার নাম, বা ছোট কোনো নাম দিয়ে দেখুন।';

  @override
  String get rateLimited =>
      'Apple Maps খোঁজার সংখ্যা সীমিত করছে। একটু থেমে আবার চেষ্টা করুন।';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps খোঁজার সংখ্যা সীমিত করছে — এ পর্যন্ত $addedটি যোগ হয়েছে, বাকিগুলো একটু পরে দেখুন।';
  }

  @override
  String importSummary(int found) {
    return '$foundটি পাওয়া গেছে';
  }

  @override
  String importSummaryIn(String region) {
    return '$region-এ';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$countটি দেখা দরকার';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$countটি পড়া যায়নি';
  }

  @override
  String nothingReadable(int count) {
    return '$countটি স্ক্রিনশটে পড়ার মতো কিছু নেই';
  }

  @override
  String get couldNotOpenMaps => 'Maps খোলা গেল না';

  @override
  String get checkingAppleAccount => 'আপনার Apple অ্যাকাউন্ট দেখা হচ্ছে…';

  @override
  String get restoredUnlocked =>
      'ফিরিয়ে আনা হয়েছে। যেকোনো আকারের গাইড আনলক হয়েছে।';

  @override
  String get noPreviousPurchase =>
      'এই Apple অ্যাকাউন্টে আগের কোনো কেনা পাওয়া যায়নি।';

  @override
  String get purchaseDidNotComplete =>
      'কেনা সম্পূর্ণ হয়নি, তাই কোনো টাকা কাটা হয়নি।';

  @override
  String alreadyInTheList(String name) {
    return '$name আগে থেকেই তালিকায় ছিল।';
  }

  @override
  String get ocrUnavailable =>
      'স্ক্রিনশট পড়তে iPhone লাগে — এই প্ল্যাটফর্মে লেখা শনাক্ত করার সুবিধা নেই।';

  @override
  String get lookupUnavailable =>
      'জায়গা খুঁজতে iPhone লাগে — এই প্ল্যাটফর্মে মানচিত্রে খোঁজার সুবিধা নেই।';

  @override
  String get compAccess => 'সৌজন্য প্রবেশাধিকার';

  @override
  String get code => 'কোড';

  @override
  String get unlock => 'আনলক';

  @override
  String get compChecking => 'কোডটি দেখা হচ্ছে…';

  @override
  String get compEnabled => 'সৌজন্য প্রবেশাধিকার চালু হয়েছে।';

  @override
  String get compRefused => 'কোডটি চেনা গেল না, বা আগেই ব্যবহার করা হয়েছে।';

  @override
  String get compTooOften =>
      'অনেকবার চেষ্টা হয়েছে। কয়েক মিনিট পরে আবার চেষ্টা করুন।';

  @override
  String get compUnreachable =>
      'সার্ভারে পৌঁছানো গেল না। সংযোগ দেখে আবার চেষ্টা করুন।';

  @override
  String get compUntrusted => 'উত্তরটি যাচাই করা গেল না, তাই কিছুই আনলক হয়নি।';

  @override
  String get addPlaces => 'যোগ করুন';

  @override
  String get fromFile => 'ফাইল থেকে';

  @override
  String get fromExistingGuide => 'আগের কোনো গাইড থেকে';

  @override
  String get importGuideTitle => 'আগের কোনো গাইডে যোগ করুন';

  @override
  String get importGuideBody =>
      'Apple Maps-এ গাইডটি খুলে শেয়ার করুন, তারপর “লিঙ্ক কপি করুন” বেছে নিন। সেটি নিচে পেস্ট করুন, Wren তাতে আগে থেকেই থাকা জায়গাগুলো পড়ে নেবে।';

  @override
  String get guideLinkLabel => 'গাইডের লিঙ্ক';

  @override
  String get readGuide => 'গাইড পড়ুন';

  @override
  String get importGuideNotALink =>
      'এটি Apple Maps গাইডের লিঙ্ক নয়। Maps-এ গাইডটি খুলে শেয়ার করুন, তারপর “লিঙ্ক কপি করুন” বেছে নিন।';

  @override
  String get importGuideNothing => 'ওই গাইডে Wren যোগ করতে পারে এমন কিছু নেই।';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ওই গাইড থেকে $countটি জায়গা পড়া হয়েছে',
      one: 'ওই গাইড থেকে ১টি জায়গা পড়া হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'তার মধ্যে $countটি জায়গা নতুন গাইডে নেওয়া যাবে না',
      one: 'তার মধ্যে ১টি জায়গা নতুন গাইডে নেওয়া যাবে না',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি জায়গা আগে থেকেই এই গাইডে',
      one: '১টি জায়গা আগে থেকেই এই গাইডে',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '“$name” থেকে';
  }

  @override
  String get republishTitle => 'Maps নতুন গাইড তৈরি করে';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'আগে থেকে থাকা গাইডে যোগ করার কোনো উপায় Apple দেয় না, তাই Wren $countটি জায়গা একসঙ্গে নিয়ে নতুন একটি গাইড তৈরি করবে।',
      one:
          'আগে থেকে থাকা গাইডে যোগ করার কোনো উপায় Apple দেয় না, তাই Wren ১টি জায়গা নিয়ে নতুন একটি গাইড তৈরি করবে।',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'নতুন গাইডটি রাখুন আর পুরোনোটি মুছে দিন।';

  @override
  String get republishKeepsPlaces =>
      'Wren এই জায়গাগুলো রেখে দেয়, তাই কিছু ভুল হলে গাইডটি আবার তৈরি করা যায়।';

  @override
  String get makeCombinedGuide => 'সম্মিলিত গাইড তৈরি করুন';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ওই ফাইল থেকে $countটি জায়গা পড়া হয়েছে',
      one: 'ওই ফাইল থেকে ১টি জায়গা পড়া হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি সারিতে নাম ছিল না',
      one: '১টি সারিতে নাম ছিল না',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'ওই ফাইলে কোনো জায়গা নেই।';

  @override
  String get fileUnreadable =>
      'Wren ওই ফাইলটি পড়তে পারল না। এটি CSV, KML, KMZ, GPX, GeoJSON আর Google Takeout এক্সপোর্ট পড়ে।';

  @override
  String lookingUpProgress(int done, int total) {
    return '$totalটির মধ্যে $doneটি খোঁজা হচ্ছে…';
  }

  @override
  String get combineNeedsUnlock => 'সম্মিলিত গাইড তৈরি করতে আনলক দরকার।';

  @override
  String get unlockCombineTitle => 'আপনার আগের কোনো গাইডে যোগ করুন';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren একটিই গাইড তৈরি করবে, যাতে আপনার গাইডের $countটি জায়গা আর নতুন জায়গাগুলো একসঙ্গে থাকবে।',
      one:
          'Wren একটিই গাইড তৈরি করবে, যাতে আপনার গাইডের ১টি জায়গা আর নতুন জায়গাটি একসঙ্গে থাকবে।',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'অন্য কোনো অ্যাপ থেকে এক্সপোর্ট করা তালিকাও পড়ে: CSV, KML, KMZ, GPX, GeoJSON বা Google Takeout।';

  @override
  String get clearList => 'তালিকা খালি করুন';

  @override
  String get clearListTitle => 'তালিকা খালি করুন';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren থেকে সব $countটি জায়গা সরিয়ে দেবেন? Apple Maps-এ আগে তৈরি করা গাইডে কোনো প্রভাব পড়ে না।',
      one:
          'Wren থেকে ওই একটি জায়গা সরিয়ে দেবেন? Apple Maps-এ আগে তৈরি করা গাইডে কোনো প্রভাব পড়ে না।',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'সরান';

  @override
  String get listCleared => 'তালিকা খালি হয়েছে।';

  @override
  String get expandingLink => 'ওই লিঙ্কটি পড়া হচ্ছে…';

  @override
  String get linkUnreachable =>
      'ওই লিঙ্কটি পড়ার জন্য Apple-এ পৌঁছানো গেল না। সংযোগ দেখে আবার চেষ্টা করুন।';

  @override
  String get splitTitle => 'এতে একটির বেশি গাইড তৈরি হবে';

  @override
  String splitBody(int guides, int count) {
    return 'একটি গাইডের লিঙ্কে কতগুলো জায়গা রাখা যায় তা Apple সীমিত রাখে। Wren $guidesটি গাইড তৈরি করবে, ক্রম ঠিক রাখার জন্য সেগুলোতে নম্বর দেওয়া থাকবে, আর সব মিলিয়ে তাতে $countটি জায়গা থাকবে।';
  }

  @override
  String splitConfirm(int guides) {
    return '$guidesটি গাইড তৈরি করুন';
  }

  @override
  String splitProgress(int done, int total) {
    return '$totalটির মধ্যে $doneটি গাইড খোলা হয়েছে। পরেরটি তৈরি করতে ট্যাপ করুন।';
  }

  @override
  String get sendPlacesTo => 'স্থান পাঠাও';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি স্থান পাঠানোর জন্য তৈরি',
      one: '১টি স্থান পাঠানোর জন্য তৈরি',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি স্থানের অবস্থান নেই, পাঠানো যাবে না',
      one: '১টি স্থানের অবস্থান নেই, পাঠানো যাবে না',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'অন্য কোনও অ্যাপ';

  @override
  String get sendPlacesFailed => 'সেই অ্যাপ ফাইলটি নিল না';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ফাইল থেকে $countটি স্থান রাখা হয়েছে, অন্য ম্যাপ অ্যাপে পাঠানোর জন্য তৈরি',
      one:
          'ফাইল থেকে ১টি স্থান রাখা হয়েছে, অন্য ম্যাপ অ্যাপে পাঠানোর জন্য তৈরি',
    );
    return '$_temp0';
  }

  @override
  String get compExpiring =>
      'Wren আপনার বিনামূল্যের অ্যাক্সেস নিশ্চিত করতে পারেনি। এটি ধরে রাখতে আগামী কয়েক দিনের মধ্যে ইন্টারনেটে সংযুক্ত হোন।';
}
