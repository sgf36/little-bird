// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class LSl extends L {
  LSl([String locale = 'sl']) : super(locale);

  @override
  String get tagline => 'Ptiček mi je povedal.';

  @override
  String get emptyTitle => 'Kraji, shranjeni.';

  @override
  String get emptyBody =>
      'Posnemi zaslon tistega, kar ti priporočijo — reel, objavo, sporočilo, stran iz vodnika. Wren prebere imena in jih doda v Apple Zemljevide.';

  @override
  String get emptyNote =>
      'Posamezen kraj se pridruži vodniku, ki ga že imaš. Več krajev ustvari novega — Apple Zemljevidi vodnikov ne znajo združiti.';

  @override
  String get addScreenshots => 'Dodaj posnetke zaslona';

  @override
  String get readingShort => 'Branje…';

  @override
  String readingProgress(int done, int total) {
    return 'Branje $done od $total…';
  }

  @override
  String get addToGuide => 'Dodaj v vodnik';

  @override
  String makeGuide(int count) {
    return 'Ustvari vodnik ($count)';
  }

  @override
  String get notFoundOnMap => 'Ni najdeno na zemljevidu';

  @override
  String get tapToSearchForIt => 'Tapni za iskanje';

  @override
  String readAs(String text) {
    return 'prebrano kot »$text«';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count krajev ni bilo najdenih. Tapni za iskanje.',
      few: '$count kraji niso bili najdeni. Tapni za iskanje.',
      two: '$count kraja nista bila najdena. Tapni za iskanje.',
      one: '$count kraj ni bil najden. Tapni za iskanje.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Kje so ti kraji?';

  @override
  String get regionDetected => 'Prebrano iz napisov. Spremeni, če ne drži.';

  @override
  String get regionNotDetected =>
      'Na posnetkih zaslona ni pisalo, kje so. Z mestom je iskanje precej natančnejše.';

  @override
  String get cityOrRegion => 'Mesto ali regija';

  @override
  String get cityExample => 'npr. Ljubljana';

  @override
  String get searchAnywhere => 'Išči povsod';

  @override
  String get findPlaces => 'Poišči kraje';

  @override
  String searchedIn(String region) {
    return 'Iskano v: $region';
  }

  @override
  String get nameThisGuide => 'Poimenuj ta vodnik';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Pod tem imenom se bo pojavil v Apple Zemljevidih, s $count kraji.',
      few: 'Pod tem imenom se bo pojavil v Apple Zemljevidih, s $count kraji.',
      two:
          'Pod tem imenom se bo pojavil v Apple Zemljevidih, z $count krajema.',
      one: 'Pod tem imenom se bo pojavil v Apple Zemljevidih, s $count krajem.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Ime vodnika';

  @override
  String get guideNameExample => 'npr. Rim, oktober';

  @override
  String get createGuide => 'Ustvari vodnik';

  @override
  String get cancel => 'Prekliči';

  @override
  String get guidesOfAnySize => 'Vodniki poljubne velikosti';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren brezplačno shrani do $limit krajev v vodnik. Izbral si jih $selected — $over več od tega.';
  }

  @override
  String get onePaymentKept => 'Eno plačilo, za vedno tvoje. Brez naročnine.';

  @override
  String unlockFor(String price) {
    return 'Odkleni za $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Raje shrani prvih $limit';
  }

  @override
  String get restorePrevious => 'Obnovi prejšnji nakup';

  @override
  String get restorePurchase => 'Obnovi nakup';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over nad brezplačno omejitvijo $limit. Lahko odkleneš ali shraniš prvih $limit.';
  }

  @override
  String get findThisPlace => 'Poišči ta kraj';

  @override
  String get searchAppleMaps => 'Išči v Apple Zemljevidih';

  @override
  String searchInRegion(String region) {
    return 'Išči v: $region';
  }

  @override
  String get searching => 'Iskanje…';

  @override
  String get typeTwoCharacters => 'Vpiši vsaj dva znaka.';

  @override
  String get nothingFound =>
      'Nič ni bilo najdeno. Poskusi z ulico ali krajšim imenom.';

  @override
  String get rateLimited =>
      'Apple Zemljevidi omejujejo število poizvedb. Počakaj trenutek in poskusi znova.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Zemljevidi omejujejo število poizvedb — doslej dodanih $added, ostale poskusi čez trenutek.';
  }

  @override
  String importSummary(int found) {
    return 'najdenih $found';
  }

  @override
  String importSummaryIn(String region) {
    return 'v: $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count za pregled';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count neberljivih';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nič berljivega na $count posnetkih zaslona',
      few: 'Nič berljivega na $count posnetkih zaslona',
      two: 'Nič berljivega na $count posnetkih zaslona',
      one: 'Nič berljivega na $count posnetku zaslona',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Zemljevidov ni bilo mogoče odpreti';

  @override
  String get checkingAppleAccount => 'Preverjanje tvojega računa Apple…';

  @override
  String get restoredUnlocked =>
      'Obnovljeno. Vodniki poljubne velikosti so odklenjeni.';

  @override
  String get noPreviousPurchase =>
      'Na tem računu Apple ni bilo najdenega prejšnjega nakupa.';

  @override
  String get purchaseDidNotComplete =>
      'Nakup ni bil dokončan, zato ni bilo nič zaračunano.';

  @override
  String alreadyInTheList(String name) {
    return '$name je bil že na seznamu.';
  }

  @override
  String get ocrUnavailable =>
      'Za branje posnetkov zaslona je potreben iPhone — na tej platformi ni prepoznavanja besedila.';

  @override
  String get lookupUnavailable =>
      'Za iskanje krajev je potreben iPhone — na tej platformi ni iskanja po zemljevidu.';

  @override
  String get compAccess => 'Brezplačen dostop';

  @override
  String get code => 'Koda';

  @override
  String get unlock => 'Odkleni';

  @override
  String get compChecking => 'Preverjanje kode…';

  @override
  String get compEnabled => 'Brezplačen dostop vklopljen.';

  @override
  String get compRefused =>
      'Ta koda ni bila prepoznana ali pa je bila že uporabljena.';

  @override
  String get compTooOften =>
      'Preveč poskusov. Počakaj nekaj minut in poskusi znova.';

  @override
  String get compUnreachable =>
      'Strežnika ni bilo mogoče doseči. Preveri povezavo in poskusi znova.';

  @override
  String get compUntrusted =>
      'Tega odgovora ni bilo mogoče preveriti, zato ni bilo nič odklenjeno.';

  @override
  String get addPlaces => 'Dodaj';

  @override
  String get fromFile => 'Iz datoteke';

  @override
  String get fromExistingGuide => 'Iz obstoječega vodnika';

  @override
  String get importGuideTitle => 'Dodaj v obstoječi vodnik';

  @override
  String get importGuideBody =>
      'V Apple Zemljevidih odpri vodnik, deli ga in izberi Kopiraj povezavo. Prilepi jo spodaj in Wren bo prebral kraje, ki so že v njem.';

  @override
  String get guideLinkLabel => 'Povezava do vodnika';

  @override
  String get readGuide => 'Preberi vodnik';

  @override
  String get importGuideNotALink =>
      'To ni povezava do vodnika v Apple Zemljevidih. Odpri vodnik v Zemljevidih, deli ga in izberi Kopiraj povezavo.';

  @override
  String get importGuideNothing =>
      'V tem vodniku ni ničesar, kar bi Wren lahko prenesel.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Iz tega vodnika prebranih $count krajev',
      few: 'Iz tega vodnika prebrani $count kraji',
      two: 'Iz tega vodnika prebrana $count kraja',
      one: 'Iz tega vodnika prebran $count kraj',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ni mogoče prenesti $count krajev iz njega',
      few: 'Ni mogoče prenesti $count krajev iz njega',
      two: 'Ni mogoče prenesti $count krajev iz njega',
      one: 'Ni mogoče prenesti $count kraja iz njega',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count krajev je že v tem vodniku',
      few: '$count kraji so že v tem vodniku',
      two: '$count kraja sta že v tem vodniku',
      one: '$count kraj je že v tem vodniku',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Iz »$name«';
  }

  @override
  String get republishTitle => 'Zemljevidi ustvarijo nov vodnik';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple ne omogoča dodajanja v vodnik, ki že obstaja, zato bo Wren ustvaril nov, ki bo vseboval vseh $count krajev.',
      few:
          'Apple ne omogoča dodajanja v vodnik, ki že obstaja, zato bo Wren ustvaril nov, ki bo vseboval vse $count kraje.',
      two:
          'Apple ne omogoča dodajanja v vodnik, ki že obstaja, zato bo Wren ustvaril nov, ki bo vseboval oba $count kraja.',
      one:
          'Apple ne omogoča dodajanja v vodnik, ki že obstaja, zato bo Wren ustvaril nov, ki bo vseboval $count kraj.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Nov vodnik obdrži, starega pa izbriši.';

  @override
  String get republishKeepsPlaces =>
      'Wren te kraje obdrži, tako da lahko vodnik ustvariš znova, če gre kaj narobe.';

  @override
  String get makeCombinedGuide => 'Ustvari združeni vodnik';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Iz te datoteke prebranih $count krajev',
      few: 'Iz te datoteke prebrani $count kraji',
      two: 'Iz te datoteke prebrana $count kraja',
      one: 'Iz te datoteke prebran $count kraj',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vrstic ni imelo imena',
      few: '$count vrstice niso imele imena',
      two: '$count vrstici nista imeli imena',
      one: '$count vrstica ni imela imena',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'V tej datoteki ni krajev.';

  @override
  String get fileUnreadable =>
      'Wren te datoteke ni mogel prebrati. Bere izvoze v oblikah CSV, KML, KMZ, GPX, GeoJSON in Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Iskanje $done od $total…';
  }

  @override
  String get combineNeedsUnlock => 'Za združeni vodnik je potreben odklep.';

  @override
  String get unlockCombineTitle => 'Dodaj v vodnik, ki ga že imaš';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren bo ustvaril en vodnik, ki bo vseboval $count krajev iz tvojega, skupaj z novimi.',
      few:
          'Wren bo ustvaril en vodnik, ki bo vseboval $count kraje iz tvojega, skupaj z novimi.',
      two:
          'Wren bo ustvaril en vodnik, ki bo vseboval $count kraja iz tvojega, skupaj z novimi.',
      one:
          'Wren bo ustvaril en vodnik, ki bo vseboval $count kraj iz tvojega, skupaj z novimi.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Prebere tudi seznam, izvožen iz druge aplikacije: CSV, KML, KMZ, GPX, GeoJSON ali Google Takeout.';

  @override
  String get clearList => 'Počisti seznam';

  @override
  String get clearListTitle => 'Počisti seznam';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Odstraniti vseh $count krajev iz Wrena? Na vodnike, ki so že narejeni v Apple Zemljevidih, to ne vpliva.',
      few:
          'Odstraniti vse $count kraje iz Wrena? Na vodnike, ki so že narejeni v Apple Zemljevidih, to ne vpliva.',
      two:
          'Odstraniti $count kraja iz Wrena? Na vodnike, ki so že narejeni v Apple Zemljevidih, to ne vpliva.',
      one:
          'Odstraniti $count kraj iz Wrena? Na vodnike, ki so že narejeni v Apple Zemljevidih, to ne vpliva.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Odstrani';

  @override
  String get listCleared => 'Seznam je počiščen.';

  @override
  String get expandingLink => 'Branje povezave…';

  @override
  String get linkUnreachable =>
      'Apple ni bil dosegljiv, zato povezave ni bilo mogoče prebrati. Preveri omrežno povezavo in poskusi znova.';

  @override
  String get splitTitle => 'Nastalo bo več vodnikov';

  @override
  String splitBody(int guides, int count) {
    return 'Apple omejuje, koliko krajev zmore ena povezava do vodnika. Wren bo zato ustvaril več vodnikov ($guides), številčenih tako, da ostane vrstni red, in med njih razporedil vse kraje ($count).';
  }

  @override
  String splitConfirm(int guides) {
    return 'Ustvari vodnike ($guides)';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Vodnik $done od $total odprt. Tapni za naslednjega.';
  }
}
