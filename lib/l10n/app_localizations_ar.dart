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
  String get emptyBodyAndroid =>
      'التقط لقطة شاشة لما يُنصح به أمامك — ريل أو منشور أو رسالة أو صفحة من دليل سفر. يقرأ Wren الأسماء ويرسلها إلى تطبيق الخرائط على هاتفك.';

  @override
  String get emptyNoteAndroid =>
      'كما يقرأ قائمة لديك بالفعل، ويعرض عليك كل مكان قبل أن يُرسل أي شيء.';

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
  String get compAccess => 'وصول مجاني';

  @override
  String get code => 'الرمز';

  @override
  String get unlock => 'فتح';

  @override
  String get compChecking => 'جارٍ التحقق من الرمز…';

  @override
  String get compEnabled => 'تم تفعيل الوصول المجاني.';

  @override
  String get compRefused =>
      'لم يتم التعرّف على هذا الرمز، أو أنه استُخدم بالفعل.';

  @override
  String get compTooOften =>
      'محاولات كثيرة جداً. انتظر بضع دقائق ثم أعد المحاولة.';

  @override
  String get compUnreachable =>
      'تعذّر الوصول إلى الخادم. تحقق من اتصالك ثم أعد المحاولة.';

  @override
  String get compUntrusted => 'تعذّر التحقق من هذا الرد، لذا لم يُفتح أي شيء.';

  @override
  String get addPlaces => 'إضافة';

  @override
  String get fromFile => 'من ملف';

  @override
  String get fromExistingGuide => 'من دليل موجود';

  @override
  String get importGuideTitle => 'الإضافة إلى دليل موجود';

  @override
  String get importGuideBody =>
      'في خرائط Apple، افتح الدليل وشاركه، ثم اختر ”نسخ الرابط“. الصقه أدناه وسيقرأ Wren الأماكن التي يضمها بالفعل.';

  @override
  String get guideLinkLabel => 'رابط الدليل';

  @override
  String get readGuide => 'قراءة الدليل';

  @override
  String get importGuideNotALink =>
      'هذا ليس رابط دليل من خرائط Apple. افتح الدليل في الخرائط وشاركه، ثم اختر ”نسخ الرابط“.';

  @override
  String get importGuideNothing =>
      'هذا الدليل لا يضم شيئاً يمكن لـ Wren إضافته.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'قُرئ $count مكان من ذلك الدليل',
      many: 'قُرئ $count مكاناً من ذلك الدليل',
      few: 'قُرئت $count أماكن من ذلك الدليل',
      two: 'قُرئ مكانان من ذلك الدليل',
      one: 'قُرئ مكان واحد من ذلك الدليل',
      zero: 'لم يُقرأ أي مكان من ذلك الدليل',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'يتعذّر نقل $count مكان منه',
      many: 'يتعذّر نقل $count مكاناً منه',
      few: 'يتعذّر نقل $count أماكن منه',
      two: 'يتعذّر نقل مكانين منه',
      one: 'يتعذّر نقل مكان واحد منه',
      zero: 'لا يوجد فيه ما يتعذّر نقله',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مكان بالفعل في هذا الدليل',
      many: '$count مكاناً بالفعل في هذا الدليل',
      few: '$count أماكن بالفعل في هذا الدليل',
      two: 'مكانان بالفعل في هذا الدليل',
      one: 'مكان واحد بالفعل في هذا الدليل',
      zero: 'لا أماكن في هذا الدليل',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'من ”$name“';
  }

  @override
  String get republishTitle => 'الخرائط تُنشئ دليلاً جديداً';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'لا توفّر Apple أي طريقة للإضافة إلى دليل موجود، لذا سيُنشئ Wren دليلاً جديداً يضم $count مكان معاً.',
      many:
          'لا توفّر Apple أي طريقة للإضافة إلى دليل موجود، لذا سيُنشئ Wren دليلاً جديداً يضم $count مكاناً معاً.',
      few:
          'لا توفّر Apple أي طريقة للإضافة إلى دليل موجود، لذا سيُنشئ Wren دليلاً جديداً يضم $count أماكن معاً.',
      two:
          'لا توفّر Apple أي طريقة للإضافة إلى دليل موجود، لذا سيُنشئ Wren دليلاً جديداً يضم المكانين معاً.',
      one:
          'لا توفّر Apple أي طريقة للإضافة إلى دليل موجود، لذا سيُنشئ Wren دليلاً جديداً يضم المكان الواحد.',
      zero:
          'لا توفّر Apple أي طريقة للإضافة إلى دليل موجود، لذا سيُنشئ Wren دليلاً جديداً.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'احتفظ بالدليل الجديد واحذف القديم.';

  @override
  String get republishKeepsPlaces =>
      'يحتفظ Wren بهذه الأماكن، فيمكنك إنشاء الدليل مرة أخرى إذا حدث أي خطأ.';

  @override
  String get makeCombinedGuide => 'إنشاء الدليل المجمّع';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'قُرئ $count مكان من ذلك الملف',
      many: 'قُرئ $count مكاناً من ذلك الملف',
      few: 'قُرئت $count أماكن من ذلك الملف',
      two: 'قُرئ مكانان من ذلك الملف',
      one: 'قُرئ مكان واحد من ذلك الملف',
      zero: 'لم يُقرأ أي مكان من ذلك الملف',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count صف بلا اسم',
      many: '$count صفاً بلا اسم',
      few: '$count صفوف بلا اسم',
      two: 'صفان بلا اسم',
      one: 'صف واحد بلا اسم',
      zero: 'لا صف بلا اسم',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'لا أماكن في ذلك الملف.';

  @override
  String get fileUnreadable =>
      'تعذّر على Wren قراءة ذلك الملف. يقرأ صيغ CSV و KML و KMZ و GPX و GeoJSON وملفات Google Takeout المُصدَّرة.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'جارٍ البحث عن $done من $total…';
  }

  @override
  String get combineNeedsUnlock => 'إنشاء الدليل المجمّع يحتاج إلى الفتح.';

  @override
  String get unlockCombineTitle => 'الإضافة إلى دليل تملكه بالفعل';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'سيُنشئ Wren دليلاً واحداً يضم $count مكان موجود في دليلك مع الأماكن الجديدة.',
      many:
          'سيُنشئ Wren دليلاً واحداً يضم $count مكاناً موجوداً في دليلك مع الأماكن الجديدة.',
      few:
          'سيُنشئ Wren دليلاً واحداً يضم $count أماكن موجودة في دليلك مع الأماكن الجديدة.',
      two:
          'سيُنشئ Wren دليلاً واحداً يضم المكانين الموجودين في دليلك مع الأماكن الجديدة.',
      one:
          'سيُنشئ Wren دليلاً واحداً يضم المكان الموجود في دليلك مع المكان الجديد.',
      zero: 'سيُنشئ Wren دليلاً واحداً يضم الأماكن الجديدة.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'يقرأ أيضاً قائمة مُصدَّرة من تطبيق آخر: CSV أو KML أو KMZ أو GPX أو GeoJSON أو Google Takeout.';

  @override
  String get clearList => 'إفراغ القائمة';

  @override
  String get clearListTitle => 'إفراغ القائمة';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'إزالة $count مكان من Wren؟ الأدلة التي أنشأتها في خرائط Apple لن تتأثر.',
      many:
          'إزالة $count مكاناً من Wren؟ الأدلة التي أنشأتها في خرائط Apple لن تتأثر.',
      few:
          'إزالة $count أماكن من Wren؟ الأدلة التي أنشأتها في خرائط Apple لن تتأثر.',
      two:
          'إزالة المكانين من Wren؟ الأدلة التي أنشأتها في خرائط Apple لن تتأثر.',
      one:
          'إزالة المكان الواحد من Wren؟ الأدلة التي أنشأتها في خرائط Apple لن تتأثر.',
      zero:
          'إزالة الأماكن من Wren؟ الأدلة التي أنشأتها في خرائط Apple لن تتأثر.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'إزالة';

  @override
  String get listCleared => 'تم إفراغ القائمة.';

  @override
  String get expandingLink => 'جارٍ قراءة ذلك الرابط…';

  @override
  String get linkUnreachable =>
      'تعذّر الوصول إلى Apple لقراءة ذلك الرابط. تحقق من اتصالك ثم أعد المحاولة.';

  @override
  String get splitTitle => 'سيؤدي هذا إلى إنشاء أكثر من دليل';

  @override
  String splitBody(int guides, int count) {
    return 'تحدّ Apple من عدد الأماكن التي يمكن أن يحملها رابط دليل واحد. سيُنشئ Wren $guides من الأدلة، مرقّمة لتبقى بالترتيب، تضم $count من الأماكن بينها.';
  }

  @override
  String splitConfirm(int guides) {
    return 'إنشاء $guides من الأدلة';
  }

  @override
  String splitProgress(int done, int total) {
    return 'فُتح الدليل $done من $total. المس لإنشاء التالي.';
  }

  @override
  String get sendPlacesTo => 'إرسال الأماكن إلى';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مكان جاهز للإرسال',
      many: '$count مكاناً جاهزة للإرسال',
      few: '$count أماكن جاهزة للإرسال',
      two: 'مكانان جاهزان للإرسال',
      one: 'مكان واحد جاهز للإرسال',
      zero: 'لا مكان جاهز للإرسال',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مكان بلا موقع ولا يمكن إرساله',
      many: '$count مكاناً بلا موقع ولا يمكن إرسالها',
      few: '$count أماكن بلا موقع ولا يمكن إرسالها',
      two: 'مكانان بلا موقع ولا يمكن إرسالهما',
      one: 'مكان واحد بلا موقع ولا يمكن إرساله',
      zero: 'لا مكان بلا موقع',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'أي تطبيق آخر';

  @override
  String get sendPlacesFailed => 'لم يقبل هذا التطبيق الملف';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'حُفظ $count مكان من الملف، جاهز للإرسال إلى تطبيق خرائط آخر',
      many: 'حُفظ $count مكاناً من الملف، جاهزة للإرسال إلى تطبيق خرائط آخر',
      few: 'حُفظت $count أماكن من الملف، جاهزة للإرسال إلى تطبيق خرائط آخر',
      two: 'حُفظ مكانان من الملف، جاهزان للإرسال إلى تطبيق خرائط آخر',
      one: 'حُفظ مكان واحد من الملف، جاهز للإرسال إلى تطبيق خرائط آخر',
      zero: 'لم يُحفظ أي مكان من الملف',
    );
    return '$_temp0';
  }

  @override
  String get compExpiring =>
      'تعذّر على Wren تأكيد وصولك المجاني. اتصل بالإنترنت خلال الأيام القليلة القادمة للحفاظ عليه.';
}
