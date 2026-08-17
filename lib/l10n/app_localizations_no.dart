// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class LNo extends L {
  LNo([String locale = 'no']) : super(locale);

  @override
  String get tagline => 'En liten fugl hvisket det til meg.';

  @override
  String get emptyTitle => 'Steder, tatt vare på.';

  @override
  String get emptyBody =>
      'Ta et skjermbilde av det folk tipser deg om — en reel, et innlegg, en melding, en side i en reisehåndbok. Wren leser navnene og legger dem i Apple Kart.';

  @override
  String get emptyNote =>
      'Ett sted havner i en guide du allerede har. Flere blir en ny — Apple Kart kan ikke slå sammen guider.';

  @override
  String get addScreenshots => 'Legg til skjermbilder';

  @override
  String get readingShort => 'Leser…';

  @override
  String readingProgress(int done, int total) {
    return 'Leser $done av $total…';
  }

  @override
  String get addToGuide => 'Legg til i en guide';

  @override
  String makeGuide(int count) {
    return 'Lag en guide ($count)';
  }

  @override
  String get notFoundOnMap => 'Ikke funnet på kartet';

  @override
  String get tapToSearchForIt => 'Trykk for å søke etter det';

  @override
  String readAs(String text) {
    return 'lest som «$text»';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count steder ble ikke funnet. Trykk for å søke etter dem.',
      one: '1 sted ble ikke funnet. Trykk for å søke etter det.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Hvor ligger disse stedene?';

  @override
  String get regionDetected =>
      'Lest fra bildetekstene. Endre det hvis det er feil.';

  @override
  String get regionNotDetected =>
      'Skjermbildene sa ikke hvor de ligger. Med en by blir søket langt mer treffsikkert.';

  @override
  String get cityOrRegion => 'By eller område';

  @override
  String get cityExample => 'f.eks. Oslo';

  @override
  String get searchAnywhere => 'Søk overalt';

  @override
  String get findPlaces => 'Finn steder';

  @override
  String searchedIn(String region) {
    return 'Søkte i $region';
  }

  @override
  String get nameThisGuide => 'Gi guiden et navn';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Den vises under dette navnet i Apple Kart, med $count steder i.',
      one: 'Den vises under dette navnet i Apple Kart, med 1 sted i.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Navn på guiden';

  @override
  String get guideNameExample => 'f.eks. Roma, oktober';

  @override
  String get createGuide => 'Lag guide';

  @override
  String get cancel => 'Avbryt';

  @override
  String get guidesOfAnySize => 'Guider uten størrelsesgrense';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren lagrer inntil $limit steder i en guide gratis. Du har valgt $selected — $over flere enn det.';
  }

  @override
  String get onePaymentKept => 'Én betaling, din for godt. Ingen abonnement.';

  @override
  String unlockFor(String price) {
    return 'Lås opp for $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Lagre de $limit første i stedet';
  }

  @override
  String get restorePrevious => 'Gjenopprett et tidligere kjøp';

  @override
  String get restorePurchase => 'Gjenopprett kjøp';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over over gratisgrensen på $limit. Du kan låse opp, eller lagre de $limit første.';
  }

  @override
  String get findThisPlace => 'Finn dette stedet';

  @override
  String get searchAppleMaps => 'Søk i Apple Kart';

  @override
  String searchInRegion(String region) {
    return 'Søk i $region';
  }

  @override
  String get searching => 'Søker…';

  @override
  String get typeTwoCharacters => 'Skriv minst to tegn.';

  @override
  String get nothingFound =>
      'Ingenting funnet. Prøv gaten, eller et kortere navn.';

  @override
  String get rateLimited =>
      'Apple Kart begrenser antall søk. Vent litt og prøv igjen.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Kart begrenser antall søk — $added lagt til så langt, prøv resten om litt.';
  }

  @override
  String importSummary(int found) {
    return '$found funnet';
  }

  @override
  String importSummaryIn(String region) {
    return 'i $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count må ses på';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count uleselige';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ingenting leselig i $count skjermbilder',
      one: 'Ingenting leselig i dette skjermbildet',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Kart kunne ikke åpnes';

  @override
  String get checkingAppleAccount => 'Sjekker Apple-kontoen din…';

  @override
  String get restoredUnlocked =>
      'Gjenopprettet. Guider uten størrelsesgrense er låst opp.';

  @override
  String get noPreviousPurchase =>
      'Fant ingen tidligere kjøp på denne Apple-kontoen.';

  @override
  String get purchaseDidNotComplete =>
      'Kjøpet ble ikke fullført, så ingenting er belastet.';

  @override
  String alreadyInTheList(String name) {
    return '$name stod allerede på listen.';
  }

  @override
  String get ocrUnavailable =>
      'Å lese skjermbilder krever en iPhone — det finnes ingen tekstgjenkjenning på denne plattformen.';

  @override
  String get lookupUnavailable =>
      'Å søke etter steder krever en iPhone — det finnes ingen kartsøk på denne plattformen.';

  @override
  String get compAccess => 'Gratis tilgang';

  @override
  String get code => 'Kode';

  @override
  String get unlock => 'Lås opp';

  @override
  String get compChecking => 'Sjekker koden…';

  @override
  String get compEnabled => 'Gratis tilgang slått på.';

  @override
  String get compRefused =>
      'Koden ble ikke gjenkjent, eller den er allerede brukt.';

  @override
  String get compTooOften =>
      'For mange forsøk. Vent et par minutter og prøv igjen.';

  @override
  String get compUnreachable =>
      'Kunne ikke nå serveren. Sjekk forbindelsen din og prøv igjen.';

  @override
  String get compUntrusted =>
      'Svaret kunne ikke bekreftes, så ingenting ble låst opp.';

  @override
  String get addPlaces => 'Legg til';

  @override
  String get fromFile => 'Fra en fil';

  @override
  String get fromExistingGuide => 'Fra en eksisterende guide';

  @override
  String get importGuideTitle => 'Legg til i en eksisterende guide';

  @override
  String get importGuideBody =>
      'Åpne guiden i Apple Kart, del den og velg «Kopier link». Lim inn linken nedenfor, så leser Wren stedene den allerede inneholder.';

  @override
  String get guideLinkLabel => 'Link til guiden';

  @override
  String get readGuide => 'Les guide';

  @override
  String get importGuideNotALink =>
      'Det er ikke en link til en guide i Apple Kart. Åpne guiden i Kart, del den og velg «Kopier link».';

  @override
  String get importGuideNothing =>
      'Den guiden inneholder ingenting Wren kan ta med videre.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Leste $count steder fra den guiden',
      one: 'Leste 1 sted fra den guiden',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count steder i den kan ikke bli med over',
      one: '1 sted i den kan ikke bli med over',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count steder er allerede i denne guiden',
      one: '1 sted er allerede i denne guiden',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Fra «$name»';
  }

  @override
  String get republishTitle => 'Kart lager en ny guide';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple gir ingen måte å legge til i en guide som alt finnes, så Wren lager en ny med alle de $count stedene i.',
      one:
          'Apple gir ingen måte å legge til i en guide som alt finnes, så Wren lager en ny med det ene stedet i.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Behold den nye guiden og slett den gamle.';

  @override
  String get republishKeepsPlaces =>
      'Wren beholder disse stedene, så du kan lage guiden igjen hvis noe går galt.';

  @override
  String get makeCombinedGuide => 'Lag den samlede guiden';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Leste $count steder fra den filen',
      one: 'Leste 1 sted fra den filen',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rader manglet navn',
      one: '1 rad manglet navn',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Ingen steder i den filen.';

  @override
  String get fileUnreadable =>
      'Wren kunne ikke lese den filen. Den leser CSV, KML, KMZ, GPX, GeoJSON og eksporter fra Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Slår opp $done av $total…';
  }

  @override
  String get combineNeedsUnlock => 'Den samlede guiden krever at du låser opp.';

  @override
  String get unlockCombineTitle => 'Legg til i en guide du allerede har';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren lager én guide med de $count stedene som allerede er i din, sammen med de nye.',
      one:
          'Wren lager én guide med stedet som allerede er i din, sammen med det nye.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Leser også en liste eksportert fra en annen app: CSV, KML, KMZ, GPX, GeoJSON eller Google Takeout.';

  @override
  String get clearList => 'Tøm listen';

  @override
  String get clearListTitle => 'Tøm listen';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Fjerne alle de $count stedene fra Wren? Guider som alt er laget i Apple Kart, blir ikke berørt.',
      one:
          'Fjerne det ene stedet fra Wren? Guider som alt er laget i Apple Kart, blir ikke berørt.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Fjern';

  @override
  String get listCleared => 'Listen er tømt.';

  @override
  String get expandingLink => 'Leser linken…';

  @override
  String get linkUnreachable =>
      'Kunne ikke nå Apple for å lese linken. Sjekk forbindelsen din og prøv igjen.';

  @override
  String get splitTitle => 'Dette blir mer enn én guide';

  @override
  String splitBody(int guides, int count) {
    return 'Apple begrenser hvor mange steder én guidelink kan romme. Wren lager $guides guider, nummererte slik at rekkefølgen holder, med $count steder til sammen.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Lag $guides guider';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Guide $done av $total er åpnet. Trykk for å lage den neste.';
  }
}
