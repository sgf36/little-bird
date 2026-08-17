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
}
