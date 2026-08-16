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
    return '$count θέλουν έλεγχο';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count δυσανάγνωστα';
  }

  @override
  String nothingReadable(int count) {
    return 'Τίποτα αναγνώσιμο σε $count στιγμιότυπα';
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
}
