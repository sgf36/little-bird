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
  String get emptyBodyAndroid =>
      'Screenshot what people tell you about — a reel, a post, a message, a page of a guidebook. Wren reads the names and sends them to the map app on your phone.';

  @override
  String get emptyNoteAndroid =>
      'It also reads a list you already have, and shows you every place before anything leaves.';

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
  String get compAccess => 'Akses gratis';

  @override
  String get code => 'Kode';

  @override
  String get unlock => 'Buka';

  @override
  String get compChecking => 'Memeriksa kode…';

  @override
  String get compEnabled => 'Akses gratis diaktifkan.';

  @override
  String get compRefused =>
      'Kode itu tidak dikenali, atau sudah pernah dipakai.';

  @override
  String get compTooOften =>
      'Terlalu banyak percobaan. Tunggu beberapa menit lalu coba lagi.';

  @override
  String get compUnreachable =>
      'Server tidak bisa dihubungi. Periksa koneksimu lalu coba lagi.';

  @override
  String get compUntrusted =>
      'Balasan itu tidak bisa diverifikasi, jadi tidak ada yang dibuka.';

  @override
  String get addPlaces => 'Tambah';

  @override
  String get fromFile => 'Dari file';

  @override
  String get fromExistingGuide => 'Dari panduan yang sudah ada';

  @override
  String get importGuideTitle => 'Tambahkan ke panduan yang sudah ada';

  @override
  String get importGuideBody =>
      'Di Apple Maps, buka panduannya dan bagikan, lalu pilih “Salin Tautan”. Tempelkan di bawah, dan Wren akan membaca tempat-tempat yang sudah ada di dalamnya.';

  @override
  String get guideLinkLabel => 'Tautan panduan';

  @override
  String get readGuide => 'Baca panduan';

  @override
  String get importGuideNotALink =>
      'Itu bukan tautan panduan Apple Maps. Buka panduannya di Maps, bagikan, lalu pilih “Salin Tautan”.';

  @override
  String get importGuideNothing =>
      'Panduan itu tidak berisi apa pun yang bisa ditambahkan Wren.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tempat terbaca dari panduan itu',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tempat di dalamnya tidak bisa dipindahkan',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tempat sudah ada di panduan ini',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Dari “$name”';
  }

  @override
  String get republishTitle => 'Maps membuat panduan baru';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple tidak menyediakan cara untuk menambah tempat ke panduan yang sudah ada, jadi Wren akan membuat panduan baru yang berisi $count tempat itu.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Simpan panduan baru dan hapus yang lama.';

  @override
  String get republishKeepsPlaces =>
      'Wren menyimpan tempat-tempat ini, jadi kalau ada yang tidak beres, kamu bisa membuat panduannya lagi.';

  @override
  String get makeCombinedGuide => 'Buat panduan gabungan';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tempat terbaca dari file itu',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count baris tidak punya nama',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Tidak ada tempat di file itu.';

  @override
  String get fileUnreadable =>
      'Wren tidak bisa membaca file itu. Wren membaca ekspor CSV, KML, KMZ, GPX, GeoJSON dan Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Mencari $done dari $total…';
  }

  @override
  String get combineNeedsUnlock => 'Panduan gabungan perlu dibuka dulu.';

  @override
  String get unlockCombineTitle => 'Tambahkan ke panduan yang sudah kamu punya';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren akan membuat satu panduan yang berisi $count tempat yang sudah ada di panduanmu sekaligus tempat-tempat yang baru.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Juga membaca daftar yang diekspor dari aplikasi lain: CSV, KML, KMZ, GPX, GeoJSON atau Google Takeout.';

  @override
  String get clearList => 'Kosongkan daftar';

  @override
  String get clearListTitle => 'Kosongkan daftar';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Hapus $count tempat dari Wren? Panduan yang sudah dibuat di Apple Maps tidak terpengaruh.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Hapus';

  @override
  String get listCleared => 'Daftar sudah dikosongkan.';

  @override
  String get expandingLink => 'Membaca tautan itu…';

  @override
  String get linkUnreachable =>
      'Apple tidak bisa dihubungi untuk membaca tautan itu. Periksa koneksimu lalu coba lagi.';

  @override
  String get splitTitle => 'Ini akan membuat lebih dari satu panduan';

  @override
  String splitBody(int guides, int count) {
    return 'Apple membatasi berapa banyak tempat yang bisa dibawa satu tautan panduan. Wren akan membuat $guides panduan, diberi nomor agar urutannya tetap, yang bersama-sama memuat $count tempat.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Buat $guides panduan';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Panduan $done dari $total sudah dibuka. Ketuk untuk membuat yang berikutnya.';
  }

  @override
  String get sendPlacesTo => 'Kirim tempat ke';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tempat siap dikirim',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tempat tidak punya lokasi dan tidak bisa dikirim',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Aplikasi lain';

  @override
  String get sendPlacesFailed => 'Aplikasi itu tidak menerima berkas';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count tempat disimpan dari berkas, siap dikirim ke aplikasi peta lain',
    );
    return '$_temp0';
  }

  @override
  String get compExpiring =>
      'Wren tidak dapat mengonfirmasi akses gratis Anda. Sambungkan ke internet dalam beberapa hari ke depan untuk mempertahankannya.';
}
