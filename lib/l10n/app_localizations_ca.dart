// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class LCa extends L {
  LCa([String locale = 'ca']) : super(locale);

  @override
  String get tagline => 'M\'ho ha dit un ocellet.';

  @override
  String get emptyTitle => 'Llocs, desats.';

  @override
  String get emptyBody =>
      'Fes una captura del que et recomanin: un reel, una publicació, un missatge, la pàgina d\'una guia de viatge. El Wren llegeix els noms i els posa a Mapes.';

  @override
  String get emptyNote =>
      'Un sol lloc s\'afegeix a una guia que ja tinguis. Uns quants en creen una de nova: Mapes no pot combinar guies.';

  @override
  String get addScreenshots => 'Afegir captures';

  @override
  String get readingShort => 'S\'està llegint…';

  @override
  String readingProgress(int done, int total) {
    return 'S\'estan llegint $done de $total…';
  }

  @override
  String get addToGuide => 'Afegir a una guia';

  @override
  String makeGuide(int count) {
    return 'Crear una guia ($count)';
  }

  @override
  String get notFoundOnMap => 'No s\'ha trobat al mapa';

  @override
  String get tapToSearchForIt => 'Toca per buscar-lo';

  @override
  String readAs(String text) {
    return 'llegit com a «$text»';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'No s\'han trobat $count llocs. Toca per buscar-los.',
      one: 'No s\'ha trobat 1 lloc. Toca per buscar-lo.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'On són aquests llocs?';

  @override
  String get regionDetected =>
      'Llegit als peus de foto. Canvia-ho si no és correcte.';

  @override
  String get regionNotDetected =>
      'A les captures no deia on són. Amb una ciutat la cerca és molt més precisa.';

  @override
  String get cityOrRegion => 'Ciutat o regió';

  @override
  String get cityExample => 'p. ex. Barcelona';

  @override
  String get searchAnywhere => 'Buscar a tot arreu';

  @override
  String get findPlaces => 'Buscar llocs';

  @override
  String searchedIn(String region) {
    return 'Buscat a $region';
  }

  @override
  String get nameThisGuide => 'Posa un nom a aquesta guia';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Apareixerà amb aquest nom a Mapes, amb $count llocs.',
      one: 'Apareixerà amb aquest nom a Mapes, amb 1 lloc.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Nom de la guia';

  @override
  String get guideNameExample => 'p. ex. Roma, octubre';

  @override
  String get createGuide => 'Crear guia';

  @override
  String get cancel => 'Cancel·lar';

  @override
  String get guidesOfAnySize => 'Guies de qualsevol mida';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'El Wren desa gratuïtament fins a $limit llocs per guia. N\'has seleccionat $selected: $over més.';
  }

  @override
  String get onePaymentKept =>
      'Un sol pagament, per sempre. Sense subscripció.';

  @override
  String unlockFor(String price) {
    return 'Desbloquejar per $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Desar només els primers $limit';
  }

  @override
  String get restorePrevious => 'Restaurar una compra anterior';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over per damunt del límit gratuït de $limit. Pots desbloquejar o desar els primers $limit.';
  }

  @override
  String get findThisPlace => 'Buscar aquest lloc';

  @override
  String get searchAppleMaps => 'Buscar a Mapes';

  @override
  String searchInRegion(String region) {
    return 'Buscar a $region';
  }

  @override
  String get searching => 'S\'està buscant…';

  @override
  String get typeTwoCharacters => 'Escriu com a mínim dos caràcters.';

  @override
  String get nothingFound =>
      'No s\'ha trobat res. Prova amb el carrer o amb un nom més curt.';

  @override
  String get rateLimited =>
      'Mapes està limitant les cerques. Espera un moment i torna-ho a provar.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Mapes està limitant les cerques: se n\'han afegit $added fins ara, prova la resta d\'aquí a una estona.';
  }

  @override
  String importSummary(int found) {
    return '$found trobats';
  }

  @override
  String importSummaryIn(String region) {
    return 'a $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count per revisar';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count illegibles';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Res llegible en $count captures',
      one: 'Res llegible en aquesta captura',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'No s\'ha pogut obrir Mapes';

  @override
  String get checkingAppleAccount =>
      'S\'està comprovant el teu compte d\'Apple…';

  @override
  String get restoredUnlocked =>
      'Restaurat. Les guies de qualsevol mida estan desbloquejades.';

  @override
  String get noPreviousPurchase =>
      'No s\'ha trobat cap compra anterior en aquest compte d\'Apple.';

  @override
  String get purchaseDidNotComplete =>
      'La compra no s\'ha completat, així que no s\'ha cobrat res.';

  @override
  String alreadyInTheList(String name) {
    return '$name ja era a la llista.';
  }

  @override
  String get ocrUnavailable =>
      'Per llegir captures cal un iPhone: en aquesta plataforma no hi ha reconeixement de text.';

  @override
  String get lookupUnavailable =>
      'Per buscar llocs cal un iPhone: en aquesta plataforma no hi ha cerca al mapa.';

  @override
  String get compAccess => 'Accés de cortesia';

  @override
  String get code => 'Codi';

  @override
  String get unlock => 'Desbloquejar';

  @override
  String get compChecking => 'S\'està comprovant aquest codi…';

  @override
  String get compEnabled => 'Accés de cortesia activat.';

  @override
  String get compRefused =>
      'No s\'ha reconegut aquest codi, o ja s\'ha fet servir.';

  @override
  String get compTooOften =>
      'Massa intents. Espera uns minuts i torna-ho a provar.';

  @override
  String get compUnreachable =>
      'No s\'ha pogut connectar amb el servidor. Comprova la connexió i torna-ho a provar.';

  @override
  String get compUntrusted =>
      'No s\'ha pogut verificar la resposta, així que no s\'ha desbloquejat res.';

  @override
  String get addPlaces => 'Afegir';

  @override
  String get fromFile => 'Des d\'un fitxer';

  @override
  String get fromExistingGuide => 'Des d\'una guia existent';

  @override
  String get importGuideTitle => 'Afegir a una guia existent';

  @override
  String get importGuideBody =>
      'A Mapes, obre la guia i comparteix-la; després tria Copiar l\'enllaç. Enganxa\'l aquí sota i el Wren llegirà els llocs que ja conté.';

  @override
  String get guideLinkLabel => 'Enllaç de la guia';

  @override
  String get readGuide => 'Llegir la guia';

  @override
  String get importGuideNotALink =>
      'Aquest no és l\'enllaç d\'una guia de Mapes. Obre la guia a Mapes, comparteix-la i tria Copiar l\'enllaç.';

  @override
  String get importGuideNothing =>
      'Aquesta guia no té cap lloc que el Wren pugui fer servir.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count llocs llegits d\'aquesta guia',
      one: '1 lloc llegit d\'aquesta guia',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count llocs no es poden passar a la guia nova',
      one: '1 lloc no es pot passar a la guia nova',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count llocs ja són en aquesta guia',
      one: '1 lloc ja és en aquesta guia',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'De «$name»';
  }

  @override
  String get republishTitle => 'Mapes crea una guia nova';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple no permet afegir llocs a una guia que ja existeix, així que el Wren en crearà una de nova amb els $count llocs.',
      one:
          'Apple no permet afegir llocs a una guia que ja existeix, així que el Wren en crearà una de nova amb aquest lloc.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Queda\'t la guia nova i esborra l\'antiga.';

  @override
  String get republishKeepsPlaces =>
      'El Wren conserva aquests llocs, així que pots tornar a crear la guia si alguna cosa va malament.';

  @override
  String get makeCombinedGuide => 'Crear la guia combinada';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count llocs llegits d\'aquest fitxer',
      one: '1 lloc llegit d\'aquest fitxer',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count files sense nom',
      one: '1 fila sense nom',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'No hi ha cap lloc en aquest fitxer.';

  @override
  String get fileUnreadable =>
      'El Wren no ha pogut llegir aquest fitxer. Llegeix exportacions en CSV, KML, KMZ, GPX, GeoJSON i Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'S\'estan buscant $done de $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'Crear la guia combinada requereix el desbloqueig.';

  @override
  String get unlockCombineTitle => 'Afegir a una guia que ja tens';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'El Wren crearà una sola guia amb els $count llocs que ja són a la teva i els nous.',
      one:
          'El Wren crearà una sola guia amb el lloc que ja és a la teva i el nou.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'També llegeix una llista exportada d\'una altra app: CSV, KML, KMZ, GPX, GeoJSON o Google Takeout.';

  @override
  String get clearList => 'Buidar la llista';

  @override
  String get clearListTitle => 'Buidar la llista';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Vols treure del Wren els $count llocs? Les guies que ja has creat a Mapes no es veuen afectades.',
      one:
          'Vols treure del Wren l\'únic lloc? Les guies que ja has creat a Mapes no es veuen afectades.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Treure';

  @override
  String get listCleared => 'Llista buidada.';

  @override
  String get expandingLink => 'S\'està llegint l\'enllaç…';

  @override
  String get linkUnreachable =>
      'No s\'ha pogut connectar amb Apple per llegir aquest enllaç. Comprova la connexió i torna-ho a provar.';

  @override
  String get splitTitle => 'Això crearà més d\'una guia';

  @override
  String splitBody(int guides, int count) {
    return 'Apple limita quants llocs pot portar l\'enllaç d\'una guia. El Wren crearà $guides guies, numerades perquè quedin en ordre, amb $count llocs entre totes.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Crear $guides guies';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Guia $done de $total oberta. Toca per crear la següent.';
  }

  @override
  String get sendPlacesTo => 'Envia els llocs a';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count llocs a punt per enviar',
      one: '1 lloc a punt per enviar',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count llocs no tenen ubicació i no es poden enviar',
      one: '1 lloc no té ubicació i no es pot enviar',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Qualsevol altra app';

  @override
  String get sendPlacesFailed => 'Aquesta app no ha acceptat el fitxer';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count llocs desats del fitxer, a punt per enviar a una altra app de mapes',
      one:
          '1 lloc desat del fitxer, a punt per enviar a una altra app de mapes',
    );
    return '$_temp0';
  }
}
