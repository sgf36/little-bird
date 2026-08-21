// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class LEs extends L {
  LEs([String locale = 'es']) : super(locale);

  @override
  String get tagline => 'Me lo ha dicho un pajarito.';

  @override
  String get emptyTitle => 'Lugares, guardados.';

  @override
  String get emptyBody =>
      'Haz una captura de lo que te recomienden: un reel, una publicación, un mensaje, la página de una guía de viaje. Wren lee los nombres y los pone en Mapas.';

  @override
  String get emptyNote =>
      'Un solo lugar se añade a una guía que ya tengas. Varios crean una nueva: Mapas no puede combinar guías.';

  @override
  String get emptyBodyAndroid =>
      'Screenshot what people tell you about — a reel, a post, a message, a page of a guidebook. Wren reads the names and sends them to the map app on your phone.';

  @override
  String get emptyNoteAndroid =>
      'It also reads a list you already have, and shows you every place before anything leaves.';

  @override
  String get addScreenshots => 'Añadir capturas';

  @override
  String get readingShort => 'Leyendo…';

  @override
  String readingProgress(int done, int total) {
    return 'Leyendo $done de $total…';
  }

  @override
  String get addToGuide => 'Añadir a una guía';

  @override
  String makeGuide(int count) {
    return 'Crear una guía ($count)';
  }

  @override
  String get notFoundOnMap => 'No se ha encontrado en el mapa';

  @override
  String get tapToSearchForIt => 'Toca para buscarlo';

  @override
  String readAs(String text) {
    return 'leído como «$text»';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'No se han encontrado $count lugares. Toca para buscarlos.',
      one: 'No se ha encontrado 1 lugar. Toca para buscarlo.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => '¿Dónde están estos lugares?';

  @override
  String get regionDetected =>
      'Leído en los pies de foto. Cámbialo si no es correcto.';

  @override
  String get regionNotDetected =>
      'En las capturas no se decía dónde están. Con una ciudad la búsqueda es mucho más precisa.';

  @override
  String get cityOrRegion => 'Ciudad o región';

  @override
  String get cityExample => 'p. ej. Madrid';

  @override
  String get searchAnywhere => 'Buscar en todas partes';

  @override
  String get findPlaces => 'Buscar lugares';

  @override
  String searchedIn(String region) {
    return 'Buscado en $region';
  }

  @override
  String get nameThisGuide => 'Ponle nombre a esta guía';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Aparecerá con este nombre en Mapas, con $count lugares.',
      one: 'Aparecerá con este nombre en Mapas, con 1 lugar.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Nombre de la guía';

  @override
  String get guideNameExample => 'p. ej. Roma, octubre';

  @override
  String get createGuide => 'Crear guía';

  @override
  String get cancel => 'Cancelar';

  @override
  String get guidesOfAnySize => 'Guías de cualquier tamaño';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren guarda gratis hasta $limit lugares por guía. Tienes $selected seleccionados: $over más de la cuenta.';
  }

  @override
  String get onePaymentKept => 'Un solo pago, para siempre. Sin suscripción.';

  @override
  String unlockFor(String price) {
    return 'Desbloquear por $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Guardar solo los primeros $limit';
  }

  @override
  String get restorePrevious => 'Restaurar una compra anterior';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over por encima del límite gratuito de $limit. Puedes desbloquear o guardar los primeros $limit.';
  }

  @override
  String get findThisPlace => 'Buscar este lugar';

  @override
  String get searchAppleMaps => 'Buscar en Mapas';

  @override
  String searchInRegion(String region) {
    return 'Buscar en $region';
  }

  @override
  String get searching => 'Buscando…';

  @override
  String get typeTwoCharacters => 'Escribe al menos dos caracteres.';

  @override
  String get nothingFound =>
      'No se ha encontrado nada. Prueba con la calle o con un nombre más corto.';

  @override
  String get rateLimited =>
      'Mapas está limitando las búsquedas. Espera un momento e inténtalo de nuevo.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Mapas está limitando las búsquedas: se han añadido $added hasta ahora, prueba con el resto en un momento.';
  }

  @override
  String importSummary(int found) {
    return '$found encontrados';
  }

  @override
  String importSummaryIn(String region) {
    return 'en $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count por revisar';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count ilegibles';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nada legible en $count capturas',
      one: 'Nada legible en esa captura',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'No se ha podido abrir Mapas';

  @override
  String get checkingAppleAccount => 'Comprobando tu cuenta de Apple…';

  @override
  String get restoredUnlocked =>
      'Restaurado. Las guías de cualquier tamaño están desbloqueadas.';

  @override
  String get noPreviousPurchase =>
      'No se ha encontrado ninguna compra anterior en esta cuenta de Apple.';

  @override
  String get purchaseDidNotComplete =>
      'La compra no se ha completado, así que no se ha cobrado nada.';

  @override
  String alreadyInTheList(String name) {
    return '$name ya estaba en la lista.';
  }

  @override
  String get ocrUnavailable =>
      'Para leer capturas hace falta un iPhone: en esta plataforma no hay reconocimiento de texto.';

  @override
  String get lookupUnavailable =>
      'Para buscar lugares hace falta un iPhone: en esta plataforma no hay búsqueda en mapas.';

  @override
  String get compAccess => 'Acceso de cortesía';

  @override
  String get code => 'Código';

  @override
  String get unlock => 'Desbloquear';

  @override
  String get compChecking => 'Comprobando ese código…';

  @override
  String get compEnabled => 'Acceso de cortesía activado.';

  @override
  String get compRefused => 'No se ha reconocido ese código, o ya se ha usado.';

  @override
  String get compTooOften =>
      'Demasiados intentos. Espera unos minutos e inténtalo de nuevo.';

  @override
  String get compUnreachable =>
      'No se ha podido conectar con el servidor. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get compUntrusted =>
      'No se ha podido verificar esa respuesta, así que no se ha desbloqueado nada.';

  @override
  String get addPlaces => 'Añadir';

  @override
  String get fromFile => 'Desde un archivo';

  @override
  String get fromExistingGuide => 'Desde una guía existente';

  @override
  String get importGuideTitle => 'Añadir a una guía existente';

  @override
  String get importGuideBody =>
      'En Mapas, abre la guía y compártela; luego elige Copiar enlace. Pégalo abajo y Wren leerá los lugares que ya contiene.';

  @override
  String get guideLinkLabel => 'Enlace de la guía';

  @override
  String get readGuide => 'Leer la guía';

  @override
  String get importGuideNotALink =>
      'Ese no es el enlace de una guía de Mapas. Abre la guía en Mapas, compártela y elige Copiar enlace.';

  @override
  String get importGuideNothing =>
      'Esa guía no contiene ningún lugar que Wren pueda utilizar.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares leídos de esa guía',
      one: '1 lugar leído de esa guía',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares no se pueden pasar a la nueva guía',
      one: '1 lugar no se puede pasar a la nueva guía',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares ya están en esta guía',
      one: '1 lugar ya está en esta guía',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'De «$name»';
  }

  @override
  String get republishTitle => 'Mapas crea una guía nueva';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple no permite añadir lugares a una guía que ya existe, así que Wren creará una nueva con los $count lugares.',
      one:
          'Apple no permite añadir lugares a una guía que ya existe, así que Wren creará una nueva con ese lugar.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Quédate con la guía nueva y borra la antigua.';

  @override
  String get republishKeepsPlaces =>
      'Wren conserva estos lugares, así que puedes volver a crear la guía si algo sale mal.';

  @override
  String get makeCombinedGuide => 'Crear la guía combinada';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares leídos de ese archivo',
      one: '1 lugar leído de ese archivo',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count filas sin nombre',
      one: '1 fila sin nombre',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'No hay ningún lugar en ese archivo.';

  @override
  String get fileUnreadable =>
      'Wren no ha podido leer ese archivo. Lee exportaciones en CSV, KML, KMZ, GPX, GeoJSON y Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Buscando $done de $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'Crear la guía combinada requiere el desbloqueo.';

  @override
  String get unlockCombineTitle => 'Añadir a una guía que ya tienes';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren creará una sola guía con los $count lugares que ya están en la tuya y los nuevos.',
      one:
          'Wren creará una sola guía con el lugar que ya está en la tuya y el nuevo.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'También lee una lista exportada de otra app: CSV, KML, KMZ, GPX, GeoJSON o Google Takeout.';

  @override
  String get clearList => 'Vaciar la lista';

  @override
  String get clearListTitle => 'Vaciar la lista';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '¿Quitar de Wren los $count lugares? Las guías ya creadas en Mapas no se ven afectadas.',
      one:
          '¿Quitar de Wren el único lugar? Las guías ya creadas en Mapas no se ven afectadas.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Quitar';

  @override
  String get listCleared => 'Lista vaciada.';

  @override
  String get expandingLink => 'Leyendo ese enlace…';

  @override
  String get linkUnreachable =>
      'No se ha podido conectar con Apple para leer ese enlace. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get splitTitle => 'Esto creará más de una guía';

  @override
  String splitBody(int guides, int count) {
    return 'Apple limita cuántos lugares puede llevar el enlace de una guía. Wren creará $guides guías, numeradas para que queden en orden, con $count lugares entre todas.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Crear $guides guías';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Guía $done de $total abierta. Toca para crear la siguiente.';
  }

  @override
  String get sendPlacesTo => 'Enviar lugares a';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares listos para enviar',
      one: '1 lugar listo para enviar',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares no tienen ubicación y no se pueden enviar',
      one: '1 lugar no tiene ubicación y no se puede enviar',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Otra app';

  @override
  String get sendPlacesFailed => 'Esa app no aceptó el archivo';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count lugares guardados del archivo, listos para enviar a otra app de mapas',
      one:
          '1 lugar guardado del archivo, listo para enviar a otra app de mapas',
    );
    return '$_temp0';
  }

  @override
  String get compExpiring =>
      'Wren no ha podido confirmar tu acceso gratuito. Conéctate a internet en los próximos días para conservarlo.';
}

