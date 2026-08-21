// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class LMs extends L {
  LMs([String locale = 'ms']) : super(locale);

  @override
  String get tagline => 'Seekor burung kecil yang memberitahu saya.';

  @override
  String get emptyTitle => 'Tempat, tersimpan.';

  @override
  String get emptyBody =>
      'Tangkap skrin apa sahaja yang disyorkan kepada anda — reel, hantaran, mesej, satu halaman buku panduan. Wren membaca namanya dan memasukkannya ke dalam Apple Maps.';

  @override
  String get emptyNote =>
      'Satu tempat akan masuk ke panduan yang sedia ada. Beberapa tempat akan mencipta panduan baharu — Apple Maps tidak boleh menggabungkan panduan.';

  @override
  String get addScreenshots => 'Tambah tangkapan skrin';

  @override
  String get readingShort => 'Membaca…';

  @override
  String readingProgress(int done, int total) {
    return 'Membaca $done daripada $total…';
  }

  @override
  String get addToGuide => 'Tambah ke panduan';

  @override
  String makeGuide(int count) {
    return 'Cipta panduan ($count)';
  }

  @override
  String get notFoundOnMap => 'Tidak dijumpai pada peta';

  @override
  String get tapToSearchForIt => 'Ketik untuk mencarinya';

  @override
  String readAs(String text) {
    return 'dibaca sebagai “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tempat tidak dijumpai. Ketik untuk mencarinya.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Di manakah tempat-tempat ini?';

  @override
  String get regionDetected =>
      'Dibaca daripada kapsyen. Ubah jika tidak tepat.';

  @override
  String get regionNotDetected =>
      'Tangkapan skrin tidak menyatakan lokasinya. Dengan nama bandar, carian menjadi jauh lebih tepat.';

  @override
  String get cityOrRegion => 'Bandar atau wilayah';

  @override
  String get cityExample => 'cth. Kuala Lumpur';

  @override
  String get searchAnywhere => 'Cari di mana-mana';

  @override
  String get findPlaces => 'Cari tempat';

  @override
  String searchedIn(String region) {
    return 'Dicari di $region';
  }

  @override
  String get nameThisGuide => 'Namakan panduan ini';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Ia akan muncul dengan nama ini dalam Apple Maps, mengandungi $count tempat.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Nama panduan';

  @override
  String get guideNameExample => 'cth. Rom, Oktober';

  @override
  String get createGuide => 'Cipta panduan';

  @override
  String get cancel => 'Batal';

  @override
  String get guidesOfAnySize => 'Panduan tanpa had bilangan';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren menyimpan sehingga $limit tempat dalam satu panduan secara percuma. Anda memilih $selected — $over lebih daripada itu.';
  }

  @override
  String get onePaymentKept =>
      'Sekali bayar, kekal selamanya. Bukan langganan.';

  @override
  String unlockFor(String price) {
    return 'Buka dengan $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Simpan $limit yang pertama sahaja';
  }

  @override
  String get restorePrevious => 'Pulihkan pembelian terdahulu';

  @override
  String get restorePurchase => 'Pulihkan pembelian';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over melebihi had percuma $limit. Anda boleh membukanya, atau menyimpan $limit yang pertama.';
  }

  @override
  String get findThisPlace => 'Cari tempat ini';

  @override
  String get searchAppleMaps => 'Cari dalam Apple Maps';

  @override
  String searchInRegion(String region) {
    return 'Cari di $region';
  }

  @override
  String get searching => 'Mencari…';

  @override
  String get typeTwoCharacters => 'Taip sekurang-kurangnya dua aksara.';

  @override
  String get nothingFound =>
      'Tiada apa-apa dijumpai. Cuba nama jalan, atau nama yang lebih pendek.';

  @override
  String get rateLimited =>
      'Apple Maps sedang mengehadkan carian. Tunggu sebentar dan cuba lagi.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps sedang mengehadkan carian — $added telah ditambah setakat ini, cuba yang lain sebentar lagi.';
  }

  @override
  String importSummary(int found) {
    return '$found dijumpai';
  }

  @override
  String importSummaryIn(String region) {
    return 'di $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count perlu disemak';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count tidak terbaca';
  }

  @override
  String nothingReadable(int count) {
    return 'Tiada apa-apa yang boleh dibaca dalam $count tangkapan skrin';
  }

  @override
  String get couldNotOpenMaps => 'Maps tidak dapat dibuka';

  @override
  String get checkingAppleAccount => 'Menyemak Akaun Apple anda…';

  @override
  String get restoredUnlocked =>
      'Dipulihkan. Panduan tanpa had bilangan telah dibuka.';

  @override
  String get noPreviousPurchase =>
      'Tiada pembelian terdahulu dijumpai pada Akaun Apple ini.';

  @override
  String get purchaseDidNotComplete =>
      'Pembelian tidak selesai, jadi tiada apa-apa yang dicaj.';

  @override
  String alreadyInTheList(String name) {
    return '$name sudah ada dalam senarai.';
  }

  @override
  String get ocrUnavailable =>
      'Membaca tangkapan skrin memerlukan iPhone — platform ini tiada pengecaman teks.';

  @override
  String get lookupUnavailable =>
      'Mencari tempat memerlukan iPhone — platform ini tiada carian peta.';

  @override
  String get compAccess => 'Akses percuma';

  @override
  String get code => 'Kod';

  @override
  String get unlock => 'Buka';

  @override
  String get compChecking => 'Menyemak kod itu…';

  @override
  String get compEnabled => 'Akses percuma telah dihidupkan.';

  @override
  String get compRefused => 'Kod itu tidak dikenali, atau telah pun digunakan.';

  @override
  String get compTooOften =>
      'Terlalu banyak percubaan. Tunggu beberapa minit dan cuba lagi.';

  @override
  String get compUnreachable =>
      'Pelayan tidak dapat dihubungi. Semak sambungan anda dan cuba lagi.';

  @override
  String get compUntrusted =>
      'Balasan itu tidak dapat disahkan, jadi tiada apa-apa yang dibuka.';

  @override
  String get addPlaces => 'Tambah';

  @override
  String get fromFile => 'Daripada fail';

  @override
  String get fromExistingGuide => 'Daripada panduan yang sedia ada';

  @override
  String get importGuideTitle => 'Tambah ke panduan yang sedia ada';

  @override
  String get importGuideBody =>
      'Dalam Apple Maps, buka panduan itu dan kongsikannya, kemudian pilih “Salin Pautan”. Tampalkannya di bawah dan Wren akan membaca tempat yang sudah ada di dalamnya.';

  @override
  String get guideLinkLabel => 'Pautan panduan';

  @override
  String get readGuide => 'Baca panduan';

  @override
  String get importGuideNotALink =>
      'Itu bukan pautan panduan Apple Maps. Buka panduan itu dalam Maps, kongsikannya, kemudian pilih “Salin Pautan”.';

  @override
  String get importGuideNothing =>
      'Panduan itu tiada apa-apa yang boleh ditambah oleh Wren.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tempat dibaca daripada panduan itu',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tempat di dalamnya tidak dapat dipindahkan',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tempat sudah ada dalam panduan ini',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Daripada “$name”';
  }

  @override
  String get republishTitle => 'Maps mencipta panduan baharu';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple tidak menyediakan cara untuk menambah tempat ke panduan yang sudah ada, jadi Wren akan mencipta panduan baharu yang mengandungi $count tempat itu.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Simpan panduan baharu dan padamkan yang lama.';

  @override
  String get republishKeepsPlaces =>
      'Wren menyimpan tempat-tempat ini, jadi anda boleh mencipta panduan itu semula jika ada apa-apa yang tidak menjadi.';

  @override
  String get makeCombinedGuide => 'Cipta panduan gabungan';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tempat dibaca daripada fail itu',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count baris tiada nama',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Tiada tempat dalam fail itu.';

  @override
  String get fileUnreadable =>
      'Wren tidak dapat membaca fail itu. Wren membaca eksport CSV, KML, KMZ, GPX, GeoJSON dan Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Mencari $done daripada $total…';
  }

  @override
  String get combineNeedsUnlock => 'Panduan gabungan perlu dibuka dahulu.';

  @override
  String get unlockCombineTitle => 'Tambah ke panduan yang sudah anda miliki';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren akan mencipta satu panduan yang mengandungi $count tempat yang sudah ada dalam panduan anda bersama tempat yang baharu.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Juga membaca senarai yang dieksport daripada aplikasi lain: CSV, KML, KMZ, GPX, GeoJSON atau Google Takeout.';

  @override
  String get clearList => 'Kosongkan senarai';

  @override
  String get clearListTitle => 'Kosongkan senarai';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Buang $count tempat daripada Wren? Panduan yang sudah dicipta dalam Apple Maps tidak terjejas.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Buang';

  @override
  String get listCleared => 'Senarai telah dikosongkan.';

  @override
  String get expandingLink => 'Membaca pautan itu…';

  @override
  String get linkUnreachable =>
      'Apple tidak dapat dihubungi untuk membaca pautan itu. Semak sambungan anda dan cuba lagi.';

  @override
  String get splitTitle => 'Ini akan mencipta lebih daripada satu panduan';

  @override
  String splitBody(int guides, int count) {
    return 'Apple mengehadkan berapa banyak tempat yang boleh dibawa oleh satu pautan panduan. Wren akan mencipta $guides panduan, dinomborkan supaya susunannya kekal, yang bersama-sama memuatkan $count tempat.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Cipta $guides panduan';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Panduan $done daripada $total telah dibuka. Ketik untuk mencipta yang seterusnya.';
  }

  @override
  String get compExpiring =>
      'Wren tidak dapat mengesahkan akses percuma anda. Sambung ke internet dalam beberapa hari akan datang untuk mengekalkannya.';
}
