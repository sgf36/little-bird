// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class LMl extends L {
  LMl([String locale = 'ml']) : super(locale);

  @override
  String get tagline => 'ഒരു കുഞ്ഞുപക്ഷി പറഞ്ഞു.';

  @override
  String get emptyTitle => 'സ്ഥലങ്ങൾ, കരുതിവെച്ച്.';

  @override
  String get emptyBody =>
      'ആരെങ്കിലും നിർദ്ദേശിക്കുന്നത് സ്ക്രീൻഷോട്ട് എടുക്കൂ — ഒരു റീൽ, ഒരു പോസ്റ്റ്, ഒരു സന്ദേശം, യാത്രാ പുസ്തകത്തിലെ ഒരു താൾ. Wren പേരുകൾ വായിച്ച് അവ Apple Maps‌ൽ ചേർക്കും.';

  @override
  String get emptyNote =>
      'ഒറ്റ സ്ഥലം നിങ്ങൾക്ക് നേരത്തേയുള്ള ഗൈഡിൽ ചേരും. പലതും ചേർന്ന് പുതിയൊരെണ്ണം ഉണ്ടാകും — Apple Maps‌ന് ഗൈഡുകൾ കൂട്ടിച്ചേർക്കാനാവില്ല.';

  @override
  String get emptyBodyAndroid =>
      'Screenshot what people tell you about — a reel, a post, a message, a page of a guidebook. Wren reads the names and sends them to the map app on your phone.';

  @override
  String get emptyNoteAndroid =>
      'It also reads a list you already have, and shows you every place before anything leaves.';

  @override
  String get addScreenshots => 'സ്ക്രീൻഷോട്ടുകൾ ചേർക്കുക';

  @override
  String get readingShort => 'വായിക്കുന്നു…';

  @override
  String readingProgress(int done, int total) {
    return '$totalൽ $done വായിക്കുന്നു…';
  }

  @override
  String get addToGuide => 'ഒരു ഗൈഡിൽ ചേർക്കുക';

  @override
  String makeGuide(int count) {
    return 'ഗൈഡ് ഉണ്ടാക്കുക ($count)';
  }

  @override
  String get notFoundOnMap => 'ഭൂപടത്തിൽ കണ്ടെത്തിയില്ല';

  @override
  String get tapToSearchForIt => 'തിരയാൻ ടാപ്പ് ചെയ്യുക';

  @override
  String readAs(String text) {
    return 'ഇങ്ങനെ വായിച്ചു: “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count സ്ഥലങ്ങൾ കണ്ടെത്തിയില്ല. തിരയാൻ ടാപ്പ് ചെയ്യുക.',
      one: '1 സ്ഥലം കണ്ടെത്തിയില്ല. തിരയാൻ ടാപ്പ് ചെയ്യുക.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'ഈ സ്ഥലങ്ങൾ എവിടെയാണ്?';

  @override
  String get regionDetected =>
      'അടിക്കുറിപ്പുകളിൽനിന്ന് വായിച്ചത്. തെറ്റാണെങ്കിൽ മാറ്റുക.';

  @override
  String get regionNotDetected =>
      'ഇവ എവിടെയാണെന്ന് സ്ക്രീൻഷോട്ടുകളിൽ ഇല്ലായിരുന്നു. നഗരം നൽകിയാൽ തിരച്ചിൽ ഏറെ കൃത്യമാകും.';

  @override
  String get cityOrRegion => 'നഗരം അല്ലെങ്കിൽ പ്രദേശം';

  @override
  String get cityExample => 'ഉദാ. കൊച്ചി';

  @override
  String get searchAnywhere => 'എവിടെയും തിരയുക';

  @override
  String get findPlaces => 'സ്ഥലങ്ങൾ കണ്ടെത്തുക';

  @override
  String searchedIn(String region) {
    return '$regionൽ തിരഞ്ഞു';
  }

  @override
  String get nameThisGuide => 'ഈ ഗൈഡിന് പേരിടുക';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ഈ പേരിൽ Apple Maps‌ൽ കാണും, അതിൽ $count സ്ഥലങ്ങൾ ഉണ്ടാകും.',
      one: 'ഈ പേരിൽ Apple Maps‌ൽ കാണും, അതിൽ 1 സ്ഥലം ഉണ്ടാകും.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'ഗൈഡിന്റെ പേര്';

  @override
  String get guideNameExample => 'ഉദാ. റോം, ഒക്ടോബർ';

  @override
  String get createGuide => 'ഗൈഡ് ഉണ്ടാക്കുക';

  @override
  String get cancel => 'റദ്ദാക്കുക';

  @override
  String get guidesOfAnySize => 'ഏത് വലുപ്പത്തിലുമുള്ള ഗൈഡുകൾ';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren ഒരു ഗൈഡിൽ സൗജന്യമായി $limit സ്ഥലങ്ങൾ വരെ സൂക്ഷിക്കും. നിങ്ങൾ $selected തിരഞ്ഞെടുത്തു — $over കൂടുതൽ.';
  }

  @override
  String get onePaymentKept =>
      'ഒറ്റത്തവണ പണം, എന്നും നിങ്ങളുടേത്. സബ്‌സ്ക്രിപ്ഷൻ അല്ല.';

  @override
  String unlockFor(String price) {
    return '$priceന് അൺലോക്ക് ചെയ്യുക';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'പകരം ആദ്യ $limit സൂക്ഷിക്കുക';
  }

  @override
  String get restorePrevious => 'മുൻപത്തെ വാങ്ങൽ വീണ്ടെടുക്കുക';

  @override
  String get restorePurchase => 'വാങ്ങൽ വീണ്ടെടുക്കുക';

  @override
  String overFreeLimit(int over, int limit) {
    return 'സൗജന്യ പരിധിയായ $limitനെക്കാൾ $over കൂടുതൽ. അൺലോക്ക് ചെയ്യാം, അല്ലെങ്കിൽ ആദ്യ $limit സൂക്ഷിക്കാം.';
  }

  @override
  String get findThisPlace => 'ഈ സ്ഥലം കണ്ടെത്തുക';

  @override
  String get searchAppleMaps => 'Apple Maps‌ൽ തിരയുക';

  @override
  String searchInRegion(String region) {
    return '$regionൽ തിരയുക';
  }

  @override
  String get searching => 'തിരയുന്നു…';

  @override
  String get typeTwoCharacters => 'കുറഞ്ഞത് രണ്ട് അക്ഷരം ടൈപ്പ് ചെയ്യുക.';

  @override
  String get nothingFound =>
      'ഒന്നും കണ്ടെത്തിയില്ല. തെരുവിന്റെ പേരോ, ചെറിയ പേരോ പരീക്ഷിക്കുക.';

  @override
  String get rateLimited =>
      'Apple Maps തിരച്ചിലുകൾ പരിമിതപ്പെടുത്തുന്നു. അൽപ്പം കാത്ത് വീണ്ടും ശ്രമിക്കുക.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps തിരച്ചിലുകൾ പരിമിതപ്പെടുത്തുന്നു — ഇതുവരെ $added ചേർത്തു, ബാക്കി അൽപ്പം കഴിഞ്ഞ് ശ്രമിക്കുക.';
  }

  @override
  String importSummary(int found) {
    return '$found കണ്ടെത്തി';
  }

  @override
  String importSummaryIn(String region) {
    return '$regionൽ';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count നോക്കണം';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count വായിക്കാനായില്ല';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count സ്ക്രീൻഷോട്ടുകളിൽ വായിക്കാവുന്നത് ഒന്നുമില്ല',
      one: '$count സ്ക്രീൻഷോട്ടിൽ വായിക്കാവുന്നത് ഒന്നുമില്ല',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Maps തുറക്കാനായില്ല';

  @override
  String get checkingAppleAccount =>
      'നിങ്ങളുടെ Apple അക്കൗണ്ട് പരിശോധിക്കുന്നു…';

  @override
  String get restoredUnlocked =>
      'വീണ്ടെടുത്തു. ഏത് വലുപ്പത്തിലുമുള്ള ഗൈഡുകൾ അൺലോക്ക് ആയി.';

  @override
  String get noPreviousPurchase =>
      'ഈ Apple അക്കൗണ്ടിൽ മുൻപത്തെ വാങ്ങൽ കണ്ടെത്തിയില്ല.';

  @override
  String get purchaseDidNotComplete =>
      'വാങ്ങൽ പൂർത്തിയായില്ല, അതിനാൽ ഒന്നും ഈടാക്കിയിട്ടില്ല.';

  @override
  String alreadyInTheList(String name) {
    return '$name നേരത്തേതന്നെ പട്ടികയിലുണ്ടായിരുന്നു.';
  }

  @override
  String get ocrUnavailable =>
      'സ്ക്രീൻഷോട്ട് വായിക്കാൻ iPhone വേണം — ഈ പ്ലാറ്റ്‌ഫോമിൽ ടെക്സ്റ്റ് തിരിച്ചറിയൽ ഇല്ല.';

  @override
  String get lookupUnavailable =>
      'സ്ഥലം തിരയാൻ iPhone വേണം — ഈ പ്ലാറ്റ്‌ഫോമിൽ ഭൂപട തിരച്ചിൽ ഇല്ല.';

  @override
  String get compAccess => 'സൗജന്യ ആക്‌സസ്';

  @override
  String get code => 'കോഡ്';

  @override
  String get unlock => 'അൺലോക്ക്';

  @override
  String get compChecking => 'ആ കോഡ് പരിശോധിക്കുന്നു…';

  @override
  String get compEnabled => 'സൗജന്യ ആക്‌സസ് ഓണാക്കി.';

  @override
  String get compRefused =>
      'ആ കോഡ് തിരിച്ചറിഞ്ഞില്ല, അല്ലെങ്കിൽ അത് നേരത്തേ ഉപയോഗിച്ചുകഴിഞ്ഞു.';

  @override
  String get compTooOften =>
      'ഏറെ ശ്രമങ്ങളായി. കുറച്ച് മിനിറ്റ് കാത്ത് വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get compUnreachable =>
      'സെർവറിലേക്ക് എത്താനായില്ല. നിങ്ങളുടെ കണക്ഷൻ പരിശോധിച്ച് വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get compUntrusted =>
      'ആ മറുപടി ഉറപ്പാക്കാനായില്ല, അതിനാൽ ഒന്നും അൺലോക്ക് ആയിട്ടില്ല.';

  @override
  String get addPlaces => 'ചേർക്കുക';

  @override
  String get fromFile => 'ഒരു ഫയലിൽനിന്ന്';

  @override
  String get fromExistingGuide => 'നിലവിലുള്ള ഗൈഡിൽനിന്ന്';

  @override
  String get importGuideTitle => 'നിലവിലുള്ള ഗൈഡിൽ ചേർക്കുക';

  @override
  String get importGuideBody =>
      'Apple Maps‌ൽ ഗൈഡ് തുറന്ന് പങ്കിടുക, പിന്നെ ലിങ്ക് പകർത്തുക എന്നത് തിരഞ്ഞെടുക്കുക. അത് താഴെ ഒട്ടിച്ചാൽ, അതിൽ നേരത്തേയുള്ള സ്ഥലങ്ങൾ Wren വായിക്കും.';

  @override
  String get guideLinkLabel => 'ഗൈഡിന്റെ ലിങ്ക്';

  @override
  String get readGuide => 'ഗൈഡ് വായിക്കുക';

  @override
  String get importGuideNotALink =>
      'അത് Apple Maps ഗൈഡിന്റെ ലിങ്ക് അല്ല. Maps‌ൽ ഗൈഡ് തുറന്ന് പങ്കിട്ട്, പിന്നെ ലിങ്ക് പകർത്തുക എന്നത് തിരഞ്ഞെടുക്കുക.';

  @override
  String get importGuideNothing =>
      'ആ ഗൈഡിൽ Wren‌ന് ചേർക്കാനാവുന്നത് ഒന്നുമില്ല.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ആ ഗൈഡിൽനിന്ന് $count സ്ഥലങ്ങൾ വായിച്ചു',
      one: 'ആ ഗൈഡിൽനിന്ന് 1 സ്ഥലം വായിച്ചു',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'അതിലെ $count സ്ഥലങ്ങൾ പുതിയതിലേക്ക് കൊണ്ടുപോകാനാവില്ല',
      one: 'അതിലെ 1 സ്ഥലം പുതിയതിലേക്ക് കൊണ്ടുപോകാനാവില്ല',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count സ്ഥലങ്ങൾ ഈ ഗൈഡിൽ നേരത്തേതന്നെയുണ്ട്',
      one: '1 സ്ഥലം ഈ ഗൈഡിൽ നേരത്തേതന്നെയുണ്ട്',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '“$name” ഗൈഡിൽനിന്ന്';
  }

  @override
  String get republishTitle => 'Maps പുതിയ ഗൈഡ് ഉണ്ടാക്കും';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'നിലവിലുള്ള ഗൈഡിൽ ചേർക്കാൻ Apple വഴിയൊന്നും തരുന്നില്ല, അതിനാൽ $count സ്ഥലങ്ങളും ഉൾപ്പെടുന്ന പുതിയൊന്ന് Wren ഉണ്ടാക്കും.',
      one:
          'നിലവിലുള്ള ഗൈഡിൽ ചേർക്കാൻ Apple വഴിയൊന്നും തരുന്നില്ല, അതിനാൽ ആ 1 സ്ഥലം ഉൾപ്പെടുന്ന പുതിയൊന്ന് Wren ഉണ്ടാക്കും.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'പുതിയ ഗൈഡ് വെച്ചിട്ട് പഴയത് നീക്കുക.';

  @override
  String get republishKeepsPlaces =>
      'ഈ സ്ഥലങ്ങൾ Wren സൂക്ഷിക്കും, അതിനാൽ എന്തെങ്കിലും പിഴച്ചാൽ ഗൈഡ് വീണ്ടും ഉണ്ടാക്കാം.';

  @override
  String get makeCombinedGuide => 'കൂട്ടിച്ചേർത്ത ഗൈഡ് ഉണ്ടാക്കുക';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ആ ഫയലിൽനിന്ന് $count സ്ഥലങ്ങൾ വായിച്ചു',
      one: 'ആ ഫയലിൽനിന്ന് 1 സ്ഥലം വായിച്ചു',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count വരികളിൽ പേരില്ലായിരുന്നു',
      one: '1 വരിയിൽ പേരില്ലായിരുന്നു',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'ആ ഫയലിൽ സ്ഥലങ്ങളില്ല.';

  @override
  String get fileUnreadable =>
      'ആ ഫയൽ Wren‌ന് വായിക്കാനായില്ല. ഇത് CSV, KML, KMZ, GPX, GeoJSON, Google Takeout ഫയലുകൾ വായിക്കും.';

  @override
  String lookingUpProgress(int done, int total) {
    return '$totalൽ $done തിരയുന്നു…';
  }

  @override
  String get combineNeedsUnlock =>
      'കൂട്ടിച്ചേർത്ത ഗൈഡ് ഉണ്ടാക്കാൻ അൺലോക്ക് വേണം.';

  @override
  String get unlockCombineTitle => 'നിലവിലുള്ള നിങ്ങളുടെ ഗൈഡിൽ ചേർക്കുക';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'നിങ്ങളുടെ ഗൈഡിൽ നേരത്തേയുള്ള $count സ്ഥലങ്ങളും പുതിയ സ്ഥലങ്ങളും ഒന്നിച്ചുള്ള ഒരേയൊരു ഗൈഡ് Wren ഉണ്ടാക്കും.',
      one:
          'നിങ്ങളുടെ ഗൈഡിൽ നേരത്തേയുള്ള 1 സ്ഥലവും പുതിയ സ്ഥലവും ഒന്നിച്ചുള്ള ഒരേയൊരു ഗൈഡ് Wren ഉണ്ടാക്കും.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'മറ്റൊരു ആപ്പിൽനിന്ന് എക്‌സ്‌പോർട്ട് ചെയ്ത പട്ടികയും വായിക്കും: CSV, KML, KMZ, GPX, GeoJSON അല്ലെങ്കിൽ Google Takeout.';

  @override
  String get clearList => 'പട്ടിക മായ്ക്കുക';

  @override
  String get clearListTitle => 'പട്ടിക മായ്ക്കുക';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren‌ൽനിന്ന് $count സ്ഥലങ്ങളും നീക്കണോ? Apple Maps‌ൽ നേരത്തേ ഉണ്ടാക്കിയ ഗൈഡുകൾക്ക് ഒന്നും സംഭവിക്കില്ല.',
      one:
          'Wren‌ൽനിന്ന് ആ ഒരു സ്ഥലം നീക്കണോ? Apple Maps‌ൽ നേരത്തേ ഉണ്ടാക്കിയ ഗൈഡുകൾക്ക് ഒന്നും സംഭവിക്കില്ല.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'നീക്കുക';

  @override
  String get listCleared => 'പട്ടിക മായ്ച്ചു.';

  @override
  String get expandingLink => 'ആ ലിങ്ക് വായിക്കുന്നു…';

  @override
  String get linkUnreachable =>
      'ആ ലിങ്ക് വായിക്കാൻ Apple‌ലേക്ക് എത്താനായില്ല. നിങ്ങളുടെ കണക്ഷൻ പരിശോധിച്ച് വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get splitTitle => 'ഇത് ഒന്നിലധികം ഗൈഡുകൾ ഉണ്ടാക്കും';

  @override
  String splitBody(int guides, int count) {
    return 'ഒരു ഗൈഡ് ലിങ്കിൽ എത്ര സ്ഥലങ്ങൾ ഉൾക്കൊള്ളാം എന്നത് Apple പരിമിതപ്പെടുത്തുന്നു. Wren $guides ഗൈഡുകൾ ഉണ്ടാക്കും, ക്രമം നിലനിൽക്കാൻ അവയ്ക്ക് നമ്പർ ഇടും, അവയിലെല്ലാം ചേർന്ന് $count സ്ഥലങ്ങൾ ഉണ്ടാകും.';
  }

  @override
  String splitConfirm(int guides) {
    return '$guides ഗൈഡുകൾ ഉണ്ടാക്കുക';
  }

  @override
  String splitProgress(int done, int total) {
    return '$totalൽ $done ഗൈഡ് തുറന്നു. അടുത്തത് ഉണ്ടാക്കാൻ ടാപ്പ് ചെയ്യുക.';
  }

  @override
  String get sendPlacesTo => 'സ്ഥലങ്ങൾ അയയ്ക്കുക';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count സ്ഥലങ്ങൾ അയയ്ക്കാൻ തയ്യാർ',
      one: '1 സ്ഥലം അയയ്ക്കാൻ തയ്യാർ',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count സ്ഥലങ്ങൾക്ക് ലൊക്കേഷൻ ഇല്ല, അയയ്ക്കാനാകില്ല',
      one: '1 സ്ഥലത്തിന് ലൊക്കേഷൻ ഇല്ല, അയയ്ക്കാനാകില്ല',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'മറ്റേതെങ്കിലും ആപ്പ്';

  @override
  String get sendPlacesFailed => 'ആ ആപ്പ് ഫയൽ സ്വീകരിച്ചില്ല';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ഫയലിൽ നിന്ന് $count സ്ഥലങ്ങൾ സൂക്ഷിച്ചു, മറ്റൊരു മാപ്പ് ആപ്പിലേക്ക് അയയ്ക്കാൻ തയ്യാർ',
      one:
          'ഫയലിൽ നിന്ന് 1 സ്ഥലം സൂക്ഷിച്ചു, മറ്റൊരു മാപ്പ് ആപ്പിലേക്ക് അയയ്ക്കാൻ തയ്യാർ',
    );
    return '$_temp0';
  }

  @override
  String get compExpiring =>
      'നിങ്ങളുടെ സൗജന്യ ആക്‌സസ് സ്ഥിരീകരിക്കാൻ Wren-ന് കഴിഞ്ഞില്ല. അത് നിലനിർത്താൻ അടുത്ത ഏതാനും ദിവസങ്ങൾക്കുള്ളിൽ ഇന്റർനെറ്റിലേക്ക് കണക്റ്റ് ചെയ്യുക.';
}
