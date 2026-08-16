// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class LDe extends L {
  LDe([String locale = 'de']) : super(locale);

  @override
  String get tagline => 'Ein Vögelchen hat mir gezwitschert.';

  @override
  String get emptyTitle => 'Orte, aufgehoben.';

  @override
  String get emptyBody =>
      'Mach einen Screenshot von dem, was dir empfohlen wird — ein Reel, ein Post, eine Nachricht, eine Seite aus einem Reiseführer. Wren liest die Namen und legt sie in Apple Karten ab.';

  @override
  String get emptyNote =>
      'Ein einzelner Ort kommt in einen Guide, den du schon hast. Mehrere ergeben einen neuen — Apple Karten kann Guides nicht zusammenführen.';

  @override
  String get addScreenshots => 'Screenshots hinzufügen';

  @override
  String get readingShort => 'Wird gelesen…';

  @override
  String readingProgress(int done, int total) {
    return '$done von $total werden gelesen…';
  }

  @override
  String get addToGuide => 'Zu einem Guide hinzufügen';

  @override
  String makeGuide(int count) {
    return 'Guide erstellen ($count)';
  }

  @override
  String get notFoundOnMap => 'Nicht auf der Karte gefunden';

  @override
  String get tapToSearchForIt => 'Tippen, um danach zu suchen';

  @override
  String readAs(String text) {
    return 'gelesen als „$text“';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Orte wurden nicht gefunden. Tippen, um danach zu suchen.',
      one: '1 Ort wurde nicht gefunden. Tippen, um danach zu suchen.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Wo liegen diese Orte?';

  @override
  String get regionDetected =>
      'Aus den Bildunterschriften gelesen. Ändere es, falls das nicht stimmt.';

  @override
  String get regionNotDetected =>
      'In den Screenshots stand nicht, wo diese Orte liegen. Mit einer Stadt wird die Suche deutlich genauer.';

  @override
  String get cityOrRegion => 'Stadt oder Region';

  @override
  String get cityExample => 'z. B. Berlin';

  @override
  String get searchAnywhere => 'Überall suchen';

  @override
  String get findPlaces => 'Orte finden';

  @override
  String searchedIn(String region) {
    return 'Gesucht in $region';
  }

  @override
  String get nameThisGuide => 'Diesen Guide benennen';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Unter diesem Namen erscheint er in Apple Karten, mit $count Orten darin.',
      one: 'Unter diesem Namen erscheint er in Apple Karten, mit 1 Ort darin.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Name des Guides';

  @override
  String get guideNameExample => 'z. B. Rom, Oktober';

  @override
  String get createGuide => 'Guide erstellen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get guidesOfAnySize => 'Guides in jeder Größe';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren sichert kostenlos bis zu $limit Orte in einem Guide. Du hast $selected ausgewählt — $over mehr als das.';
  }

  @override
  String get onePaymentKept => 'Einmal zahlen, für immer behalten. Kein Abo.';

  @override
  String unlockFor(String price) {
    return 'Für $price freischalten';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Stattdessen die ersten $limit sichern';
  }

  @override
  String get restorePrevious => 'Früheren Kauf wiederherstellen';

  @override
  String get restorePurchase => 'Kauf wiederherstellen';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over über dem kostenlosen Limit von $limit. Du kannst freischalten oder die ersten $limit sichern.';
  }

  @override
  String get findThisPlace => 'Diesen Ort finden';

  @override
  String get searchAppleMaps => 'In Apple Karten suchen';

  @override
  String searchInRegion(String region) {
    return 'In $region suchen';
  }

  @override
  String get searching => 'Wird gesucht…';

  @override
  String get typeTwoCharacters => 'Gib mindestens zwei Zeichen ein.';

  @override
  String get nothingFound =>
      'Nichts gefunden. Versuch die Straße oder einen kürzeren Namen.';

  @override
  String get rateLimited =>
      'Apple Karten drosselt die Abfragen. Warte einen Moment und versuch es erneut.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Karten drosselt die Abfragen — $added bisher hinzugefügt, versuch den Rest gleich noch einmal.';
  }

  @override
  String importSummary(int found) {
    return '$found gefunden';
  }

  @override
  String importSummaryIn(String region) {
    return 'in $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count zu prüfen';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count unlesbar';
  }

  @override
  String nothingReadable(int count) {
    return 'Nichts Lesbares in $count Screenshots';
  }

  @override
  String get couldNotOpenMaps => 'Karten konnte nicht geöffnet werden';

  @override
  String get checkingAppleAccount => 'Dein Apple-Account wird geprüft…';

  @override
  String get restoredUnlocked =>
      'Wiederhergestellt. Guides in jeder Größe sind freigeschaltet.';

  @override
  String get noPreviousPurchase =>
      'Kein früherer Kauf mit diesem Apple-Account gefunden.';

  @override
  String get purchaseDidNotComplete =>
      'Der Kauf wurde nicht abgeschlossen, es wurde nichts berechnet.';

  @override
  String alreadyInTheList(String name) {
    return '$name war bereits in der Liste.';
  }

  @override
  String get ocrUnavailable =>
      'Zum Lesen von Screenshots wird ein iPhone benötigt — auf dieser Plattform gibt es keine Texterkennung.';

  @override
  String get lookupUnavailable =>
      'Für die Ortssuche wird ein iPhone benötigt — auf dieser Plattform gibt es keine Kartensuche.';

  @override
  String get compAccess => 'Kostenloser Zugang';

  @override
  String get code => 'Code';

  @override
  String get unlock => 'Freischalten';

  @override
  String get compChecking => 'Der Code wird geprüft…';

  @override
  String get compEnabled => 'Kostenloser Zugang aktiviert.';

  @override
  String get compRefused =>
      'Dieser Code wurde nicht erkannt oder wurde bereits verwendet.';

  @override
  String get compTooOften =>
      'Zu viele Versuche. Warte ein paar Minuten und versuch es erneut.';

  @override
  String get compUnreachable =>
      'Der Server war nicht erreichbar. Prüf deine Verbindung und versuch es erneut.';

  @override
  String get compUntrusted =>
      'Diese Antwort ließ sich nicht verifizieren, es wurde nichts freigeschaltet.';
}
