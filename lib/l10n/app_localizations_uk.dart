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
  String get emptyBodyAndroid =>
      'Зроби знімок екрана того, що тобі радять — рілс, допис, повідомлення, сторінку путівника. Wren прочитає назви й надішле їх у застосунок карт на вашому телефоні.';

  @override
  String get emptyNoteAndroid =>
      'Він також прочитає список, який у вас уже є, і покаже кожне місце, перш ніж щось буде надіслано.';

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

  @override
  String get addPlaces => 'Додати';

  @override
  String get fromFile => 'З файлу';

  @override
  String get fromExistingGuide => 'З наявного путівника';

  @override
  String get importGuideTitle => 'Додати до наявного путівника';

  @override
  String get importGuideBody =>
      'Відкрий путівник в Apple Картах, натисни «Оприлюднити» й вибери «Скопіювати посилання». Встав його нижче, і Wren прочитає місця, які в ньому вже є.';

  @override
  String get guideLinkLabel => 'Посилання на путівник';

  @override
  String get readGuide => 'Прочитати путівник';

  @override
  String get importGuideNotALink =>
      'Це не посилання на путівник Apple Карт. Відкрий путівник у Картах, натисни «Оприлюднити» й вибери «Скопіювати посилання».';

  @override
  String get importGuideNothing =>
      'У цьому путівнику немає нічого, що Wren міг би перенести.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'З цього путівника прочитано $count місця',
      many: 'З цього путівника прочитано $count місць',
      few: 'З цього путівника прочитано $count місця',
      one: 'З цього путівника прочитано $count місце',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count місця з нього не можна перенести',
      many: '$count місць з нього не можна перенести',
      few: '$count місця з нього не можна перенести',
      one: '$count місце з нього не можна перенести',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count місця вже в цьому путівнику',
      many: '$count місць вже в цьому путівнику',
      few: '$count місця вже в цьому путівнику',
      one: '$count місце вже в цьому путівнику',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'З «$name»';
  }

  @override
  String get republishTitle => 'Карти створять новий путівник';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple не дає змоги додавати місця до вже наявного путівника, тому Wren створить новий — у ньому буде $count місця.',
      many:
          'Apple не дає змоги додавати місця до вже наявного путівника, тому Wren створить новий — у ньому будуть усі $count місць.',
      few:
          'Apple не дає змоги додавати місця до вже наявного путівника, тому Wren створить новий — у ньому будуть усі $count місця.',
      one:
          'Apple не дає змоги додавати місця до вже наявного путівника, тому Wren створить новий — у ньому буде $count місце.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Залиш новий путівник, а старий видали.';

  @override
  String get republishKeepsPlaces =>
      'Wren зберігає ці місця, тож путівник можна створити заново, якщо щось піде не так.';

  @override
  String get makeCombinedGuide => 'Створити об\'єднаний путівник';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'З цього файлу прочитано $count місця',
      many: 'З цього файлу прочитано $count місць',
      few: 'З цього файлу прочитано $count місця',
      one: 'З цього файлу прочитано $count місце',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'У $count рядка не було назви',
      many: 'У $count рядках не було назви',
      few: 'У $count рядках не було назви',
      one: 'У $count рядку не було назви',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'У цьому файлі немає місць.';

  @override
  String get fileUnreadable =>
      'Wren не зміг прочитати цей файл. Він читає CSV, KML, KMZ, GPX, GeoJSON і вивантаження Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Шукаю $done з $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'Об\'єднаний путівник потребує розблокування.';

  @override
  String get unlockCombineTitle => 'Додати до путівника, який у тебе вже є';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren створить один путівник, де будуть і $count місця з твого, і нові.',
      many:
          'Wren створить один путівник, де будуть і $count місць з твого, і нові.',
      few:
          'Wren створить один путівник, де будуть і $count місця з твого, і нові.',
      one:
          'Wren створить один путівник, де будуть і $count місце з твого, і нові.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Також читає список, експортований з іншого застосунку: CSV, KML, KMZ, GPX, GeoJSON або Google Takeout.';

  @override
  String get clearList => 'Очистити список';

  @override
  String get clearListTitle => 'Очистити список';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Прибрати всі $count місця з Wren? Путівників, уже створених в Apple Картах, це не торкнеться.',
      many:
          'Прибрати всі $count місць з Wren? Путівників, уже створених в Apple Картах, це не торкнеться.',
      few:
          'Прибрати всі $count місця з Wren? Путівників, уже створених в Apple Картах, це не торкнеться.',
      one:
          'Прибрати $count місце з Wren? Путівників, уже створених в Apple Картах, це не торкнеться.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Прибрати';

  @override
  String get listCleared => 'Список очищено.';

  @override
  String get expandingLink => 'Читаю посилання…';

  @override
  String get linkUnreachable =>
      'Не вдалося зв\'язатися з Apple, щоб прочитати це посилання. Перевір з\'єднання й спробуй знову.';

  @override
  String get splitTitle => 'Вийде більше ніж один путівник';

  @override
  String splitBody(int guides, int count) {
    return 'Apple обмежує, скільки місць вміщає одне посилання на путівник. Тому Wren створить кілька путівників ($guides) з номерами, щоб порядок зберігся, і розподілить між ними всі місця ($count).';
  }

  @override
  String splitConfirm(int guides) {
    return 'Створити путівники ($guides)';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Путівник $done з $total відкрито. Торкнись, щоб зробити наступний.';
  }

  @override
  String get sendPlacesTo => 'Надіслати місця до';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count місця готові до надсилання',
      many: '$count місць готові до надсилання',
      few: '$count місця готові до надсилання',
      one: '$count місце готове до надсилання',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count місця без координат, їх не надіслати',
      many: '$count місць без координат, їх не надіслати',
      few: '$count місця без координат, їх не надіслати',
      one: '$count місце без координат, його не надіслати',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Будь-який інший застосунок';

  @override
  String get sendPlacesFailed => 'Цей застосунок не прийняв файл';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count місця з файлу готові до надсилання в інший застосунок карт',
      many: '$count місць з файлу готові до надсилання в інший застосунок карт',
      few: '$count місця з файлу готові до надсилання в інший застосунок карт',
      one: '$count місце з файлу готове до надсилання в інший застосунок карт',
    );
    return '$_temp0';
  }

  @override
  String get compExpiring =>
      'Wren не зміг підтвердити ваш безкоштовний доступ. Підключіться до інтернету впродовж найближчих днів, щоб зберегти його.';
}
