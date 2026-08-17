// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class LHe extends L {
  LHe([String locale = 'he']) : super(locale);

  @override
  String get tagline => 'ציפור קטנה לחשה לי.';

  @override
  String get emptyTitle => 'מקומות, שמורים.';

  @override
  String get emptyBody =>
      'צלם מסך של מה שממליצים לך עליו — ריל, פוסט, הודעה, עמוד מתוך מדריך טיולים. Wren קורא את השמות ומכניס אותם למפות של Apple.';

  @override
  String get emptyNote =>
      'מקום בודד מצטרף למדריך שכבר יש לך. כמה מקומות יוצרים מדריך חדש — המפות של Apple לא יודעות למזג מדריכים.';

  @override
  String get addScreenshots => 'הוספת צילומי מסך';

  @override
  String get readingShort => 'קורא…';

  @override
  String readingProgress(int done, int total) {
    return 'קורא $done מתוך $total…';
  }

  @override
  String get addToGuide => 'הוספה למדריך';

  @override
  String makeGuide(int count) {
    return 'יצירת מדריך ($count)';
  }

  @override
  String get notFoundOnMap => 'לא נמצא במפה';

  @override
  String get tapToSearchForIt => 'יש להקיש כדי לחפש';

  @override
  String readAs(String text) {
    return 'נקרא כ־„$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count מקומות לא נמצאו. יש להקיש כדי לחפש אותם.',
      many: '$count מקומות לא נמצאו. יש להקיש כדי לחפש אותם.',
      two: 'שני מקומות לא נמצאו. יש להקיש כדי לחפש אותם.',
      one: 'מקום אחד לא נמצא. יש להקיש כדי לחפש אותו.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'היכן נמצאים המקומות האלה?';

  @override
  String get regionDetected => 'נקרא מהכיתובים. אפשר לשנות אם זה לא נכון.';

  @override
  String get regionNotDetected =>
      'בצילומי המסך לא נכתב היכן הם נמצאים. עם עיר החיפוש מדויק בהרבה.';

  @override
  String get cityOrRegion => 'עיר או אזור';

  @override
  String get cityExample => 'לדוגמה תל אביב';

  @override
  String get searchAnywhere => 'חיפוש בכל מקום';

  @override
  String get findPlaces => 'מציאת מקומות';

  @override
  String searchedIn(String region) {
    return 'חיפוש ב$region';
  }

  @override
  String get nameThisGuide => 'שם למדריך הזה';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'הוא יופיע בשם הזה במפות של Apple, עם $count מקומות.',
      many: 'הוא יופיע בשם הזה במפות של Apple, עם $count מקומות.',
      two: 'הוא יופיע בשם הזה במפות של Apple, עם שני מקומות.',
      one: 'הוא יופיע בשם הזה במפות של Apple, עם מקום אחד.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'שם המדריך';

  @override
  String get guideNameExample => 'לדוגמה רומא, אוקטובר';

  @override
  String get createGuide => 'יצירת מדריך';

  @override
  String get cancel => 'ביטול';

  @override
  String get guidesOfAnySize => 'מדריכים בכל גודל';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return '‏Wren שומר עד $limit מקומות במדריך בחינם. סימנת $selected — $over יותר מזה.';
  }

  @override
  String get onePaymentKept => 'תשלום אחד, נשאר לתמיד. בלי מינוי.';

  @override
  String unlockFor(String price) {
    return 'פתיחה תמורת $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'לשמור במקום זאת את $limit הראשונים';
  }

  @override
  String get restorePrevious => 'שחזור רכישה קודמת';

  @override
  String get restorePurchase => 'שחזור רכישה';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over מעל המגבלה החינמית של $limit. אפשר לפתוח, או לשמור את $limit הראשונים.';
  }

  @override
  String get findThisPlace => 'מציאת המקום הזה';

  @override
  String get searchAppleMaps => 'חיפוש במפות של Apple';

  @override
  String searchInRegion(String region) {
    return 'חיפוש ב$region';
  }

  @override
  String get searching => 'מחפש…';

  @override
  String get typeTwoCharacters => 'יש להקליד שני תווים לפחות.';

  @override
  String get nothingFound =>
      'לא נמצא דבר. אפשר לנסות את הרחוב, או שם קצר יותר.';

  @override
  String get rateLimited =>
      'המפות של Apple מגבילות את החיפושים. יש להמתין רגע ולנסות שוב.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'המפות של Apple מגבילות את החיפושים — נוספו $added עד כה, אפשר לנסות את השאר בעוד רגע.';
  }

  @override
  String importSummary(int found) {
    return 'נמצאו $found';
  }

  @override
  String importSummaryIn(String region) {
    return 'ב$region';
  }

  @override
  String importSummaryNeedLook(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count דורשים בדיקה',
      many: '$count דורשים בדיקה',
      two: '$count דורשים בדיקה',
      one: '$count דורש בדיקה',
    );
    return '$_temp0';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count לא קריאים';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'אין דבר קריא ב־$count צילומי מסך',
      many: 'אין דבר קריא ב־$count צילומי מסך',
      two: 'אין דבר קריא ב־$count צילומי מסך',
      one: 'אין דבר קריא ב־$count צילום מסך',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'לא ניתן לפתוח את המפות';

  @override
  String get checkingAppleAccount => 'בודק את חשבון Apple שלך…';

  @override
  String get restoredUnlocked => 'שוחזר. מדריכים בכל גודל נפתחו.';

  @override
  String get noPreviousPurchase => 'לא נמצאה רכישה קודמת בחשבון Apple הזה.';

  @override
  String get purchaseDidNotComplete => 'הרכישה לא הושלמה, ולכן לא חויבת בדבר.';

  @override
  String alreadyInTheList(String name) {
    return '$name כבר היה ברשימה.';
  }

  @override
  String get ocrUnavailable =>
      'קריאת צילומי מסך דורשת iPhone — בפלטפורמה הזאת אין זיהוי טקסט.';

  @override
  String get lookupUnavailable =>
      'חיפוש מקומות דורש iPhone — בפלטפורמה הזאת אין חיפוש במפה.';

  @override
  String get compAccess => 'גישה ללא תשלום';

  @override
  String get code => 'קוד';

  @override
  String get unlock => 'פתיחה';

  @override
  String get compChecking => 'בודק את הקוד…';

  @override
  String get compEnabled => 'גישה ללא תשלום הופעלה.';

  @override
  String get compRefused => 'הקוד הזה לא זוהה, או שכבר נעשה בו שימוש.';

  @override
  String get compTooOften =>
      'יותר מדי ניסיונות. יש להמתין כמה דקות ולנסות שוב.';

  @override
  String get compUnreachable =>
      'לא ניתן היה להגיע לשרת. יש לבדוק את החיבור ולנסות שוב.';

  @override
  String get compUntrusted => 'לא ניתן היה לאמת את התשובה, ולכן לא נפתח דבר.';

  @override
  String get addPlaces => 'הוספה';

  @override
  String get fromFile => 'מקובץ';

  @override
  String get fromExistingGuide => 'ממדריך קיים';

  @override
  String get importGuideTitle => 'הוספה למדריך קיים';

  @override
  String get importGuideBody =>
      'במפות של Apple יש לפתוח את המדריך, לשתף אותו ולבחור „העתקת קישור”. יש להדביק את הקישור למטה, ואז Wren יקרא את המקומות שכבר יש בו.';

  @override
  String get guideLinkLabel => 'קישור למדריך';

  @override
  String get readGuide => 'קריאת המדריך';

  @override
  String get importGuideNotALink =>
      'זה לא קישור למדריך במפות של Apple. יש לפתוח את המדריך במפות, לשתף אותו ולבחור „העתקת קישור”.';

  @override
  String get importGuideNothing => 'במדריך הזה אין מקומות שאפשר לצרף.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'נקראו $count מקומות מהמדריך הזה',
      two: 'נקראו שני מקומות מהמדריך הזה',
      one: 'נקרא מקום אחד מהמדריך הזה',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count מקומות מתוכו לא יעברו למדריך החדש',
      two: 'שני מקומות מתוכו לא יעברו למדריך החדש',
      one: 'מקום אחד מתוכו לא יעבור למדריך החדש',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count מקומות כבר במדריך הזה',
      two: 'שני מקומות כבר במדריך הזה',
      one: 'מקום אחד כבר במדריך הזה',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'מתוך „$name”';
  }

  @override
  String get republishTitle => 'המפות יוצרות מדריך חדש';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'המפות של Apple לא מאפשרות להוסיף מקומות למדריך שכבר קיים, ולכן Wren ייצור מדריך חדש עם כל $count המקומות.',
      two:
          'המפות של Apple לא מאפשרות להוסיף מקומות למדריך שכבר קיים, ולכן Wren ייצור מדריך חדש עם שני המקומות.',
      one:
          'המפות של Apple לא מאפשרות להוסיף מקומות למדריך שכבר קיים, ולכן Wren ייצור מדריך חדש עם המקום הזה.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'יש לשמור את המדריך החדש ולמחוק את הישן.';

  @override
  String get republishKeepsPlaces =>
      'המקומות האלה נשמרים ב־Wren, כך שאפשר ליצור את המדריך שוב אם משהו משתבש.';

  @override
  String get makeCombinedGuide => 'יצירת המדריך המשולב';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'נקראו $count מקומות מהקובץ הזה',
      two: 'נקראו שני מקומות מהקובץ הזה',
      one: 'נקרא מקום אחד מהקובץ הזה',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ב־$count שורות לא היה שם',
      two: 'בשתי שורות לא היה שם',
      one: 'בשורה אחת לא היה שם',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'אין מקומות בקובץ הזה.';

  @override
  String get fileUnreadable =>
      'לא ניתן היה לקרוא את הקובץ הזה. Wren קורא קובצי CSV, KML, KMZ, GPX, GeoJSON וייצוא מ־Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'מחפש $done מתוך $total…';
  }

  @override
  String get combineNeedsUnlock => 'יצירת המדריך המשולב דורשת פתיחה.';

  @override
  String get unlockCombineTitle => 'הוספה למדריך שכבר יש לך';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ייווצר מדריך אחד שיכיל את $count המקומות שכבר יש במדריך שלך יחד עם החדשים.',
      two:
          'ייווצר מדריך אחד שיכיל את שני המקומות שכבר יש במדריך שלך יחד עם החדשים.',
      one: 'ייווצר מדריך אחד שיכיל את המקום שכבר יש במדריך שלך יחד עם החדש.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'קורא גם רשימה שמייצאים מאפליקציה אחרת: CSV, KML, KMZ, GPX, GeoJSON או Google Takeout.';

  @override
  String get clearList => 'ניקוי הרשימה';

  @override
  String get clearListTitle => 'ניקוי הרשימה';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'להסיר את כל $count המקומות מהרשימה? מדריכים שכבר נוצרו במפות של Apple נשארים כמו שהם.',
      two:
          'להסיר את שני המקומות מהרשימה? מדריכים שכבר נוצרו במפות של Apple נשארים כמו שהם.',
      one:
          'להסיר את המקום היחיד מהרשימה? מדריכים שכבר נוצרו במפות של Apple נשארים כמו שהם.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'הסרה';

  @override
  String get listCleared => 'הרשימה נוקתה.';

  @override
  String get expandingLink => 'קורא את הקישור…';

  @override
  String get linkUnreachable =>
      'לא ניתן היה להגיע ל־Apple כדי לקרוא את הקישור. יש לבדוק את החיבור ולנסות שוב.';

  @override
  String get splitTitle => 'ייווצר יותר ממדריך אחד';

  @override
  String splitBody(int guides, int count) {
    return 'המפות של Apple מגבילות כמה מקומות יכול לשאת קישור אחד של מדריך. ייווצרו $guides מדריכים, ממוספרים כדי לשמור על הסדר, ובהם $count מקומות יחד.';
  }

  @override
  String splitConfirm(int guides) {
    return 'יצירת $guides מדריכים';
  }

  @override
  String splitProgress(int done, int total) {
    return 'מדריך $done מתוך $total נפתח. יש להקיש כדי ליצור את הבא.';
  }
}
