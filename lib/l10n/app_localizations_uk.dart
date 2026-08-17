// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class LUk extends L {
  LUk([String locale = 'uk']) : super(locale);

  @override
  String get tagline => 'Сорока на хвості принесла.';

  @override
  String get emptyTitle => 'Місця, збережені.';

  @override
  String get emptyBody =>
      'Зроби знімок екрана того, що тобі радять — рілс, допис, повідомлення, сторінку путівника. Wren прочитає назви й додасть їх у Apple Карти.';

  @override
  String get emptyNote =>
      'Одне місце додається до путівника, який у тебе вже є. Кілька створять новий — Apple Карти не вміють об\'єднувати путівники.';

  @override
  String get addScreenshots => 'Додати знімки екрана';

  @override
  String get readingShort => 'Читаю…';

  @override
  String readingProgress(int done, int total) {
    return 'Читаю $done з $total…';
  }

  @override
  String get addToGuide => 'Додати до путівника';

  @override
  String makeGuide(int count) {
    return 'Створити путівник ($count)';
  }

  @override
  String get notFoundOnMap => 'Не знайдено на карті';

  @override
  String get tapToSearchForIt => 'Торкнись, щоб знайти';

  @override
  String readAs(String text) {
    return 'розпізнано як «$text»';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count місця не знайдено. Торкнись, щоб знайти їх.',
      many: '$count місць не знайдено. Торкнись, щоб знайти їх.',
      few: '$count місця не знайдено. Торкнись, щоб знайти їх.',
      one: '$count місце не знайдено. Торкнись, щоб знайти його.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Де розташовані ці місця?';

  @override
  String get regionDetected => 'Прочитано з підписів. Зміни, якщо це не так.';

  @override
  String get regionNotDetected =>
      'На знімках не було сказано, де вони розташовані. З містом пошук буде значно точнішим.';

  @override
  String get cityOrRegion => 'Місто або регіон';

  @override
  String get cityExample => 'напр. Київ';

  @override
  String get searchAnywhere => 'Шукати всюди';

  @override
  String get findPlaces => 'Знайти місця';

  @override
  String searchedIn(String region) {
    return 'Пошук у: $region';
  }

  @override
  String get nameThisGuide => 'Назви цей путівник';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Під цією назвою він з\'явиться в Apple Картах, у ньому буде $count місця.',
      many:
          'Під цією назвою він з\'явиться в Apple Картах, у ньому буде $count місць.',
      few:
          'Під цією назвою він з\'явиться в Apple Картах, у ньому буде $count місця.',
      one:
          'Під цією назвою він з\'явиться в Apple Картах, у ньому буде $count місце.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Назва путівника';

  @override
  String get guideNameExample => 'напр. Рим, жовтень';

  @override
  String get createGuide => 'Створити путівник';

  @override
  String get cancel => 'Скасувати';

  @override
  String get guidesOfAnySize => 'Путівники без обмежень';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren безкоштовно зберігає в путівнику до $limit місць. Вибрано $selected — на $over більше.';
  }

  @override
  String get onePaymentKept => 'Один платіж, назавжди. Без підписки.';

  @override
  String unlockFor(String price) {
    return 'Розблокувати за $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Зберегти лише перші $limit';
  }

  @override
  String get restorePrevious => 'Відновити попередню покупку';

  @override
  String get restorePurchase => 'Відновити покупку';

  @override
  String overFreeLimit(int over, int limit) {
    return 'На $over більше за безкоштовний ліміт у $limit. Можна розблокувати або зберегти перші $limit.';
  }

  @override
  String get findThisPlace => 'Знайти це місце';

  @override
  String get searchAppleMaps => 'Шукати в Apple Картах';

  @override
  String searchInRegion(String region) {
    return 'Шукати в: $region';
  }

  @override
  String get searching => 'Триває пошук…';

  @override
  String get typeTwoCharacters => 'Введи щонайменше два символи.';

  @override
  String get nothingFound =>
      'Нічого не знайдено. Спробуй вулицю або коротшу назву.';

  @override
  String get rateLimited =>
      'Apple Карти обмежують кількість запитів. Зачекай трохи й спробуй знову.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Карти обмежують кількість запитів — поки додано $added, решту спробуй трохи згодом.';
  }

  @override
  String importSummary(int found) {
    return 'знайдено $found';
  }

  @override
  String importSummaryIn(String region) {
    return 'у: $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count на перевірку';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count нерозпізнано';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Нічого читабельного на $count знімках екрана',
      many: 'Нічого читабельного на $count знімках екрана',
      few: 'Нічого читабельного на $count знімках екрана',
      one: 'Нічого читабельного на $count знімку екрана',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Не вдалося відкрити Карти';

  @override
  String get checkingAppleAccount => 'Перевіряю твій обліковий запис Apple…';

  @override
  String get restoredUnlocked =>
      'Відновлено. Путівники без обмежень розблоковано.';

  @override
  String get noPreviousPurchase =>
      'У цьому обліковому записі Apple попередніх покупок не знайдено.';

  @override
  String get purchaseDidNotComplete =>
      'Покупку не завершено, тож нічого не списано.';

  @override
  String alreadyInTheList(String name) {
    return '$name вже було у списку.';
  }

  @override
  String get ocrUnavailable =>
      'Для читання знімків екрана потрібен iPhone — на цій платформі немає розпізнавання тексту.';

  @override
  String get lookupUnavailable =>
      'Для пошуку місць потрібен iPhone — на цій платформі немає пошуку по карті.';

  @override
  String get compAccess => 'Безкоштовний доступ';

  @override
  String get code => 'Код';

  @override
  String get unlock => 'Розблокувати';

  @override
  String get compChecking => 'Перевіряю код…';

  @override
  String get compEnabled => 'Безкоштовний доступ ввімкнено.';

  @override
  String get compRefused => 'Цей код не розпізнано або він уже використаний.';

  @override
  String get compTooOften =>
      'Забагато спроб. Зачекай кілька хвилин і спробуй знову.';

  @override
  String get compUnreachable =>
      'Не вдалося зв\'язатися з сервером. Перевір з\'єднання й спробуй знову.';

  @override
  String get compUntrusted =>
      'Не вдалося перевірити відповідь, тож нічого не розблоковано.';
}
