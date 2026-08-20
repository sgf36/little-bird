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
  String get emptyBodyAndroid =>
      'Open a list of places you already keep — a file exported from another map app, or a Google Takeout archive. CSV, KML, KMZ, GPX and GeoJSON are all read.';

  @override
  String get emptyNoteAndroid =>
      'Nothing leaves until you have looked at it. Wren then hands the list to a map app on the phone.';

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
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دیکھنی ہیں',
      one: '$count دیکھنی ہے',
    );
    return '$_temp0';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count پڑھی نہیں گئیں';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count اسکرین شاٹس میں پڑھنے کے قابل کچھ نہیں',
      one: '$count اسکرین شاٹ میں پڑھنے کے قابل کچھ نہیں',
    );
    return '$_temp0';
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
  String get compAccess => 'اعزازی رسائی';

  @override
  String get code => 'کوڈ';

  @override
  String get unlock => 'ان لاک کریں';

  @override
  String get compChecking => 'یہ کوڈ دیکھا جا رہا ہے…';

  @override
  String get compEnabled => 'اعزازی رسائی آن ہو گئی۔';

  @override
  String get compRefused =>
      'یہ کوڈ پہچانا نہیں گیا، یا پہلے ہی استعمال ہو چکا ہے۔';

  @override
  String get compTooOften =>
      'بہت زیادہ کوششیں۔ چند منٹ ٹھہر کر دوبارہ کوشش کیجیے۔';

  @override
  String get compUnreachable =>
      'سرور تک نہیں پہنچا جا سکا۔ اپنا کنکشن دیکھ کر دوبارہ کوشش کیجیے۔';

  @override
  String get compUntrusted =>
      'اس جواب کی تصدیق نہیں ہو سکی، اس لیے کچھ ان لاک نہیں ہوا۔';

  @override
  String get addPlaces => 'شامل کریں';

  @override
  String get fromFile => 'فائل سے';

  @override
  String get fromExistingGuide => 'پہلے سے موجود گائیڈ سے';

  @override
  String get importGuideTitle => 'پہلے سے موجود گائیڈ میں شامل کریں';

  @override
  String get importGuideBody =>
      'Apple Maps میں گائیڈ کھول کر شیئر کیجیے، پھر ”لنک کاپی کریں“ چنیے۔ اسے نیچے پیسٹ کیجیے، Wren اس میں پہلے سے موجود جگہیں پڑھ لے گا۔';

  @override
  String get guideLinkLabel => 'گائیڈ کا لنک';

  @override
  String get readGuide => 'گائیڈ پڑھیں';

  @override
  String get importGuideNotALink =>
      'یہ Apple Maps گائیڈ کا لنک نہیں ہے۔ گائیڈ کو Maps میں کھولیے، شیئر کیجیے، پھر ”لنک کاپی کریں“ چنیے۔';

  @override
  String get importGuideNothing =>
      'اس گائیڈ میں ایسا کچھ نہیں جو Wren شامل کر سکے۔';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'اس گائیڈ سے $count جگہیں پڑھیں',
      one: 'اس گائیڈ سے 1 جگہ پڑھی',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'اس میں سے $count جگہیں نئی گائیڈ میں نہیں لے جائی جا سکتیں',
      one: 'اس میں سے 1 جگہ نئی گائیڈ میں نہیں لے جائی جا سکتی',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count جگہیں پہلے سے اس گائیڈ میں',
      one: '1 جگہ پہلے سے اس گائیڈ میں',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '”$name“ سے';
  }

  @override
  String get republishTitle => 'Maps نئی گائیڈ بناتا ہے';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple پہلے سے موجود گائیڈ میں کچھ شامل کرنے کا کوئی راستہ نہیں دیتا، اس لیے Wren تمام $count جگہوں والی نئی گائیڈ بنائے گا۔',
      one:
          'Apple پہلے سے موجود گائیڈ میں کچھ شامل کرنے کا کوئی راستہ نہیں دیتا، اس لیے Wren 1 جگہ والی نئی گائیڈ بنائے گا۔',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'نئی گائیڈ رکھیے اور پرانی حذف کر دیجیے۔';

  @override
  String get republishKeepsPlaces =>
      'Wren یہ جگہیں سنبھال رکھتا ہے، اس لیے کچھ غلط ہو جائے تو گائیڈ دوبارہ بنائی جا سکتی ہے۔';

  @override
  String get makeCombinedGuide => 'مشترکہ گائیڈ بنائیں';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'اس فائل سے $count جگہیں پڑھیں',
      one: 'اس فائل سے 1 جگہ پڑھی',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count قطاروں میں نام نہیں تھا',
      one: '1 قطار میں نام نہیں تھا',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'اس فائل میں کوئی جگہ نہیں۔';

  @override
  String get fileUnreadable =>
      'Wren وہ فائل نہیں پڑھ سکا۔ یہ CSV، KML، KMZ، GPX، GeoJSON اور Google Takeout ایکسپورٹ پڑھتا ہے۔';

  @override
  String lookingUpProgress(int done, int total) {
    return '$total میں سے $done تلاش کر رہا ہے…';
  }

  @override
  String get combineNeedsUnlock => 'مشترکہ گائیڈ بنانے کے لیے ان لاک درکار ہے۔';

  @override
  String get unlockCombineTitle => 'اپنی پہلے سے موجود گائیڈ میں شامل کریں';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren ایک ہی گائیڈ بنائے گا، جس میں آپ کی گائیڈ کی $count جگہیں اور نئی جگہیں، دونوں ہوں گی۔',
      one:
          'Wren ایک ہی گائیڈ بنائے گا، جس میں آپ کی گائیڈ کی 1 جگہ اور نئی جگہ، دونوں ہوں گی۔',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'کسی دوسری ایپ سے ایکسپورٹ کی گئی فہرست بھی پڑھتا ہے: CSV، KML، KMZ، GPX، GeoJSON یا Google Takeout۔';

  @override
  String get clearList => 'فہرست خالی کریں';

  @override
  String get clearListTitle => 'فہرست خالی کریں';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren سے تمام $count جگہیں ہٹا دیں؟ Apple Maps میں پہلے بنائی گئی گائیڈز پر کوئی اثر نہیں پڑتا۔',
      one:
          'Wren سے وہ ایک جگہ ہٹا دیں؟ Apple Maps میں پہلے بنائی گئی گائیڈز پر کوئی اثر نہیں پڑتا۔',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'ہٹائیں';

  @override
  String get listCleared => 'فہرست خالی ہو گئی۔';

  @override
  String get expandingLink => 'وہ لنک پڑھا جا رہا ہے…';

  @override
  String get linkUnreachable =>
      'وہ لنک پڑھنے کے لیے Apple تک نہیں پہنچا جا سکا۔ اپنا کنکشن دیکھ کر دوبارہ کوشش کیجیے۔';

  @override
  String get splitTitle => 'اس سے ایک سے زیادہ گائیڈز بنیں گی';

  @override
  String splitBody(int guides, int count) {
    return 'ایک گائیڈ کے لنک میں کتنی جگہیں آ سکتی ہیں، Apple اسے محدود رکھتا ہے۔ Wren $guides گائیڈز بنائے گا، ترتیب برقرار رہے اس لیے ان پر نمبر ہوں گے، اور ان سب میں مل کر $count جگہیں ہوں گی۔';
  }

  @override
  String splitConfirm(int guides) {
    return '$guides گائیڈز بنائیں';
  }

  @override
  String splitProgress(int done, int total) {
    return '$total میں سے $done گائیڈ کھل گئی۔ اگلی بنانے کے لیے ٹیپ کریں۔';
  }

  @override
  String get sendPlacesTo => 'مقامات بھیجیں';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مقامات بھیجنے کے لیے تیار',
      one: '1 مقام بھیجنے کے لیے تیار',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مقامات کا محلِ وقوع نہیں، انہیں بھیجا نہیں جا سکتا',
      one: '1 مقام کا محلِ وقوع نہیں، اسے بھیجا نہیں جا سکتا',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'کوئی اور ایپ';

  @override
  String get sendPlacesFailed => 'اُس ایپ نے فائل نہیں لی';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'فائل سے $count مقامات رکھے گئے، کسی اور نقشہ ایپ کو بھیجنے کے لیے تیار',
      one: 'فائل سے 1 مقام رکھا گیا، کسی اور نقشہ ایپ کو بھیجنے کے لیے تیار',
    );
    return '$_temp0';
  }
}
