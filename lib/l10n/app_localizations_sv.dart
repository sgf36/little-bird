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
    return 'Inget läsbart i $count skärmavbilder';
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
  String get reviewerAccess => 'Granskaråtkomst';

  @override
  String get code => 'Kod';

  @override
  String get unlock => 'Lås upp';

  @override
  String get reviewerEnabled => 'Granskaråtkomst påslagen.';

  @override
  String get codeNotRecognised => 'Koden känns inte igen.';
}