/// The translations for Spanish Castilian, as used in Mexico (`es_MX`).
class LEsMx extends LEs {
  LEsMx() : super('es_MX');

  @override
  String get tagline => 'Me lo dijo un pajarito.';

  @override
  String get emptyTitle => 'Lugares, guardados.';

  @override
  String get emptyBody =>
      'Toma una captura de lo que te recomienden: un reel, una publicación, un mensaje, la página de una guía de viaje. Wren lee los nombres y los pone en Mapas.';

  @override
  String get emptyNote =>
      'Un solo lugar se agrega a una guía que ya tengas. Varios crean una nueva: Mapas no puede combinar guías.';

  @override
  String get addScreenshots => 'Agregar capturas';

  @override
  String get readingShort => 'Leyendo…';

  @override
  String readingProgress(int done, int total) {
    return 'Leyendo $done de $total…';
  }

  @override
  String get addToGuide => 'Agregar a una guía';

  @override
  String makeGuide(int count) {
    return 'Crear una guía ($count)';
  }

  @override
  String get notFoundOnMap => 'No se encontró en el mapa';

  @override
  String get tapToSearchForIt => 'Toca para buscarlo';

  @override
  String readAs(String text) {
    return 'leído como “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'No se encontraron $count lugares. Toca para buscarlos.',
      one: 'No se encontró 1 lugar. Toca para buscarlo.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => '¿Dónde están estos lugares?';

  @override
  String get regionDetected =>
      'Se leyó en los pies de foto. Cámbialo si no es correcto.';

  @override
  String get regionNotDetected =>
      'En las capturas no decía dónde están. Con una ciudad la búsqueda es mucho más precisa.';

  @override
  String get cityOrRegion => 'Ciudad o región';

  @override
  String get cityExample => 'p. ej. Ciudad de México';

  @override
  String get searchAnywhere => 'Buscar en todos lados';

  @override
  String get findPlaces => 'Buscar lugares';

  @override
  String searchedIn(String region) {
    return 'Se buscó en $region';
  }

  @override
  String get nameThisGuide => 'Ponle nombre a esta guía';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Aparecerá con este nombre en Mapas, con $count lugares.',
      one: 'Aparecerá con este nombre en Mapas, con 1 lugar.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Nombre de la guía';

  @override
  String get guideNameExample => 'p. ej. Roma, octubre';

  @override
  String get createGuide => 'Crear guía';

  @override
  String get cancel => 'Cancelar';

  @override
  String get guidesOfAnySize => 'Guías de cualquier tamaño';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren guarda gratis hasta $limit lugares por guía. Tienes $selected seleccionados: $over más de la cuenta.';
  }

