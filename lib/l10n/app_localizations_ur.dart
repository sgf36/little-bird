// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class LUr extends L {
  LUr([String locale = 'ur']) : super(locale);

  @override
  String get tagline => 'ایک ننھی چڑیا نے بتایا۔';

  @override
  String get emptyTitle => 'جگہیں، سنبھال کر۔';

  @override
  String get emptyBody =>
      'جو کوئی آپ کو بتائے، اس کا اسکرین شاٹ لے لیجیے — ایک ریل، ایک پوسٹ، ایک پیغام، یا سفری کتاب کا ایک صفحہ۔ Wren نام پڑھ لیتا ہے اور انہیں Apple Maps میں رکھ دیتا ہے۔';

  @override
  String get emptyNote =>
      'ایک جگہ آپ کی پہلے سے موجود گائیڈ میں شامل ہو جاتی ہے۔ کئی جگہیں نئی گائیڈ بناتی ہیں — Apple Maps گائیڈز کو آپس میں نہیں ملا سکتا۔';

  @override
  String get addScreenshots => 'اسکرین شاٹ شامل کریں';

  @override
  String get readingShort => 'پڑھ رہا ہے…';

  @override
  String readingProgress(int done, int total) {
    return '$total میں سے $done پڑھ رہا ہے…';
  }

  @override
  String get addToGuide => 'کسی گائیڈ میں شامل کریں';

  @override
  String makeGuide(int count) {
    return 'گائیڈ بنائیں ($count)';
  }

  @override
  String get notFoundOnMap => 'نقشے پر نہیں ملی';

  @override
  String get tapToSearchForIt => 'تلاش کے لیے ٹیپ کریں';

  @override
  String readAs(String text) {
    return 'یوں پڑھا گیا: ”$text“';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count جگہیں نہیں ملیں۔ تلاش کے لیے ٹیپ کریں۔',
      one: '1 جگہ نہیں ملی۔ تلاش کے لیے ٹیپ کریں۔',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'یہ جگہیں کہاں ہیں؟';

  @override
  String get regionDetected => 'کیپشن سے پڑھا گیا۔ غلط ہو تو بدل دیجیے۔';

  @override
  String get regionNotDetected =>
      'اسکرین شاٹس میں یہ نہیں لکھا تھا کہ یہ کہاں ہیں۔ شہر بتانے سے تلاش کہیں زیادہ درست ہوتی ہے۔';

  @override
  String get cityOrRegion => 'شہر یا علاقہ';

  @override
  String get cityExample => 'مثلاً کراچی';

  @override
  String get searchAnywhere => 'ہر جگہ تلاش کریں';

  @override
  String get findPlaces => 'جگہیں تلاش کریں';

  @override
  String searchedIn(String region) {
    return '$region میں تلاش کیا گیا';
  }

  @override
  String get nameThisGuide => 'اس گائیڈ کو نام دیجیے';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'یہ Apple Maps میں اسی نام سے نظر آئے گی، اس میں $count جگہیں ہوں گی۔',
      one: 'یہ Apple Maps میں اسی نام سے نظر آئے گی، اس میں 1 جگہ ہوگی۔',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'گائیڈ کا نام';

  @override
  String get guideNameExample => 'مثلاً روم، اکتوبر';

  @override
  String get createGuide => 'گائیڈ بنائیں';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get guidesOfAnySize => 'کسی بھی حجم کی گائیڈز';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren ایک گائیڈ میں مفت $limit جگہوں تک محفوظ کرتا ہے۔ آپ نے $selected منتخب کی ہیں — $over زیادہ۔';
  }

  @override
  String get onePaymentKept =>
      'ایک بار کی ادائیگی، ہمیشہ کے لیے آپ کی۔ کوئی سبسکرپشن نہیں۔';

  @override
  String unlockFor(String price) {
    return '$price میں ان لاک کریں';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'اس کے بجائے پہلی $limit محفوظ کریں';
  }

  @override
  String get restorePrevious => 'پچھلی خریداری بحال کریں';

  @override
  String get restorePurchase => 'خریداری بحال کریں';

  @override
  String overFreeLimit(int over, int limit) {
    return 'مفت حد $limit سے $over زیادہ۔ آپ ان لاک کر سکتے ہیں، یا پہلی $limit محفوظ کر سکتے ہیں۔';
  }

  @override
  String get findThisPlace => 'یہ جگہ تلاش کریں';

  @override
  String get searchAppleMaps => 'Apple Maps میں تلاش کریں';

  @override
  String searchInRegion(String region) {
    return '$region میں تلاش کریں';
  }

  @override
  String get searching => 'تلاش جاری ہے…';

  @override
  String get typeTwoCharacters => 'کم از کم دو حروف لکھیے۔';

  @override
  String get nothingFound => 'کچھ نہیں ملا۔ گلی کا نام، یا چھوٹا نام آزمائیے۔';

  @override
  String get rateLimited =>
      'Apple Maps تلاش کو محدود کر رہا ہے۔ ذرا ٹھہر کر دوبارہ کوشش کیجیے۔';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps تلاش کو محدود کر رہا ہے — اب تک $added شامل ہوئیں، باقی تھوڑی دیر بعد آزمائیے۔';
  }

  @override
  String importSummary(int found) {
    return '$found ملیں';
  }

  @override
  String importSummaryIn(String region) {
    return '$region میں';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count دیکھنی ہیں';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count پڑھی نہیں گئیں';
  }

  @override
  String nothingReadable(int count) {
    return '$count اسکرین شاٹس میں پڑھنے کے قابل کچھ نہیں';
  }

  @override
  String get couldNotOpenMaps => 'Maps نہیں کھل سکا';

  @override
  String get checkingAppleAccount => 'آپ کا Apple اکاؤنٹ دیکھا جا رہا ہے…';

  @override
  String get restoredUnlocked =>
      'بحال ہو گیا۔ کسی بھی حجم کی گائیڈز ان لاک ہیں۔';

  @override
  String get noPreviousPurchase =>
      'اس Apple اکاؤنٹ پر پچھلی کوئی خریداری نہیں ملی۔';

  @override
  String get purchaseDidNotComplete =>
      'خریداری مکمل نہیں ہوئی، اس لیے کچھ وصول نہیں کیا گیا۔';

  @override
  String alreadyInTheList(String name) {
    return '$name پہلے ہی فہرست میں تھی۔';
  }

  @override
  String get ocrUnavailable =>
      'اسکرین شاٹ پڑھنے کے لیے iPhone چاہیے — اس پلیٹ فارم پر متن کی شناخت نہیں ہے۔';

  @override
  String get lookupUnavailable =>
      'جگہ تلاش کرنے کے لیے iPhone چاہیے — اس پلیٹ فارم پر نقشے میں تلاش نہیں ہے۔';

  @override
  String get reviewerAccess => 'جائزہ کار رسائی';

  @override
  String get code => 'کوڈ';

  @override
  String get unlock => 'ان لاک کریں';

  @override
  String get reviewerEnabled => 'جائزہ کار رسائی آن ہو گئی۔';

  @override
  String get codeNotRecognised => 'یہ کوڈ پہچانا نہیں گیا۔';
}
