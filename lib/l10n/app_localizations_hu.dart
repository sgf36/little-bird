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
  String get reviewerAccess => 'Ellenőri hozzáférés';

  @override
  String get code => 'Kód';

  @override
  String get unlock => 'Feloldás';

  @override
  String get reviewerEnabled => 'Ellenőri hozzáférés bekapcsolva.';

  @override
  String get codeNotRecognised => 'Ez a kód nem ismerhető fel.';
}
