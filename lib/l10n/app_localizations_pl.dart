// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class LPl extends L {
  LPl([String locale = 'pl']) : super(locale);

  @override
  String get tagline => 'Ptaszek mi wyćwierkał.';

  @override
  String get emptyTitle => 'Miejsca, zachowane.';

  @override
  String get emptyBody =>
      'Zrób zrzut ekranu tego, co ci polecają — rolki, posta, wiadomości, strony przewodnika. Wren odczyta nazwy i doda je do Map Apple.';

  @override
  String get emptyNote =>
      'Pojedyncze miejsce trafia do przewodnika, który już masz. Kilka tworzy nowy — Mapy Apple nie potrafią łączyć przewodników.';

  @override
  String get addScreenshots => 'Dodaj zrzuty ekranu';

  @override
  String get readingShort => 'Odczytywanie…';

  @override
  String readingProgress(int done, int total) {
    return 'Odczytywanie $done z $total…';
  }

  @override
  String get addToGuide => 'Dodaj do przewodnika';

  @override
  String makeGuide(int count) {
    return 'Utwórz przewodnik ($count)';
  }

  @override
  String get notFoundOnMap => 'Nie znaleziono na mapie';

  @override
  String get tapToSearchForIt => 'Dotknij, aby wyszukać';

  @override
  String readAs(String text) {
    return 'odczytano jako „$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nie znaleziono $count miejsca. Dotknij, aby je wyszukać.',
      many: 'Nie znaleziono $count miejsc. Dotknij, aby je wyszukać.',
      few: 'Nie znaleziono $count miejsc. Dotknij, aby je wyszukać.',
      one: 'Nie znaleziono 1 miejsca. Dotknij, aby je wyszukać.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Gdzie są te miejsca?';

  @override
  String get regionDetected => 'Odczytano z podpisów. Zmień, jeśli to nie tak.';

  @override
  String get regionNotDetected =>
      'W zrzutach nie było napisane, gdzie one są. Podanie miasta znacznie poprawia trafność wyszukiwania.';

  @override
  String get cityOrRegion => 'Miasto lub region';

  @override
  String get cityExample => 'np. Warszawa';

  @override
  String get searchAnywhere => 'Szukaj wszędzie';

  @override
  String get findPlaces => 'Znajdź miejsca';

  @override
  String searchedIn(String region) {
    return 'Wyszukano w: $region';
  }

  @override
  String get nameThisGuide => 'Nazwij ten przewodnik';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pod tą nazwą pojawi się w Mapach Apple, z $count miejsca.',
      many: 'Pod tą nazwą pojawi się w Mapach Apple, z $count miejscami.',
      few: 'Pod tą nazwą pojawi się w Mapach Apple, z $count miejscami.',
      one: 'Pod tą nazwą pojawi się w Mapach Apple, z 1 miejscem.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Nazwa przewodnika';

  @override
  String get guideNameExample => 'np. Rzym, październik';

  @override
  String get createGuide => 'Utwórz przewodnik';

  @override
  String get cancel => 'Anuluj';

  @override
  String get guidesOfAnySize => 'Przewodniki bez ograniczeń';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren zapisuje w przewodniku do $limit miejsc za darmo. Masz zaznaczone $selected — o $over za dużo.';
  }

  @override
  String get onePaymentKept => 'Jedna płatność, na zawsze. Bez abonamentu.';

  @override
  String unlockFor(String price) {
    return 'Odblokuj za $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Zapisz zamiast tego pierwsze $limit';
  }

  @override
  String get restorePrevious => 'Przywróć wcześniejszy zakup';

  @override
  String get restorePurchase => 'Przywróć zakup';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over ponad darmowy limit $limit. Możesz odblokować albo zapisać pierwsze $limit.';
  }

  @override
  String get findThisPlace => 'Znajdź to miejsce';

  @override
  String get searchAppleMaps => 'Szukaj w Mapach Apple';

  @override
  String searchInRegion(String region) {
    return 'Szukaj w: $region';
  }

  @override
  String get searching => 'Szukanie…';

  @override
  String get typeTwoCharacters => 'Wpisz co najmniej dwa znaki.';

  @override
  String get nothingFound =>
      'Nic nie znaleziono. Spróbuj podać ulicę albo krótszą nazwę.';

  @override
  String get rateLimited =>
      'Mapy Apple ograniczają liczbę zapytań. Odczekaj chwilę i spróbuj ponownie.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Mapy Apple ograniczają liczbę zapytań — dodano na razie $added, spróbuj resztę za chwilę.';
  }

  @override
  String importSummary(int found) {
    return 'znaleziono $found';
  }

  @override
  String importSummaryIn(String region) {
    return 'w: $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count do sprawdzenia';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count nieczytelnych';
  }

  @override
  String nothingReadable(int count) {
    return 'Nic czytelnego w $count zrzutach ekranu';
  }

  @override
  String get couldNotOpenMaps => 'Nie udało się otworzyć Map';

  @override
  String get checkingAppleAccount => 'Sprawdzanie konta Apple…';

  @override
  String get restoredUnlocked =>
      'Przywrócono. Przewodniki bez ograniczeń są odblokowane.';

  @override
  String get noPreviousPurchase =>
      'Nie znaleziono wcześniejszego zakupu na tym koncie Apple.';

  @override
  String get purchaseDidNotComplete =>
      'Zakup nie doszedł do skutku, więc nic nie zostało pobrane.';

  @override
  String alreadyInTheList(String name) {
    return '$name już było na liście.';
  }

  @override
  String get ocrUnavailable =>
      'Odczytywanie zrzutów ekranu wymaga iPhone\'a — na tej platformie nie ma rozpoznawania tekstu.';

  @override
  String get lookupUnavailable =>
      'Wyszukiwanie miejsc wymaga iPhone\'a — na tej platformie nie ma wyszukiwania na mapie.';

  @override
  String get compAccess => 'Bezpłatny dostęp';

  @override
  String get code => 'Kod';

  @override
  String get unlock => 'Odblokuj';

  @override
  String get compChecking => 'Sprawdzanie kodu…';

  @override
  String get compEnabled => 'Bezpłatny dostęp włączony.';

  @override
  String get compRefused =>
      'Nie rozpoznano tego kodu albo został już wykorzystany.';

  @override
  String get compTooOften =>
      'Zbyt wiele prób. Odczekaj kilka minut i spróbuj ponownie.';

  @override
  String get compUnreachable =>
      'Nie udało się połączyć z serwerem. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get compUntrusted =>
      'Nie udało się zweryfikować odpowiedzi, więc nic nie zostało odblokowane.';
}
