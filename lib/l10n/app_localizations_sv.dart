// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class LSv extends L {
  LSv([String locale = 'sv']) : super(locale);

  @override
  String get tagline => 'En liten fågel viskade det.';

  @override
  String get emptyTitle => 'Platser, sparade.';

  @override
  String get emptyBody =>
      'Skärmavbilda det folk tipsar dig om — en reel, ett inlägg, ett meddelande, en sida ur en reseguide. Wren läser namnen och lägger in dem i Apple Kartor.';

  @override
  String get emptyNote =>
      'En ensam plats hamnar i en guide du redan har. Flera blir en ny — Apple Kartor kan inte slå ihop guider.';

  @override
  String get emptyBodyAndroid =>
      'Skärmavbilda det folk tipsar dig om — en reel, ett inlägg, ett meddelande, en sida ur en reseguide. Wren läser namnen och skickar dem till kartappen i din telefon.';

  @override
  String get emptyNoteAndroid =>
      'Den läser också en lista du redan har, och visar dig varje plats innan något skickas.';

  @override
  String get addScreenshots => 'Lägg till skärmavbilder';

  @override
  String get readingShort => 'Läser…';

  @override
  String readingProgress(int done, int total) {
    return 'Läser $done av $total…';
  }

  @override
  String get addToGuide => 'Lägg till i en guide';

  @override
  String makeGuide(int count) {
    return 'Skapa en guide ($count)';
  }

  @override
  String get notFoundOnMap => 'Hittades inte på kartan';

  @override
  String get tapToSearchForIt => 'Tryck för att söka efter den';

  @override
  String readAs(String text) {
    return 'läst som ”$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count platser hittades inte. Tryck för att söka efter dem.',
      one: '1 plats hittades inte. Tryck för att söka efter den.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Var ligger de här platserna?';

  @override
  String get regionDetected =>
      'Läst ur bildtexterna. Ändra om det inte stämmer.';

  @override
  String get regionNotDetected =>
      'Inget i skärmavbilderna sa var de ligger. Med en stad blir sökningen mycket träffsäkrare.';

  @override
  String get cityOrRegion => 'Stad eller region';

  @override
  String get cityExample => 't.ex. Stockholm';

  @override
  String get searchAnywhere => 'Sök överallt';

  @override
  String get findPlaces => 'Hitta platser';

  @override
  String searchedIn(String region) {
    return 'Sökte i $region';
  }

  @override
  String get nameThisGuide => 'Ge guiden ett namn';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Den visas under det här namnet i Apple Kartor, med $count platser i.',
      one: 'Den visas under det här namnet i Apple Kartor, med 1 plats i.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Guidens namn';

  @override
  String get guideNameExample => 't.ex. Rom, oktober';

  @override
  String get createGuide => 'Skapa guide';

  @override
  String get cancel => 'Avbryt';

  @override
  String get guidesOfAnySize => 'Guider utan storleksgräns';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren sparar upp till $limit platser i en guide gratis. Du har valt $selected — $over fler än så.';
  }

  @override
  String get onePaymentKept =>
      'En betalning, din för gott. Ingen prenumeration.';

  @override
  String unlockFor(String price) {
    return 'Lås upp för $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Spara de $limit första i stället';
  }

  @override
  String get restorePrevious => 'Återskapa ett tidigare köp';

  @override
  String get restorePurchase => 'Återskapa köp';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over över gratisgränsen på $limit. Du kan låsa upp, eller spara de $limit första.';
  }

  @override
  String get findThisPlace => 'Hitta den här platsen';

  @override
  String get searchAppleMaps => 'Sök i Apple Kartor';

  @override
  String searchInRegion(String region) {
    return 'Sök i $region';
  }

  @override
  String get searching => 'Söker…';

  @override
  String get typeTwoCharacters => 'Skriv minst två tecken.';

  @override
  String get nothingFound =>
      'Inget hittades. Prova med gatan, eller ett kortare namn.';

  @override
  String get rateLimited =>
      'Apple Kartor begränsar antalet sökningar. Vänta en stund och försök igen.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Kartor begränsar antalet sökningar — $added tillagda hittills, prova resten om en stund.';
  }

  @override
  String importSummary(int found) {
    return '$found hittade';
  }

  @override
  String importSummaryIn(String region) {
    return 'i $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count att titta på';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count oläsliga';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Inget läsbart i $count skärmavbilder',
      one: 'Inget läsbart i den här skärmavbilden',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Det gick inte att öppna Kartor';

  @override
  String get checkingAppleAccount => 'Kollar ditt Apple-konto…';

  @override
  String get restoredUnlocked =>
      'Återskapat. Guider utan storleksgräns är upplåsta.';

  @override
  String get noPreviousPurchase =>
      'Inget tidigare köp hittades på det här Apple-kontot.';

  @override
  String get purchaseDidNotComplete =>
      'Köpet slutfördes inte, så inget har debiterats.';

  @override
  String alreadyInTheList(String name) {
    return '$name fanns redan i listan.';
  }

  @override
  String get ocrUnavailable =>
      'Att läsa skärmavbilder kräver en iPhone — det finns ingen textigenkänning på den här plattformen.';

  @override
  String get lookupUnavailable =>
      'Att söka platser kräver en iPhone — det finns ingen kartsökning på den här plattformen.';

  @override
  String get compAccess => 'Kostnadsfri åtkomst';

  @override
  String get code => 'Kod';

  @override
  String get unlock => 'Lås upp';

  @override
  String get compChecking => 'Kollar koden…';

  @override
  String get compEnabled => 'Kostnadsfri åtkomst påslagen.';

  @override
  String get compRefused =>
      'Koden känns inte igen, eller så är den redan använd.';

  @override
  String get compTooOften =>
      'För många försök. Vänta några minuter och försök igen.';

  @override
  String get compUnreachable =>
      'Det gick inte att nå servern. Kontrollera din anslutning och försök igen.';

  @override
  String get compUntrusted =>
      'Svaret kunde inte verifieras, så inget har låsts upp.';

  @override
  String get addPlaces => 'Lägg till';

  @override
  String get fromFile => 'Från en fil';

  @override
  String get fromExistingGuide => 'Från en befintlig guide';

  @override
  String get importGuideTitle => 'Lägg till i en befintlig guide';

  @override
  String get importGuideBody =>
      'Öppna guiden i Apple Kartor, dela den och välj ”Kopiera länk”. Klistra in länken nedan, så läser Wren de platser den redan innehåller.';

  @override
  String get guideLinkLabel => 'Länk till guiden';

  @override
  String get readGuide => 'Läs guide';

  @override
  String get importGuideNotALink =>
      'Det är ingen länk till en guide i Apple Kartor. Öppna guiden i Kartor, dela den och välj ”Kopiera länk”.';

  @override
  String get importGuideNothing =>
      'Den guiden innehåller inget som Wren kan ta med.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Läste $count platser från den guiden',
      one: 'Läste 1 plats från den guiden',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count platser i den kan inte följa med',
      one: '1 plats i den kan inte följa med',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count platser finns redan i den här guiden',
      one: '1 plats finns redan i den här guiden',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Från ”$name”';
  }

  @override
  String get republishTitle => 'Kartor skapar en ny guide';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple ger inget sätt att lägga till i en guide som redan finns, så Wren skapar en ny med alla $count platser i.',
      one:
          'Apple ger inget sätt att lägga till i en guide som redan finns, så Wren skapar en ny med den enda platsen i.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Behåll den nya guiden och radera den gamla.';

  @override
  String get republishKeepsPlaces =>
      'Wren behåller de här platserna, så du kan skapa guiden igen om något går fel.';

  @override
  String get makeCombinedGuide => 'Skapa den sammanslagna guiden';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Läste $count platser från den filen',
      one: 'Läste 1 plats från den filen',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rader saknade namn',
      one: '1 rad saknade namn',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Inga platser i den filen.';

  @override
  String get fileUnreadable =>
      'Wren kunde inte läsa den filen. Den läser CSV, KML, KMZ, GPX, GeoJSON och exporter från Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Slår upp $done av $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'Den sammanslagna guiden kräver att du låser upp.';

  @override
  String get unlockCombineTitle => 'Lägg till i en guide du redan har';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren skapar en enda guide med de $count platser som redan finns i din, tillsammans med de nya.',
      one:
          'Wren skapar en enda guide med platsen som redan finns i din, tillsammans med den nya.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Läser även en lista exporterad från en annan app: CSV, KML, KMZ, GPX, GeoJSON eller Google Takeout.';

  @override
  String get clearList => 'Rensa listan';

  @override
  String get clearListTitle => 'Rensa listan';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Ta bort alla $count platser från Wren? Guider som redan skapats i Apple Kartor påverkas inte.',
      one:
          'Ta bort den enda platsen från Wren? Guider som redan skapats i Apple Kartor påverkas inte.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Ta bort';

  @override
  String get listCleared => 'Listan är rensad.';

  @override
  String get expandingLink => 'Läser länken…';

  @override
  String get linkUnreachable =>
      'Det gick inte att nå Apple för att läsa länken. Kontrollera din anslutning och försök igen.';

  @override
  String get splitTitle => 'Det blir mer än en guide';

  @override
  String splitBody(int guides, int count) {
    return 'Apple begränsar hur många platser en guidelänk kan bära. Wren skapar $guides guider, numrerade så att ordningen håller, med $count platser tillsammans.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Skapa $guides guider';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Guide $done av $total är öppnad. Tryck för att skapa nästa.';
  }

  @override
  String get sendPlacesTo => 'Skicka platser till';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count platser är klara att skicka',
      one: '1 plats är klar att skicka',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count platser saknar position och kan inte skickas',
      one: '1 plats saknar position och kan inte skickas',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Någon annan app';

  @override
  String get sendPlacesFailed => 'Appen tog inte emot filen';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count platser behölls från filen, klara för en annan kartapp',
      one: '1 plats behölls från filen, klar för en annan kartapp',
    );
    return '$_temp0';
  }

  @override
  String get compExpiring =>
      'Wren kunde inte bekräfta din kostnadsfria åtkomst. Anslut till internet under de närmaste dagarna för att behålla den.';
}
