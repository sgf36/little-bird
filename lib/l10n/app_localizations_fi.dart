// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class LFi extends L {
  LFi([String locale = 'fi']) : super(locale);

  @override
  String get tagline => 'Pikkulintu kertoi.';

  @override
  String get emptyTitle => 'Paikat, talteen.';

  @override
  String get emptyBody =>
      'Ota kuvakaappaus siitä, mitä sinulle suositellaan — reelistä, julkaisusta, viestistä, matkaoppaan sivusta. Wren lukee nimet ja vie ne Apple Kartat -appiin.';

  @override
  String get emptyNote =>
      'Yksittäinen paikka liittyy oppaaseen, joka sinulla jo on. Useampi luo uuden — Apple Kartat ei osaa yhdistää oppaita.';

  @override
  String get addScreenshots => 'Lisää kuvakaappauksia';

  @override
  String get readingShort => 'Luetaan…';

  @override
  String readingProgress(int done, int total) {
    return 'Luetaan $done / $total…';
  }

  @override
  String get addToGuide => 'Lisää oppaaseen';

  @override
  String makeGuide(int count) {
    return 'Luo opas ($count)';
  }

  @override
  String get notFoundOnMap => 'Ei löytynyt kartalta';

  @override
  String get tapToSearchForIt => 'Etsi napauttamalla';

  @override
  String readAs(String text) {
    return 'luettiin muodossa ”$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count paikkaa ei löytynyt. Etsi ne napauttamalla.',
      one: '1 paikkaa ei löytynyt. Etsi se napauttamalla.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Missä nämä paikat ovat?';

  @override
  String get regionDetected =>
      'Luettu kuvateksteistä. Muuta, jos se ei pidä paikkaansa.';

  @override
  String get regionNotDetected =>
      'Kuvakaappauksissa ei kerrottu, missä nämä ovat. Kaupungin kanssa haku osuu paljon paremmin.';

  @override
  String get cityOrRegion => 'Kaupunki tai alue';

  @override
  String get cityExample => 'esim. Helsinki';

  @override
  String get searchAnywhere => 'Hae kaikkialta';

  @override
  String get findPlaces => 'Etsi paikat';

  @override
  String searchedIn(String region) {
    return 'Haettu alueelta $region';
  }

  @override
  String get nameThisGuide => 'Anna oppaalle nimi';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Se näkyy tällä nimellä Apple Kartoissa, ja siinä on $count paikkaa.',
      one: 'Se näkyy tällä nimellä Apple Kartoissa, ja siinä on 1 paikka.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Oppaan nimi';

  @override
  String get guideNameExample => 'esim. Rooma, lokakuu';

  @override
  String get createGuide => 'Luo opas';

  @override
  String get cancel => 'Kumoa';

  @override
  String get guidesOfAnySize => 'Minkä kokoisia oppaita tahansa';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren tallentaa oppaaseen ilmaiseksi enintään $limit paikkaa. Olet valinnut $selected — $over enemmän.';
  }

  @override
  String get onePaymentKept => 'Yksi maksu, pysyy ikuisesti. Ei tilausta.';

  @override
  String unlockFor(String price) {
    return 'Avaa hintaan $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Tallenna sen sijaan $limit ensimmäistä';
  }

  @override
  String get restorePrevious => 'Palauta aiempi osto';

  @override
  String get restorePurchase => 'Palauta osto';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over yli ilmaisen $limit paikan rajan. Voit avata rajan tai tallentaa $limit ensimmäistä.';
  }

  @override
  String get findThisPlace => 'Etsi tämä paikka';

  @override
  String get searchAppleMaps => 'Hae Apple Kartoista';

  @override
  String searchInRegion(String region) {
    return 'Hae alueelta $region';
  }

  @override
  String get searching => 'Haetaan…';

  @override
  String get typeTwoCharacters => 'Kirjoita vähintään kaksi merkkiä.';

  @override
  String get nothingFound => 'Ei tuloksia. Kokeile katua tai lyhyempää nimeä.';

  @override
  String get rateLimited =>
      'Apple Kartat rajoittaa hakuja. Odota hetki ja yritä uudelleen.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Kartat rajoittaa hakuja — $added lisätty tähän mennessä, kokeile loppuja hetken päästä.';
  }

  @override
  String importSummary(int found) {
    return '$found löytyi';
  }

  @override
  String importSummaryIn(String region) {
    return 'alueelta $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count tarkistettavaa';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count lukukelvotonta';
  }

  @override
  String nothingReadable(int count) {
    return 'Ei mitään luettavaa $count kuvakaappauksessa';
  }

  @override
  String get couldNotOpenMaps => 'Karttoja ei voitu avata';

  @override
  String get checkingAppleAccount => 'Tarkistetaan Apple-tiliäsi…';

  @override
  String get restoredUnlocked =>
      'Palautettu. Minkä kokoiset oppaat tahansa on avattu.';

  @override
  String get noPreviousPurchase =>
      'Tältä Apple-tililtä ei löytynyt aiempaa ostoa.';

  @override
  String get purchaseDidNotComplete =>
      'Osto ei mennyt läpi, joten mitään ei veloitettu.';

  @override
  String alreadyInTheList(String name) {
    return '$name oli jo listalla.';
  }

  @override
  String get ocrUnavailable =>
      'Kuvakaappausten lukeminen vaatii iPhonen — tällä alustalla ei ole tekstintunnistusta.';

  @override
  String get lookupUnavailable =>
      'Paikkojen haku vaatii iPhonen — tällä alustalla ei ole karttahakua.';

  @override
  String get compAccess => 'Maksuton käyttöoikeus';

  @override
  String get code => 'Koodi';

  @override
  String get unlock => 'Avaa';

  @override
  String get compChecking => 'Tarkistetaan koodia…';

  @override
  String get compEnabled => 'Maksuton käyttöoikeus otettu käyttöön.';

  @override
  String get compRefused => 'Koodia ei tunnistettu, tai se on jo käytetty.';

  @override
  String get compTooOften =>
      'Liian monta yritystä. Odota muutama minuutti ja yritä uudelleen.';

  @override
  String get compUnreachable =>
      'Palvelimeen ei saatu yhteyttä. Tarkista yhteytesi ja yritä uudelleen.';

  @override
  String get compUntrusted =>
      'Vastausta ei voitu varmentaa, joten mitään ei avattu.';

  @override
  String get addPlaces => 'Lisää';

  @override
  String get fromFile => 'Tiedostosta';

  @override
  String get fromExistingGuide => 'Olemassa olevasta oppaasta';

  @override
  String get importGuideTitle => 'Lisää olemassa olevaan oppaaseen';

  @override
  String get importGuideBody =>
      'Avaa opas Apple Kartoissa, jaa se ja valitse ”Kopioi linkki”. Liitä linkki alle, niin Wren lukee paikat, jotka oppaassa jo ovat.';

  @override
  String get guideLinkLabel => 'Oppaan linkki';

  @override
  String get readGuide => 'Lue opas';

  @override
  String get importGuideNotALink =>
      'Tämä ei ole Apple Kartat -oppaan linkki. Avaa opas Kartoissa, jaa se ja valitse ”Kopioi linkki”.';

  @override
  String get importGuideNothing =>
      'Oppaassa ei ole yhtään paikkaa, jonka Wren voisi ottaa mukaan.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Luettiin $count paikkaa oppaasta',
      one: 'Luettiin 1 paikka oppaasta',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count paikkaa oppaasta ei voi ottaa mukaan',
      one: '1 paikkaa oppaasta ei voi ottaa mukaan',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count paikkaa on jo tässä oppaassa',
      one: '1 paikka on jo tässä oppaassa',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Oppaasta ”$name”';
  }

  @override
  String get republishTitle => 'Kartat luo uuden oppaan';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple ei tarjoa tapaa lisätä paikkoja valmiiseen oppaaseen, joten Wren luo uuden, jossa on kaikki $count paikkaa.',
      one:
          'Apple ei tarjoa tapaa lisätä paikkoja valmiiseen oppaaseen, joten Wren luo uuden, jossa on tämä yksi paikka.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Pidä uusi opas ja poista vanha.';

  @override
  String get republishKeepsPlaces =>
      'Wren pitää nämä paikat tallessa, joten voit luoda oppaan uudelleen, jos jokin menee vikaan.';

  @override
  String get makeCombinedGuide => 'Luo yhdistetty opas';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Luettiin $count paikkaa tiedostosta',
      one: 'Luettiin 1 paikka tiedostosta',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count riviltä puuttui nimi',
      one: '1 riviltä puuttui nimi',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Tiedostossa ei ole paikkoja.';

  @override
  String get fileUnreadable =>
      'Wren ei voinut lukea tiedostoa. Se lukee CSV-, KML-, KMZ-, GPX- ja GeoJSON-tiedostoja sekä Google Takeout -vientejä.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Etsitään $done / $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'Yhdistetyn oppaan luominen edellyttää avaamista.';

  @override
  String get unlockCombineTitle => 'Lisää oppaaseen, joka sinulla jo on';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren luo yhden oppaan, joka sisältää sekä ne $count paikkaa, jotka oppaassasi jo ovat, että uudet.',
      one:
          'Wren luo yhden oppaan, joka sisältää sekä oppaassasi jo olevan paikan että uuden.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Lukee myös toisesta appista viedyn listan: CSV, KML, KMZ, GPX, GeoJSON tai Google Takeout.';

  @override
  String get clearList => 'Tyhjennä lista';

  @override
  String get clearListTitle => 'Tyhjennä lista';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Poistetaanko kaikki $count paikkaa Wrenistä? Apple Kartoissa jo tehdyt oppaat eivät muutu.',
      one:
          'Poistetaanko tämä yksi paikka Wrenistä? Apple Kartoissa jo tehdyt oppaat eivät muutu.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Poista';

  @override
  String get listCleared => 'Lista tyhjennetty.';

  @override
  String get expandingLink => 'Luetaan linkkiä…';

  @override
  String get linkUnreachable =>
      'Appleen ei saatu yhteyttä linkin lukemista varten. Tarkista yhteytesi ja yritä uudelleen.';

  @override
  String get splitTitle => 'Tästä tulee useampi kuin yksi opas';

  @override
  String splitBody(int guides, int count) {
    return 'Apple rajoittaa, montako paikkaa yhteen opaslinkkiin mahtuu. Wren tekee $guides opasta, numeroituna niin että järjestys säilyy, ja niissä on yhteensä $count paikkaa.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Luo $guides opasta';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Opas $done / $total avattu. Napauta, niin luodaan seuraava.';
  }

  @override
  String get sendPlacesTo => 'Lähetä paikat';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count paikkaa valmiina lähetettäväksi',
      one: '1 paikka valmiina lähetettäväksi',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count paikalla ei ole sijaintia eikä niitä voi lähettää',
      one: '1 paikalla ei ole sijaintia eikä sitä voi lähettää',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Mikä tahansa muu sovellus';

  @override
  String get sendPlacesFailed => 'Sovellus ei ottanut tiedostoa vastaan';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count paikkaa säilytettiin tiedostosta, valmiina toiseen karttasovellukseen',
      one:
          '1 paikka säilytettiin tiedostosta, valmis toiseen karttasovellukseen',
    );
    return '$_temp0';
  }
}
