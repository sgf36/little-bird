// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class LRo extends L {
  LRo([String locale = 'ro']) : super(locale);

  @override
  String get tagline => 'Mi-a spus o păsărică.';

  @override
  String get emptyTitle => 'Locuri, păstrate.';

  @override
  String get emptyBody =>
      'Fă o captură de ecran cu ce ți se recomandă — un reel, o postare, un mesaj, o pagină dintr-un ghid de călătorie. Wren citește numele și le pune în Apple Hărți.';

  @override
  String get emptyNote =>
      'Un singur loc intră într-un ghid pe care îl ai deja. Mai multe creează unul nou — Apple Hărți nu poate îmbina ghiduri.';

  @override
  String get addScreenshots => 'Adaugă capturi de ecran';

  @override
  String get readingShort => 'Se citește…';

  @override
  String readingProgress(int done, int total) {
    return 'Se citește $done din $total…';
  }

  @override
  String get addToGuide => 'Adaugă într-un ghid';

  @override
  String makeGuide(int count) {
    return 'Creează un ghid ($count)';
  }

  @override
  String get notFoundOnMap => 'Nu a fost găsit pe hartă';

  @override
  String get tapToSearchForIt => 'Atinge pentru a-l căuta';

  @override
  String readAs(String text) {
    return 'citit ca „$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de locuri nu au fost găsite. Atinge pentru a le căuta.',
      few: '$count locuri nu au fost găsite. Atinge pentru a le căuta.',
      one: '1 loc nu a fost găsit. Atinge pentru a-l căuta.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Unde se află aceste locuri?';

  @override
  String get regionDetected => 'Citit din descrieri. Schimbă dacă nu e corect.';

  @override
  String get regionNotDetected =>
      'În capturi nu scria unde se află. Cu un oraș, căutarea devine mult mai precisă.';

  @override
  String get cityOrRegion => 'Oraș sau regiune';

  @override
  String get cityExample => 'de ex. București';

  @override
  String get searchAnywhere => 'Caută peste tot';

  @override
  String get findPlaces => 'Găsește locurile';

  @override
  String searchedIn(String region) {
    return 'Căutat în $region';
  }

  @override
  String get nameThisGuide => 'Dă un nume acestui ghid';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Va apărea cu acest nume în Apple Hărți, cu $count de locuri.',
      few: 'Va apărea cu acest nume în Apple Hărți, cu $count locuri.',
      one: 'Va apărea cu acest nume în Apple Hărți, cu 1 loc.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Numele ghidului';

  @override
  String get guideNameExample => 'de ex. Roma, octombrie';

  @override
  String get createGuide => 'Creează ghidul';

  @override
  String get cancel => 'Anulează';

  @override
  String get guidesOfAnySize => 'Ghiduri de orice mărime';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren salvează gratuit până la $limit locuri într-un ghid. Ai selectat $selected — cu $over mai multe.';
  }

  @override
  String get onePaymentKept =>
      'O singură plată, a ta pentru totdeauna. Fără abonament.';

  @override
  String unlockFor(String price) {
    return 'Deblochează pentru $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Salvează în schimb primele $limit';
  }

  @override
  String get restorePrevious => 'Restaurează o achiziție anterioară';

  @override
  String get restorePurchase => 'Restaurează achiziția';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over peste limita gratuită de $limit. Poți debloca sau salva primele $limit.';
  }

  @override
  String get findThisPlace => 'Găsește acest loc';

  @override
  String get searchAppleMaps => 'Caută în Apple Hărți';

  @override
  String searchInRegion(String region) {
    return 'Caută în $region';
  }

  @override
  String get searching => 'Se caută…';

  @override
  String get typeTwoCharacters => 'Scrie cel puțin două caractere.';

  @override
  String get nothingFound =>
      'Nu s-a găsit nimic. Încearcă strada sau un nume mai scurt.';

  @override
  String get rateLimited =>
      'Apple Hărți limitează căutările. Așteaptă puțin și încearcă din nou.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Hărți limitează căutările — $added adăugate până acum, încearcă restul peste puțin timp.';
  }

  @override
  String importSummary(int found) {
    return '$found găsite';
  }

  @override
  String importSummaryIn(String region) {
    return 'în $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count de verificat';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count ilizibile';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nimic lizibil în $count de capturi de ecran',
      few: 'Nimic lizibil în $count capturi de ecran',
      one: 'Nimic lizibil în acea captură de ecran',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Hărți nu a putut fi deschisă';

  @override
  String get checkingAppleAccount => 'Se verifică contul tău Apple…';

  @override
  String get restoredUnlocked =>
      'Restaurat. Ghidurile de orice mărime sunt deblocate.';

  @override
  String get noPreviousPurchase =>
      'Nu s-a găsit nicio achiziție anterioară pe acest cont Apple.';

  @override
  String get purchaseDidNotComplete =>
      'Achiziția nu s-a finalizat, așa că nu s-a perceput nimic.';

  @override
  String alreadyInTheList(String name) {
    return '$name era deja în listă.';
  }

  @override
  String get ocrUnavailable =>
      'Citirea capturilor de ecran necesită un iPhone — pe această platformă nu există recunoaștere de text.';

  @override
  String get lookupUnavailable =>
      'Căutarea locurilor necesită un iPhone — pe această platformă nu există căutare pe hartă.';

  @override
  String get compAccess => 'Acces gratuit';

  @override
  String get code => 'Cod';

  @override
  String get unlock => 'Deblochează';

  @override
  String get compChecking => 'Se verifică acest cod…';

  @override
  String get compEnabled => 'Acces gratuit activat.';

  @override
  String get compRefused =>
      'Acest cod nu a fost recunoscut sau a fost deja folosit.';

  @override
  String get compTooOften =>
      'Prea multe încercări. Așteaptă câteva minute și încearcă din nou.';

  @override
  String get compUnreachable =>
      'Serverul nu a putut fi contactat. Verifică-ți conexiunea și încearcă din nou.';

  @override
  String get compUntrusted =>
      'Răspunsul nu a putut fi verificat, așa că nu s-a deblocat nimic.';

  @override
  String get addPlaces => 'Adaugă';

  @override
  String get fromFile => 'Dintr-un fișier';

  @override
  String get fromExistingGuide => 'Dintr-un ghid existent';

  @override
  String get importGuideTitle => 'Adaugă într-un ghid existent';

  @override
  String get importGuideBody =>
      'În Apple Hărți, deschide ghidul și partajează-l, apoi alege Copiază linkul. Lipește-l mai jos și Wren va citi locurile pe care le conține deja.';

  @override
  String get guideLinkLabel => 'Linkul ghidului';

  @override
  String get readGuide => 'Citește ghidul';

  @override
  String get importGuideNotALink =>
      'Acesta nu este un link de ghid Apple Hărți. Deschide ghidul în Hărți, partajează-l, apoi alege Copiază linkul.';

  @override
  String get importGuideNothing =>
      'Acel ghid nu conține nimic ce Wren ar putea prelua.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S-au citit $count de locuri din acel ghid',
      few: 'S-au citit $count locuri din acel ghid',
      one: 'S-a citit 1 loc din acel ghid',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de locuri din el nu pot fi preluate',
      few: '$count locuri din el nu pot fi preluate',
      one: '1 loc din el nu poate fi preluat',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de locuri deja în acest ghid',
      few: '$count locuri deja în acest ghid',
      one: '1 loc deja în acest ghid',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Din „$name”';
  }

  @override
  String get republishTitle => 'Hărți creează un ghid nou';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple nu permite adăugarea de locuri într-un ghid care există deja, așa că Wren va crea unul nou, cu toate cele $count de locuri.',
      few:
          'Apple nu permite adăugarea de locuri într-un ghid care există deja, așa că Wren va crea unul nou, cu toate cele $count locuri.',
      one:
          'Apple nu permite adăugarea de locuri într-un ghid care există deja, așa că Wren va crea unul nou, cu acel 1 loc.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Păstrează ghidul nou și șterge-l pe cel vechi.';

  @override
  String get republishKeepsPlaces =>
      'Wren păstrează aceste locuri, așa că poți crea ghidul din nou dacă ceva nu merge bine.';

  @override
  String get makeCombinedGuide => 'Creează ghidul combinat';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S-au citit $count de locuri din acel fișier',
      few: 'S-au citit $count locuri din acel fișier',
      one: 'S-a citit 1 loc din acel fișier',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de rânduri nu aveau nume',
      few: '$count rânduri nu aveau nume',
      one: '1 rând nu avea nume',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Niciun loc în acel fișier.';

  @override
  String get fileUnreadable =>
      'Wren nu a putut citi acel fișier. Citește exporturi CSV, KML, KMZ, GPX, GeoJSON și Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Se caută $done din $total…';
  }

  @override
  String get combineNeedsUnlock => 'Ghidul combinat necesită deblocarea.';

  @override
  String get unlockCombineTitle => 'Adaugă într-un ghid pe care îl ai deja';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren va crea un singur ghid care va conține cele $count de locuri deja aflate în al tău, împreună cu cele noi.',
      few:
          'Wren va crea un singur ghid care va conține cele $count locuri deja aflate în al tău, împreună cu cele noi.',
      one:
          'Wren va crea un singur ghid care va conține locul deja aflat în al tău, împreună cu cel nou.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Citește și o listă exportată din altă aplicație: CSV, KML, KMZ, GPX, GeoJSON sau Google Takeout.';

  @override
  String get clearList => 'Golește lista';

  @override
  String get clearListTitle => 'Golește lista';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Elimini toate cele $count de locuri din Wren? Ghidurile deja create în Apple Hărți nu sunt afectate.',
      few:
          'Elimini toate cele $count locuri din Wren? Ghidurile deja create în Apple Hărți nu sunt afectate.',
      one:
          'Elimini singurul loc din Wren? Ghidurile deja create în Apple Hărți nu sunt afectate.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Elimină';

  @override
  String get listCleared => 'Lista a fost golită.';

  @override
  String get expandingLink => 'Se citește linkul…';

  @override
  String get linkUnreachable =>
      'Nu s-a putut contacta Apple pentru a citi acel link. Verifică-ți conexiunea și încearcă din nou.';

  @override
  String get splitTitle => 'Se vor crea mai multe ghiduri';

  @override
  String splitBody(int guides, int count) {
    return 'Apple limitează câte locuri poate duce un link de ghid. Wren va crea mai multe ghiduri ($guides), numerotate ca să rămână în ordine, și va împărți între ele toate locurile ($count).';
  }

  @override
  String splitConfirm(int guides) {
    return 'Creează ghidurile ($guides)';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Ghidul $done din $total a fost deschis. Atinge pentru a-l crea pe următorul.';
  }

  @override
  String get sendPlacesTo => 'Trimite locurile către';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de locuri sunt gata de trimis',
      few: '$count locuri sunt gata de trimis',
      one: '1 loc este gata de trimis',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de locuri nu au poziție și nu pot fi trimise',
      few: '$count locuri nu au poziție și nu pot fi trimise',
      one: '1 loc nu are poziție și nu poate fi trimis',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Orice altă aplicație';

  @override
  String get sendPlacesFailed => 'Acea aplicație nu a acceptat fișierul';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count de locuri păstrate din fișier, gata pentru altă aplicație de hărți',
      few:
          '$count locuri păstrate din fișier, gata pentru altă aplicație de hărți',
      one: '1 loc păstrat din fișier, gata pentru altă aplicație de hărți',
    );
    return '$_temp0';
  }
}