  @override
  String get onePaymentKept => 'Un solo pago, para siempre. Sin suscripción.';

  @override
  String unlockFor(String price) {
    return 'Desbloquear por $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Mejor guardar los primeros $limit';
  }

  @override
  String get restorePrevious => 'Restaurar una compra anterior';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over por encima del límite gratuito de $limit. Puedes desbloquear o guardar los primeros $limit.';
  }

  @override
  String get findThisPlace => 'Buscar este lugar';

  @override
  String get searchAppleMaps => 'Buscar en Mapas';

  @override
  String searchInRegion(String region) {
    return 'Buscar en $region';
  }

  @override
  String get searching => 'Buscando…';

  @override
  String get typeTwoCharacters => 'Escribe al menos dos caracteres.';

  @override
  String get nothingFound =>
      'No se encontró nada. Prueba con la calle o con un nombre más corto.';

  @override
  String get rateLimited =>
      'Mapas está limitando las búsquedas. Espera un momento y vuelve a intentarlo.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Mapas está limitando las búsquedas: se agregaron $added hasta ahora, intenta con el resto en un momento.';
  }

  @override
  String importSummary(int found) {
    return '$found encontrados';
  }

  @override
  String importSummaryIn(String region) {
    return 'en $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count por revisar';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count ilegibles';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nada legible en $count capturas',
      one: 'Nada legible en esa captura',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'No se pudo abrir Mapas';

  @override
  String get checkingAppleAccount => 'Revisando tu cuenta de Apple…';

  @override
  String get restoredUnlocked =>
      'Restaurado. Las guías de cualquier tamaño están desbloqueadas.';

  @override
  String get noPreviousPurchase =>
      'No se encontró ninguna compra anterior en esta cuenta de Apple.';

  @override
  String get purchaseDidNotComplete =>
      'La compra no se completó, así que no se cobró nada.';

  @override
  String alreadyInTheList(String name) {
    return '$name ya estaba en la lista.';
  }

  @override
  String get ocrUnavailable =>
      'Para leer capturas se necesita un iPhone: en esta plataforma no hay reconocimiento de texto.';

  @override
  String get lookupUnavailable =>
      'Para buscar lugares se necesita un iPhone: en esta plataforma no hay búsqueda en mapas.';

  @override
  String get compAccess => 'Acceso de cortesía';

  @override
  String get code => 'Código';

  @override
  String get unlock => 'Desbloquear';

  @override
  String get compChecking => 'Revisando ese código…';

  @override
  String get compEnabled => 'Acceso de cortesía activado.';

  @override
  String get compRefused => 'No se reconoció ese código, o ya se usó.';

  @override
  String get compTooOften =>
      'Demasiados intentos. Espera unos minutos y vuelve a intentarlo.';

  @override
  String get compUnreachable =>
      'No se pudo conectar con el servidor. Revisa tu conexión y vuelve a intentarlo.';

  @override
  String get compUntrusted =>
      'No se pudo verificar esa respuesta, así que no se desbloqueó nada.';

  @override
  String get addPlaces => 'Agregar';

  @override
  String get fromFile => 'Desde un archivo';

  @override
  String get fromExistingGuide => 'Desde una guía existente';

  @override
  String get importGuideTitle => 'Agregar a una guía existente';

  @override
  String get importGuideBody =>
      'En Mapas, abre la guía y compártela; luego elige Copiar enlace. Pégalo abajo y Wren leerá los lugares que ya tiene.';

  @override
  String get guideLinkLabel => 'Enlace de la guía';

  @override
  String get readGuide => 'Leer la guía';

  @override
  String get importGuideNotALink =>
      'Ese no es el enlace de una guía de Mapas. Abre la guía en Mapas, compártela y elige Copiar enlace.';

  @override
  String get importGuideNothing =>
      'Esa guía no tiene ningún lugar que Wren pueda usar.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares leídos de esa guía',
      one: '1 lugar leído de esa guía',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares no se pueden pasar a la guía nueva',
      one: '1 lugar no se puede pasar a la guía nueva',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares ya están en esta guía',
      one: '1 lugar ya está en esta guía',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'De “$name”';
  }

  @override
  String get republishTitle => 'Mapas crea una guía nueva';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple no permite agregar lugares a una guía que ya existe, así que Wren creará una nueva con los $count lugares.',
      one:
          'Apple no permite agregar lugares a una guía que ya existe, así que Wren creará una nueva con ese lugar.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Quédate con la guía nueva y elimina la anterior.';

  @override
  String get republishKeepsPlaces =>
      'Wren conserva estos lugares, así que puedes volver a crear la guía si algo sale mal.';

  @override
  String get makeCombinedGuide => 'Crear la guía combinada';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares leídos de ese archivo',
      one: '1 lugar leído de ese archivo',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count filas sin nombre',
      one: '1 fila sin nombre',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'No hay ningún lugar en ese archivo.';

  @override
  String get fileUnreadable =>
      'Wren no pudo leer ese archivo. Lee exportaciones en CSV, KML, KMZ, GPX, GeoJSON y Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Buscando $done de $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'Crear la guía combinada requiere el desbloqueo.';

  @override
  String get unlockCombineTitle => 'Agregar a una guía que ya tienes';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren creará una sola guía con los $count lugares que ya están en la tuya y los nuevos.',
      one:
          'Wren creará una sola guía con el lugar que ya está en la tuya y el nuevo.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'También lee una lista exportada de otra app: CSV, KML, KMZ, GPX, GeoJSON o Google Takeout.';

  @override
  String get clearList => 'Vaciar la lista';

  @override
  String get clearListTitle => 'Vaciar la lista';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '¿Quitar de Wren los $count lugares? Las guías que ya creaste en Mapas no se ven afectadas.',
      one:
          '¿Quitar de Wren el único lugar? Las guías que ya creaste en Mapas no se ven afectadas.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Quitar';

  @override
  String get listCleared => 'Lista vaciada.';

  @override
  String get expandingLink => 'Leyendo ese enlace…';

  @override
  String get linkUnreachable =>
      'No se pudo conectar con Apple para leer ese enlace. Revisa tu conexión y vuelve a intentarlo.';

  @override
  String get splitTitle => 'Esto va a crear más de una guía';

  @override
  String splitBody(int guides, int count) {
    return 'Apple limita cuántos lugares puede llevar el enlace de una guía. Wren va a crear $guides guías, numeradas para que queden en orden, con $count lugares entre todas.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Crear $guides guías';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Guía $done de $total abierta. Toca para crear la siguiente.';
  }

  @override
  String get sendPlacesTo => 'Enviar lugares a';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares listos para enviar',
      one: '1 lugar listo para enviar',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares no tienen ubicación y no se pueden enviar',
      one: '1 lugar no tiene ubicación y no se puede enviar',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Cualquier otra app';

  @override
  String get sendPlacesFailed => 'Esa app no quiso el archivo';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count lugares guardados del archivo, listos para enviar a otra app de mapas',
      one:
          '1 lugar guardado del archivo, listo para enviar a otra app de mapas',
    );
    return '$_temp0';
  }

  @override
  String get compExpiring =>
      'Wren no pudo confirmar tu acceso gratuito. Conéctate a internet en los próximos días para conservarlo.';
}
