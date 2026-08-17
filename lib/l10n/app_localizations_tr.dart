// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class LTr extends L {
  LTr([String locale = 'tr']) : super(locale);

  @override
  String get tagline => 'Bir kuş fısıldadı.';

  @override
  String get emptyTitle => 'Mekânlar, saklı.';

  @override
  String get emptyBody =>
      'Sana önerilen şeyin ekran görüntüsünü al — bir reel, bir gönderi, bir mesaj, bir gezi rehberinin sayfası. Wren adları okur ve Apple Harita\'ya koyar.';

  @override
  String get emptyNote =>
      'Tek bir mekân, zaten sahip olduğun bir rehbere eklenir. Birden fazlası yenisini oluşturur — Apple Harita rehberleri birleştiremez.';

  @override
  String get addScreenshots => 'Ekran görüntüsü ekle';

  @override
  String get readingShort => 'Okunuyor…';

  @override
  String readingProgress(int done, int total) {
    return '$total görüntünün $done tanesi okunuyor…';
  }

  @override
  String get addToGuide => 'Bir rehbere ekle';

  @override
  String makeGuide(int count) {
    return 'Rehber oluştur ($count)';
  }

  @override
  String get notFoundOnMap => 'Haritada bulunamadı';

  @override
  String get tapToSearchForIt => 'Aramak için dokun';

  @override
  String readAs(String text) {
    return 'şöyle okundu: “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mekân bulunamadı. Aramak için dokun.',
      one: '1 mekân bulunamadı. Aramak için dokun.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Bu mekânlar nerede?';

  @override
  String get regionDetected => 'Açıklamalardan okundu. Yanlışsa değiştir.';

  @override
  String get regionNotDetected =>
      'Ekran görüntülerinde nerede olduklarını yazmıyordu. Bir şehir verirsen arama çok daha isabetli olur.';

  @override
  String get cityOrRegion => 'Şehir veya bölge';

  @override
  String get cityExample => 'örn. İstanbul';

  @override
  String get searchAnywhere => 'Her yerde ara';

  @override
  String get findPlaces => 'Mekânları bul';

  @override
  String searchedIn(String region) {
    return 'Şurada arandı: $region';
  }

  @override
  String get nameThisGuide => 'Bu rehbere bir ad ver';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Apple Harita\'da bu adla görünecek, içinde $count mekân olacak.',
      one: 'Apple Harita\'da bu adla görünecek, içinde 1 mekân olacak.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Rehber adı';

  @override
  String get guideNameExample => 'örn. Roma, ekim';

  @override
  String get createGuide => 'Rehberi oluştur';

  @override
  String get cancel => 'Vazgeç';

  @override
  String get guidesOfAnySize => 'Her boyutta rehber';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren bir rehbere ücretsiz olarak en fazla $limit mekân kaydeder. $selected tane seçtin — $over tane fazla.';
  }

  @override
  String get onePaymentKept => 'Tek ödeme, sonsuza dek senin. Abonelik yok.';

  @override
  String unlockFor(String price) {
    return '$price karşılığında aç';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Bunun yerine ilk $limit tanesini kaydet';
  }

  @override
  String get restorePrevious => 'Önceki bir satın alımı geri yükle';

  @override
  String get restorePurchase => 'Satın alımı geri yükle';

  @override
  String overFreeLimit(int over, int limit) {
    return 'Ücretsiz $limit sınırının $over üzerinde. Kilidi açabilir ya da ilk $limit tanesini kaydedebilirsin.';
  }

  @override
  String get findThisPlace => 'Bu mekânı bul';

  @override
  String get searchAppleMaps => 'Apple Harita\'da ara';

  @override
  String searchInRegion(String region) {
    return 'Şurada ara: $region';
  }

  @override
  String get searching => 'Aranıyor…';

  @override
  String get typeTwoCharacters => 'En az iki karakter yaz.';

  @override
  String get nothingFound =>
      'Hiçbir şey bulunamadı. Sokağı ya da daha kısa bir adı dene.';

  @override
  String get rateLimited =>
      'Apple Harita aramaları sınırlıyor. Biraz bekleyip yeniden dene.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Harita aramaları sınırlıyor — şu ana kadar $added tane eklendi, kalanları birazdan dene.';
  }

  @override
  String importSummary(int found) {
    return '$found bulundu';
  }

  @override
  String importSummaryIn(String region) {
    return 'şurada: $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count tanesine bakmak gerek';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count tanesi okunamadı';
  }

  @override
  String nothingReadable(int count) {
    return '$count ekran görüntüsünde okunacak bir şey yok';
  }

  @override
  String get couldNotOpenMaps => 'Harita açılamadı';

  @override
  String get checkingAppleAccount => 'Apple Hesabın kontrol ediliyor…';

  @override
  String get restoredUnlocked => 'Geri yüklendi. Her boyutta rehber açıldı.';

  @override
  String get noPreviousPurchase =>
      'Bu Apple Hesabında önceki bir satın alım bulunamadı.';

  @override
  String get purchaseDidNotComplete =>
      'Satın alma tamamlanmadı, dolayısıyla hiçbir ücret alınmadı.';

  @override
  String alreadyInTheList(String name) {
    return '$name zaten listedeydi.';
  }

  @override
  String get ocrUnavailable =>
      'Ekran görüntülerini okumak için iPhone gerekir — bu platformda metin tanıma yok.';

  @override
  String get lookupUnavailable =>
      'Mekân aramak için iPhone gerekir — bu platformda harita araması yok.';

  @override
  String get compAccess => 'Ücretsiz erişim';

  @override
  String get code => 'Kod';

  @override
  String get unlock => 'Kilidi aç';

  @override
  String get compChecking => 'Bu kod kontrol ediliyor…';

  @override
  String get compEnabled => 'Ücretsiz erişim açıldı.';

  @override
  String get compRefused => 'Bu kod tanınmadı ya da daha önce kullanılmış.';

  @override
  String get compTooOften =>
      'Çok fazla deneme yapıldı. Birkaç dakika bekleyip yeniden dene.';

  @override
  String get compUnreachable =>
      'Sunucuya ulaşılamadı. Bağlantını kontrol edip yeniden dene.';

  @override
  String get compUntrusted =>
      'Bu yanıt doğrulanamadı, bu yüzden hiçbir şeyin kilidi açılmadı.';

  @override
  String get addPlaces => 'Ekle';

  @override
  String get fromFile => 'Bir dosyadan';

  @override
  String get fromExistingGuide => 'Var olan bir rehberden';

  @override
  String get importGuideTitle => 'Var olan bir rehbere ekle';

  @override
  String get importGuideBody =>
      'Apple Harita\'da rehberi aç ve paylaş, ardından Bağlantıyı Kopyala\'yı seç. Aşağıya yapıştır, Wren de içinde zaten bulunan mekânları okur.';

  @override
  String get guideLinkLabel => 'Rehber bağlantısı';

  @override
  String get readGuide => 'Rehberi oku';

  @override
  String get importGuideNotALink =>
      'Bu bir Apple Harita rehber bağlantısı değil. Rehberi Harita\'da aç, paylaş, ardından Bağlantıyı Kopyala\'yı seç.';

  @override
  String get importGuideNothing =>
      'O rehberde Wren\'in ekleyebileceği bir şey yok.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'O rehberden $count mekân okundu',
      one: 'O rehberden 1 mekân okundu',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'İçindeki $count mekân aktarılamıyor',
      one: 'İçindeki 1 mekân aktarılamıyor',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mekân bu rehberde zaten var',
      one: '1 mekân bu rehberde zaten var',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '“$name” rehberinden';
  }

  @override
  String get republishTitle => 'Harita yeni bir rehber oluşturur';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple, var olan bir rehbere ekleme yapmanın yolunu vermiyor; bu yüzden Wren $count mekânın tümünü içeren yeni bir rehber oluşturacak.',
      one:
          'Apple, var olan bir rehbere ekleme yapmanın yolunu vermiyor; bu yüzden Wren o 1 mekânı içeren yeni bir rehber oluşturacak.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Yeni rehberi sakla, eskisini sil.';

  @override
  String get republishKeepsPlaces =>
      'Wren bu mekânları saklar, böylece bir şey ters giderse rehberi yeniden oluşturabilirsin.';

  @override
  String get makeCombinedGuide => 'Birleşik rehberi oluştur';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'O dosyadan $count mekân okundu',
      one: 'O dosyadan 1 mekân okundu',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count satırda ad yoktu',
      one: '1 satırda ad yoktu',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'O dosyada mekân yok.';

  @override
  String get fileUnreadable =>
      'Wren o dosyayı okuyamadı. CSV, KML, KMZ, GPX, GeoJSON ve Google Takeout dosyalarını okur.';

  @override
  String lookingUpProgress(int done, int total) {
    return '$total mekânın $done tanesi aranıyor…';
  }

  @override
  String get combineNeedsUnlock =>
      'Birleşik rehberi oluşturmak için kilidi açman gerekiyor.';

  @override
  String get unlockCombineTitle => 'Zaten sahip olduğun bir rehbere ekle';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren, rehberindeki $count mekânı yeni mekânlarla birlikte tek bir rehberde toplayacak.',
      one:
          'Wren, rehberindeki 1 mekânı yeni mekânla birlikte tek bir rehberde toplayacak.',
    );
    return '$_temp0';
  }
}
