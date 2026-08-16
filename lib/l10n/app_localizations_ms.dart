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
}
