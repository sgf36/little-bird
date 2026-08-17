// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class LRu extends L {
  LRu([String locale = 'ru']) : super(locale);

  @override
  String get tagline => 'Сорока на хвосте принесла.';

  @override
  String get emptyTitle => 'Места, сохранённые.';

  @override
  String get emptyBody =>
      'Сделай скриншот того, что тебе советуют — рилс, пост, сообщение, страницу путеводителя. Wren прочитает названия и добавит их в Apple Карты.';

  @override
  String get emptyNote =>
      'Одно место добавится в путеводитель, который у тебя уже есть. Несколько создадут новый — Apple Карты не умеют объединять путеводители.';

  @override
  String get addScreenshots => 'Добавить скриншоты';

  @override
  String get readingShort => 'Читаю…';

  @override
  String readingProgress(int done, int total) {
    return 'Читаю $done из $total…';
  }

  @override
  String get addToGuide => 'Добавить в путеводитель';

  @override
  String makeGuide(int count) {
    return 'Создать путеводитель ($count)';
  }

  @override
  String get notFoundOnMap => 'Не найдено на карте';

  @override
  String get tapToSearchForIt => 'Нажми, чтобы найти';

  @override
  String readAs(String text) {
    return 'распознано как «$text»';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count места не найдено. Нажми, чтобы найти их.',
      many: '$count мест не найдено. Нажми, чтобы найти их.',
      few: '$count места не найдены. Нажми, чтобы найти их.',
      one: '$count место не найдено. Нажми, чтобы найти его.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Где находятся эти места?';

  @override
  String get regionDetected => 'Прочитано в подписях. Измени, если это не так.';

  @override
  String get regionNotDetected =>
      'В скриншотах не было сказано, где они находятся. С городом поиск будет намного точнее.';

  @override
  String get cityOrRegion => 'Город или регион';

  @override
  String get cityExample => 'напр. Москва';

  @override
  String get searchAnywhere => 'Искать везде';

  @override
  String get findPlaces => 'Найти места';

  @override
  String searchedIn(String region) {
    return 'Поиск в: $region';
  }

  @override
  String get nameThisGuide => 'Назови этот путеводитель';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Под этим названием он появится в Apple Картах, в нём будет $count места.',
      many:
          'Под этим названием он появится в Apple Картах, в нём будет $count мест.',
      few:
          'Под этим названием он появится в Apple Картах, в нём будет $count места.',
      one:
          'Под этим названием он появится в Apple Картах, в нём будет $count место.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Название путеводителя';

  @override
  String get guideNameExample => 'напр. Рим, октябрь';

  @override
  String get createGuide => 'Создать путеводитель';

  @override
  String get cancel => 'Отменить';

  @override
  String get guidesOfAnySize => 'Путеводители без ограничений';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren бесплатно сохраняет в путеводителе до $limit мест. Выбрано $selected — на $over больше.';
  }

  @override
  String get onePaymentKept => 'Один платёж, навсегда. Без подписки.';

  @override
  String unlockFor(String price) {
    return 'Разблокировать за $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Сохранить только первые $limit';
  }

  @override
  String get restorePrevious => 'Восстановить прежнюю покупку';

  @override
  String get restorePurchase => 'Восстановить покупку';

  @override
  String overFreeLimit(int over, int limit) {
    return 'На $over больше бесплатного лимита в $limit. Можно разблокировать или сохранить первые $limit.';
  }

  @override
  String get findThisPlace => 'Найти это место';

  @override
  String get searchAppleMaps => 'Искать в Apple Картах';

  @override
  String searchInRegion(String region) {
    return 'Искать в: $region';
  }

  @override
  String get searching => 'Идёт поиск…';

  @override
  String get typeTwoCharacters => 'Введи хотя бы два символа.';

  @override
  String get nothingFound =>
      'Ничего не найдено. Попробуй улицу или название покороче.';

  @override
  String get rateLimited =>
      'Apple Карты ограничивают число запросов. Подожди немного и попробуй снова.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Карты ограничивают число запросов — пока добавлено $added, остальное попробуй чуть позже.';
  }

  @override
  String importSummary(int found) {
    return 'найдено $found';
  }

  @override
  String importSummaryIn(String region) {
    return 'в: $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count на проверку';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count не распознано';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ничего читаемого в $count скриншотах',
      many: 'Ничего читаемого в $count скриншотах',
      few: 'Ничего читаемого в $count скриншотах',
      one: 'Ничего читаемого в $count скриншоте',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Не удалось открыть Карты';

  @override
  String get checkingAppleAccount => 'Проверяю твой аккаунт Apple…';

  @override
  String get restoredUnlocked =>
      'Восстановлено. Путеводители без ограничений разблокированы.';

  @override
  String get noPreviousPurchase =>
      'На этом аккаунте Apple прежних покупок не найдено.';

  @override
  String get purchaseDidNotComplete =>
      'Покупка не завершилась, поэтому ничего не списано.';

  @override
  String alreadyInTheList(String name) {
    return '$name уже было в списке.';
  }

  @override
  String get ocrUnavailable =>
      'Для чтения скриншотов нужен iPhone — на этой платформе нет распознавания текста.';

  @override
  String get lookupUnavailable =>
      'Для поиска мест нужен iPhone — на этой платформе нет поиска по карте.';

  @override
  String get compAccess => 'Бесплатный доступ';

  @override
  String get code => 'Код';

  @override
  String get unlock => 'Разблокировать';

  @override
  String get compChecking => 'Проверяю код…';

  @override
  String get compEnabled => 'Бесплатный доступ включён.';

  @override
  String get compRefused => 'Этот код не распознан или уже использован.';

  @override
  String get compTooOften =>
      'Слишком много попыток. Подожди несколько минут и попробуй снова.';

  @override
  String get compUnreachable =>
      'Не удалось связаться с сервером. Проверь соединение и попробуй снова.';

  @override
  String get compUntrusted =>
      'Не удалось проверить ответ, поэтому ничего не разблокировано.';
}
