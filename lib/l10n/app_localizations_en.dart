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
    return '$count need a look';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count unreadable';
  }

  @override
  String nothingReadable(int count) {
    return 'Nothing readable in $count screenshots';
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
  String get reviewerAccess => 'Reviewer access';

  @override
  String get code => 'Code';

  @override
  String get unlock => 'Unlock';

  @override
  String get reviewerEnabled => 'Reviewer access enabled.';

  @override
  String get codeNotRecognised => 'That code was not recognised.';
}
