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
}
