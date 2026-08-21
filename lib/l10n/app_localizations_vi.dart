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
  String get compAccess => 'Quyền truy cập miễn phí';

  @override
  String get code => 'Mã';

  @override
  String get unlock => 'Mở khoá';

  @override
  String get compChecking => 'Đang kiểm tra mã…';

  @override
  String get compEnabled => 'Đã bật quyền truy cập miễn phí.';

  @override
  String get compRefused => 'Không nhận ra mã đó, hoặc mã đã được dùng rồi.';

  @override
  String get compTooOften => 'Thử quá nhiều lần. Chờ vài phút rồi thử lại.';

  @override
  String get compUnreachable =>
      'Không kết nối được với máy chủ. Kiểm tra kết nối rồi thử lại.';

  @override
  String get compUntrusted =>
      'Không xác minh được phản hồi đó nên không có gì được mở khoá.';

  @override
  String get addPlaces => 'Thêm';

  @override
  String get fromFile => 'Từ một tệp';

  @override
  String get fromExistingGuide => 'Từ một hướng dẫn có sẵn';

  @override
  String get importGuideTitle => 'Thêm vào một hướng dẫn có sẵn';

  @override
  String get importGuideBody =>
      'Trong Apple Maps, mở hướng dẫn đó và chia sẻ, rồi chọn “Sao chép liên kết”. Dán vào bên dưới và Wren sẽ đọc những địa điểm đang có trong đó.';

  @override
  String get guideLinkLabel => 'Liên kết hướng dẫn';

  @override
  String get readGuide => 'Đọc hướng dẫn';

  @override
  String get importGuideNotALink =>
      'Đó không phải liên kết hướng dẫn của Apple Maps. Mở hướng dẫn trong Maps, chia sẻ, rồi chọn “Sao chép liên kết”.';

  @override
  String get importGuideNothing => 'Hướng dẫn đó không có gì để Wren thêm vào.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã đọc $count địa điểm từ hướng dẫn đó',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count địa điểm trong đó không chuyển sang được',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count địa điểm đã có trong hướng dẫn này',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Từ “$name”';
  }

  @override
  String get republishTitle => 'Maps tạo một hướng dẫn mới';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple không có cách nào để thêm vào một hướng dẫn đã tồn tại, nên Wren sẽ tạo một hướng dẫn mới chứa cả $count địa điểm.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Giữ hướng dẫn mới và xoá hướng dẫn cũ.';

  @override
  String get republishKeepsPlaces =>
      'Wren giữ lại những địa điểm này, nên nếu có gì không ổn, bạn có thể tạo lại hướng dẫn.';

  @override
  String get makeCombinedGuide => 'Tạo hướng dẫn đã gộp';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã đọc $count địa điểm từ tệp đó',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hàng không có tên',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Không có địa điểm nào trong tệp đó.';

  @override
  String get fileUnreadable =>
      'Wren không đọc được tệp đó. Wren đọc các tệp xuất CSV, KML, KMZ, GPX, GeoJSON và Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Đang tìm $done trong $total…';
  }

  @override
  String get combineNeedsUnlock => 'Cần mở khoá để tạo hướng dẫn đã gộp.';

  @override
  String get unlockCombineTitle => 'Thêm vào hướng dẫn bạn đã có';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren sẽ tạo một hướng dẫn chứa cả $count địa điểm đang có trong hướng dẫn của bạn và những địa điểm mới.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Cũng đọc được danh sách xuất ra từ ứng dụng khác: CSV, KML, KMZ, GPX, GeoJSON hoặc Google Takeout.';

  @override
  String get clearList => 'Xoá danh sách';

  @override
  String get clearListTitle => 'Xoá danh sách';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Xoá $count địa điểm khỏi Wren? Các hướng dẫn đã tạo trong Apple Maps không bị ảnh hưởng.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Xoá hết';

  @override
  String get listCleared => 'Đã xoá danh sách.';

  @override
  String get expandingLink => 'Đang đọc liên kết đó…';

  @override
  String get linkUnreachable =>
      'Không kết nối được với Apple để đọc liên kết đó. Kiểm tra kết nối rồi thử lại.';

  @override
  String get splitTitle => 'Việc này sẽ tạo nhiều hướng dẫn';

  @override
  String splitBody(int guides, int count) {
    return 'Apple giới hạn số địa điểm mà một liên kết hướng dẫn có thể chứa. Wren sẽ tạo $guides hướng dẫn, được đánh số để giữ đúng thứ tự, cùng chứa $count địa điểm.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Tạo $guides hướng dẫn';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Đã mở hướng dẫn $done trong $total. Chạm để tạo cái tiếp theo.';
  }

  @override
  String get compExpiring =>
      'Wren không thể xác nhận quyền truy cập miễn phí của bạn. Hãy kết nối internet trong vài ngày tới để giữ quyền này.';
}
