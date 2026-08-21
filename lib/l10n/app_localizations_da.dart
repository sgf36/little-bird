// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class LDa extends L {
  LDa([String locale = 'da']) : super(locale);

  @override
  String get tagline => 'En lille fugl har hvisket mig det.';

  @override
  String get emptyTitle => 'Steder, gemt.';

  @override
  String get emptyBody =>
      'Tag et skærmbillede af det, folk anbefaler dig — en reel, et opslag, en besked, en side i en rejseguide. Wren læser navnene og lægger dem i Apple Kort.';

  @override
  String get emptyNote =>
      'Ét sted lægger sig i en guide, du allerede har. Flere bliver til en ny — Apple Kort kan ikke slå guider sammen.';

  @override
  String get addScreenshots => 'Tilføj skærmbilleder';

  @override
  String get readingShort => 'Læser…';

  @override
  String readingProgress(int done, int total) {
    return 'Læser $done af $total…';
  }

  @override
  String get addToGuide => 'Føj til en guide';

  @override
  String makeGuide(int count) {
    return 'Lav en guide ($count)';
  }

  @override
  String get notFoundOnMap => 'Ikke fundet på kortet';

  @override
  String get tapToSearchForIt => 'Tryk for at søge efter det';

  @override
  String readAs(String text) {
    return 'læst som »$text«';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count steder blev ikke fundet. Tryk for at søge efter dem.',
      one: '1 sted blev ikke fundet. Tryk for at søge efter det.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Hvor ligger de her steder?';

  @override
  String get regionDetected =>
      'Læst i billedteksterne. Ret det, hvis det er forkert.';

  @override
  String get regionNotDetected =>
      'Der stod ikke i skærmbillederne, hvor de ligger. Med en by bliver søgningen langt mere præcis.';

  @override
  String get cityOrRegion => 'By eller område';

  @override
  String get cityExample => 'f.eks. København';

  @override
  String get searchAnywhere => 'Søg alle steder';

  @override
  String get findPlaces => 'Find steder';

  @override
  String searchedIn(String region) {
    return 'Søgte i $region';
  }

  @override
  String get nameThisGuide => 'Giv guiden et navn';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Den vises under dette navn i Apple Kort, med $count steder i.',
      one: 'Den vises under dette navn i Apple Kort, med 1 sted i.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Guidens navn';

  @override
  String get guideNameExample => 'f.eks. Rom, oktober';

  @override
  String get createGuide => 'Opret guide';

  @override
  String get cancel => 'Annuller';

  @override
  String get guidesOfAnySize => 'Guider uden størrelsesgrænse';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren gemmer op til $limit steder i en guide gratis. Du har valgt $selected — $over flere end det.';
  }

  @override
  String get onePaymentKept => 'Én betaling, din for altid. Intet abonnement.';

  @override
  String unlockFor(String price) {
    return 'Lås op for $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Gem de første $limit i stedet';
  }

  @override
  String get restorePrevious => 'Gendan et tidligere køb';

  @override
  String get restorePurchase => 'Gendan køb';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over over den gratis grænse på $limit. Du kan låse op eller gemme de første $limit.';
  }

  @override
  String get findThisPlace => 'Find dette sted';

  @override
  String get searchAppleMaps => 'Søg i Apple Kort';

  @override
  String searchInRegion(String region) {
    return 'Søg i $region';
  }

  @override
  String get searching => 'Søger…';

  @override
  String get typeTwoCharacters => 'Skriv mindst to tegn.';

  @override
  String get nothingFound =>
      'Intet fundet. Prøv med gaden eller et kortere navn.';

  @override
  String get rateLimited =>
      'Apple Kort begrænser antallet af opslag. Vent et øjeblik, og prøv igen.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Kort begrænser antallet af opslag — $added tilføjet indtil videre, prøv resten om lidt.';
  }

  @override
  String importSummary(int found) {
    return '$found fundet';
  }

  @override
  String importSummaryIn(String region) {
    return 'i $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count skal ses efter';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count ulæselige';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Intet læsbart i $count skærmbilleder',
      one: 'Intet læsbart i dette skærmbillede',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Kort kunne ikke åbnes';

  @override
  String get checkingAppleAccount => 'Tjekker din Apple-konto…';

  @override
  String get restoredUnlocked =>
      'Gendannet. Guider uden størrelsesgrænse er låst op.';

  @override
  String get noPreviousPurchase =>
      'Der blev ikke fundet et tidligere køb på denne Apple-konto.';

  @override
  String get purchaseDidNotComplete =>
      'Købet blev ikke gennemført, så der er ikke trukket noget.';

  @override
  String alreadyInTheList(String name) {
    return '$name stod allerede på listen.';
  }

  @override
  String get ocrUnavailable =>
      'At læse skærmbilleder kræver en iPhone — der er ingen tekstgenkendelse på denne platform.';

  @override
  String get lookupUnavailable =>
      'At søge efter steder kræver en iPhone — der er ingen kortsøgning på denne platform.';

  @override
  String get compAccess => 'Gratis adgang';

  @override
  String get code => 'Kode';

  @override
  String get unlock => 'Lås op';

  @override
  String get compChecking => 'Tjekker koden…';

  @override
  String get compEnabled => 'Gratis adgang slået til.';

  @override
  String get compRefused =>
      'Koden blev ikke genkendt, eller den er allerede brugt.';

  @override
  String get compTooOften =>
      'For mange forsøg. Vent et par minutter, og prøv igen.';

  @override
  String get compUnreachable =>
      'Serveren kunne ikke nås. Tjek din forbindelse, og prøv igen.';

  @override
  String get compUntrusted =>
      'Svaret kunne ikke bekræftes, så der blev ikke låst op for noget.';

  @override
  String get addPlaces => 'Tilføj';

  @override
  String get fromFile => 'Fra en fil';

  @override
  String get fromExistingGuide => 'Fra en eksisterende guide';

  @override
  String get importGuideTitle => 'Føj til en eksisterende guide';

  @override
  String get importGuideBody =>
      'Åbn guiden i Apple Kort, del den, og vælg »Kopier link«. Indsæt linket nedenfor, så læser Wren de steder, den allerede indeholder.';

  @override
  String get guideLinkLabel => 'Link til guiden';

  @override
  String get readGuide => 'Læs guide';

  @override
  String get importGuideNotALink =>
      'Det er ikke et link til en guide i Apple Kort. Åbn guiden i Kort, del den, og vælg »Kopier link«.';

  @override
  String get importGuideNothing =>
      'Den guide indeholder ikke noget, Wren kan tage med over.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Læste $count steder fra den guide',
      one: 'Læste 1 sted fra den guide',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count steder i den kan ikke føres med over',
      one: '1 sted i den kan ikke føres med over',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count steder er allerede i denne guide',
      one: '1 sted er allerede i denne guide',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Fra »$name«';
  }

  @override
  String get republishTitle => 'Kort laver en ny guide';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple giver ingen mulighed for at føje til en guide, der allerede findes, så Wren laver en ny med alle $count steder i.',
      one:
          'Apple giver ingen mulighed for at føje til en guide, der allerede findes, så Wren laver en ny med det ene sted i.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Behold den nye guide, og slet den gamle.';

  @override
  String get republishKeepsPlaces =>
      'Wren beholder disse steder, så du kan lave guiden igen, hvis noget går galt.';

  @override
  String get makeCombinedGuide => 'Lav den samlede guide';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Læste $count steder fra den fil',
      one: 'Læste 1 sted fra den fil',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rækker havde intet navn',
      one: '1 række havde intet navn',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Ingen steder i den fil.';

  @override
  String get fileUnreadable =>
      'Wren kunne ikke læse den fil. Den læser CSV, KML, KMZ, GPX, GeoJSON og eksporter fra Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Slår $done af $total op…';
  }

  @override
  String get combineNeedsUnlock => 'Den samlede guide kræver, at du låser op.';

  @override
  String get unlockCombineTitle => 'Føj til en guide, du allerede har';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren laver én guide med de $count steder, der allerede er i din, sammen med de nye.',
      one:
          'Wren laver én guide med det sted, der allerede er i din, sammen med det nye.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Læser også en liste eksporteret fra en anden app: CSV, KML, KMZ, GPX, GeoJSON eller Google Takeout.';

  @override
  String get clearList => 'Ryd listen';

  @override
  String get clearListTitle => 'Ryd listen';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Fjern alle $count steder fra Wren? Guider, der allerede er lavet i Apple Kort, bliver ikke berørt.',
      one:
          'Fjern det ene sted fra Wren? Guider, der allerede er lavet i Apple Kort, bliver ikke berørt.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Fjern';

  @override
  String get listCleared => 'Listen er ryddet.';

  @override
  String get expandingLink => 'Læser linket…';

  @override
  String get linkUnreachable =>
      'Kunne ikke nå Apple for at læse linket. Tjek din forbindelse, og prøv igen.';

  @override
  String get splitTitle => 'Det bliver mere end én guide';

  @override
  String splitBody(int guides, int count) {
    return 'Apple begrænser, hvor mange steder ét guidelink kan rumme. Wren laver $guides guider, nummererede så rækkefølgen holder, med $count steder tilsammen.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Lav $guides guider';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Guide $done af $total er åbnet. Tryk for at lave den næste.';
  }

  @override
  String get compExpiring =>
      'Wren kunne ikke bekræfte din gratis adgang. Opret forbindelse til internettet i løbet af de næste par dage for at beholde den.';
}
