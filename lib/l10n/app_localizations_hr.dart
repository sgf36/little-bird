// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class LHr extends L {
  LHr([String locale = 'hr']) : super(locale);

  @override
  String get tagline => 'Rekla mi je ptičica.';

  @override
  String get emptyTitle => 'Mjesta, sačuvana.';

  @override
  String get emptyBody =>
      'Snimi zaslon onoga što ti preporuče — reel, objavu, poruku, stranicu vodiča. Wren pročita imena i stavi ih u Apple Karte.';

  @override
  String get emptyNote =>
      'Jedno mjesto pridružuje se vodiču koji već imaš. Više njih stvara novi — Apple Karte ne mogu spojiti vodiče.';

  @override
  String get addScreenshots => 'Dodaj snimke zaslona';

  @override
  String get readingShort => 'Čitanje…';

  @override
  String readingProgress(int done, int total) {
    return 'Čitanje $done od $total…';
  }

  @override
  String get addToGuide => 'Dodaj u vodič';

  @override
  String makeGuide(int count) {
    return 'Napravi vodič ($count)';
  }

  @override
  String get notFoundOnMap => 'Nije pronađeno na karti';

  @override
  String get tapToSearchForIt => 'Dodirni za pretraživanje';

  @override
  String readAs(String text) {
    return 'pročitano kao „$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mjesta nije pronađeno. Dodirni za pretraživanje.',
      few: '$count mjesta nisu pronađena. Dodirni za pretraživanje.',
      one: '$count mjesto nije pronađeno. Dodirni za pretraživanje.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Gdje su ta mjesta?';

  @override
  String get regionDetected => 'Pročitano iz opisa. Promijeni ako nije točno.';

  @override
  String get regionNotDetected =>
      'Na snimkama zaslona nije pisalo gdje se nalaze. S gradom je pretraživanje mnogo preciznije.';

  @override
  String get cityOrRegion => 'Grad ili regija';

  @override
  String get cityExample => 'npr. Zagreb';

  @override
  String get searchAnywhere => 'Traži svugdje';

  @override
  String get findPlaces => 'Pronađi mjesta';

  @override
  String searchedIn(String region) {
    return 'Traženo u: $region';
  }

  @override
  String get nameThisGuide => 'Imenuj ovaj vodič';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pojavit će se pod ovim imenom u Apple Kartama, s $count mjesta.',
      few: 'Pojavit će se pod ovim imenom u Apple Kartama, s $count mjesta.',
      one: 'Pojavit će se pod ovim imenom u Apple Kartama, s $count mjestom.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Naziv vodiča';

  @override
  String get guideNameExample => 'npr. Rim, listopad';

  @override
  String get createGuide => 'Napravi vodič';

  @override
  String get cancel => 'Odustani';

  @override
  String get guidesOfAnySize => 'Vodiči bilo koje veličine';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren besplatno sprema do $limit mjesta u vodič. Odabrao si $selected — $over više od toga.';
  }

  @override
  String get onePaymentKept => 'Jedno plaćanje, zauvijek tvoje. Bez pretplate.';

  @override
  String unlockFor(String price) {
    return 'Otključaj za $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Radije spremi prvih $limit';
  }

  @override
  String get restorePrevious => 'Vrati prethodnu kupnju';

  @override
  String get restorePurchase => 'Vrati kupnju';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over iznad besplatnog ograničenja od $limit. Možeš otključati ili spremiti prvih $limit.';
  }

  @override
  String get findThisPlace => 'Pronađi ovo mjesto';

  @override
  String get searchAppleMaps => 'Traži u Apple Kartama';

  @override
  String searchInRegion(String region) {
    return 'Traži u: $region';
  }

  @override
  String get searching => 'Traženje…';

  @override
  String get typeTwoCharacters => 'Upiši barem dva znaka.';

  @override
  String get nothingFound =>
      'Ništa nije pronađeno. Probaj ulicu ili kraće ime.';

  @override
  String get rateLimited =>
      'Apple Karte ograničavaju broj upita. Pričekaj trenutak i pokušaj ponovno.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Karte ograničavaju broj upita — dodano je $added do sada, ostatak pokušaj za koji trenutak.';
  }

  @override
  String importSummary(int found) {
    return 'pronađeno $found';
  }

  @override
  String importSummaryIn(String region) {
    return 'u: $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count za provjeru';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count nečitljivih';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ništa čitljivo na $count snimaka zaslona',
      few: 'Ništa čitljivo na $count snimke zaslona',
      one: 'Ništa čitljivo na $count snimci zaslona',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Karte se nisu mogle otvoriti';

  @override
  String get checkingAppleAccount => 'Provjera tvog Apple računa…';

  @override
  String get restoredUnlocked =>
      'Vraćeno. Vodiči bilo koje veličine su otključani.';

  @override
  String get noPreviousPurchase =>
      'Na ovom Apple računu nije pronađena prethodna kupnja.';

  @override
  String get purchaseDidNotComplete =>
      'Kupnja nije dovršena pa ništa nije naplaćeno.';

  @override
  String alreadyInTheList(String name) {
    return '$name je već bilo na popisu.';
  }

  @override
  String get ocrUnavailable =>
      'Za čitanje snimaka zaslona potreban je iPhone — na ovoj platformi nema prepoznavanja teksta.';

  @override
  String get lookupUnavailable =>
      'Za traženje mjesta potreban je iPhone — na ovoj platformi nema pretraživanja karte.';

  @override
  String get compAccess => 'Besplatan pristup';

  @override
  String get code => 'Kôd';

  @override
  String get unlock => 'Otključaj';

  @override
  String get compChecking => 'Provjera kôda…';

  @override
  String get compEnabled => 'Besplatan pristup uključen.';

  @override
  String get compRefused => 'Taj kôd nije prepoznat ili je već iskorišten.';

  @override
  String get compTooOften =>
      'Previše pokušaja. Pričekaj nekoliko minuta i pokušaj ponovno.';

  @override
  String get compUnreachable =>
      'Poslužitelju nije bilo moguće pristupiti. Provjeri vezu i pokušaj ponovno.';

  @override
  String get compUntrusted =>
      'Taj odgovor nije bilo moguće provjeriti pa ništa nije otključano.';

  @override
  String get addPlaces => 'Dodaj';

  @override
  String get fromFile => 'Iz datoteke';

  @override
  String get fromExistingGuide => 'Iz postojećeg vodiča';

  @override
  String get importGuideTitle => 'Dodaj u postojeći vodič';

  @override
  String get importGuideBody =>
      'U Apple Kartama otvori vodič, podijeli ga i odaberi Kopiraj link. Zalijepi ga niže i Wren će pročitati mjesta koja su već u njemu.';

  @override
  String get guideLinkLabel => 'Link do vodiča';

  @override
  String get readGuide => 'Pročitaj vodič';

  @override
  String get importGuideNotALink =>
      'To nije link vodiča Apple Karata. Otvori vodič u Kartama, podijeli ga i odaberi Kopiraj link.';

  @override
  String get importGuideNothing =>
      'U tom vodiču nema ničega što bi Wren mogao prenijeti.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pročitano $count mjesta iz tog vodiča',
      few: 'Pročitana $count mjesta iz tog vodiča',
      one: 'Pročitano $count mjesto iz tog vodiča',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mjesta iz njega nije moguće prenijeti',
      few: '$count mjesta iz njega nije moguće prenijeti',
      one: '$count mjesto iz njega nije moguće prenijeti',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mjesta već u ovom vodiču',
      few: '$count mjesta već u ovom vodiču',
      one: '$count mjesto već u ovom vodiču',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Iz „$name”';
  }

  @override
  String get republishTitle => 'Karte prave novi vodič';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple ne omogućuje dodavanje u vodič koji već postoji, pa će Wren napraviti novi koji sadrži svih $count mjesta.',
      few:
          'Apple ne omogućuje dodavanje u vodič koji već postoji, pa će Wren napraviti novi koji sadrži sva $count mjesta.',
      one:
          'Apple ne omogućuje dodavanje u vodič koji već postoji, pa će Wren napraviti novi koji sadrži to $count mjesto.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Zadrži novi vodič i izbriši stari.';

  @override
  String get republishKeepsPlaces =>
      'Wren zadržava ova mjesta, pa vodič možeš napraviti ponovno ako nešto krene po zlu.';

  @override
  String get makeCombinedGuide => 'Napravi spojeni vodič';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pročitano $count mjesta iz te datoteke',
      few: 'Pročitana $count mjesta iz te datoteke',
      one: 'Pročitano $count mjesto iz te datoteke',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count redaka nije imalo ime',
      few: '$count retka nisu imala ime',
      one: '$count redak nije imao ime',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'U toj datoteci nema nijednog mjesta.';

  @override
  String get fileUnreadable =>
      'Wren nije mogao pročitati tu datoteku. Čita izvoze u formatima CSV, KML, KMZ, GPX, GeoJSON i Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Traženje $done od $total…';
  }

  @override
  String get combineNeedsUnlock => 'Spojeni vodič zahtijeva otključavanje.';

  @override
  String get unlockCombineTitle => 'Dodaj u vodič koji već imaš';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren će napraviti jedan vodič koji sadrži $count mjesta iz tvojeg, zajedno s novima.',
      few:
          'Wren će napraviti jedan vodič koji sadrži $count mjesta iz tvojeg, zajedno s novima.',
      one:
          'Wren će napraviti jedan vodič koji sadrži $count mjesto iz tvojeg, zajedno s novima.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Čita i popis izvezen iz druge aplikacije: CSV, KML, KMZ, GPX, GeoJSON ili Google Takeout.';

  @override
  String get clearList => 'Očisti popis';

  @override
  String get clearListTitle => 'Očisti popis';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Ukloniti svih $count mjesta iz Wrena? Vodiči koji su već napravljeni u Apple Kartama ostaju nedirnuti.',
      few:
          'Ukloniti sva $count mjesta iz Wrena? Vodiči koji su već napravljeni u Apple Kartama ostaju nedirnuti.',
      one:
          'Ukloniti $count mjesto iz Wrena? Vodiči koji su već napravljeni u Apple Kartama ostaju nedirnuti.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Ukloni';

  @override
  String get listCleared => 'Popis je očišćen.';

  @override
  String get expandingLink => 'Čitanje linka…';

  @override
  String get linkUnreachable =>
      'Appleu nije bilo moguće pristupiti da bi se link pročitao. Provjeri vezu i pokušaj ponovno.';

  @override
  String get splitTitle => 'Bit će više od jednog vodiča';

  @override
  String splitBody(int guides, int count) {
    return 'Apple ograničava koliko mjesta može stati u jedan link vodiča. Wren će zato napraviti nekoliko vodiča ($guides), numeriranih tako da ostane redoslijed, i rasporediti u njih sva mjesta ($count).';
  }

  @override
  String splitConfirm(int guides) {
    return 'Napravi vodiče ($guides)';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Vodič $done od $total otvoren. Dodirni za sljedeći.';
  }
}
