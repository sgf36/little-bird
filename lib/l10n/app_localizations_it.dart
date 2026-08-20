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
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nulla di leggibile in $count screenshot',
      one: 'Nulla di leggibile in quello screenshot',
    );
    return '$_temp0';
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
  String get compAccess => 'Accesso omaggio';

  @override
  String get code => 'Codice';

  @override
  String get unlock => 'Sblocca';

  @override
  String get compChecking => 'Verifica del codice…';

  @override
  String get compEnabled => 'Accesso omaggio attivato.';

  @override
  String get compRefused => 'Codice non riconosciuto, oppure già utilizzato.';

  @override
  String get compTooOften =>
      'Troppi tentativi. Aspetta qualche minuto e riprova.';

  @override
  String get compUnreachable =>
      'Impossibile raggiungere il server. Controlla la connessione e riprova.';

  @override
  String get compUntrusted =>
      'Non è stato possibile verificare la risposta, quindi non è stato sbloccato nulla.';

  @override
  String get addPlaces => 'Aggiungi';

  @override
  String get fromFile => 'Da un file';

  @override
  String get fromExistingGuide => 'Da una guida esistente';

  @override
  String get importGuideTitle => 'Aggiungi a una guida esistente';

  @override
  String get importGuideBody =>
      'In Mappe, apri la guida e condividila, poi scegli Copia link. Incollalo qui sotto e Wren leggerà i luoghi che contiene già.';

  @override
  String get guideLinkLabel => 'Link della guida';

  @override
  String get readGuide => 'Leggi la guida';

  @override
  String get importGuideNotALink =>
      'Questo non è il link di una guida di Mappe. Apri la guida in Mappe, condividila, poi scegli Copia link.';

  @override
  String get importGuideNothing =>
      'Quella guida non contiene nessun luogo che Wren possa usare.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count luoghi letti da quella guida',
      one: '1 luogo letto da quella guida',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count luoghi non possono essere trasferiti',
      one: '1 luogo non può essere trasferito',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count luoghi sono già in questa guida',
      one: '1 luogo è già in questa guida',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Da «$name»';
  }

  @override
  String get republishTitle => 'Mappe crea una nuova guida';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple non permette di aggiungere luoghi a una guida che esiste già, quindi Wren ne crea una nuova con tutti i $count luoghi.',
      one:
          'Apple non permette di aggiungere luoghi a una guida che esiste già, quindi Wren ne crea una nuova con quel luogo.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Tieni la nuova guida ed elimina quella vecchia.';

  @override
  String get republishKeepsPlaces =>
      'Wren conserva questi luoghi, così puoi ricreare la guida se qualcosa va storto.';

  @override
  String get makeCombinedGuide => 'Crea la guida combinata';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count luoghi letti da quel file',
      one: '1 luogo letto da quel file',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count righe senza nome',
      one: '1 riga senza nome',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Nessun luogo in quel file.';

  @override
  String get fileUnreadable =>
      'Wren non è riuscito a leggere quel file. Legge le esportazioni CSV, KML, KMZ, GPX, GeoJSON e Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Ricerca di $done su $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'Creare la guida combinata richiede lo sblocco.';

  @override
  String get unlockCombineTitle => 'Aggiungi a una guida che hai già';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren creerà una sola guida con i $count luoghi già presenti nella tua e quelli nuovi.',
      one:
          'Wren creerà una sola guida con il luogo già presente nella tua e quello nuovo.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Legge anche un elenco esportato da un\'altra app: CSV, KML, KMZ, GPX, GeoJSON o Google Takeout.';

  @override
  String get clearList => 'Svuota l\'elenco';

  @override
  String get clearListTitle => 'Svuota l\'elenco';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Rimuovere da Wren tutti i $count luoghi? Le guide già create in Mappe non vengono toccate.',
      one:
          'Rimuovere da Wren l\'unico luogo? Le guide già create in Mappe non vengono toccate.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Rimuovi';

  @override
  String get listCleared => 'Elenco svuotato.';

  @override
  String get expandingLink => 'Lettura del link…';

  @override
  String get linkUnreachable =>
      'Impossibile raggiungere Apple per leggere quel link. Controlla la connessione e riprova.';

  @override
  String get splitTitle => 'Verrà creata più di una guida';

  @override
  String splitBody(int guides, int count) {
    return 'Apple limita quanti luoghi può contenere il link di una guida. Wren creerà $guides guide, numerate per restare in ordine, con $count luoghi in tutto.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Crea $guides guide';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Guida $done di $total aperta. Tocca per creare la prossima.';
  }

  @override
  String get sendPlacesTo => 'Invia i luoghi a';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count luoghi pronti da inviare',
      one: '1 luogo pronto da inviare',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count luoghi non hanno una posizione e non possono essere inviati',
      one: '1 luogo non ha una posizione e non può essere inviato',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Un’altra app';

  @override
  String get sendPlacesFailed => 'Quell’app non ha accettato il file';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count luoghi conservati dal file, pronti per un\'altra app di mappe',
      one: '1 luogo conservato dal file, pronto per un\'altra app di mappe',
    );
    return '$_temp0';
  }
}
