// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class LHu extends L {
  LHu([String locale = 'hu']) : super(locale);

  @override
  String get tagline => 'Egy kismadár csiripelte.';

  @override
  String get emptyTitle => 'Helyek, eltéve.';

  @override
  String get emptyBody =>
      'Készíts képernyőképet arról, amit ajánlanak neked — egy reelről, egy posztról, egy üzenetről, egy útikönyv oldaláról. A Wren kiolvassa a neveket, és beteszi őket az Apple Térképekbe.';

  @override
  String get emptyNote =>
      'Egyetlen hely bekerül egy már meglévő útikalauzba. Több helyből új készül — az Apple Térképek nem tud útikalauzokat összevonni.';

  @override
  String get addScreenshots => 'Képernyőképek hozzáadása';

  @override
  String get readingShort => 'Olvasás…';

  @override
  String readingProgress(int done, int total) {
    return '$done / $total olvasása…';
  }

  @override
  String get addToGuide => 'Hozzáadás egy útikalauzhoz';

  @override
  String makeGuide(int count) {
    return 'Útikalauz készítése ($count)';
  }

  @override
  String get notFoundOnMap => 'Nem található a térképen';

  @override
  String get tapToSearchForIt => 'Koppints rá a kereséshez';

  @override
  String readAs(String text) {
    return 'így olvasva: „$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hely nem található. Koppints rájuk a kereséshez.',
      one: '1 hely nem található. Koppints rá a kereséshez.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Hol vannak ezek a helyek?';

  @override
  String get regionDetected =>
      'A képaláírásokból olvasva. Írd át, ha nem stimmel.';

  @override
  String get regionNotDetected =>
      'A képernyőképeken nem szerepelt, hol vannak. Egy várossal a keresés sokkal pontosabb lesz.';

  @override
  String get cityOrRegion => 'Város vagy régió';

  @override
  String get cityExample => 'pl. Budapest';

  @override
  String get searchAnywhere => 'Keresés mindenhol';

  @override
  String get findPlaces => 'Helyek keresése';

  @override
  String searchedIn(String region) {
    return 'Keresés itt: $region';
  }

  @override
  String get nameThisGuide => 'Nevezd el ezt az útikalauzt';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ezen a néven jelenik meg az Apple Térképekben, $count hellyel.',
      one: 'Ezen a néven jelenik meg az Apple Térképekben, 1 hellyel.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Az útikalauz neve';

  @override
  String get guideNameExample => 'pl. Róma, október';

  @override
  String get createGuide => 'Útikalauz létrehozása';

  @override
  String get cancel => 'Mégse';

  @override
  String get guidesOfAnySize => 'Bármekkora útikalauz';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'A Wren ingyen legfeljebb $limit helyet ment egy útikalauzba. $selected van kijelölve — $over darabbal több.';
  }

  @override
  String get onePaymentKept =>
      'Egyszeri fizetés, örökre a tiéd. Nincs előfizetés.';

  @override
  String unlockFor(String price) {
    return 'Feloldás $price összegért';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Inkább az első $limit mentése';
  }

  @override
  String get restorePrevious => 'Korábbi vásárlás visszaállítása';

  @override
  String get restorePurchase => 'Vásárlás visszaállítása';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over darabbal az ingyenes $limit fölött. Feloldhatod, vagy elmentheted az első $limit helyet.';
  }

  @override
  String get findThisPlace => 'Ennek a helynek a megkeresése';

  @override
  String get searchAppleMaps => 'Keresés az Apple Térképekben';

  @override
  String searchInRegion(String region) {
    return 'Keresés itt: $region';
  }

  @override
  String get searching => 'Keresés…';

  @override
  String get typeTwoCharacters => 'Írj be legalább két karaktert.';

  @override
  String get nothingFound =>
      'Nincs találat. Próbáld az utcával vagy egy rövidebb névvel.';

  @override
  String get rateLimited =>
      'Az Apple Térképek korlátozza a lekérdezéseket. Várj egy kicsit, és próbáld újra.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Az Apple Térképek korlátozza a lekérdezéseket — eddig $added került be, a többit próbáld meg kicsit később.';
  }

  @override
  String importSummary(int found) {
    return '$found találat';
  }

  @override
  String importSummaryIn(String region) {
    return 'itt: $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count átnézendő';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count olvashatatlan';
  }

  @override
  String nothingReadable(int count) {
    return 'Semmi olvasható $count képernyőképen';
  }

  @override
  String get couldNotOpenMaps => 'A Térképek nem nyitható meg';

  @override
  String get checkingAppleAccount => 'Apple-fiókod ellenőrzése…';

  @override
  String get restoredUnlocked =>
      'Visszaállítva. A bármekkora útikalauz fel van oldva.';

  @override
  String get noPreviousPurchase =>
      'Nem található korábbi vásárlás ezen az Apple-fiókon.';

  @override
  String get purchaseDidNotComplete =>
      'A vásárlás nem fejeződött be, így semmit nem számoltunk fel.';

  @override
  String alreadyInTheList(String name) {
    return '$name már szerepelt a listán.';
  }

  @override
  String get ocrUnavailable =>
      'A képernyőképek olvasásához iPhone kell — ezen a platformon nincs szövegfelismerés.';

  @override
  String get lookupUnavailable =>
      'A helykereséshez iPhone kell — ezen a platformon nincs térképes keresés.';

  @override
  String get compAccess => 'Ingyenes hozzáférés';

  @override
  String get code => 'Kód';

  @override
  String get unlock => 'Feloldás';

  @override
  String get compChecking => 'A kód ellenőrzése…';

  @override
  String get compEnabled => 'Ingyenes hozzáférés bekapcsolva.';

  @override
  String get compRefused =>
      'Ez a kód nem ismerhető fel, vagy már felhasználták.';

  @override
  String get compTooOften =>
      'Túl sok próbálkozás. Várj néhány percet, és próbáld újra.';

  @override
  String get compUnreachable =>
      'A kiszolgáló nem érhető el. Ellenőrizd a kapcsolatot, és próbáld újra.';

  @override
  String get compUntrusted =>
      'A válasz nem volt ellenőrizhető, ezért semmi nem oldódott fel.';

  @override
  String get addPlaces => 'Hozzáadás';

  @override
  String get fromFile => 'Fájlból';

  @override
  String get fromExistingGuide => 'Meglévő útikalauzból';

  @override
  String get importGuideTitle => 'Hozzáadás meglévő útikalauzhoz';

  @override
  String get importGuideBody =>
      'Az Apple Térképekben nyisd meg az útikalauzt és oszd meg, majd válaszd a Hivatkozás másolása lehetőséget. Illeszd be alább, és a Wren kiolvassa a benne lévő helyeket.';

  @override
  String get guideLinkLabel => 'Útikalauz hivatkozása';

  @override
  String get readGuide => 'Útikalauz beolvasása';

  @override
  String get importGuideNotALink =>
      'Ez nem Apple Térképek útikalauz-hivatkozás. Nyisd meg az útikalauzt a Térképekben, oszd meg, majd válaszd a Hivatkozás másolása lehetőséget.';

  @override
  String get importGuideNothing =>
      'Abban az útikalauzban nincs semmi, amit a Wren hozzá tudna adni.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hely beolvasva abból az útikalauzból',
      one: '1 hely beolvasva abból az útikalauzból',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hely nem vihető át belőle',
      one: '1 hely nem vihető át belőle',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hely már szerepel ebben az útikalauzban',
      one: '1 hely már szerepel ebben az útikalauzban',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '„$name” útikalauzból';
  }

  @override
  String get republishTitle => 'A Térképek új útikalauzt készít';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Az Apple nem ad módot arra, hogy egy meglévő útikalauzhoz helyeket adjunk, ezért a Wren új útikalauzt készít, amelyben mindegyik hely szerepel, összesen $count.',
      one:
          'Az Apple nem ad módot arra, hogy egy meglévő útikalauzhoz helyet adjunk, ezért a Wren új útikalauzt készít, amelyben az az 1 hely szerepel.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Tartsd meg az új útikalauzt, a régit pedig töröld.';

  @override
  String get republishKeepsPlaces =>
      'A Wren megőrzi ezeket a helyeket, így ha valami félresikerül, újra elkészítheted az útikalauzt.';

  @override
  String get makeCombinedGuide => 'Az összevont útikalauz elkészítése';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hely beolvasva abból a fájlból',
      one: '1 hely beolvasva abból a fájlból',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sorban nem volt név',
      one: '1 sorban nem volt név',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Nincs hely abban a fájlban.';

  @override
  String get fileUnreadable =>
      'A Wren nem tudta beolvasni azt a fájlt. CSV-, KML-, KMZ-, GPX-, GeoJSON- és Google Takeout-fájlokat olvas.';

  @override
  String lookingUpProgress(int done, int total) {
    return '$done / $total keresése…';
  }

  @override
  String get combineNeedsUnlock =>
      'Az összevont útikalauz elkészítéséhez feloldás kell.';

  @override
  String get unlockCombineTitle => 'Hozzáadás a saját útikalauzodhoz';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'A Wren egyetlen útikalauzt készít, amelyben a sajátodban már meglévő $count hely és az új helyek együtt szerepelnek.',
      one:
          'A Wren egyetlen útikalauzt készít, amelyben a sajátodban már meglévő 1 hely és az új hely együtt szerepel.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Más appból exportált listát is beolvas: CSV, KML, KMZ, GPX, GeoJSON vagy Google Takeout.';

  @override
  String get clearList => 'Lista kiürítése';

  @override
  String get clearListTitle => 'Lista kiürítése';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Eltávolítod mind a $count helyet a Wrenből? Az Apple Térképekben már elkészült útikalauzokat ez nem érinti.',
      one:
          'Eltávolítod azt az 1 helyet a Wrenből? Az Apple Térképekben már elkészült útikalauzokat ez nem érinti.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Eltávolítás';

  @override
  String get listCleared => 'A lista kiürítve.';

  @override
  String get expandingLink => 'A hivatkozás beolvasása…';

  @override
  String get linkUnreachable =>
      'Nem sikerült elérni az Apple-t a hivatkozás beolvasásához. Ellenőrizd a kapcsolatot, és próbáld újra.';

  @override
  String get splitTitle => 'Ez több útikalauzt készít';

  @override
  String splitBody(int guides, int count) {
    return 'Az Apple korlátozza, hogy egy útikalauz-hivatkozás hány helyet vihet. A Wren $guides útikalauzt készít, megszámozva, hogy sorrendben maradjanak, és ezek együtt $count helyet tartalmaznak.';
  }

  @override
  String splitConfirm(int guides) {
    return '$guides útikalauz készítése';
  }

  @override
  String splitProgress(int done, int total) {
    return '$done / $total útikalauz megnyitva. Koppints a következő elkészítéséhez.';
  }
}
