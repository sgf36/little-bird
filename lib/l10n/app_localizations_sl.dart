// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class LSl extends L {
  LSl([String locale = 'sl']) : super(locale);

  @override
  String get tagline => 'Ptiček mi je povedal.';

  @override
  String get emptyTitle => 'Kraji, shranjeni.';

  @override
  String get emptyBody =>
      'Posnemi zaslon tistega, kar ti priporočijo — reel, objavo, sporočilo, stran iz vodnika. Wren prebere imena in jih doda v Apple Zemljevide.';

  @override
  String get emptyNote =>
      'Posamezen kraj se pridruži vodniku, ki ga že imaš. Več krajev ustvari novega — Apple Zemljevidi vodnikov ne znajo združiti.';

  @override
  String get addScreenshots => 'Dodaj posnetke zaslona';

  @override
  String get readingShort => 'Branje…';

  @override
  String readingProgress(int done, int total) {
    return 'Branje $done od $total…';
  }

  @override
  String get addToGuide => 'Dodaj v vodnik';

  @override
  String makeGuide(int count) {
    return 'Ustvari vodnik ($count)';
  }

  @override
  String get notFoundOnMap => 'Ni najdeno na zemljevidu';

  @override
  String get tapToSearchForIt => 'Tapni za iskanje';

  @override
  String readAs(String text) {
    return 'prebrano kot »$text«';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count krajev ni bilo najdenih. Tapni za iskanje.',
      few: '$count kraji niso bili najdeni. Tapni za iskanje.',
      two: '$count kraja nista bila najdena. Tapni za iskanje.',
      one: '$count kraj ni bil najden. Tapni za iskanje.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Kje so ti kraji?';

  @override
  String get regionDetected => 'Prebrano iz napisov. Spremeni, če ne drži.';

  @override
  String get regionNotDetected =>
      'Na posnetkih zaslona ni pisalo, kje so. Z mestom je iskanje precej natančnejše.';

  @override
  String get cityOrRegion => 'Mesto ali regija';

  @override
  String get cityExample => 'npr. Ljubljana';

  @override
  String get searchAnywhere => 'Išči povsod';

  @override
  String get findPlaces => 'Poišči kraje';

  @override
  String searchedIn(String region) {
    return 'Iskano v: $region';
  }

  @override
  String get nameThisGuide => 'Poimenuj ta vodnik';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Pod tem imenom se bo pojavil v Apple Zemljevidih, s $count kraji.',
      few: 'Pod tem imenom se bo pojavil v Apple Zemljevidih, s $count kraji.',
      two:
          'Pod tem imenom se bo pojavil v Apple Zemljevidih, z $count krajema.',
      one: 'Pod tem imenom se bo pojavil v Apple Zemljevidih, s $count krajem.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Ime vodnika';

  @override
  String get guideNameExample => 'npr. Rim, oktober';

  @override
  String get createGuide => 'Ustvari vodnik';

  @override
  String get cancel => 'Prekliči';

  @override
  String get guidesOfAnySize => 'Vodniki poljubne velikosti';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren brezplačno shrani do $limit krajev v vodnik. Izbral si jih $selected — $over več od tega.';
  }

  @override
  String get onePaymentKept => 'Eno plačilo, za vedno tvoje. Brez naročnine.';

  @override
  String unlockFor(String price) {
    return 'Odkleni za $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Raje shrani prvih $limit';
  }

  @override
  String get restorePrevious => 'Obnovi prejšnji nakup';

  @override
  String get restorePurchase => 'Obnovi nakup';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over nad brezplačno omejitvijo $limit. Lahko odkleneš ali shraniš prvih $limit.';
  }

  @override
  String get findThisPlace => 'Poišči ta kraj';

  @override
  String get searchAppleMaps => 'Išči v Apple Zemljevidih';

  @override
  String searchInRegion(String region) {
    return 'Išči v: $region';
  }

  @override
  String get searching => 'Iskanje…';

  @override
  String get typeTwoCharacters => 'Vpiši vsaj dva znaka.';

  @override
  String get nothingFound =>
      'Nič ni bilo najdeno. Poskusi z ulico ali krajšim imenom.';

  @override
  String get rateLimited =>
      'Apple Zemljevidi omejujejo število poizvedb. Počakaj trenutek in poskusi znova.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Zemljevidi omejujejo število poizvedb — doslej dodanih $added, ostale poskusi čez trenutek.';
  }

  @override
  String importSummary(int found) {
    return 'najdenih $found';
  }

  @override
  String importSummaryIn(String region) {
    return 'v: $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count za pregled';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count neberljivih';
  }

  @override
  String nothingReadable(int count) {
    return 'Nič berljivega na $count posnetkih zaslona';
  }

  @override
  String get couldNotOpenMaps => 'Zemljevidov ni bilo mogoče odpreti';

  @override
  String get checkingAppleAccount => 'Preverjanje tvojega računa Apple…';

  @override
  String get restoredUnlocked =>
      'Obnovljeno. Vodniki poljubne velikosti so odklenjeni.';

  @override
  String get noPreviousPurchase =>
      'Na tem računu Apple ni bilo najdenega prejšnjega nakupa.';

  @override
  String get purchaseDidNotComplete =>
      'Nakup ni bil dokončan, zato ni bilo nič zaračunano.';

  @override
  String alreadyInTheList(String name) {
    return '$name je bil že na seznamu.';
  }

  @override
  String get ocrUnavailable =>
      'Za branje posnetkov zaslona je potreben iPhone — na tej platformi ni prepoznavanja besedila.';

  @override
  String get lookupUnavailable =>
      'Za iskanje krajev je potreben iPhone — na tej platformi ni iskanja po zemljevidu.';

  @override
  String get compAccess => 'Brezplačen dostop';

  @override
  String get code => 'Koda';

  @override
  String get unlock => 'Odkleni';

  @override
  String get compChecking => 'Preverjanje kode…';

  @override
  String get compEnabled => 'Brezplačen dostop vklopljen.';

  @override
  String get compRefused =>
      'Ta koda ni bila prepoznana ali pa je bila že uporabljena.';

  @override
  String get compTooOften =>
      'Preveč poskusov. Počakaj nekaj minut in poskusi znova.';

  @override
  String get compUnreachable =>
      'Strežnika ni bilo mogoče doseči. Preveri povezavo in poskusi znova.';

  @override
  String get compUntrusted =>
      'Tega odgovora ni bilo mogoče preveriti, zato ni bilo nič odklenjeno.';
}
