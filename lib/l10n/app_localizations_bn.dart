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
  String get reviewerAccess => 'পর্যালোচকের প্রবেশাধিকার';

  @override
  String get code => 'কোড';

  @override
  String get unlock => 'আনলক';

  @override
  String get reviewerEnabled => 'পর্যালোচকের প্রবেশাধিকার চালু হয়েছে।';

  @override
  String get codeNotRecognised => 'কোডটি চেনা গেল না।';
}
