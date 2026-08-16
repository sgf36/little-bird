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
    return 'Niets leesbaars in $count schermafbeeldingen';
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
  String get reviewerAccess => 'Toegang voor beoordelaars';

  @override
  String get code => 'Code';

  @override
  String get unlock => 'Ontgrendel';

  @override
  String get reviewerEnabled => 'Toegang voor beoordelaars ingeschakeld.';

  @override
  String get codeNotRecognised => 'Die code is niet herkend.';
}
