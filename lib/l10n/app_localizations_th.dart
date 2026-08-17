// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class LTh extends L {
  LTh([String locale = 'th']) : super(locale);

  @override
  String get tagline => 'นกน้อยกระซิบมา';

  @override
  String get emptyTitle => 'ที่เที่ยว เก็บไว้';

  @override
  String get emptyBody =>
      'แคปหน้าจอสิ่งที่คนแนะนำคุณ — รีล โพสต์ ข้อความ หรือหน้าหนังสือนำเที่ยว Wren จะอ่านชื่อแล้วใส่ลงใน Apple Maps ให้';

  @override
  String get emptyNote =>
      'ที่เดียวจะไปเพิ่มในไกด์ที่คุณมีอยู่แล้ว หลายที่จะกลายเป็นไกด์ใหม่ — Apple Maps รวมไกด์เข้าด้วยกันไม่ได้';

  @override
  String get addScreenshots => 'เพิ่มภาพหน้าจอ';

  @override
  String get readingShort => 'กำลังอ่าน…';

  @override
  String readingProgress(int done, int total) {
    return 'กำลังอ่าน $done จาก $total…';
  }

  @override
  String get addToGuide => 'เพิ่มลงในไกด์';

  @override
  String makeGuide(int count) {
    return 'สร้างไกด์ ($count)';
  }

  @override
  String get notFoundOnMap => 'ไม่พบบนแผนที่';

  @override
  String get tapToSearchForIt => 'แตะเพื่อค้นหา';

  @override
  String readAs(String text) {
    return 'อ่านได้ว่า “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ไม่พบ $count ที่ แตะเพื่อค้นหา',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'ที่เหล่านี้อยู่ที่ไหน';

  @override
  String get regionDetected => 'อ่านมาจากคำบรรยายภาพ ถ้าไม่ใช่ก็แก้ได้';

  @override
  String get regionNotDetected =>
      'ในภาพหน้าจอไม่ได้บอกว่าอยู่ที่ไหน ถ้าใส่ชื่อเมือง การค้นหาจะแม่นยำขึ้นมาก';

  @override
  String get cityOrRegion => 'เมืองหรือภูมิภาค';

  @override
  String get cityExample => 'เช่น กรุงเทพฯ';

  @override
  String get searchAnywhere => 'ค้นหาทุกที่';

  @override
  String get findPlaces => 'ค้นหาสถานที่';

  @override
  String searchedIn(String region) {
    return 'ค้นหาใน$region';
  }

  @override
  String get nameThisGuide => 'ตั้งชื่อไกด์นี้';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'จะแสดงด้วยชื่อนี้ใน Apple Maps โดยมี $count ที่อยู่ข้างใน',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'ชื่อไกด์';

  @override
  String get guideNameExample => 'เช่น โรม ตุลาคม';

  @override
  String get createGuide => 'สร้างไกด์';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get guidesOfAnySize => 'ไกด์ไม่จำกัดจำนวน';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren บันทึกได้ฟรีสูงสุด $limit ที่ต่อไกด์ คุณเลือกไว้ $selected ที่ เกินมา $over ที่';
  }

  @override
  String get onePaymentKept =>
      'จ่ายครั้งเดียว ใช้ได้ตลอดไป ไม่ใช่การสมัครสมาชิก';

  @override
  String unlockFor(String price) {
    return 'ปลดล็อกในราคา $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'บันทึกแค่ $limit ที่แรกแทน';
  }

  @override
  String get restorePrevious => 'กู้คืนการซื้อครั้งก่อน';

  @override
  String get restorePurchase => 'กู้คืนการซื้อ';

  @override
  String overFreeLimit(int over, int limit) {
    return 'เกินขีดจำกัดฟรีที่ $limit ที่อยู่ $over ที่ คุณจะปลดล็อก หรือบันทึกแค่ $limit ที่แรกก็ได้';
  }

  @override
  String get findThisPlace => 'ค้นหาที่นี่';

  @override
  String get searchAppleMaps => 'ค้นหาใน Apple Maps';

  @override
  String searchInRegion(String region) {
    return 'ค้นหาใน$region';
  }

  @override
  String get searching => 'กำลังค้นหา…';

  @override
  String get typeTwoCharacters => 'พิมพ์อย่างน้อยสองตัวอักษร';

  @override
  String get nothingFound => 'ไม่พบอะไรเลย ลองใส่ชื่อถนน หรือชื่อที่สั้นลง';

  @override
  String get rateLimited =>
      'Apple Maps กำลังจำกัดการค้นหา รอสักครู่แล้วลองใหม่';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps กำลังจำกัดการค้นหา — เพิ่มไปแล้ว $added ที่ ที่เหลือลองใหม่อีกสักครู่';
  }

  @override
  String importSummary(int found) {
    return 'พบ $found ที่';
  }

  @override
  String importSummaryIn(String region) {
    return 'ใน$region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count ที่ต้องตรวจดู';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count ที่อ่านไม่ออก';
  }

  @override
  String nothingReadable(int count) {
    return 'อ่านอะไรไม่ได้เลยจากภาพหน้าจอ $count ภาพ';
  }

  @override
  String get couldNotOpenMaps => 'เปิดแผนที่ไม่ได้';

  @override
  String get checkingAppleAccount => 'กำลังตรวจสอบบัญชี Apple ของคุณ…';

  @override
  String get restoredUnlocked => 'กู้คืนแล้ว ไกด์ไม่จำกัดจำนวนถูกปลดล็อกแล้ว';

  @override
  String get noPreviousPurchase => 'ไม่พบการซื้อครั้งก่อนในบัญชี Apple นี้';

  @override
  String get purchaseDidNotComplete =>
      'การซื้อไม่สำเร็จ จึงไม่มีการเรียกเก็บเงิน';

  @override
  String alreadyInTheList(String name) {
    return '$name อยู่ในรายการอยู่แล้ว';
  }

  @override
  String get ocrUnavailable =>
      'การอ่านภาพหน้าจอต้องใช้ iPhone — แพลตฟอร์มนี้ไม่มีการรู้จำข้อความ';

  @override
  String get lookupUnavailable =>
      'การค้นหาสถานที่ต้องใช้ iPhone — แพลตฟอร์มนี้ไม่มีการค้นหาบนแผนที่';

  @override
  String get compAccess => 'สิทธิ์ใช้งานฟรี';

  @override
  String get code => 'รหัส';

  @override
  String get unlock => 'ปลดล็อก';

  @override
  String get compChecking => 'กำลังตรวจสอบรหัส…';

  @override
  String get compEnabled => 'เปิดสิทธิ์ใช้งานฟรีแล้ว';

  @override
  String get compRefused => 'ไม่รู้จักรหัสนี้ หรือรหัสนี้ถูกใช้ไปแล้ว';

  @override
  String get compTooOften => 'ลองมาหลายครั้งเกินไป รอสักสองสามนาทีแล้วลองใหม่';

  @override
  String get compUnreachable =>
      'ติดต่อเซิร์ฟเวอร์ไม่ได้ ตรวจสอบการเชื่อมต่อแล้วลองใหม่';

  @override
  String get compUntrusted => 'ยืนยันคำตอบนั้นไม่ได้ จึงไม่มีการปลดล็อกอะไร';

  @override
  String get addPlaces => 'เพิ่ม';

  @override
  String get fromFile => 'จากไฟล์';

  @override
  String get fromExistingGuide => 'จากไกด์ที่มีอยู่';

  @override
  String get importGuideTitle => 'เพิ่มลงในไกด์ที่มีอยู่';

  @override
  String get importGuideBody =>
      'ใน Apple Maps เปิดไกด์นั้นแล้วแชร์ จากนั้นเลือก “คัดลอกลิงก์” วางลงข้างล่างนี้ แล้ว Wren จะอ่านที่ที่อยู่ในไกด์นั้นให้';

  @override
  String get guideLinkLabel => 'ลิงก์ไกด์';

  @override
  String get readGuide => 'อ่านไกด์';

  @override
  String get importGuideNotALink =>
      'นั่นไม่ใช่ลิงก์ไกด์ของ Apple Maps เปิดไกด์ใน Apple Maps แล้วแชร์ จากนั้นเลือก “คัดลอกลิงก์”';

  @override
  String get importGuideNothing => 'ไกด์นั้นไม่มีอะไรที่ Wren เพิ่มได้';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'อ่านได้ $count ที่จากไกด์นั้น',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ที่ในนั้นย้ายมาไม่ได้',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ที่อยู่ในไกด์นี้แล้ว',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'จาก “$name”';
  }

  @override
  String get republishTitle => 'Apple Maps จะสร้างไกด์ใหม่';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple ไม่มีวิธีเพิ่มที่ลงในไกด์ที่มีอยู่แล้ว ดังนั้น Wren จะสร้างไกด์ใหม่ที่มีทั้ง $count ที่',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'เก็บไกด์ใหม่ไว้ แล้วลบไกด์เดิม';

  @override
  String get republishKeepsPlaces =>
      'Wren เก็บที่เหล่านี้ไว้ ถ้ามีอะไรผิดพลาด คุณสร้างไกด์ใหม่อีกครั้งได้';

  @override
  String get makeCombinedGuide => 'สร้างไกด์ที่รวมกันแล้ว';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'อ่านได้ $count ที่จากไฟล์นั้น',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count แถวไม่มีชื่อ',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'ไม่มีที่ในไฟล์นั้น';

  @override
  String get fileUnreadable =>
      'Wren อ่านไฟล์นั้นไม่ได้ โดยอ่านไฟล์ที่ส่งออกแบบ CSV, KML, KMZ, GPX, GeoJSON และ Google Takeout ได้';

  @override
  String lookingUpProgress(int done, int total) {
    return 'กำลังค้นหา $done จาก $total…';
  }

  @override
  String get combineNeedsUnlock => 'การสร้างไกด์ที่รวมกันแล้วต้องปลดล็อกก่อน';

  @override
  String get unlockCombineTitle => 'เพิ่มลงในไกด์ที่คุณมีอยู่แล้ว';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren จะสร้างไกด์เดียวที่รวม $count ที่ในไกด์ของคุณกับที่ใหม่ที่เพิ่งหาเจอไว้ด้วยกัน',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'อ่านรายการที่ส่งออกจากแอปอื่นได้ด้วย: CSV, KML, KMZ, GPX, GeoJSON หรือ Google Takeout';

  @override
  String get clearList => 'ล้างรายการ';

  @override
  String get clearListTitle => 'ล้างรายการ';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ลบ $count ที่ออกจาก Wren ไหม ไกด์ที่สร้างไว้แล้วใน Apple Maps ไม่ได้รับผลกระทบ',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'ลบ';

  @override
  String get listCleared => 'ล้างรายการแล้ว';

  @override
  String get expandingLink => 'กำลังอ่านลิงก์นั้น…';

  @override
  String get linkUnreachable =>
      'ติดต่อ Apple เพื่ออ่านลิงก์นั้นไม่ได้ ตรวจสอบการเชื่อมต่อแล้วลองใหม่';

  @override
  String get splitTitle => 'จะได้ไกด์มากกว่าหนึ่งอัน';

  @override
  String splitBody(int guides, int count) {
    return 'Apple จำกัดจำนวนที่ที่ลิงก์ไกด์เดียวจะพาไปได้ Wren จะสร้างไกด์ $guides อัน ใส่เลขกำกับให้เรียงตามลำดับ และแบ่ง $count ที่ไว้ในนั้น';
  }

  @override
  String splitConfirm(int guides) {
    return 'สร้างไกด์ $guides อัน';
  }

  @override
  String splitProgress(int done, int total) {
    return 'เปิดไกด์ที่ $done จาก $total แล้ว แตะเพื่อสร้างอันต่อไป';
  }
}
