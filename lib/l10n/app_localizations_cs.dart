// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class LCs extends L {
  LCs([String locale = 'cs']) : super(locale);

  @override
  String get tagline => 'Ptáček mi to vyzradil.';

  @override
  String get emptyTitle => 'Místa, uchovaná.';

  @override
  String get emptyBody =>
      'Vyfoť si obrazovku s tím, co ti doporučí — reel, příspěvek, zprávu, stránku z průvodce. Wren přečte názvy a uloží je do Map Apple.';

  @override
  String get emptyNote =>
      'Jedno místo se přidá do průvodce, kterého už máš. Několik jich vytvoří nového — Mapy Apple neumějí průvodce slučovat.';

  @override
  String get addScreenshots => 'Přidat snímky obrazovky';

  @override
  String get readingShort => 'Načítání…';

  @override
  String readingProgress(int done, int total) {
    return 'Načítání $done z $total…';
  }

  @override
  String get addToGuide => 'Přidat do průvodce';

  @override
  String makeGuide(int count) {
    return 'Vytvořit průvodce ($count)';
  }

  @override
  String get notFoundOnMap => 'Na mapě nenalezeno';

  @override
  String get tapToSearchForIt => 'Klepnutím ho vyhledáš';

  @override
  String readAs(String text) {
    return 'přečteno jako „$text“';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count míst se nepodařilo najít. Klepnutím je vyhledáš.',
      many: '$count místa se nepodařilo najít. Klepnutím je vyhledáš.',
      few: '$count místa se nepodařilo najít. Klepnutím je vyhledáš.',
      one: '1 místo se nepodařilo najít. Klepnutím ho vyhledáš.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Kde tato místa jsou?';

  @override
  String get regionDetected => 'Přečteno z popisků. Pokud to nesedí, změň to.';

  @override
  String get regionNotDetected =>
      'Ve snímcích nebylo napsané, kde tato místa jsou. S městem bude hledání mnohem přesnější.';

  @override
  String get cityOrRegion => 'Město nebo oblast';

  @override
  String get cityExample => 'např. Praha';

  @override
  String get searchAnywhere => 'Hledat všude';

  @override
  String get findPlaces => 'Najít místa';

  @override
  String searchedIn(String region) {
    return 'Hledáno v: $region';
  }

  @override
  String get nameThisGuide => 'Pojmenuj tohoto průvodce';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pod tímto názvem se objeví v Mapách Apple, s $count místy.',
      many: 'Pod tímto názvem se objeví v Mapách Apple, s $count místy.',
      few: 'Pod tímto názvem se objeví v Mapách Apple, s $count místy.',
      one: 'Pod tímto názvem se objeví v Mapách Apple, s 1 místem.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Název průvodce';

  @override
  String get guideNameExample => 'např. Řím, říjen';

  @override
  String get createGuide => 'Vytvořit průvodce';

  @override
  String get cancel => 'Zrušit';

  @override
  String get guidesOfAnySize => 'Průvodci bez omezení';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren uloží do průvodce zdarma až $limit míst. Máš vybráno $selected — o $over víc.';
  }

  @override
  String get onePaymentKept => 'Jedna platba, navždy tvoje. Žádné předplatné.';

  @override
  String unlockFor(String price) {
    return 'Odemknout za $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Uložit raději prvních $limit';
  }

  @override
  String get restorePrevious => 'Obnovit dřívější nákup';

  @override
  String get restorePurchase => 'Obnovit nákup';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over nad bezplatný limit $limit. Můžeš odemknout, nebo uložit prvních $limit.';
  }

  @override
  String get findThisPlace => 'Najít toto místo';

  @override
  String get searchAppleMaps => 'Hledat v Mapách Apple';

  @override
  String searchInRegion(String region) {
    return 'Hledat v: $region';
  }

  @override
  String get searching => 'Hledání…';

  @override
  String get typeTwoCharacters => 'Napiš alespoň dva znaky.';

  @override
  String get nothingFound => 'Nic nenalezeno. Zkus ulici nebo kratší název.';

  @override
  String get rateLimited =>
      'Mapy Apple omezují počet dotazů. Chvíli počkej a zkus to znovu.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Mapy Apple omezují počet dotazů — zatím přidáno $added, zbytek zkus za chvíli.';
  }

  @override
  String importSummary(int found) {
    return 'nalezeno $found';
  }

  @override
  String importSummaryIn(String region) {
    return 'v: $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count ke kontrole';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count nečitelných';
  }

  @override
  String nothingReadable(int count) {
    return 'Nic čitelného na $count snímcích obrazovky';
  }

  @override
  String get couldNotOpenMaps => 'Mapy se nepodařilo otevřít';

  @override
  String get checkingAppleAccount => 'Kontrola tvého účtu Apple…';

  @override
  String get restoredUnlocked =>
      'Obnoveno. Průvodci bez omezení jsou odemčení.';

  @override
  String get noPreviousPurchase =>
      'Na tomto účtu Apple nebyl nalezen žádný dřívější nákup.';

  @override
  String get purchaseDidNotComplete =>
      'Nákup nebyl dokončen, takže nic nebylo účtováno.';

  @override
  String alreadyInTheList(String name) {
    return '$name už v seznamu bylo.';
  }

  @override
  String get ocrUnavailable =>
      'Čtení snímků obrazovky vyžaduje iPhone — na této platformě není rozpoznávání textu.';

  @override
  String get lookupUnavailable =>
      'Hledání míst vyžaduje iPhone — na této platformě není vyhledávání v mapách.';

  @override
  String get compAccess => 'Bezplatný přístup';

  @override
  String get code => 'Kód';

  @override
  String get unlock => 'Odemknout';

  @override
  String get compChecking => 'Kontrola kódu…';

  @override
  String get compEnabled => 'Bezplatný přístup zapnut.';

  @override
  String get compRefused => 'Tento kód nebyl rozpoznán, nebo už byl použit.';

  @override
  String get compTooOften =>
      'Příliš mnoho pokusů. Počkej pár minut a zkus to znovu.';

  @override
  String get compUnreachable =>
      'Server se nepodařilo kontaktovat. Zkontroluj připojení a zkus to znovu.';

  @override
  String get compUntrusted =>
      'Odpověď se nepodařilo ověřit, takže nic nebylo odemčeno.';
}
