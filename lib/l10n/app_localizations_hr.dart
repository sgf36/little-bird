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
    return 'Ništa čitljivo na $count snimaka zaslona';
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
  String get reviewerAccess => 'Pristup za recenzente';

  @override
  String get code => 'Kôd';

  @override
  String get unlock => 'Otključaj';

  @override
  String get reviewerEnabled => 'Pristup za recenzente uključen.';

  @override
  String get codeNotRecognised => 'Taj kôd nije prepoznat.';
}
