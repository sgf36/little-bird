// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class LAr extends L {
  LAr([String locale = 'ar']) : super(locale);

  @override
  String get tagline => 'أخبرني عصفور صغير.';

  @override
  String get emptyTitle => 'أماكن، محفوظة.';

  @override
  String get emptyBody =>
      'التقط لقطة شاشة لما يُنصح به أمامك — ريل أو منشور أو رسالة أو صفحة من دليل سفر. يقرأ Wren الأسماء ويضعها في خرائط Apple.';

  @override
  String get emptyNote =>
      'المكان الواحد يُضاف إلى دليل لديك بالفعل. الأماكن المتعددة تُنشئ دليلاً جديداً — خرائط Apple لا تستطيع دمج الأدلة.';

  @override
  String get addScreenshots => 'إضافة لقطات شاشة';

  @override
  String get readingShort => 'جارٍ القراءة…';

  @override
  String readingProgress(int done, int total) {
    return 'جارٍ قراءة $done من $total…';
  }

  @override
  String get addToGuide => 'الإضافة إلى دليل';

  @override
  String makeGuide(int count) {
    return 'إنشاء دليل ($count)';
  }

  @override
  String get notFoundOnMap => 'لم يُعثر عليه على الخريطة';

  @override
  String get tapToSearchForIt => 'المس للبحث عنه';

  @override
  String readAs(String text) {
    return 'قُرئ هكذا: ”$text“';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'لم يُعثر على $count مكان. المس للبحث عنها.',
      many: 'لم يُعثر على $count مكاناً. المس للبحث عنها.',
      few: 'لم يُعثر على $count أماكن. المس للبحث عنها.',
      two: 'لم يُعثر على مكانين. المس للبحث عنهما.',
      one: 'لم يُعثر على مكان واحد. المس للبحث عنه.',
      zero: 'لم يُعثر على أي مكان. المس للبحث.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'أين تقع هذه الأماكن؟';

  @override
  String get regionDetected => 'قُرئ من التعليقات. غيّره إذا لم يكن صحيحاً.';

  @override
  String get regionNotDetected =>
      'لم تذكر لقطات الشاشة أين تقع هذه الأماكن. تحديد المدينة يجعل البحث أدق بكثير.';

  @override
  String get cityOrRegion => 'المدينة أو المنطقة';

  @override
  String get cityExample => 'مثل دبي';

  @override
  String get searchAnywhere => 'البحث في كل مكان';

  @override
  String get findPlaces => 'العثور على الأماكن';

  @override
  String searchedIn(String region) {
    return 'بحث في $region';
  }

  @override
  String get nameThisGuide => 'سمِّ هذا الدليل';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'سيظهر بهذا الاسم في خرائط Apple، ويضم $count مكان.',
      many: 'سيظهر بهذا الاسم في خرائط Apple، ويضم $count مكاناً.',
      few: 'سيظهر بهذا الاسم في خرائط Apple، ويضم $count أماكن.',
      two: 'سيظهر بهذا الاسم في خرائط Apple، ويضم مكانين.',
      one: 'سيظهر بهذا الاسم في خرائط Apple، ويضم مكاناً واحداً.',
      zero: 'سيظهر بهذا الاسم في خرائط Apple.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'اسم الدليل';

  @override
  String get guideNameExample => 'مثل روما، أكتوبر';

  @override
  String get createGuide => 'إنشاء الدليل';

  @override
  String get cancel => 'إلغاء';

  @override
  String get guidesOfAnySize => 'أدلة بأي حجم';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'يحفظ Wren مجاناً ما يصل إلى $limit أماكن في الدليل. لديك $selected محدداً — أي $over أكثر من ذلك.';
  }

  @override
  String get onePaymentKept => 'دفعة واحدة، تبقى لك للأبد. بلا اشتراك.';

  @override
  String unlockFor(String price) {
    return 'الفتح مقابل $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'حفظ أول $limit بدلاً من ذلك';
  }

  @override
  String get restorePrevious => 'استعادة عملية شراء سابقة';

  @override
  String get restorePurchase => 'استعادة الشراء';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over فوق الحد المجاني البالغ $limit. يمكنك الفتح، أو حفظ أول $limit.';
  }

  @override
  String get findThisPlace => 'العثور على هذا المكان';

  @override
  String get searchAppleMaps => 'البحث في خرائط Apple';

  @override
  String searchInRegion(String region) {
    return 'البحث في $region';
  }

  @override
  String get searching => 'جارٍ البحث…';

  @override
  String get typeTwoCharacters => 'اكتب حرفين على الأقل.';

  @override
  String get nothingFound =>
      'لم يُعثر على شيء. جرّب اسم الشارع، أو اسماً أقصر.';

  @override
  String get rateLimited =>
      'خرائط Apple تحد من عمليات البحث. انتظر لحظة ثم أعد المحاولة.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'خرائط Apple تحد من عمليات البحث — أُضيف $added حتى الآن، جرّب البقية بعد قليل.';
  }

  @override
  String importSummary(int found) {
    return 'عُثر على $found';
  }

  @override
  String importSummaryIn(String region) {
    return 'في $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count بحاجة إلى مراجعة';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count غير مقروء';
  }

  @override
  String nothingReadable(int count) {
    return 'لا شيء مقروء في $count لقطة شاشة';
  }

  @override
  String get couldNotOpenMaps => 'تعذّر فتح الخرائط';

  @override
  String get checkingAppleAccount => 'جارٍ التحقق من حساب Apple الخاص بك…';

  @override
  String get restoredUnlocked => 'تمت الاستعادة. الأدلة بأي حجم مفتوحة الآن.';

  @override
  String get noPreviousPurchase =>
      'لم يُعثر على عملية شراء سابقة على حساب Apple هذا.';

  @override
  String get purchaseDidNotComplete =>
      'لم تكتمل عملية الشراء، لذا لم يُخصم أي مبلغ.';

  @override
  String alreadyInTheList(String name) {
    return '$name كان موجوداً في القائمة بالفعل.';
  }

  @override
  String get ocrUnavailable =>
      'قراءة لقطات الشاشة تتطلب iPhone — لا يوجد تعرّف على النص على هذه المنصة.';

  @override
  String get lookupUnavailable =>
      'البحث عن الأماكن يتطلب iPhone — لا يوجد بحث في الخرائط على هذه المنصة.';

  @override
  String get reviewerAccess => 'وصول المراجِع';

  @override
  String get code => 'الرمز';

  @override
  String get unlock => 'فتح';

  @override
  String get reviewerEnabled => 'تم تفعيل وصول المراجِع.';

  @override
  String get codeNotRecognised => 'لم يتم التعرّف على هذا الرمز.';
}
