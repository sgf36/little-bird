// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class LNl extends L {
  LNl([String locale = 'nl']) : super(locale);

  @override
  String get tagline => 'Een vogeltje heeft het me verteld.';

  @override
  String get emptyTitle => 'Plekken, bewaard.';

  @override
  String get emptyBody =>
      'Maak een schermafbeelding van wat mensen je aanraden — een reel, een post, een bericht, een pagina uit een reisgids. Wren leest de namen en zet ze in Apple Kaarten.';

  @override
  String get emptyNote =>
      'Eén plek komt in een gids die je al hebt. Meerdere maken een nieuwe — Apple Kaarten kan gidsen niet samenvoegen.';

  @override
  String get addScreenshots => 'Schermafbeeldingen toevoegen';

  @override
  String get readingShort => 'Lezen…';

  @override
  String readingProgress(int done, int total) {
    return '$done van $total gelezen…';
  }

  @override
  String get addToGuide => 'Aan een gids toevoegen';

  @override
  String makeGuide(int count) {
    return 'Gids maken ($count)';
  }

  @override
  String get notFoundOnMap => 'Niet gevonden op de kaart';

  @override
  String get tapToSearchForIt => 'Tik om ernaar te zoeken';

  @override
  String readAs(String text) {
    return 'gelezen als ‘$text’';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plekken zijn niet gevonden. Tik om ernaar te zoeken.',
      one: '1 plek is niet gevonden. Tik om ernaar te zoeken.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Waar liggen deze plekken?';

  @override
  String get regionDetected =>
      'Uit de bijschriften gelezen. Pas het aan als het niet klopt.';

  @override
  String get regionNotDetected =>
      'In de schermafbeeldingen stond niet waar deze liggen. Met een stad wordt het zoeken veel nauwkeuriger.';

  @override
  String get cityOrRegion => 'Stad of regio';

  @override
  String get cityExample => 'bv. Amsterdam';

  @override
  String get searchAnywhere => 'Overal zoeken';

  @override
  String get findPlaces => 'Plekken zoeken';

  @override
  String searchedIn(String region) {
    return 'Gezocht in $region';
  }

  @override
  String get nameThisGuide => 'Geef deze gids een naam';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Hij verschijnt onder deze naam in Apple Kaarten, met $count plekken erin.',
      one: 'Hij verschijnt onder deze naam in Apple Kaarten, met 1 plek erin.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Naam van de gids';

  @override
  String get guideNameExample => 'bv. Rome, oktober';

  @override
  String get createGuide => 'Gids maken';

  @override
  String get cancel => 'Annuleer';

  @override
  String get guidesOfAnySize => 'Gidsen van elke omvang';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren bewaart gratis tot $limit plekken in een gids. Je hebt er $selected geselecteerd — $over meer dan dat.';
  }

  @override
  String get onePaymentKept =>
      'Eén betaling, voorgoed van jou. Geen abonnement.';

  @override
  String unlockFor(String price) {
    return 'Ontgrendel voor $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Bewaar in plaats daarvan de eerste $limit';
  }

  @override
  String get restorePrevious => 'Eerdere aankoop herstellen';

  @override
  String get restorePurchase => 'Aankoop herstellen';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over boven de gratis limiet van $limit. Je kunt ontgrendelen of de eerste $limit bewaren.';
  }

  @override
  String get findThisPlace => 'Deze plek zoeken';

  @override
  String get searchAppleMaps => 'Zoeken in Apple Kaarten';

  @override
  String searchInRegion(String region) {
    return 'Zoeken in $region';
  }

  @override
  String get searching => 'Bezig met zoeken…';

  @override
  String get typeTwoCharacters => 'Typ minstens twee tekens.';

  @override
  String get nothingFound =>
      'Niets gevonden. Probeer de straat of een kortere naam.';

  @override
  String get rateLimited =>
      'Apple Kaarten beperkt het aantal zoekopdrachten. Wacht even en probeer het opnieuw.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Kaarten beperkt het aantal zoekopdrachten — $added tot nu toe toegevoegd, probeer de rest zo meteen.';
  }

  @override
  String importSummary(int found) {
    return '$found gevonden';
  }

  @override
  String importSummaryIn(String region) {
    return 'in $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count nakijken';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count onleesbaar';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Niets leesbaars in $count schermafbeeldingen',
      one: 'Niets leesbaars in deze schermafbeelding',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Kaarten kon niet worden geopend';

  @override
  String get checkingAppleAccount => 'Je Apple Account controleren…';

  @override
  String get restoredUnlocked =>
      'Hersteld. Gidsen van elke omvang zijn ontgrendeld.';

  @override
  String get noPreviousPurchase =>
      'Geen eerdere aankoop gevonden op deze Apple Account.';

  @override
  String get purchaseDidNotComplete =>
      'De aankoop is niet voltooid, er is niets in rekening gebracht.';

  @override
  String alreadyInTheList(String name) {
    return '$name stond al in de lijst.';
  }

  @override
  String get ocrUnavailable =>
      'Voor het lezen van schermafbeeldingen is een iPhone nodig — op dit platform is er geen tekstherkenning.';

  @override
  String get lookupUnavailable =>
      'Voor het zoeken naar plekken is een iPhone nodig — op dit platform is er geen kaartzoekfunctie.';

  @override
  String get compAccess => 'Gratis toegang';

  @override
  String get code => 'Code';

  @override
  String get unlock => 'Ontgrendel';

  @override
  String get compChecking => 'Die code controleren…';

  @override
  String get compEnabled => 'Gratis toegang ingeschakeld.';

  @override
  String get compRefused => 'Die code is niet herkend, of is al gebruikt.';

  @override
  String get compTooOften =>
      'Te veel pogingen. Wacht een paar minuten en probeer het opnieuw.';

  @override
  String get compUnreachable =>
      'De server was niet bereikbaar. Controleer je verbinding en probeer het opnieuw.';

  @override
  String get compUntrusted =>
      'Dat antwoord kon niet worden geverifieerd, er is niets ontgrendeld.';

  @override
  String get addPlaces => 'Toevoegen';

  @override
  String get fromFile => 'Uit een bestand';

  @override
  String get fromExistingGuide => 'Uit een bestaande gids';

  @override
  String get importGuideTitle => 'Aan een bestaande gids toevoegen';

  @override
  String get importGuideBody =>
      'Open de gids in Apple Kaarten, deel hem en kies ‘Kopieer link’. Plak de link hieronder, dan leest Wren de plekken die er al in staan.';

  @override
  String get guideLinkLabel => 'Link naar de gids';

  @override
  String get readGuide => 'Gids lezen';

  @override
  String get importGuideNotALink =>
      'Dat is geen link naar een gids in Apple Kaarten. Open de gids in Kaarten, deel hem en kies ‘Kopieer link’.';

  @override
  String get importGuideNothing =>
      'In die gids staat niets wat Wren kan overnemen.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plekken uit die gids gelezen',
      one: '1 plek uit die gids gelezen',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plekken daarin kunnen niet worden overgenomen',
      one: '1 plek daarin kan niet worden overgenomen',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plekken staan al in deze gids',
      one: '1 plek staat al in deze gids',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Uit ‘$name’';
  }

  @override
  String get republishTitle => 'Kaarten maakt een nieuwe gids';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple biedt geen manier om een bestaande gids uit te breiden, dus maakt Wren een nieuwe met alle $count plekken erin.',
      one:
          'Apple biedt geen manier om een bestaande gids uit te breiden, dus maakt Wren een nieuwe met die ene plek erin.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Houd de nieuwe gids en verwijder de oude.';

  @override
  String get republishKeepsPlaces =>
      'Wren bewaart deze plekken, dus je kunt de gids opnieuw maken als er iets misgaat.';

  @override
  String get makeCombinedGuide => 'Gecombineerde gids maken';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plekken uit dat bestand gelezen',
      one: '1 plek uit dat bestand gelezen',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rijen hadden geen naam',
      one: '1 rij had geen naam',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Geen plekken in dat bestand.';

  @override
  String get fileUnreadable =>
      'Wren kon dat bestand niet lezen. Het leest CSV, KML, KMZ, GPX, GeoJSON en exports uit Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return '$done van $total opgezocht…';
  }

  @override
  String get combineNeedsUnlock =>
      'De gecombineerde gids vereist de ontgrendeling.';

  @override
  String get unlockCombineTitle => 'Toevoegen aan een gids die je al hebt';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren maakt één gids met de $count plekken die al in de jouwe staan en de nieuwe erbij.',
      one:
          'Wren maakt één gids met de plek die al in de jouwe staat en de nieuwe erbij.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Leest ook een lijst die uit een andere app is geëxporteerd: CSV, KML, KMZ, GPX, GeoJSON of Google Takeout.';

  @override
  String get clearList => 'Lijst wissen';

  @override
  String get clearListTitle => 'Lijst wissen';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Alle $count plekken uit Wren verwijderen? Gidsen die al in Apple Kaarten zijn gemaakt, blijven ongemoeid.',
      one:
          'De ene plek uit Wren verwijderen? Gidsen die al in Apple Kaarten zijn gemaakt, blijven ongemoeid.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Verwijder';

  @override
  String get listCleared => 'Lijst gewist.';

  @override
  String get expandingLink => 'Die link lezen…';

  @override
  String get linkUnreachable =>
      'Apple was niet bereikbaar om die link te lezen. Controleer je verbinding en probeer het opnieuw.';

  @override
  String get splitTitle => 'Dit levert meer dan één gids op';

  @override
  String splitBody(int guides, int count) {
    return 'Apple beperkt hoeveel plekken één gidslink kan bevatten. Wren maakt $guides gidsen, genummerd zodat de volgorde blijft, met samen $count plekken.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Maak $guides gidsen';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Gids $done van $total geopend. Tik om de volgende te maken.';
  }

  @override
  String get sendPlacesTo => 'Plaatsen sturen naar';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plaatsen klaar om te sturen',
      one: '1 plaats klaar om te sturen',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count plaatsen hebben geen locatie en kunnen niet worden gestuurd',
      one: '1 plaats heeft geen locatie en kan niet worden gestuurd',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Een andere app';

  @override
  String get sendPlacesFailed => 'Die app nam het bestand niet aan';
}
