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
    return 'Ingenting leselig i $count skjermbilder';
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
  String get reviewerAccess => 'Tilgang for anmeldere';

  @override
  String get code => 'Kode';

  @override
  String get unlock => 'Lås opp';

  @override
  String get reviewerEnabled => 'Tilgang for anmeldere slått på.';

  @override
  String get codeNotRecognised => 'Koden ble ikke gjenkjent.';
}
