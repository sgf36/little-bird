// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class LEl extends L {
  LEl([String locale = 'el']) : super(locale);

  @override
  String get tagline => 'Μου το είπε ένα πουλάκι.';

  @override
  String get emptyTitle => 'Μέρη, φυλαγμένα.';

  @override
  String get emptyBody =>
      'Βγάλε στιγμιότυπο οθόνης απ\' ό,τι σου προτείνουν — ένα reel, μια ανάρτηση, ένα μήνυμα, μια σελίδα από ταξιδιωτικό οδηγό. Το Wren διαβάζει τα ονόματα και τα βάζει στους Χάρτες της Apple.';

  @override
  String get emptyNote =>
      'Ένα μεμονωμένο μέρος μπαίνει σε οδηγό που έχεις ήδη. Πολλά φτιάχνουν καινούριο — οι Χάρτες της Apple δεν συγχωνεύουν οδηγούς.';

  @override
  String get addScreenshots => 'Προσθήκη στιγμιότυπων';

  @override
  String get readingShort => 'Ανάγνωση…';

  @override
  String readingProgress(int done, int total) {
    return 'Ανάγνωση $done από $total…';
  }

  @override
  String get addToGuide => 'Προσθήκη σε οδηγό';

  @override
  String makeGuide(int count) {
    return 'Δημιουργία οδηγού ($count)';
  }

  @override
  String get notFoundOnMap => 'Δεν βρέθηκε στον χάρτη';

  @override
  String get tapToSearchForIt => 'Άγγιξε για αναζήτηση';

  @override
  String readAs(String text) {
    return 'διαβάστηκε ως «$text»';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count μέρη δεν βρέθηκαν. Άγγιξε για αναζήτηση.',
      one: '1 μέρος δεν βρέθηκε. Άγγιξε για αναζήτηση.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Πού βρίσκονται αυτά τα μέρη;';

  @override
  String get regionDetected =>
      'Διαβάστηκε από τις λεζάντες. Άλλαξέ το αν δεν ισχύει.';

  @override
  String get regionNotDetected =>
      'Στα στιγμιότυπα δεν έλεγε πού βρίσκονται. Με μια πόλη η αναζήτηση γίνεται πολύ πιο ακριβής.';

  @override
  String get cityOrRegion => 'Πόλη ή περιοχή';

  @override
  String get cityExample => 'π.χ. Αθήνα';

  @override
  String get searchAnywhere => 'Αναζήτηση παντού';

  @override
  String get findPlaces => 'Εύρεση μερών';

  @override
  String searchedIn(String region) {
    return 'Αναζήτηση σε $region';
  }

  @override
  String get nameThisGuide => 'Δώσε όνομα σε αυτόν τον οδηγό';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Θα εμφανίζεται με αυτό το όνομα στους Χάρτες της Apple, με $count μέρη μέσα.',
      one:
          'Θα εμφανίζεται με αυτό το όνομα στους Χάρτες της Apple, με 1 μέρος μέσα.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Όνομα οδηγού';

  @override
  String get guideNameExample => 'π.χ. Ρώμη, Οκτώβριος';

  @override
  String get createGuide => 'Δημιουργία οδηγού';

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get guidesOfAnySize => 'Οδηγοί χωρίς όριο';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Το Wren αποθηκεύει δωρεάν έως $limit μέρη σε έναν οδηγό. Έχεις επιλέξει $selected — $over παραπάνω.';
  }

  @override
  String get onePaymentKept =>
      'Μία πληρωμή, δική σου για πάντα. Χωρίς συνδρομή.';

  @override
  String unlockFor(String price) {
    return 'Ξεκλείδωμα για $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Αποθήκευση των πρώτων $limit αντ\' αυτού';
  }

  @override
  String get restorePrevious => 'Επαναφορά προηγούμενης αγοράς';

  @override
  String get restorePurchase => 'Επαναφορά αγοράς';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over πάνω από το δωρεάν όριο των $limit. Μπορείς να ξεκλειδώσεις ή να αποθηκεύσεις τα πρώτα $limit.';
  }

  @override
  String get findThisPlace => 'Εύρεση αυτού του μέρους';

  @override
  String get searchAppleMaps => 'Αναζήτηση στους Χάρτες της Apple';

  @override
  String searchInRegion(String region) {
    return 'Αναζήτηση σε $region';
  }

  @override
  String get searching => 'Αναζήτηση…';

  @override
  String get typeTwoCharacters => 'Πληκτρολόγησε τουλάχιστον δύο χαρακτήρες.';

  @override
  String get nothingFound =>
      'Δεν βρέθηκε τίποτα. Δοκίμασε τον δρόμο ή ένα πιο σύντομο όνομα.';

  @override
  String get rateLimited =>
      'Οι Χάρτες της Apple περιορίζουν τις αναζητήσεις. Περίμενε λίγο και δοκίμασε ξανά.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Οι Χάρτες της Apple περιορίζουν τις αναζητήσεις — προστέθηκαν $added μέχρι στιγμής, δοκίμασε τα υπόλοιπα σε λίγο.';
  }

  @override
  String importSummary(int found) {
    return 'βρέθηκαν $found';
  }

  @override
  String importSummaryIn(String region) {
    return 'σε $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count θέλουν έλεγχο',
      one: '1 θέλει έλεγχο',
    );
    return '$_temp0';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count δυσανάγνωστα';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Τίποτα αναγνώσιμο σε $count στιγμιότυπα',
      one: 'Τίποτα αναγνώσιμο σε αυτό το στιγμιότυπο',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Δεν ήταν δυνατό το άνοιγμα των Χαρτών';

  @override
  String get checkingAppleAccount => 'Έλεγχος του Apple Account σου…';

  @override
  String get restoredUnlocked =>
      'Έγινε επαναφορά. Οι οδηγοί χωρίς όριο ξεκλείδωσαν.';

  @override
  String get noPreviousPurchase =>
      'Δεν βρέθηκε προηγούμενη αγορά σε αυτό το Apple Account.';

  @override
  String get purchaseDidNotComplete =>
      'Η αγορά δεν ολοκληρώθηκε, οπότε δεν χρεώθηκε τίποτα.';

  @override
  String alreadyInTheList(String name) {
    return 'Το $name ήταν ήδη στη λίστα.';
  }

  @override
  String get ocrUnavailable =>
      'Η ανάγνωση στιγμιότυπων απαιτεί iPhone — σε αυτήν την πλατφόρμα δεν υπάρχει αναγνώριση κειμένου.';

  @override
  String get lookupUnavailable =>
      'Η αναζήτηση μερών απαιτεί iPhone — σε αυτήν την πλατφόρμα δεν υπάρχει αναζήτηση σε χάρτη.';

  @override
  String get compAccess => 'Δωρεάν πρόσβαση';

  @override
  String get code => 'Κωδικός';

  @override
  String get unlock => 'Ξεκλείδωμα';

  @override
  String get compChecking => 'Έλεγχος αυτού του κωδικού…';

  @override
  String get compEnabled => 'Η δωρεάν πρόσβαση ενεργοποιήθηκε.';

  @override
  String get compRefused =>
      'Ο κωδικός δεν αναγνωρίστηκε ή έχει ήδη χρησιμοποιηθεί.';

  @override
  String get compTooOften =>
      'Πάρα πολλές προσπάθειες. Περίμενε λίγα λεπτά και δοκίμασε ξανά.';

  @override
  String get compUnreachable =>
      'Δεν ήταν δυνατή η σύνδεση με τον διακομιστή. Έλεγξε τη σύνδεσή σου και δοκίμασε ξανά.';

  @override
  String get compUntrusted =>
      'Δεν ήταν δυνατή η επαλήθευση της απάντησης, οπότε δεν ξεκλείδωσε τίποτα.';

  @override
  String get addPlaces => 'Προσθήκη';

  @override
  String get fromFile => 'Από αρχείο';

  @override
  String get fromExistingGuide => 'Από υπάρχοντα οδηγό';

  @override
  String get importGuideTitle => 'Προσθήκη σε υπάρχοντα οδηγό';

  @override
  String get importGuideBody =>
      'Άνοιξε τον οδηγό στους Χάρτες της Apple, κοινοποίησέ τον και διάλεξε «Αντιγραφή συνδέσμου». Επικόλλησέ τον παρακάτω και το Wren θα διαβάσει τα μέρη που έχει ήδη μέσα.';

  @override
  String get guideLinkLabel => 'Σύνδεσμος οδηγού';

  @override
  String get readGuide => 'Ανάγνωση οδηγού';

  @override
  String get importGuideNotALink =>
      'Αυτός δεν είναι σύνδεσμος οδηγού των Χαρτών της Apple. Άνοιξε τον οδηγό στους Χάρτες, κοινοποίησέ τον και διάλεξε «Αντιγραφή συνδέσμου».';

  @override
  String get importGuideNothing =>
      'Αυτός ο οδηγός δεν έχει μέσα κάτι που να μπορεί να πάρει μαζί του το Wren.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Διαβάστηκαν $count μέρη από αυτόν τον οδηγό',
      one: 'Διαβάστηκε 1 μέρος από αυτόν τον οδηγό',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count μέρη μέσα δεν μπορούν να μεταφερθούν',
      one: '1 μέρος μέσα δεν μπορεί να μεταφερθεί',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count μέρη υπάρχουν ήδη σε αυτόν τον οδηγό',
      one: '1 μέρος υπάρχει ήδη σε αυτόν τον οδηγό',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Από «$name»';
  }

  @override
  String get republishTitle => 'Οι Χάρτες φτιάχνουν νέο οδηγό';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Η Apple δεν δίνει τρόπο να προστεθεί κάτι σε οδηγό που υπάρχει ήδη, οπότε το Wren θα φτιάξει νέον με όλα τα $count μέρη μέσα.',
      one:
          'Η Apple δεν δίνει τρόπο να προστεθεί κάτι σε οδηγό που υπάρχει ήδη, οπότε το Wren θα φτιάξει νέον με το ένα μέρος μέσα.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Κράτα τον νέο οδηγό και σβήσε τον παλιό.';

  @override
  String get republishKeepsPlaces =>
      'Το Wren κρατά αυτά τα μέρη, άρα μπορείς να φτιάξεις τον οδηγό ξανά αν πάει κάτι στραβά.';

  @override
  String get makeCombinedGuide => 'Δημιουργία του ενιαίου οδηγού';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Διαβάστηκαν $count μέρη από αυτό το αρχείο',
      one: 'Διαβάστηκε 1 μέρος από αυτό το αρχείο',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count γραμμές δεν είχαν όνομα',
      one: '1 γραμμή δεν είχε όνομα',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Κανένα μέρος σε αυτό το αρχείο.';

  @override
  String get fileUnreadable =>
      'Το Wren δεν μπόρεσε να διαβάσει αυτό το αρχείο. Διαβάζει CSV, KML, KMZ, GPX, GeoJSON και εξαγωγές από το Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Αναζήτηση $done από $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'Η δημιουργία του ενιαίου οδηγού χρειάζεται το ξεκλείδωμα.';

  @override
  String get unlockCombineTitle => 'Προσθήκη σε οδηγό που έχεις ήδη';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Το Wren θα φτιάξει έναν μόνο οδηγό με τα $count μέρη που έχεις ήδη στον δικό σου και τα νέα μαζί.',
      one:
          'Το Wren θα φτιάξει έναν μόνο οδηγό με το μέρος που έχεις ήδη στον δικό σου και το νέο μαζί.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Διαβάζει και λίστα που έχεις εξαγάγει από άλλη εφαρμογή: CSV, KML, KMZ, GPX, GeoJSON ή Google Takeout.';

  @override
  String get clearList => 'Άδειασμα της λίστας';

  @override
  String get clearListTitle => 'Άδειασμα της λίστας';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Να αφαιρεθούν και τα $count μέρη από το Wren; Οι οδηγοί που έχουν ήδη φτιαχτεί στους Χάρτες της Apple δεν επηρεάζονται.',
      one:
          'Να αφαιρεθεί το ένα μέρος από το Wren; Οι οδηγοί που έχουν ήδη φτιαχτεί στους Χάρτες της Apple δεν επηρεάζονται.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Αφαίρεση';

  @override
  String get listCleared => 'Η λίστα άδειασε.';

  @override
  String get expandingLink => 'Ανάγνωση του συνδέσμου…';

  @override
  String get linkUnreachable =>
      'Δεν ήταν δυνατή η σύνδεση με την Apple για την ανάγνωση του συνδέσμου. Έλεγξε τη σύνδεσή σου και δοκίμασε ξανά.';

  @override
  String get splitTitle => 'Αυτό θα φτιάξει πάνω από έναν οδηγό';

  @override
  String splitBody(int guides, int count) {
    return 'Η Apple περιορίζει πόσα μέρη χωράει ένας σύνδεσμος οδηγού. Το Wren θα φτιάξει $guides οδηγούς, αριθμημένους ώστε να μένουν στη σειρά, με $count μέρη συνολικά.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Δημιουργία $guides οδηγών';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Άνοιξε ο οδηγός $done από $total. Άγγιξε για να φτιάξεις τον επόμενο.';
  }

  @override
  String get sendPlacesTo => 'Αποστολή τοποθεσιών σε';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count τοποθεσίες έτοιμες για αποστολή',
      one: '1 τοποθεσία έτοιμη για αποστολή',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count τοποθεσίες δεν έχουν θέση και δεν μπορούν να σταλούν',
      one: '1 τοποθεσία δεν έχει θέση και δεν μπορεί να σταλεί',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Οποιαδήποτε άλλη εφαρμογή';

  @override
  String get sendPlacesFailed => 'Αυτή η εφαρμογή δεν δέχτηκε το αρχείο';
}
