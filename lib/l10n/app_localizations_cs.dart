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
  String get emptyBodyAndroid =>
      'Open a list of places you already keep — a file exported from another map app, or a Google Takeout archive. CSV, KML, KMZ, GPX and GeoJSON are all read.';

  @override
  String get emptyNoteAndroid =>
      'Nothing leaves until you have looked at it. Wren then hands the list to a map app on the phone.';

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
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nic čitelného na $count snímcích obrazovky',
      many: 'Nic čitelného na $count snímcích obrazovky',
      few: 'Nic čitelného na $count snímcích obrazovky',
      one: 'Nic čitelného na tomto snímku obrazovky',
    );
    return '$_temp0';
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

  @override
  String get addPlaces => 'Přidat';

  @override
  String get fromFile => 'Ze souboru';

  @override
  String get fromExistingGuide => 'Z existujícího průvodce';

  @override
  String get importGuideTitle => 'Přidat do existujícího průvodce';

  @override
  String get importGuideBody =>
      'V Mapách Apple otevři průvodce, sdílej ho a vyber Kopírovat odkaz. Vlož ho níže a Wren přečte místa, která už obsahuje.';

  @override
  String get guideLinkLabel => 'Odkaz na průvodce';

  @override
  String get readGuide => 'Přečíst průvodce';

  @override
  String get importGuideNotALink =>
      'To není odkaz na průvodce z Map Apple. Otevři průvodce v Mapách, sdílej ho a vyber Kopírovat odkaz.';

  @override
  String get importGuideNothing =>
      'V tomto průvodci není nic, co by Wren mohl přenést.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Z tohoto průvodce přečteno $count míst',
      many: 'Z tohoto průvodce přečteno $count místa',
      few: 'Z tohoto průvodce přečteno $count místa',
      one: 'Z tohoto průvodce přečteno 1 místo',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count míst z něj nelze přenést',
      many: '$count místa z něj nelze přenést',
      few: '$count místa z něj nelze přenést',
      one: '1 místo z něj nelze přenést',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count míst už v tomto průvodci',
      many: '$count místa už v tomto průvodci',
      few: '$count místa už v tomto průvodci',
      one: '1 místo už v tomto průvodci',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Z „$name“';
  }

  @override
  String get republishTitle => 'Mapy vytvoří nového průvodce';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple neumožňuje přidávat místa do průvodce, který už existuje, takže Wren vytvoří nového — se všemi $count místy.',
      many:
          'Apple neumožňuje přidávat místa do průvodce, který už existuje, takže Wren vytvoří nového — se všemi $count místy.',
      few:
          'Apple neumožňuje přidávat místa do průvodce, který už existuje, takže Wren vytvoří nového — se všemi $count místy.',
      one:
          'Apple neumožňuje přidávat místa do průvodce, který už existuje, takže Wren vytvoří nového — s tím 1 místem.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Nového průvodce si nech a toho starého smaž.';

  @override
  String get republishKeepsPlaces =>
      'Wren si tato místa nechá, takže když se něco pokazí, můžeš průvodce vytvořit znovu.';

  @override
  String get makeCombinedGuide => 'Vytvořit sloučeného průvodce';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Z tohoto souboru přečteno $count míst',
      many: 'Z tohoto souboru přečteno $count místa',
      few: 'Z tohoto souboru přečteno $count místa',
      one: 'Z tohoto souboru přečteno 1 místo',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count řádků nemělo název',
      many: '$count řádku nemělo název',
      few: '$count řádky neměly název',
      one: '1 řádek neměl název',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'V tomto souboru nejsou žádná místa.';

  @override
  String get fileUnreadable =>
      'Wren nedokázal ten soubor přečíst. Čte exporty CSV, KML, KMZ, GPX, GeoJSON a Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Hledání $done z $total…';
  }

  @override
  String get combineNeedsUnlock => 'Sloučený průvodce vyžaduje odemknutí.';

  @override
  String get unlockCombineTitle => 'Přidat do průvodce, kterého už máš';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren vytvoří jednoho průvodce, ve kterém bude $count míst z tvého a k tomu ta nová.',
      many:
          'Wren vytvoří jednoho průvodce, ve kterém bude $count místa z tvého a k tomu ta nová.',
      few:
          'Wren vytvoří jednoho průvodce, ve kterém budou $count místa z tvého a k tomu ta nová.',
      one:
          'Wren vytvoří jednoho průvodce, ve kterém bude 1 místo z tvého a k tomu ta nová.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Přečte i seznam vyexportovaný z jiné aplikace: CSV, KML, KMZ, GPX, GeoJSON nebo Google Takeout.';

  @override
  String get clearList => 'Vymazat seznam';

  @override
  String get clearListTitle => 'Vymazat seznam';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Odebrat všech $count míst z Wrenu? Průvodců už vytvořených v Mapách Apple se to nedotkne.',
      many:
          'Odebrat $count místa z Wrenu? Průvodců už vytvořených v Mapách Apple se to nedotkne.',
      few:
          'Odebrat všechna $count místa z Wrenu? Průvodců už vytvořených v Mapách Apple se to nedotkne.',
      one:
          'Odebrat to jedno místo z Wrenu? Průvodců už vytvořených v Mapách Apple se to nedotkne.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Odebrat';

  @override
  String get listCleared => 'Seznam vymazán.';

  @override
  String get expandingLink => 'Načítání odkazu…';

  @override
  String get linkUnreachable =>
      'Apple se nepodařilo kontaktovat, takže odkaz nešlo přečíst. Zkontroluj připojení a zkus to znovu.';

  @override
  String get splitTitle => 'Vznikne víc než jeden průvodce';

  @override
  String splitBody(int guides, int count) {
    return 'Apple omezuje, kolik míst se vejde do jednoho odkazu na průvodce. Wren proto vytvoří několik průvodců ($guides), číslovaných tak, aby zůstalo jejich pořadí, a rozdělí do nich všechna místa ($count).';
  }

  @override
  String splitConfirm(int guides) {
    return 'Vytvořit průvodce ($guides)';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Průvodce $done z $total otevřen. Klepnutím vytvoříš dalšího.';
  }

  @override
  String get sendPlacesTo => 'Poslat místa do';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count míst je připravených k odeslání',
      many: '$count místa jsou připravená k odeslání',
      few: '$count místa jsou připravená k odeslání',
      one: '1 místo je připravené k odeslání',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count míst nemá polohu a nelze je odeslat',
      many: '$count místa nemají polohu a nelze je odeslat',
      few: '$count místa nemají polohu a nelze je odeslat',
      one: '1 místo nemá polohu a nelze ho odeslat',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Jakákoli jiná aplikace';

  @override
  String get sendPlacesFailed => 'Tato aplikace soubor nepřijala';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count míst ze souboru je připravených k odeslání do jiné mapové aplikace',
      many:
          '$count místa ze souboru jsou připravená k odeslání do jiné mapové aplikace',
      few:
          '$count místa ze souboru jsou připravená k odeslání do jiné mapové aplikace',
      one:
          '1 místo ze souboru je připravené k odeslání do jiné mapové aplikace',
    );
    return '$_temp0';
  }
}
