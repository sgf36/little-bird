// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class LSk extends L {
  LSk([String locale = 'sk']) : super(locale);

  @override
  String get tagline => 'Vtáčik mi to pošepkal.';

  @override
  String get emptyTitle => 'Miesta, odložené.';

  @override
  String get emptyBody =>
      'Odfoť si obrazovku s tým, čo ti odporúčajú — reel, príspevok, správu, stranu zo sprievodcu. Wren prečíta názvy a uloží ich do Máp Apple.';

  @override
  String get emptyNote =>
      'Jedno miesto sa pridá do sprievodcu, ktorého už máš. Viacero ich vytvorí nového — Mapy Apple nevedia sprievodcov zlúčiť.';

  @override
  String get addScreenshots => 'Pridať snímky obrazovky';

  @override
  String get readingShort => 'Načítava sa…';

  @override
  String readingProgress(int done, int total) {
    return 'Načítava sa $done z $total…';
  }

  @override
  String get addToGuide => 'Pridať do sprievodcu';

  @override
  String makeGuide(int count) {
    return 'Vytvoriť sprievodcu ($count)';
  }

  @override
  String get notFoundOnMap => 'Na mape sa nenašlo';

  @override
  String get tapToSearchForIt => 'Klepnutím ho vyhľadáš';

  @override
  String readAs(String text) {
    return 'prečítané ako „$text“';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count miest sa nepodarilo nájsť. Klepnutím ich vyhľadáš.',
      many: '$count miesta sa nepodarilo nájsť. Klepnutím ich vyhľadáš.',
      few: '$count miesta sa nepodarilo nájsť. Klepnutím ich vyhľadáš.',
      one: '1 miesto sa nepodarilo nájsť. Klepnutím ho vyhľadáš.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Kde sa tieto miesta nachádzajú?';

  @override
  String get regionDetected => 'Prečítané z popisov. Ak to nesedí, zmeň to.';

  @override
  String get regionNotDetected =>
      'V snímkach nebolo napísané, kde sa nachádzajú. S mestom bude hľadanie oveľa presnejšie.';

  @override
  String get cityOrRegion => 'Mesto alebo oblasť';

  @override
  String get cityExample => 'napr. Bratislava';

  @override
  String get searchAnywhere => 'Hľadať všade';

  @override
  String get findPlaces => 'Nájsť miesta';

  @override
  String searchedIn(String region) {
    return 'Hľadané v: $region';
  }

  @override
  String get nameThisGuide => 'Pomenuj tohto sprievodcu';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pod týmto názvom sa objaví v Mapách Apple, s $count miestami.',
      many: 'Pod týmto názvom sa objaví v Mapách Apple, s $count miestami.',
      few: 'Pod týmto názvom sa objaví v Mapách Apple, s $count miestami.',
      one: 'Pod týmto názvom sa objaví v Mapách Apple, s 1 miestom.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Názov sprievodcu';

  @override
  String get guideNameExample => 'napr. Rím, október';

  @override
  String get createGuide => 'Vytvoriť sprievodcu';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get guidesOfAnySize => 'Sprievodcovia bez obmedzenia';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren uloží do sprievodcu zadarmo až $limit miest. Máš vybraných $selected — o $over viac.';
  }

  @override
  String get onePaymentKept => 'Jedna platba, navždy tvoja. Žiadne predplatné.';

  @override
  String unlockFor(String price) {
    return 'Odomknúť za $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Uložiť radšej prvých $limit';
  }

  @override
  String get restorePrevious => 'Obnoviť skorší nákup';

  @override
  String get restorePurchase => 'Obnoviť nákup';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over nad bezplatný limit $limit. Môžeš odomknúť alebo uložiť prvých $limit.';
  }

  @override
  String get findThisPlace => 'Nájsť toto miesto';

  @override
  String get searchAppleMaps => 'Hľadať v Mapách Apple';

  @override
  String searchInRegion(String region) {
    return 'Hľadať v: $region';
  }

  @override
  String get searching => 'Hľadá sa…';

  @override
  String get typeTwoCharacters => 'Napíš aspoň dva znaky.';

  @override
  String get nothingFound => 'Nič sa nenašlo. Skús ulicu alebo kratší názov.';

  @override
  String get rateLimited =>
      'Mapy Apple obmedzujú počet dopytov. Chvíľu počkaj a skús to znova.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Mapy Apple obmedzujú počet dopytov — zatiaľ pridaných $added, zvyšok skús o chvíľu.';
  }

  @override
  String importSummary(int found) {
    return 'nájdených $found';
  }

  @override
  String importSummaryIn(String region) {
    return 'v: $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count na kontrolu';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count nečitateľných';
  }

  @override
  String nothingReadable(int count) {
    return 'Nič čitateľné na $count snímkach obrazovky';
  }

  @override
  String get couldNotOpenMaps => 'Mapy sa nepodarilo otvoriť';

  @override
  String get checkingAppleAccount => 'Kontrola tvojho účtu Apple…';

  @override
  String get restoredUnlocked =>
      'Obnovené. Sprievodcovia bez obmedzenia sú odomknutí.';

  @override
  String get noPreviousPurchase =>
      'Na tomto účte Apple sa nenašiel žiadny skorší nákup.';

  @override
  String get purchaseDidNotComplete =>
      'Nákup nebol dokončený, takže sa nič neúčtovalo.';

  @override
  String alreadyInTheList(String name) {
    return '$name už bolo v zozname.';
  }

  @override
  String get ocrUnavailable =>
      'Čítanie snímok obrazovky vyžaduje iPhone — na tejto platforme nie je rozpoznávanie textu.';

  @override
  String get lookupUnavailable =>
      'Hľadanie miest vyžaduje iPhone — na tejto platforme nie je vyhľadávanie v mapách.';

  @override
  String get compAccess => 'Bezplatný prístup';

  @override
  String get code => 'Kód';

  @override
  String get unlock => 'Odomknúť';

  @override
  String get compChecking => 'Kontrola kódu…';

  @override
  String get compEnabled => 'Bezplatný prístup zapnutý.';

  @override
  String get compRefused => 'Tento kód nebol rozpoznaný, alebo už bol použitý.';

  @override
  String get compTooOften =>
      'Príliš veľa pokusov. Počkaj pár minút a skús to znova.';

  @override
  String get compUnreachable =>
      'Server sa nepodarilo kontaktovať. Skontroluj pripojenie a skús to znova.';

  @override
  String get compUntrusted =>
      'Odpoveď sa nepodarilo overiť, takže sa nič neodomklo.';
}
