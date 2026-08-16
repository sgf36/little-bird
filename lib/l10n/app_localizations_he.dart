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
    return '$count דורשים בדיקה';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count לא קריאים';
  }

  @override
  String nothingReadable(int count) {
    return 'אין דבר קריא ב־$count צילומי מסך';
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
  String get reviewerAccess => 'גישת בודק';

  @override
  String get code => 'קוד';

  @override
  String get unlock => 'פתיחה';

  @override
  String get reviewerEnabled => 'גישת בודק הופעלה.';

  @override
  String get codeNotRecognised => 'הקוד הזה לא זוהה.';
}
