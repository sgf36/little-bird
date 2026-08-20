// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LEn extends L {
  LEn([String locale = 'en']) : super(locale);

  @override
  String get tagline => 'A little bird told me.';

  @override
  String get emptyTitle => 'Places, kept.';

  @override
  String get emptyBody =>
      'Screenshot what people tell you about — a reel, a post, a message, a page of a guidebook. Wren reads the names and puts them in Apple Maps.';

  @override
  String get emptyNote =>
      'One place joins a guide you already have. Several become a new one — Apple Maps cannot merge guides.';

  @override
  String get addScreenshots => 'Add screenshots';

  @override
  String get readingShort => 'Reading…';

  @override
  String readingProgress(int done, int total) {
    return 'Reading $done of $total…';
  }

  @override
  String get addToGuide => 'Add to a guide';

  @override
  String makeGuide(int count) {
    return 'Make a guide ($count)';
  }

  @override
  String get notFoundOnMap => 'Not found on the map';

  @override
  String get tapToSearchForIt => 'Tap to search for it';

  @override
  String readAs(String text) {
    return 'read as “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count places were not found. Tap to search for them.',
      one: '1 place was not found. Tap to search for it.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Where are these places?';

  @override
  String get regionDetected =>
      'Read from the captions. Change it if that is wrong.';

  @override
  String get regionNotDetected =>
      'Nothing in the screenshots said where these are. A city makes the search far more accurate.';

  @override
  String get cityOrRegion => 'City or region';

  @override
  String get cityExample => 'e.g. London';

  @override
  String get searchAnywhere => 'Search anywhere';

  @override
  String get findPlaces => 'Find places';

  @override
  String searchedIn(String region) {
    return 'Searched in $region';
  }

  @override
  String get nameThisGuide => 'Name this guide';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'It will appear under this name in Apple Maps, with $count places in it.',
      one: 'It will appear under this name in Apple Maps, with 1 place in it.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Guide name';

  @override
  String get guideNameExample => 'e.g. Rome, October';

  @override
  String get createGuide => 'Create guide';

  @override
  String get cancel => 'Cancel';

  @override
  String get guidesOfAnySize => 'Guides of any size';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren saves up to $limit places in a guide for free. You have $selected selected — $over more than that.';
  }

  @override
  String get onePaymentKept => 'One payment, kept for good. No subscription.';

  @override
  String unlockFor(String price) {
    return 'Unlock for $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Save the first $limit instead';
  }

  @override
  String get restorePrevious => 'Restore a previous purchase';

  @override
  String get restorePurchase => 'Restore purchase';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over over the free limit of $limit. You can unlock, or save the first $limit.';
  }

  @override
  String get findThisPlace => 'Find this place';

  @override
  String get searchAppleMaps => 'Search Apple Maps';

  @override
  String searchInRegion(String region) {
    return 'Search in $region';
  }

  @override
  String get searching => 'Searching…';

  @override
  String get typeTwoCharacters => 'Type at least two characters.';

  @override
  String get nothingFound =>
      'Nothing found. Try the street, or a shorter name.';

  @override
  String get rateLimited =>
      'Apple Maps is rate-limiting lookups. Pause a moment and try again.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps is rate-limiting lookups — added $added so far, try the rest in a moment.';
  }

  @override
  String importSummary(int found) {
    return '$found found';
  }

  @override
  String importSummaryIn(String region) {
    return 'in $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count need a look',
      one: '1 needs a look',
    );
    return '$_temp0';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count unreadable';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nothing readable in $count screenshots',
      one: 'Nothing readable in that screenshot',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Could not open Maps';

  @override
  String get checkingAppleAccount => 'Checking your Apple Account…';

  @override
  String get restoredUnlocked => 'Restored. Guides of any size are unlocked.';

  @override
  String get noPreviousPurchase =>
      'No previous purchase found on this Apple Account.';

  @override
  String get purchaseDidNotComplete =>
      'The purchase did not complete, so nothing was charged.';

  @override
  String alreadyInTheList(String name) {
    return '$name was already in the list.';
  }

  @override
  String get ocrUnavailable =>
      'Reading screenshots needs an iPhone — there is no text recognition on this platform.';

  @override
  String get lookupUnavailable =>
      'Place lookup needs an iPhone — there is no map search on this platform.';

  @override
  String get compAccess => 'Complimentary access';

  @override
  String get code => 'Code';

  @override
  String get unlock => 'Unlock';

  @override
  String get compChecking => 'Checking that code…';

  @override
  String get compEnabled => 'Complimentary access enabled.';

  @override
  String get compRefused =>
      'That code was not recognised, or it has already been used.';

  @override
  String get compTooOften =>
      'Too many attempts. Wait a few minutes and try again.';

  @override
  String get compUnreachable =>
      'Could not reach the server. Check your connection and try again.';

  @override
  String get compUntrusted =>
      'That reply could not be verified, so nothing was unlocked.';

  @override
  String get addPlaces => 'Add';

  @override
  String get fromFile => 'From a file';

  @override
  String get fromExistingGuide => 'From an existing guide';

  @override
  String get importGuideTitle => 'Add to an existing guide';

  @override
  String get importGuideBody =>
      'In Apple Maps, open the guide and share it, then choose Copy Link. Paste it below and Wren will read the places it already holds.';

  @override
  String get guideLinkLabel => 'Guide link';

  @override
  String get readGuide => 'Read guide';

  @override
  String get importGuideNotALink =>
      'That is not an Apple Maps guide link. Open the guide in Maps, share it, then choose Copy Link.';

  @override
  String get importGuideNothing => 'That guide holds nothing Wren can add to.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Read $count places from that guide',
      one: 'Read 1 place from that guide',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count places in it cannot be carried over',
      one: '1 place in it cannot be carried over',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count places already in this guide',
      one: '1 place already in this guide',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'From “$name”';
  }

  @override
  String get republishTitle => 'Maps makes a new guide';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple gives no way to add to a guide that already exists, so Wren will make a new one holding all $count places.',
      one:
          'Apple gives no way to add to a guide that already exists, so Wren will make a new one holding the 1 place.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Keep the new guide and delete the old one.';

  @override
  String get republishKeepsPlaces =>
      'Wren keeps these places, so you can make the guide again if anything goes wrong.';

  @override
  String get makeCombinedGuide => 'Make the combined guide';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Read $count places from that file',
      one: 'Read 1 place from that file',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rows had no name',
      one: '1 row had no name',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'No places in that file.';

  @override
  String get fileUnreadable =>
      'Wren could not read that file. It reads CSV, KML, KMZ, GPX, GeoJSON and Google Takeout exports.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Looking up $done of $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'Making the combined guide needs the unlock.';

  @override
  String get unlockCombineTitle => 'Add to a guide you already have';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren will make one guide holding the $count places already in yours together with the new ones.',
      one:
          'Wren will make one guide holding the place already in yours together with the new one.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Also reads a list exported from another app: CSV, KML, KMZ, GPX, GeoJSON or Google Takeout.';

  @override
  String get clearList => 'Clear the list';

  @override
  String get clearListTitle => 'Clear the list';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Remove all $count places from Wren? Guides already made in Apple Maps are not affected.',
      one:
          'Remove the one place from Wren? Guides already made in Apple Maps are not affected.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Clear';

  @override
  String get listCleared => 'List cleared.';

  @override
  String get expandingLink => 'Reading that link…';

  @override
  String get linkUnreachable =>
      'Could not reach Apple to read that link. Check your connection and try again.';

  @override
  String get splitTitle => 'This will make more than one guide';

  @override
  String splitBody(int guides, int count) {
    return 'Apple limits how many places one guide link can carry. Wren will make $guides guides, numbered so they stay in order, holding $count places between them.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Make $guides guides';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Guide $done of $total opened. Tap to make the next.';
  }

  @override
  String get sendPlacesTo => 'Send places to';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count places ready to send',
      one: '1 place ready to send',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count places have no location and cannot be sent',
      one: '1 place has no location and cannot be sent',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Any other app';

  @override
  String get sendPlacesFailed => 'That app would not take the file';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count places kept from the file, ready to send to another map app',
      one: '1 place kept from the file, ready to send to another map app',
    );
    return '$_temp0';
  }
}
