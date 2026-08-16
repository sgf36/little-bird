// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class LIt extends L {
  LIt([String locale = 'it']) : super(locale);

  @override
  String get tagline => 'Me l\'ha detto un uccellino.';

  @override
  String get emptyTitle => 'Luoghi, conservati.';

  @override
  String get emptyBody =>
      'Fai uno screenshot di ciò che ti consigliano: un reel, un post, un messaggio, la pagina di una guida. Wren legge i nomi e li mette in Mappe.';

  @override
  String get emptyNote =>
      'Un solo luogo si aggiunge a una guida che hai già. Più luoghi ne creano una nuova: Mappe non sa unire le guide.';

  @override
  String get addScreenshots => 'Aggiungi screenshot';

  @override
  String get readingShort => 'Lettura…';

  @override
  String readingProgress(int done, int total) {
    return 'Lettura di $done su $total…';
  }

  @override
  String get addToGuide => 'Aggiungi a una guida';

  @override
  String makeGuide(int count) {
    return 'Crea una guida ($count)';
  }

  @override
  String get notFoundOnMap => 'Non trovato sulla mappa';

  @override
  String get tapToSearchForIt => 'Tocca per cercarlo';

  @override
  String readAs(String text) {
    return 'letto come «$text»';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count luoghi non sono stati trovati. Tocca per cercarli.',
      one: '1 luogo non è stato trovato. Tocca per cercarlo.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Dove si trovano questi luoghi?';

  @override
  String get regionDetected =>
      'Letto dalle didascalie. Cambialo se non è corretto.';

  @override
  String get regionNotDetected =>
      'Negli screenshot non era indicato dove si trovano. Con una città la ricerca è molto più precisa.';

  @override
  String get cityOrRegion => 'Città o regione';

  @override
  String get cityExample => 'es. Milano';

  @override
  String get searchAnywhere => 'Cerca ovunque';

  @override
  String get findPlaces => 'Trova i luoghi';

  @override
  String searchedIn(String region) {
    return 'Cercato a $region';
  }

  @override
  String get nameThisGuide => 'Dai un nome a questa guida';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Comparirà con questo nome in Mappe, con $count luoghi.',
      one: 'Comparirà con questo nome in Mappe, con 1 luogo.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Nome della guida';

  @override
  String get guideNameExample => 'es. Roma, ottobre';

  @override
  String get createGuide => 'Crea guida';

  @override
  String get cancel => 'Annulla';

  @override
  String get guidesOfAnySize => 'Guide di qualsiasi dimensione';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren salva gratuitamente fino a $limit luoghi per guida. Ne hai selezionati $selected: $over in più.';
  }

  @override
  String get onePaymentKept =>
      'Un pagamento solo, tuo per sempre. Nessun abbonamento.';

  @override
  String unlockFor(String price) {
    return 'Sblocca per $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Salva invece i primi $limit';
  }

  @override
  String get restorePrevious => 'Ripristina un acquisto precedente';

  @override
  String get restorePurchase => 'Ripristina acquisto';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over oltre il limite gratuito di $limit. Puoi sbloccare oppure salvare i primi $limit.';
  }

  @override
  String get findThisPlace => 'Trova questo luogo';

  @override
  String get searchAppleMaps => 'Cerca in Mappe';

  @override
  String searchInRegion(String region) {
    return 'Cerca a $region';
  }

  @override
  String get searching => 'Ricerca…';

  @override
  String get typeTwoCharacters => 'Scrivi almeno due caratteri.';

  @override
  String get nothingFound =>
      'Nessun risultato. Prova con la via o con un nome più corto.';

  @override
  String get rateLimited =>
      'Mappe sta limitando le ricerche. Aspetta un momento e riprova.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Mappe sta limitando le ricerche: finora ne sono stati aggiunti $added, riprova con il resto tra poco.';
  }

  @override
  String importSummary(int found) {
    return '$found trovati';
  }

  @override
  String importSummaryIn(String region) {
    return 'a $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count da controllare';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count illeggibili';
  }

  @override
  String nothingReadable(int count) {
    return 'Nulla di leggibile in $count screenshot';
  }

  @override
  String get couldNotOpenMaps => 'Impossibile aprire Mappe';

  @override
  String get checkingAppleAccount => 'Verifica del tuo account Apple…';

  @override
  String get restoredUnlocked =>
      'Ripristinato. Le guide di qualsiasi dimensione sono sbloccate.';

  @override
  String get noPreviousPurchase =>
      'Nessun acquisto precedente trovato su questo account Apple.';

  @override
  String get purchaseDidNotComplete =>
      'L\'acquisto non è andato a buon fine, quindi non è stato addebitato nulla.';

  @override
  String alreadyInTheList(String name) {
    return '$name era già nell\'elenco.';
  }

  @override
  String get ocrUnavailable =>
      'Per leggere gli screenshot serve un iPhone: su questa piattaforma non c\'è il riconoscimento del testo.';

  @override
  String get lookupUnavailable =>
      'Per cercare i luoghi serve un iPhone: su questa piattaforma non c\'è la ricerca sulle mappe.';

  @override
  String get reviewerAccess => 'Accesso per revisori';

  @override
  String get code => 'Codice';

  @override
  String get unlock => 'Sblocca';

  @override
  String get reviewerEnabled => 'Accesso per revisori attivato.';

  @override
  String get codeNotRecognised => 'Codice non riconosciuto.';
}
