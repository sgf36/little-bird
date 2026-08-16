// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class LVi extends L {
  LVi([String locale = 'vi']) : super(locale);

  @override
  String get tagline => 'Một chú chim nhỏ mách tôi.';

  @override
  String get emptyTitle => 'Những nơi, được giữ lại.';

  @override
  String get emptyBody =>
      'Chụp màn hình những gì người ta gợi ý cho bạn — một reel, một bài đăng, một tin nhắn, một trang sách hướng dẫn du lịch. Wren đọc tên và đưa chúng vào Apple Maps.';

  @override
  String get emptyNote =>
      'Một địa điểm sẽ được thêm vào hướng dẫn bạn đã có. Nhiều địa điểm sẽ tạo hướng dẫn mới — Apple Maps không gộp được các hướng dẫn.';

  @override
  String get addScreenshots => 'Thêm ảnh chụp màn hình';

  @override
  String get readingShort => 'Đang đọc…';

  @override
  String readingProgress(int done, int total) {
    return 'Đang đọc $done trong $total…';
  }

  @override
  String get addToGuide => 'Thêm vào một hướng dẫn';

  @override
  String makeGuide(int count) {
    return 'Tạo hướng dẫn ($count)';
  }

  @override
  String get notFoundOnMap => 'Không tìm thấy trên bản đồ';

  @override
  String get tapToSearchForIt => 'Chạm để tìm';

  @override
  String readAs(String text) {
    return 'đọc thành “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Không tìm thấy $count địa điểm. Chạm để tìm.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Những nơi này ở đâu?';

  @override
  String get regionDetected => 'Đọc từ phần chú thích. Sửa lại nếu không đúng.';

  @override
  String get regionNotDetected =>
      'Ảnh chụp màn hình không nói những nơi này ở đâu. Có tên thành phố thì tìm kiếm chính xác hơn nhiều.';

  @override
  String get cityOrRegion => 'Thành phố hoặc khu vực';

  @override
  String get cityExample => 'vd. Hà Nội';

  @override
  String get searchAnywhere => 'Tìm ở mọi nơi';

  @override
  String get findPlaces => 'Tìm địa điểm';

  @override
  String searchedIn(String region) {
    return 'Đã tìm ở $region';
  }

  @override
  String get nameThisGuide => 'Đặt tên cho hướng dẫn này';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nó sẽ hiện với tên này trong Apple Maps, gồm $count địa điểm.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Tên hướng dẫn';

  @override
  String get guideNameExample => 'vd. Rome, tháng 10';

  @override
  String get createGuide => 'Tạo hướng dẫn';

  @override
  String get cancel => 'Huỷ';

  @override
  String get guidesOfAnySize => 'Hướng dẫn không giới hạn';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren lưu miễn phí tối đa $limit địa điểm trong một hướng dẫn. Bạn đang chọn $selected — nhiều hơn $over.';
  }

  @override
  String get onePaymentKept =>
      'Trả một lần, giữ mãi mãi. Không phải gói thuê bao.';

  @override
  String unlockFor(String price) {
    return 'Mở khoá với $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Chỉ lưu $limit địa điểm đầu tiên';
  }

  @override
  String get restorePrevious => 'Khôi phục giao dịch trước đây';

  @override
  String get restorePurchase => 'Khôi phục giao dịch';

  @override
  String overFreeLimit(int over, int limit) {
    return 'Vượt $over so với giới hạn miễn phí là $limit. Bạn có thể mở khoá, hoặc lưu $limit địa điểm đầu tiên.';
  }

  @override
  String get findThisPlace => 'Tìm địa điểm này';

  @override
  String get searchAppleMaps => 'Tìm trong Apple Maps';

  @override
  String searchInRegion(String region) {
    return 'Tìm ở $region';
  }

  @override
  String get searching => 'Đang tìm…';

  @override
  String get typeTwoCharacters => 'Nhập ít nhất hai ký tự.';

  @override
  String get nothingFound =>
      'Không tìm thấy gì. Thử tên đường, hoặc một cái tên ngắn hơn.';

  @override
  String get rateLimited =>
      'Apple Maps đang giới hạn số lần tìm. Chờ một lát rồi thử lại.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps đang giới hạn số lần tìm — đã thêm $added địa điểm, phần còn lại thử lại sau một lát.';
  }

  @override
  String importSummary(int found) {
    return 'tìm thấy $found';
  }

  @override
  String importSummaryIn(String region) {
    return 'ở $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count cần xem lại';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count không đọc được';
  }

  @override
  String nothingReadable(int count) {
    return 'Không đọc được gì trong $count ảnh chụp màn hình';
  }

  @override
  String get couldNotOpenMaps => 'Không mở được Maps';

  @override
  String get checkingAppleAccount => 'Đang kiểm tra Tài khoản Apple của bạn…';

  @override
  String get restoredUnlocked =>
      'Đã khôi phục. Hướng dẫn không giới hạn đã được mở khoá.';

  @override
  String get noPreviousPurchase =>
      'Không tìm thấy giao dịch trước đây trên Tài khoản Apple này.';

  @override
  String get purchaseDidNotComplete =>
      'Giao dịch chưa hoàn tất nên không có khoản nào bị tính phí.';

  @override
  String alreadyInTheList(String name) {
    return '$name đã có trong danh sách.';
  }

  @override
  String get ocrUnavailable =>
      'Đọc ảnh chụp màn hình cần iPhone — nền tảng này không có nhận dạng văn bản.';

  @override
  String get lookupUnavailable =>
      'Tìm địa điểm cần iPhone — nền tảng này không có tìm kiếm trên bản đồ.';

  @override
  String get reviewerAccess => 'Quyền truy cập của người kiểm duyệt';

  @override
  String get code => 'Mã';

  @override
  String get unlock => 'Mở khoá';

  @override
  String get reviewerEnabled => 'Đã bật quyền truy cập của người kiểm duyệt.';

  @override
  String get codeNotRecognised => 'Không nhận ra mã đó.';
}
