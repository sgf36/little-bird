import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_no.dart';
import 'app_localizations_or.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L
/// returned by `L.of(context)`.
///
/// Applications need to include `L.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L.localizationsDelegates,
///   supportedLocales: L.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L.supportedLocales
/// property.
abstract class L {
  L(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L of(BuildContext context) {
    return Localizations.of<L>(context, L)!;
  }

  static const LocalizationsDelegate<L> delegate = _LDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('es', 'MX'),
    Locale('fi'),
    Locale('fr'),
    Locale('fr', 'CA'),
    Locale('gu'),
    Locale('he'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('kn'),
    Locale('ko'),
    Locale('ml'),
    Locale('mr'),
    Locale('ms'),
    Locale('nl'),
    Locale('no'),
    Locale('or'),
    Locale('pa'),
    Locale('pl'),
    Locale('pt'),
    Locale('pt', 'PT'),
    Locale('ro'),
    Locale('ru'),
    Locale('sk'),
    Locale('sl'),
    Locale('sv'),
    Locale('ta'),
    Locale('te'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('ur'),
    Locale('vi'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// Shown under the app name on the opening screen. An English idiom meaning 'somebody told me, and I am not saying who'. Translate the sense, not the words — the app is named after the bird in that saying. If no equivalent idiom exists, something like 'somebody told me about it' is right.
  ///
  /// In en, this message translates to:
  /// **'A little bird told me.'**
  String get tagline;

  /// Headline on the empty main screen. Two words, deliberately terse: the app keeps places for you.
  ///
  /// In en, this message translates to:
  /// **'Places, kept.'**
  String get emptyTitle;

  /// Explains the app on the empty screen. 'Wren' is the app name and is never translated. 'Reel' means a short social video.
  ///
  /// In en, this message translates to:
  /// **'Screenshot what people tell you about — a reel, a post, a message, a page of a guidebook. Wren reads the names and puts them in Apple Maps.'**
  String get emptyBody;

  /// A limitation of Apple Maps, stated up front. 'Guide' is Apple's own feature name — use whatever Apple Maps calls it in this language.
  ///
  /// In en, this message translates to:
  /// **'One place joins a guide you already have. Several become a new one — Apple Maps cannot merge guides.'**
  String get emptyNote;

  /// The opening line of the first screen, on a platform that cannot make guides. It replaces emptyBody, which describes reading screenshots into Apple Maps and is true of neither half here: there is no text recognition and no Apple Maps. Say what this build does, which is read a file.
  ///
  /// In en, this message translates to:
  /// **'Open a list of places you already keep — a file exported from another map app, or a Google Takeout archive. CSV, KML, KMZ, GPX and GeoJSON are all read.'**
  String get emptyBodyAndroid;

  /// The quieter second line of the first screen, on a platform that cannot make guides. It replaces emptyNote, which is about Apple Maps refusing to merge guides. Two promises: the list is shown before anything is sent, and the destination is whichever map app is installed. Name no map app here — the sheet that sends the places names them, and only the ones actually installed.
  ///
  /// In en, this message translates to:
  /// **'Nothing leaves until you have looked at it. Wren then hands the list to a map app on the phone.'**
  String get emptyNoteAndroid;

  /// Button. Opens the photo picker.
  ///
  /// In en, this message translates to:
  /// **'Add screenshots'**
  String get addScreenshots;

  /// Button label while text recognition is running.
  ///
  /// In en, this message translates to:
  /// **'Reading…'**
  String get readingShort;

  /// Progress while reading screenshots.
  ///
  /// In en, this message translates to:
  /// **'Reading {done} of {total}…'**
  String readingProgress(int done, int total);

  /// Button shown when exactly one place is selected. It opens that place in Apple Maps, where the user can add it to a guide they already have.
  ///
  /// In en, this message translates to:
  /// **'Add to a guide'**
  String get addToGuide;

  /// Button that creates a new guide containing the selected places.
  ///
  /// In en, this message translates to:
  /// **'Make a guide ({count})'**
  String makeGuide(int count);

  /// Title of a place Apple Maps could not identify.
  ///
  /// In en, this message translates to:
  /// **'Not found on the map'**
  String get notFoundOnMap;

  /// Prompt under an unidentified place.
  ///
  /// In en, this message translates to:
  /// **'Tap to search for it'**
  String get tapToSearchForIt;

  /// Shows the exact text that was read from the screenshot, so the user can tell a correct match from a confident wrong one. Keep the quotation marks in the style of the target language.
  ///
  /// In en, this message translates to:
  /// **'read as “{text}”'**
  String readAs(String text);

  /// Banner counting places that could not be identified.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 place was not found. Tap to search for it.} other{{count} places were not found. Tap to search for them.}}'**
  String notFoundBanner(int count);

  /// Title of the dialog asking which city the batch is in.
  ///
  /// In en, this message translates to:
  /// **'Where are these places?'**
  String get whereAreThesePlaces;

  /// Shown when a city was found in the screenshot text.
  ///
  /// In en, this message translates to:
  /// **'Read from the captions. Change it if that is wrong.'**
  String get regionDetected;

  /// Shown when no city could be found in the screenshot text.
  ///
  /// In en, this message translates to:
  /// **'Nothing in the screenshots said where these are. A city makes the search far more accurate.'**
  String get regionNotDetected;

  /// Text field label.
  ///
  /// In en, this message translates to:
  /// **'City or region'**
  String get cityOrRegion;

  /// Placeholder example in the city field. Replace London with a well-known city in the target language's main market.
  ///
  /// In en, this message translates to:
  /// **'e.g. London'**
  String get cityExample;

  /// Button. Proceeds without narrowing the search to a city.
  ///
  /// In en, this message translates to:
  /// **'Search anywhere'**
  String get searchAnywhere;

  /// Confirming button on the city dialog.
  ///
  /// In en, this message translates to:
  /// **'Find places'**
  String get findPlaces;

  /// Banner showing which place the search was centred on.
  ///
  /// In en, this message translates to:
  /// **'Searched in {region}'**
  String searchedIn(String region);

  /// Title of the dialog asking what to call the guide.
  ///
  /// In en, this message translates to:
  /// **'Name this guide'**
  String get nameThisGuide;

  /// Explains where the name will be seen.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{It will appear under this name in Apple Maps, with 1 place in it.} other{It will appear under this name in Apple Maps, with {count} places in it.}}'**
  String nameThisGuideBody(int count);

  /// Text field label.
  ///
  /// In en, this message translates to:
  /// **'Guide name'**
  String get guideName;

  /// Placeholder example for a guide name: a city and a month. Use a city and month natural in the target language.
  ///
  /// In en, this message translates to:
  /// **'e.g. Rome, October'**
  String get guideNameExample;

  /// Confirming button.
  ///
  /// In en, this message translates to:
  /// **'Create guide'**
  String get createGuide;

  /// Dismisses a dialog without acting.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Title of the purchase sheet, and the name of the in-app purchase.
  ///
  /// In en, this message translates to:
  /// **'Guides of any size'**
  String get guidesOfAnySize;

  /// Explains why the purchase is being offered.
  ///
  /// In en, this message translates to:
  /// **'Wren saves up to {limit} places in a guide for free. You have {selected} selected — {over} more than that.'**
  String unlockExplain(int limit, int selected, int over);

  /// Reassurance that nothing recurs.
  ///
  /// In en, this message translates to:
  /// **'One payment, kept for good. No subscription.'**
  String get onePaymentKept;

  /// Purchase button. The price comes from the App Store already formatted for the user's country — never reformat it.
  ///
  /// In en, this message translates to:
  /// **'Unlock for {price}'**
  String unlockFor(String price);

  /// Button that proceeds with only the free allowance rather than buying.
  ///
  /// In en, this message translates to:
  /// **'Save the first {limit} instead'**
  String saveFirstInstead(int limit);

  /// Link on the purchase sheet.
  ///
  /// In en, this message translates to:
  /// **'Restore a previous purchase'**
  String get restorePrevious;

  /// Menu item in the top-right.
  ///
  /// In en, this message translates to:
  /// **'Restore purchase'**
  String get restorePurchase;

  /// Banner when more places are selected than the free allowance.
  ///
  /// In en, this message translates to:
  /// **'{over} over the free limit of {limit}. You can unlock, or save the first {limit}.'**
  String overFreeLimit(int over, int limit);

  /// Title of the search sheet.
  ///
  /// In en, this message translates to:
  /// **'Find this place'**
  String get findThisPlace;

  /// Search field label when no city is set.
  ///
  /// In en, this message translates to:
  /// **'Search Apple Maps'**
  String get searchAppleMaps;

  /// Search field label when a city is set.
  ///
  /// In en, this message translates to:
  /// **'Search in {region}'**
  String searchInRegion(String region);

  /// Shown while a search is running.
  ///
  /// In en, this message translates to:
  /// **'Searching…'**
  String get searching;

  /// Shown when the search box is nearly empty.
  ///
  /// In en, this message translates to:
  /// **'Type at least two characters.'**
  String get typeTwoCharacters;

  /// Shown when a search returns no places.
  ///
  /// In en, this message translates to:
  /// **'Nothing found. Try the street, or a shorter name.'**
  String get nothingFound;

  /// Apple has temporarily refused further searches.
  ///
  /// In en, this message translates to:
  /// **'Apple Maps is rate-limiting lookups. Pause a moment and try again.'**
  String get rateLimited;

  /// Apple refused further searches part-way through a batch.
  ///
  /// In en, this message translates to:
  /// **'Apple Maps is rate-limiting lookups — added {added} so far, try the rest in a moment.'**
  String rateLimitedDuringImport(int added);

  /// How many places were identified from the screenshots.
  ///
  /// In en, this message translates to:
  /// **'{found} found'**
  String importSummary(int found);

  /// Appended to the summary. Reads as '12 found in London'.
  ///
  /// In en, this message translates to:
  /// **'in {region}'**
  String importSummaryIn(String region);

  /// Appended to the summary, counting places that were not identified.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 needs a look} other{{count} need a look}}'**
  String importSummaryNeedLook(int count);

  /// Appended to the summary, counting screenshots with no readable text.
  ///
  /// In en, this message translates to:
  /// **'{count} unreadable'**
  String importSummaryUnreadable(int count);

  /// Shown when no screenshot yielded any text.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Nothing readable in that screenshot} other{Nothing readable in {count} screenshots}}'**
  String nothingReadable(int count);

  /// Opening the Apple Maps link failed.
  ///
  /// In en, this message translates to:
  /// **'Could not open Maps'**
  String get couldNotOpenMaps;

  /// Shown while restoring a purchase.
  ///
  /// In en, this message translates to:
  /// **'Checking your Apple Account…'**
  String get checkingAppleAccount;

  /// A previous purchase was found.
  ///
  /// In en, this message translates to:
  /// **'Restored. Guides of any size are unlocked.'**
  String get restoredUnlocked;

  /// Nothing to restore.
  ///
  /// In en, this message translates to:
  /// **'No previous purchase found on this Apple Account.'**
  String get noPreviousPurchase;

  /// The payment sheet was cancelled or failed.
  ///
  /// In en, this message translates to:
  /// **'The purchase did not complete, so nothing was charged.'**
  String get purchaseDidNotComplete;

  /// The chosen place duplicates one already added.
  ///
  /// In en, this message translates to:
  /// **'{name} was already in the list.'**
  String alreadyInTheList(String name);

  /// Shown if the app runs somewhere without Apple's Vision framework.
  ///
  /// In en, this message translates to:
  /// **'Reading screenshots needs an iPhone — there is no text recognition on this platform.'**
  String get ocrUnavailable;

  /// Shown if the app runs somewhere without MapKit.
  ///
  /// In en, this message translates to:
  /// **'Place lookup needs an iPhone — there is no map search on this platform.'**
  String get lookupUnavailable;

  /// Title of a hidden dialog, reached by long-pressing the app name. Used by App Review and by people the developer has given a free code to. 'Complimentary' in the sense of free of charge, not in the sense of praise.
  ///
  /// In en, this message translates to:
  /// **'Complimentary access'**
  String get compAccess;

  /// Text field label for the complimentary access code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// Confirming button on the complimentary access dialog.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock;

  /// Shown while the code is being checked with the server.
  ///
  /// In en, this message translates to:
  /// **'Checking that code…'**
  String get compChecking;

  /// The code was accepted and the paid feature is now unlocked.
  ///
  /// In en, this message translates to:
  /// **'Complimentary access enabled.'**
  String get compEnabled;

  /// The code failed. Deliberately covers several causes in one sentence — wrong, already used, withdrawn — because saying which would confirm to a stranger that a code they hold is real.
  ///
  /// In en, this message translates to:
  /// **'That code was not recognised, or it has already been used.'**
  String get compRefused;

  /// Rate limited after repeated failures.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Wait a few minutes and try again.'**
  String get compTooOften;

  /// The code could not be checked because the network was unavailable.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the server. Check your connection and try again.'**
  String get compUnreachable;

  /// The server answered but the answer failed a signature check. Rare, and means either a fault or something impersonating the server.
  ///
  /// In en, this message translates to:
  /// **'That reply could not be verified, so nothing was unlocked.'**
  String get compUntrusted;

  /// Button that opens a menu of the three ways places can be added: screenshots, a file, or an existing guide. Kept to one word because it sits beside a longer button.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addPlaces;

  /// Menu item for importing a list exported from another app.
  ///
  /// In en, this message translates to:
  /// **'From a file'**
  String get fromFile;

  /// Menu item for reading the places out of a guide the user already has in Apple Maps.
  ///
  /// In en, this message translates to:
  /// **'From an existing guide'**
  String get fromExistingGuide;

  /// Title of the dialog where a shared Apple Maps guide link is pasted.
  ///
  /// In en, this message translates to:
  /// **'Add to an existing guide'**
  String get importGuideTitle;

  /// Instructions for finding the guide link. 'Copy Link' is the wording Apple Maps itself uses on the share sheet, so use whatever Apple Maps says in this language.
  ///
  /// In en, this message translates to:
  /// **'In Apple Maps, open the guide and share it, then choose Copy Link. Paste it below and Wren will read the places it already holds.'**
  String get importGuideBody;

  /// Text field label for the pasted link.
  ///
  /// In en, this message translates to:
  /// **'Guide link'**
  String get guideLinkLabel;

  /// Confirming button. Reads the places out of the pasted link; it does not publish anything.
  ///
  /// In en, this message translates to:
  /// **'Read guide'**
  String get readGuide;

  /// Shown when the pasted text could not be decoded as a guide link.
  ///
  /// In en, this message translates to:
  /// **'That is not an Apple Maps guide link. Open the guide in Maps, share it, then choose Copy Link.'**
  String get importGuideNotALink;

  /// Shown when the link decoded but contained no place Wren can republish.
  ///
  /// In en, this message translates to:
  /// **'That guide holds nothing Wren can add to.'**
  String get importGuideNothing;

  /// How many places came out of the pasted guide link.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Read 1 place from that guide} other{Read {count} places from that guide}}'**
  String importedGuideSummary(int count);

  /// Places in the pasted guide that cannot go into the new one: either they carried no Apple place identifier, or Apple answered that it no longer has a record of that identifier. Said plainly rather than hidden, because Apple drops such places on arrival and the user would otherwise wonder where a place went. The wording is deliberately general so it covers both causes without a second string in 47 languages.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 place in it cannot be carried over} other{{count} places in it cannot be carried over}}'**
  String importedGuideUnusable(int count);

  /// Header of the collapsed group holding the places that came from the existing guide. Tapping it expands the group.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 place already in this guide} other{{count} places already in this guide}}'**
  String alreadyInGuide(int count);

  /// Subtitle under the group header, naming the guide the places came from.
  ///
  /// In en, this message translates to:
  /// **'From “{name}”'**
  String fromGuideNamed(String name);

  /// Title of the dialog shown before publishing a guide that includes imported places.
  ///
  /// In en, this message translates to:
  /// **'Maps makes a new guide'**
  String get republishTitle;

  /// Explains why a combined guide appears rather than the old one growing. A limitation of Apple Maps, not of this app, and worth saying so.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Apple gives no way to add to a guide that already exists, so Wren will make a new one holding the 1 place.} other{Apple gives no way to add to a guide that already exists, so Wren will make a new one holding all {count} places.}}'**
  String republishBody(int count);

  /// What to do afterwards.
  ///
  /// In en, this message translates to:
  /// **'Keep the new guide and delete the old one.'**
  String get republishThenDelete;

  /// Reassurance that deleting the wrong guide is recoverable, because the places stay in the app after publishing.
  ///
  /// In en, this message translates to:
  /// **'Wren keeps these places, so you can make the guide again if anything goes wrong.'**
  String get republishKeepsPlaces;

  /// Confirming button on the dialog above.
  ///
  /// In en, this message translates to:
  /// **'Make the combined guide'**
  String get makeCombinedGuide;

  /// How many places were found in an imported file.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Read 1 place from that file} other{Read {count} places from that file}}'**
  String fileImportSummary(int count);

  /// Rows in the file that could not be used because they carried nothing to search for.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 row had no name} other{{count} rows had no name}}'**
  String fileImportSkipped(int count);

  /// The file parsed but held nothing usable.
  ///
  /// In en, this message translates to:
  /// **'No places in that file.'**
  String get fileNoPlaces;

  /// Shown when a chosen file is not in a format the app understands. The format names are file types and stay in Latin letters.
  ///
  /// In en, this message translates to:
  /// **'Wren could not read that file. It reads CSV, KML, KMZ, GPX, GeoJSON and Google Takeout exports.'**
  String get fileUnreadable;

  /// Progress while each name from a file is matched against Apple Maps.
  ///
  /// In en, this message translates to:
  /// **'Looking up {done} of {total}…'**
  String lookingUpProgress(int done, int total);

  /// Banner shown once places have been read out of an existing guide but the one-time purchase has not been made. Says it at that point rather than at the end, so nobody does the work first and finds out afterwards.
  ///
  /// In en, this message translates to:
  /// **'Making the combined guide needs the unlock.'**
  String get combineNeedsUnlock;

  /// Heading of the purchase sheet shown when publishing a guide that includes places carried over from an existing one.
  ///
  /// In en, this message translates to:
  /// **'Add to a guide you already have'**
  String get unlockCombineTitle;

  /// What the purchase buys, on the sheet above. Describes the combined guide, and 'yours' means the guide the user already keeps in Apple Maps.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Wren will make one guide holding the place already in yours together with the new one.} other{Wren will make one guide holding the {count} places already in yours together with the new ones.}}'**
  String unlockCombineBody(int count);

  /// Shown on the empty main screen so the file formats are discoverable without opening a menu. The format names are file types and stay in Latin letters.
  ///
  /// In en, this message translates to:
  /// **'Also reads a list exported from another app: CSV, KML, KMZ, GPX, GeoJSON or Google Takeout.'**
  String get acceptedFormats;

  /// Menu item that removes every place from the app's list.
  ///
  /// In en, this message translates to:
  /// **'Clear the list'**
  String get clearList;

  /// Title of the confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Clear the list'**
  String get clearListTitle;

  /// Confirmation before clearing. The second sentence matters: clearing the app's list does not delete anything from Apple Maps, and users reasonably fear that it might.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Remove the one place from Wren? Guides already made in Apple Maps are not affected.} other{Remove all {count} places from Wren? Guides already made in Apple Maps are not affected.}}'**
  String clearListBody(int count);

  /// The button that does it. Short, and not the same word as the menu item so the dialog does not read as an echo.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearListConfirm;

  /// Confirmation after clearing.
  ///
  /// In en, this message translates to:
  /// **'List cleared.'**
  String get listCleared;

  /// Shown while a short Apple Maps link is being expanded, which is a network request and so not instant.
  ///
  /// In en, this message translates to:
  /// **'Reading that link…'**
  String get expandingLink;

  /// The short link could not be expanded because the network was unavailable.
  ///
  /// In en, this message translates to:
  /// **'Could not reach Apple to read that link. Check your connection and try again.'**
  String get linkUnreachable;

  /// Title of the dialog shown when there are more places than one Apple Maps guide link can carry.
  ///
  /// In en, this message translates to:
  /// **'This will make more than one guide'**
  String get splitTitle;

  /// Explains why several guides appear instead of one. A limit in Apple Maps, not in this app.
  ///
  /// In en, this message translates to:
  /// **'Apple limits how many places one guide link can carry. Wren will make {guides} guides, numbered so they stay in order, holding {count} places between them.'**
  String splitBody(int guides, int count);

  /// Confirming button on the dialog above.
  ///
  /// In en, this message translates to:
  /// **'Make {guides} guides'**
  String splitConfirm(int guides);

  /// Shown after each guide is handed to Apple Maps, because Maps can only be given one at a time and the user has to come back to Wren in between.
  ///
  /// In en, this message translates to:
  /// **'Guide {done} of {total} opened. Tap to make the next.'**
  String splitProgress(int done, int total);

  /// Title of the sheet that lists map apps a place list can be sent to. Android only.
  ///
  /// In en, this message translates to:
  /// **'Send places to'**
  String get sendPlacesTo;

  /// How many places will go into the exported file.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 place ready to send} other{{count} places ready to send}}'**
  String sendPlacesReady(int count);

  /// Places dropped from the export because they have no coordinate. Other map apps do not look an address up, so a place without one would vanish from the file silently — said plainly instead.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 place has no location and cannot be sent} other{{count} places have no location and cannot be sent}}'**
  String sendPlacesNoLocation(int count);

  /// Opens the system share sheet instead of a named app, so apps Wren does not list by name still work.
  ///
  /// In en, this message translates to:
  /// **'Any other app'**
  String get sendPlacesOtherApp;

  /// Shown when the receiving app did not accept the handover.
  ///
  /// In en, this message translates to:
  /// **'That app would not take the file'**
  String get sendPlacesFailed;

  /// Shown after importing a file when the places carried their own coordinates and no map lookup was possible — they can be sent to another map app, but not put in an Apple Maps guide.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 place kept from the file, ready to send to another map app} other{{count} places kept from the file, ready to send to another map app}}'**
  String fileImportPositioned(int count);
}

class _LDelegate extends LocalizationsDelegate<L> {
  const _LDelegate();

  @override
  Future<L> load(Locale locale) {
    return SynchronousFuture<L>(lookupL(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'bn',
    'ca',
    'cs',
    'da',
    'de',
    'el',
    'en',
    'es',
    'fi',
    'fr',
    'gu',
    'he',
    'hi',
    'hr',
    'hu',
    'id',
    'it',
    'ja',
    'kn',
    'ko',
    'ml',
    'mr',
    'ms',
    'nl',
    'no',
    'or',
    'pa',
    'pl',
    'pt',
    'ro',
    'ru',
    'sk',
    'sl',
    'sv',
    'ta',
    'te',
    'th',
    'tr',
    'uk',
    'ur',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_LDelegate old) => false;
}

L lookupL(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return LZhHant();
        }
        break;
      }
  }

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'es':
      {
        switch (locale.countryCode) {
          case 'MX':
            return LEsMx();
        }
        break;
      }
    case 'fr':
      {
        switch (locale.countryCode) {
          case 'CA':
            return LFrCa();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'PT':
            return LPtPt();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return LAr();
    case 'bn':
      return LBn();
    case 'ca':
      return LCa();
    case 'cs':
      return LCs();
    case 'da':
      return LDa();
    case 'de':
      return LDe();
    case 'el':
      return LEl();
    case 'en':
      return LEn();
    case 'es':
      return LEs();
    case 'fi':
      return LFi();
    case 'fr':
      return LFr();
    case 'gu':
      return LGu();
    case 'he':
      return LHe();
    case 'hi':
      return LHi();
    case 'hr':
      return LHr();
    case 'hu':
      return LHu();
    case 'id':
      return LId();
    case 'it':
      return LIt();
    case 'ja':
      return LJa();
    case 'kn':
      return LKn();
    case 'ko':
      return LKo();
    case 'ml':
      return LMl();
    case 'mr':
      return LMr();
    case 'ms':
      return LMs();
    case 'nl':
      return LNl();
    case 'no':
      return LNo();
    case 'or':
      return LOr();
    case 'pa':
      return LPa();
    case 'pl':
      return LPl();
    case 'pt':
      return LPt();
    case 'ro':
      return LRo();
    case 'ru':
      return LRu();
    case 'sk':
      return LSk();
    case 'sl':
      return LSl();
    case 'sv':
      return LSv();
    case 'ta':
      return LTa();
    case 'te':
      return LTe();
    case 'th':
      return LTh();
    case 'tr':
      return LTr();
    case 'uk':
      return LUk();
    case 'ur':
      return LUr();
    case 'vi':
      return LVi();
    case 'zh':
      return LZh();
  }

  throw FlutterError(
    'L.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
