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
  String get emptyBodyAndroid =>
      'Open a list of places you already keep — a file exported from another map app, or a Google Takeout archive. CSV, KML, KMZ, GPX and GeoJSON are all read.';

  @override
  String get emptyNoteAndroid =>
      'Nothing leaves until you have looked at it. Wren then hands the list to a map app on the phone.';

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
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nichts Lesbares in $count Screenshots',
      one: 'Nichts Lesbares in diesem Screenshot',
    );
    return '$_temp0';
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

  @override
  String get addPlaces => 'Hinzufügen';

  @override
  String get fromFile => 'Aus einer Datei';

  @override
  String get fromExistingGuide => 'Aus einem bestehenden Guide';

  @override
  String get importGuideTitle => 'Zu einem bestehenden Guide hinzufügen';

  @override
  String get importGuideBody =>
      'Öffne den Guide in Apple Karten, teile ihn und wähle „Link kopieren“. Füge ihn unten ein, dann liest Wren die Orte, die er schon enthält.';

  @override
  String get guideLinkLabel => 'Link zum Guide';

  @override
  String get readGuide => 'Guide lesen';

  @override
  String get importGuideNotALink =>
      'Das ist kein Link zu einem Guide in Apple Karten. Öffne den Guide in Karten, teile ihn und wähle „Link kopieren“.';

  @override
  String get importGuideNothing =>
      'Dieser Guide enthält nichts, was Wren übernehmen kann.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Orte aus diesem Guide gelesen',
      one: '1 Ort aus diesem Guide gelesen',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Orte darin lassen sich nicht übernehmen',
      one: '1 Ort darin lässt sich nicht übernehmen',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Orte sind schon in diesem Guide',
      one: '1 Ort ist schon in diesem Guide',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Aus „$name“';
  }

  @override
  String get republishTitle => 'Karten erstellt einen neuen Guide';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple bietet keine Möglichkeit, einen bestehenden Guide zu ergänzen. Wren erstellt deshalb einen neuen mit allen $count Orten darin.',
      one:
          'Apple bietet keine Möglichkeit, einen bestehenden Guide zu ergänzen. Wren erstellt deshalb einen neuen mit dem einen Ort darin.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Behalte den neuen Guide und lösche den alten.';

  @override
  String get republishKeepsPlaces =>
      'Wren behält diese Orte, du kannst den Guide also neu erstellen, falls etwas schiefgeht.';

  @override
  String get makeCombinedGuide => 'Zusammengeführten Guide erstellen';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Orte aus dieser Datei gelesen',
      one: '1 Ort aus dieser Datei gelesen',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Zeilen hatten keinen Namen',
      one: '1 Zeile hatte keinen Namen',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Keine Orte in dieser Datei.';

  @override
  String get fileUnreadable =>
      'Wren konnte diese Datei nicht lesen. Gelesen werden CSV, KML, KMZ, GPX, GeoJSON und Exporte aus Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return '$done von $total werden gesucht…';
  }

  @override
  String get combineNeedsUnlock =>
      'Der zusammengeführte Guide erfordert die Freischaltung.';

  @override
  String get unlockCombineTitle =>
      'Zu einem Guide hinzufügen, den du schon hast';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren erstellt einen einzigen Guide mit den $count Orten, die schon in deinem sind, und den neuen.',
      one:
          'Wren erstellt einen einzigen Guide mit dem Ort, der schon in deinem ist, und dem neuen.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Liest auch eine Liste, die aus einer anderen App exportiert wurde: CSV, KML, KMZ, GPX, GeoJSON oder Google Takeout.';

  @override
  String get clearList => 'Liste leeren';

  @override
  String get clearListTitle => 'Liste leeren';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Alle $count Orte aus Wren entfernen? Bereits in Apple Karten erstellte Guides bleiben unberührt.',
      one:
          'Den einen Ort aus Wren entfernen? Bereits in Apple Karten erstellte Guides bleiben unberührt.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Entfernen';

  @override
  String get listCleared => 'Liste geleert.';

  @override
  String get expandingLink => 'Der Link wird gelesen…';

  @override
  String get linkUnreachable =>
      'Apple war nicht erreichbar, um diesen Link zu lesen. Prüf deine Verbindung und versuch es erneut.';

  @override
  String get splitTitle => 'Daraus werden mehrere Guides';

  @override
  String splitBody(int guides, int count) {
    return 'Apple begrenzt, wie viele Orte ein Guide-Link tragen kann. Wren erstellt $guides Guides, nummeriert, damit die Reihenfolge bleibt, mit $count Orten insgesamt.';
  }

  @override
  String splitConfirm(int guides) {
    return '$guides Guides erstellen';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Guide $done von $total geöffnet. Tippen, um den nächsten zu erstellen.';
  }

  @override
  String get sendPlacesTo => 'Orte senden an';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Orte sind bereit zum Senden',
      one: '1 Ort ist bereit zum Senden',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count Orte haben keinen Standort und können nicht gesendet werden',
      one: '1 Ort hat keinen Standort und kann nicht gesendet werden',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Andere App';

  @override
  String get sendPlacesFailed => 'Diese App hat die Datei nicht angenommen';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count Orte aus der Datei behalten, bereit für eine andere Karten-App',
      one: '1 Ort aus der Datei behalten, bereit für eine andere Karten-App',
    );
    return '$_temp0';
  }
}
