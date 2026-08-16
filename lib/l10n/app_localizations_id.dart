// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class LId extends L {
  LId([String locale = 'id']) : super(locale);

  @override
  String get tagline => 'Burung kecil yang memberitahuku.';

  @override
  String get emptyTitle => 'Tempat, tersimpan.';

  @override
  String get emptyBody =>
      'Tangkap layar apa pun yang direkomendasikan kepadamu — reel, unggahan, pesan, satu halaman buku panduan. Wren membaca namanya dan memasukkannya ke Apple Maps.';

  @override
  String get emptyNote =>
      'Satu tempat masuk ke panduan yang sudah kamu punya. Beberapa tempat membuat panduan baru — Apple Maps tidak bisa menggabungkan panduan.';

  @override
  String get addScreenshots => 'Tambahkan tangkapan layar';

  @override
  String get readingShort => 'Membaca…';

  @override
  String readingProgress(int done, int total) {
    return 'Membaca $done dari $total…';
  }

  @override
  String get addToGuide => 'Tambahkan ke panduan';

  @override
  String makeGuide(int count) {
    return 'Buat panduan ($count)';
  }

  @override
  String get notFoundOnMap => 'Tidak ditemukan di peta';

  @override
  String get tapToSearchForIt => 'Ketuk untuk mencarinya';

  @override
  String readAs(String text) {
    return 'terbaca sebagai “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tempat tidak ditemukan. Ketuk untuk mencarinya.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Di mana tempat-tempat ini?';

  @override
  String get regionDetected =>
      'Terbaca dari keterangan gambar. Ubah kalau keliru.';

  @override
  String get regionNotDetected =>
      'Di tangkapan layar tidak disebutkan lokasinya. Dengan nama kota, pencarian jadi jauh lebih tepat.';

  @override
  String get cityOrRegion => 'Kota atau wilayah';

  @override
  String get cityExample => 'mis. Jakarta';

  @override
  String get searchAnywhere => 'Cari di mana saja';

  @override
  String get findPlaces => 'Cari tempat';

  @override
  String searchedIn(String region) {
    return 'Dicari di $region';
  }

  @override
  String get nameThisGuide => 'Beri nama panduan ini';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Panduan akan muncul dengan nama ini di Apple Maps, berisi $count tempat.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Nama panduan';

  @override
  String get guideNameExample => 'mis. Roma, Oktober';

  @override
  String get createGuide => 'Buat panduan';

  @override
  String get cancel => 'Batalkan';

  @override
  String get guidesOfAnySize => 'Panduan tanpa batas jumlah';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren menyimpan hingga $limit tempat dalam satu panduan secara gratis. Kamu memilih $selected — $over lebih banyak dari itu.';
  }

  @override
  String get onePaymentKept =>
      'Sekali bayar, selamanya milikmu. Bukan langganan.';

  @override
  String unlockFor(String price) {
    return 'Buka seharga $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Simpan $limit yang pertama saja';
  }

  @override
  String get restorePrevious => 'Pulihkan pembelian sebelumnya';

  @override
  String get restorePurchase => 'Pulihkan pembelian';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over melebihi batas gratis $limit. Kamu bisa membuka batasnya, atau menyimpan $limit yang pertama.';
  }

  @override
  String get findThisPlace => 'Cari tempat ini';

  @override
  String get searchAppleMaps => 'Cari di Apple Maps';

  @override
  String searchInRegion(String region) {
    return 'Cari di $region';
  }

  @override
  String get searching => 'Mencari…';

  @override
  String get typeTwoCharacters => 'Ketik setidaknya dua karakter.';

  @override
  String get nothingFound =>
      'Tidak ada yang ditemukan. Coba nama jalannya, atau nama yang lebih pendek.';

  @override
  String get rateLimited =>
      'Apple Maps sedang membatasi pencarian. Tunggu sebentar lalu coba lagi.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps sedang membatasi pencarian — $added sudah ditambahkan, sisanya coba sebentar lagi.';
  }

  @override
  String importSummary(int found) {
    return '$found ditemukan';
  }

  @override
  String importSummaryIn(String region) {
    return 'di $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count perlu dicek';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count tidak terbaca';
  }

  @override
  String nothingReadable(int count) {
    return 'Tidak ada yang terbaca di $count tangkapan layar';
  }

  @override
  String get couldNotOpenMaps => 'Maps tidak bisa dibuka';

  @override
  String get checkingAppleAccount => 'Memeriksa Akun Apple kamu…';

  @override
  String get restoredUnlocked =>
      'Dipulihkan. Panduan tanpa batas jumlah sudah terbuka.';

  @override
  String get noPreviousPurchase =>
      'Tidak ada pembelian sebelumnya di Akun Apple ini.';

  @override
  String get purchaseDidNotComplete =>
      'Pembelian tidak selesai, jadi tidak ada yang ditagih.';

  @override
  String alreadyInTheList(String name) {
    return '$name sudah ada di daftar.';
  }

  @override
  String get ocrUnavailable =>
      'Membaca tangkapan layar butuh iPhone — di platform ini tidak ada pengenalan teks.';

  @override
  String get lookupUnavailable =>
      'Mencari tempat butuh iPhone — di platform ini tidak ada pencarian peta.';

  @override
  String get reviewerAccess => 'Akses peninjau';

  @override
  String get code => 'Kode';

  @override
  String get unlock => 'Buka';

  @override
  String get reviewerEnabled => 'Akses peninjau diaktifkan.';

  @override
  String get codeNotRecognised => 'Kode itu tidak dikenali.';
}
