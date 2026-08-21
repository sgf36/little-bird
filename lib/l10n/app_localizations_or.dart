// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oriya (`or`).
class LOr extends L {
  LOr([String locale = 'or']) : super(locale);

  @override
  String get tagline => 'ଗୋଟିଏ ଛୋଟ ଚଢ଼େଇ କହିଲା।';

  @override
  String get emptyTitle => 'ସ୍ଥାନ, ସାଇତି ରଖା।';

  @override
  String get emptyBody =>
      'କେହି ଯାହା ସୁପାରିଶ କରନ୍ତି ତାହାର ସ୍କ୍ରିନଶଟ୍ ନିଅନ୍ତୁ — ଏକ ରିଲ୍, ଏକ ପୋଷ୍ଟ, ଏକ ବାର୍ତ୍ତା, କିମ୍ବା ଗାଇଡ୍‌ବୁକ୍‌ର ଗୋଟିଏ ପୃଷ୍ଠା। Wren ନାମଗୁଡ଼ିକ ପଢ଼ି ସେଗୁଡ଼ିକୁ Apple Maps‌ରେ ରଖିଦିଏ।';

  @override
  String get emptyNote =>
      'ଗୋଟିଏ ସ୍ଥାନ ଆପଣଙ୍କ ପାଖରେ ପୂର୍ବରୁ ଥିବା ଗାଇଡ୍‌ରେ ଯୋଡ଼ି ହୁଏ। ଏକାଧିକ ହେଲେ ନୂଆ ଗୋଟିଏ ତିଆରି ହୁଏ — Apple Maps ଗାଇଡ୍‌ଗୁଡ଼ିକୁ ମିଶାଇ ପାରେ ନାହିଁ।';

  @override
  String get addScreenshots => 'ସ୍କ୍ରିନଶଟ୍ ଯୋଡ଼ନ୍ତୁ';

  @override
  String get readingShort => 'ପଢ଼ୁଛି…';

  @override
  String readingProgress(int done, int total) {
    return '$totalରୁ $done ପଢ଼ୁଛି…';
  }

  @override
  String get addToGuide => 'ଏକ ଗାଇଡ୍‌ରେ ଯୋଡ଼ନ୍ତୁ';

  @override
  String makeGuide(int count) {
    return 'ଗାଇଡ୍ ତିଆରି କରନ୍ତୁ ($count)';
  }

  @override
  String get notFoundOnMap => 'ମାନଚିତ୍ରରେ ମିଳିଲା ନାହିଁ';

  @override
  String get tapToSearchForIt => 'ଖୋଜିବା ପାଇଁ ଟ୍ୟାପ୍ କରନ୍ତୁ';

  @override
  String readAs(String text) {
    return 'ଏହିପରି ପଢ଼ାଗଲା: “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countଟି ସ୍ଥାନ ମିଳିଲା ନାହିଁ। ଖୋଜିବା ପାଇଁ ଟ୍ୟାପ୍ କରନ୍ତୁ।',
      one: '1ଟି ସ୍ଥାନ ମିଳିଲା ନାହିଁ। ଖୋଜିବା ପାଇଁ ଟ୍ୟାପ୍ କରନ୍ତୁ।',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'ଏହି ସ୍ଥାନଗୁଡ଼ିକ କେଉଁଠି?';

  @override
  String get regionDetected => 'କ୍ୟାପ୍‌ସନରୁ ପଢ଼ାଯାଇଛି। ଭୁଲ ଥିଲେ ବଦଳାନ୍ତୁ।';

  @override
  String get regionNotDetected =>
      'ଏଗୁଡ଼ିକ କେଉଁଠି ଅଛି ତାହା ସ୍କ୍ରିନଶଟ୍‌ରେ ଲେଖା ନଥିଲା। ସହର ଦେଲେ ଖୋଜା ବହୁତ ଠିକ୍ ହୁଏ।';

  @override
  String get cityOrRegion => 'ସହର କିମ୍ବା ଅଞ୍ଚଳ';

  @override
  String get cityExample => 'ଯଥା ଭୁବନେଶ୍ୱର';

  @override
  String get searchAnywhere => 'ସବୁଠି ଖୋଜନ୍ତୁ';

  @override
  String get findPlaces => 'ସ୍ଥାନ ଖୋଜନ୍ତୁ';

  @override
  String searchedIn(String region) {
    return '$regionରେ ଖୋଜାଗଲା';
  }

  @override
  String get nameThisGuide => 'ଏହି ଗାଇଡ୍‌କୁ ନାମ ଦିଅନ୍ତୁ';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ଏହି ନାମରେ ଏହା Apple Maps‌ରେ ଦେଖାଯିବ, ଏଥିରେ $countଟି ସ୍ଥାନ ରହିବ।',
      one: 'ଏହି ନାମରେ ଏହା Apple Maps‌ରେ ଦେଖାଯିବ, ଏଥିରେ 1ଟି ସ୍ଥାନ ରହିବ।',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'ଗାଇଡ୍‌ର ନାମ';

  @override
  String get guideNameExample => 'ଯଥା ରୋମ୍, ଅକ୍ଟୋବର';

  @override
  String get createGuide => 'ଗାଇଡ୍ ତିଆରି କରନ୍ତୁ';

  @override
  String get cancel => 'ବାତିଲ୍ କରନ୍ତୁ';

  @override
  String get guidesOfAnySize => 'ଯେକୌଣସି ଆକାରର ଗାଇଡ୍';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren ଗୋଟିଏ ଗାଇଡ୍‌ରେ ମାଗଣାରେ $limitଟି ପର୍ଯ୍ୟନ୍ତ ସ୍ଥାନ ସାଇତେ। ଆପଣ $selectedଟି ବାଛିଛନ୍ତି — $overଟି ଅଧିକ।';
  }

  @override
  String get onePaymentKept =>
      'ଥରେ ଦେୟ, ଚିରଦିନ ଆପଣଙ୍କର। କୌଣସି ସବ୍‌ସ୍କ୍ରିପ୍‌ସନ୍ ନାହିଁ।';

  @override
  String unlockFor(String price) {
    return '$priceରେ ଅନଲକ୍ କରନ୍ତୁ';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'ଏହା ବଦଳରେ ପ୍ରଥମ $limitଟି ସାଇତନ୍ତୁ';
  }

  @override
  String get restorePrevious => 'ପୂର୍ବ କ୍ରୟ ପୁନରୁଦ୍ଧାର କରନ୍ତୁ';

  @override
  String get restorePurchase => 'କ୍ରୟ ପୁନରୁଦ୍ଧାର କରନ୍ତୁ';

  @override
  String overFreeLimit(int over, int limit) {
    return 'ମାଗଣା ସୀମା $limitଠାରୁ $overଟି ଅଧିକ। ଅନଲକ୍ କରିପାରିବେ, କିମ୍ବା ପ୍ରଥମ $limitଟି ସାଇତିପାରିବେ।';
  }

  @override
  String get findThisPlace => 'ଏହି ସ୍ଥାନ ଖୋଜନ୍ତୁ';

  @override
  String get searchAppleMaps => 'Apple Maps‌ରେ ଖୋଜନ୍ତୁ';

  @override
  String searchInRegion(String region) {
    return '$regionରେ ଖୋଜନ୍ତୁ';
  }

  @override
  String get searching => 'ଖୋଜୁଛି…';

  @override
  String get typeTwoCharacters => 'ଅନ୍ତତଃ ଦୁଇଟି ଅକ୍ଷର ଲେଖନ୍ତୁ।';

  @override
  String get nothingFound =>
      'କିଛି ମିଳିଲା ନାହିଁ। ରାସ୍ତାର ନାମ, କିମ୍ବା ଛୋଟ ନାମ ଚେଷ୍ଟା କରନ୍ତୁ।';

  @override
  String get rateLimited =>
      'Apple Maps ଖୋଜାକୁ ସୀମିତ କରୁଛି। ଟିକିଏ ଅପେକ୍ଷା କରି ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ।';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps ଖୋଜାକୁ ସୀମିତ କରୁଛି — ଏପର୍ଯ୍ୟନ୍ତ $addedଟି ଯୋଡ଼ାଗଲା, ବାକିଗୁଡ଼ିକ ଟିକିଏ ପରେ ଚେଷ୍ଟା କରନ୍ତୁ।';
  }

  @override
  String importSummary(int found) {
    return '$foundଟି ମିଳିଲା';
  }

  @override
  String importSummaryIn(String region) {
    return '$regionରେ';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$countଟି ଦେଖିବାକୁ ଅଛି';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$countଟି ପଢ଼ାଗଲା ନାହିଁ';
  }

  @override
  String nothingReadable(int count) {
    return '$countଟି ସ୍କ୍ରିନଶଟ୍‌ରେ ପଢ଼ିବା ଯୋଗ୍ୟ କିଛି ନାହିଁ';
  }

  @override
  String get couldNotOpenMaps => 'Maps ଖୋଲାଗଲା ନାହିଁ';

  @override
  String get checkingAppleAccount => 'ଆପଣଙ୍କ Apple ଖାତା ଯାଞ୍ଚ କରୁଛି…';

  @override
  String get restoredUnlocked =>
      'ପୁନରୁଦ୍ଧାର ହେଲା। ଯେକୌଣସି ଆକାରର ଗାଇଡ୍ ଅନଲକ୍ ହୋଇଛି।';

  @override
  String get noPreviousPurchase =>
      'ଏହି Apple ଖାତାରେ ପୂର୍ବ କୌଣସି କ୍ରୟ ମିଳିଲା ନାହିଁ।';

  @override
  String get purchaseDidNotComplete =>
      'କ୍ରୟ ସମ୍ପୂର୍ଣ୍ଣ ହେଲା ନାହିଁ, ତେଣୁ କିଛି ନିଆଯାଇ ନାହିଁ।';

  @override
  String alreadyInTheList(String name) {
    return '$name ପୂର୍ବରୁ ତାଲିକାରେ ଥିଲା।';
  }

  @override
  String get ocrUnavailable =>
      'ସ୍କ୍ରିନଶଟ୍ ପଢ଼ିବା ପାଇଁ iPhone ଦରକାର — ଏହି ପ୍ଲାଟଫର୍ମରେ ଲେଖା ଚିହ୍ନଟ ନାହିଁ।';

  @override
  String get lookupUnavailable =>
      'ସ୍ଥାନ ଖୋଜିବା ପାଇଁ iPhone ଦରକାର — ଏହି ପ୍ଲାଟଫର୍ମରେ ମାନଚିତ୍ର ଖୋଜା ନାହିଁ।';

  @override
  String get compAccess => 'ମାଗଣା ପ୍ରବେଶ';

  @override
  String get code => 'କୋଡ୍';

  @override
  String get unlock => 'ଅନଲକ୍ କରନ୍ତୁ';

  @override
  String get compChecking => 'ସେହି କୋଡ୍ ଯାଞ୍ଚ କରୁଛି…';

  @override
  String get compEnabled => 'ମାଗଣା ପ୍ରବେଶ ଚାଲୁ ହେଲା।';

  @override
  String get compRefused =>
      'ସେହି କୋଡ୍ ଚିହ୍ନଟ ହେଲା ନାହିଁ, କିମ୍ବା ଏହା ପୂର୍ବରୁ ବ୍ୟବହୃତ ହୋଇସାରିଛି।';

  @override
  String get compTooOften =>
      'ବହୁତ ଥର ଚେଷ୍ଟା ହେଲା। କିଛି ମିନିଟ୍ ଅପେକ୍ଷା କରି ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ।';

  @override
  String get compUnreachable =>
      'ସର୍ଭର ପାଖରେ ପହଞ୍ଚି ହେଲା ନାହିଁ। ଆପଣଙ୍କ ସଂଯୋଗ ଯାଞ୍ଚ କରି ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ।';

  @override
  String get compUntrusted =>
      'ସେହି ଉତ୍ତର ଯାଞ୍ଚ ହୋଇପାରିଲା ନାହିଁ, ତେଣୁ କିଛି ଅନଲକ୍ ହେଲା ନାହିଁ।';

  @override
  String get addPlaces => 'ଯୋଡ଼ନ୍ତୁ';

  @override
  String get fromFile => 'ଏକ ଫାଇଲ୍‌ରୁ';

  @override
  String get fromExistingGuide => 'ପୂର୍ବରୁ ଥିବା ଗାଇଡ୍‌ରୁ';

  @override
  String get importGuideTitle => 'ପୂର୍ବରୁ ଥିବା ଗାଇଡ୍‌ରେ ଯୋଡ଼ନ୍ତୁ';

  @override
  String get importGuideBody =>
      'Apple Maps‌ରେ ଗାଇଡ୍ ଖୋଲି ଶେୟାର୍ କରନ୍ତୁ, ତା\'ପରେ ଲିଙ୍କ୍ କପି କରନ୍ତୁ ବିକଳ୍ପଟି ବାଛନ୍ତୁ। ତାହା ତଳେ ପେଷ୍ଟ କଲେ, ଏଥିରେ ପୂର୍ବରୁ ଥିବା ସ୍ଥାନଗୁଡ଼ିକୁ Wren ପଢ଼ିଦେବ।';

  @override
  String get guideLinkLabel => 'ଗାଇଡ୍‌ର ଲିଙ୍କ୍';

  @override
  String get readGuide => 'ଗାଇଡ୍ ପଢ଼ନ୍ତୁ';

  @override
  String get importGuideNotALink =>
      'ଏହା Apple Maps ଗାଇଡ୍‌ର ଲିଙ୍କ୍ ନୁହେଁ। Maps‌ରେ ଗାଇଡ୍ ଖୋଲି ଶେୟାର୍ କରନ୍ତୁ, ତା\'ପରେ ଲିଙ୍କ୍ କପି କରନ୍ତୁ ବିକଳ୍ପଟି ବାଛନ୍ତୁ।';

  @override
  String get importGuideNothing =>
      'ସେହି ଗାଇଡ୍‌ରେ Wren ଯୋଡ଼ିପାରିବ ଏପରି କିଛି ନାହିଁ।';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ସେହି ଗାଇଡ୍‌ରୁ $countଟି ସ୍ଥାନ ପଢ଼ାଗଲା',
      one: 'ସେହି ଗାଇଡ୍‌ରୁ 1ଟି ସ୍ଥାନ ପଢ଼ାଗଲା',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ଏଥିରେ $countଟି ସ୍ଥାନ ନୂଆ ଗାଇଡ୍‌କୁ ନେଇ ହେବ ନାହିଁ',
      one: 'ଏଥିରେ 1ଟି ସ୍ଥାନ ନୂଆ ଗାଇଡ୍‌କୁ ନେଇ ହେବ ନାହିଁ',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countଟି ସ୍ଥାନ ପୂର୍ବରୁ ଏହି ଗାଇଡ୍‌ରେ ଅଛି',
      one: '1ଟି ସ୍ଥାନ ପୂର୍ବରୁ ଏହି ଗାଇଡ୍‌ରେ ଅଛି',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '“$name” ଗାଇଡ୍‌ରୁ';
  }

  @override
  String get republishTitle => 'Maps ନୂଆ ଗୋଟିଏ ଗାଇଡ୍ ତିଆରି କରେ';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ପୂର୍ବରୁ ଥିବା ଗାଇଡ୍‌ରେ ଯୋଡ଼ିବାର କୌଣସି ଉପାୟ Apple ଦିଏ ନାହିଁ, ତେଣୁ ସବୁ $countଟି ସ୍ଥାନକୁ ନେଇ Wren ନୂଆ ଗୋଟିଏ ତିଆରି କରିବ।',
      one:
          'ପୂର୍ବରୁ ଥିବା ଗାଇଡ୍‌ରେ ଯୋଡ଼ିବାର କୌଣସି ଉପାୟ Apple ଦିଏ ନାହିଁ, ତେଣୁ ସେହି 1ଟି ସ୍ଥାନକୁ ନେଇ Wren ନୂଆ ଗୋଟିଏ ତିଆରି କରିବ।',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'ନୂଆ ଗାଇଡ୍ ରଖି ପୁରୁଣାଟି ଡିଲିଟ୍ କରନ୍ତୁ।';

  @override
  String get republishKeepsPlaces =>
      'ଏହି ସ୍ଥାନଗୁଡ଼ିକ Wren ରଖିଥାଏ, ତେଣୁ କିଛି ଭୁଲ ହେଲେ ଗାଇଡ୍‌କୁ ପୁଣି ତିଆରି କରିପାରିବେ।';

  @override
  String get makeCombinedGuide => 'ମିଳିତ ଗାଇଡ୍ ତିଆରି କରନ୍ତୁ';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ସେହି ଫାଇଲ୍‌ରୁ $countଟି ସ୍ଥାନ ପଢ଼ାଗଲା',
      one: 'ସେହି ଫାଇଲ୍‌ରୁ 1ଟି ସ୍ଥାନ ପଢ଼ାଗଲା',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countଟି ଧାଡ଼ିରେ ନାମ ନଥିଲା',
      one: '1ଟି ଧାଡ଼ିରେ ନାମ ନଥିଲା',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'ସେହି ଫାଇଲ୍‌ରେ କୌଣସି ସ୍ଥାନ ନାହିଁ।';

  @override
  String get fileUnreadable =>
      'ସେହି ଫାଇଲ୍ Wren ପଢ଼ି ପାରିଲା ନାହିଁ। ଏହା CSV, KML, KMZ, GPX, GeoJSON ଏବଂ Google Takeout ଫାଇଲ୍ ପଢ଼େ।';

  @override
  String lookingUpProgress(int done, int total) {
    return '$totalରୁ $done ଖୋଜୁଛି…';
  }

  @override
  String get combineNeedsUnlock => 'ମିଳିତ ଗାଇଡ୍ ତିଆରି କରିବାକୁ ଅନଲକ୍ ଦରକାର।';

  @override
  String get unlockCombineTitle => 'ପୂର୍ବରୁ ଥିବା ଆପଣଙ୍କ ଗାଇଡ୍‌ରେ ଯୋଡ଼ନ୍ତୁ';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ଆପଣଙ୍କ ଗାଇଡ୍‌ରେ ପୂର୍ବରୁ ଥିବା $countଟି ସ୍ଥାନ ଓ ନୂଆ ସ୍ଥାନଗୁଡ଼ିକୁ ଏକାଠି ନେଇ Wren ଗୋଟିଏ ହିଁ ଗାଇଡ୍ ତିଆରି କରିବ।',
      one:
          'ଆପଣଙ୍କ ଗାଇଡ୍‌ରେ ପୂର୍ବରୁ ଥିବା 1ଟି ସ୍ଥାନ ଓ ନୂଆ ସ୍ଥାନକୁ ଏକାଠି ନେଇ Wren ଗୋଟିଏ ହିଁ ଗାଇଡ୍ ତିଆରି କରିବ।',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'ଅନ୍ୟ ଏକ ଆପ୍‌ରୁ ଏକ୍ସପୋର୍ଟ୍ କରାଯାଇଥିବା ତାଲିକା ମଧ୍ୟ ପଢ଼େ: CSV, KML, KMZ, GPX, GeoJSON କିମ୍ବା Google Takeout।';

  @override
  String get clearList => 'ତାଲିକା ଖାଲି କରନ୍ତୁ';

  @override
  String get clearListTitle => 'ତାଲିକା ଖାଲି କରନ୍ତୁ';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren‌ରୁ ସବୁ $countଟି ସ୍ଥାନ ହଟାଇବେ? Apple Maps‌ରେ ପୂର୍ବରୁ ତିଆରି ହୋଇଥିବା ଗାଇଡ୍‌ଗୁଡ଼ିକରେ କୌଣସି ପ୍ରଭାବ ପଡ଼େ ନାହିଁ।',
      one:
          'Wren‌ରୁ ସେହି ଗୋଟିଏ ସ୍ଥାନ ହଟାଇବେ? Apple Maps‌ରେ ପୂର୍ବରୁ ତିଆରି ହୋଇଥିବା ଗାଇଡ୍‌ଗୁଡ଼ିକରେ କୌଣସି ପ୍ରଭାବ ପଡ଼େ ନାହିଁ।',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'ହଟାନ୍ତୁ';

  @override
  String get listCleared => 'ତାଲିକା ଖାଲି ହେଲା।';

  @override
  String get expandingLink => 'ସେହି ଲିଙ୍କ୍ ପଢ଼ୁଛି…';

  @override
  String get linkUnreachable =>
      'ସେହି ଲିଙ୍କ୍ ପଢ଼ିବା ପାଇଁ Apple ପାଖରେ ପହଞ୍ଚି ହେଲା ନାହିଁ। ଆପଣଙ୍କ ସଂଯୋଗ ଯାଞ୍ଚ କରି ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ।';

  @override
  String get splitTitle => 'ଏଥିରୁ ଏକାଧିକ ଗାଇଡ୍ ତିଆରି ହେବ';

  @override
  String splitBody(int guides, int count) {
    return 'ଗୋଟିଏ ଗାଇଡ୍ ଲିଙ୍କ୍‌ରେ କେତେଟି ସ୍ଥାନ ରହିପାରିବ ତାହା Apple ସୀମିତ ରଖେ। Wren $guidesଟି ଗାଇଡ୍ ତିଆରି କରିବ, କ୍ରମ ବଜାୟ ରହିବା ପାଇଁ ସେଗୁଡ଼ିକରେ ନମ୍ବର ରହିବ, ଏବଂ ସେ ସବୁରେ ମିଶି $countଟି ସ୍ଥାନ ରହିବ।';
  }

  @override
  String splitConfirm(int guides) {
    return '$guidesଟି ଗାଇଡ୍ ତିଆରି କରନ୍ତୁ';
  }

  @override
  String splitProgress(int done, int total) {
    return '$totalରୁ $doneଟି ଗାଇଡ୍ ଖୋଲିଲା। ପରବର୍ତ୍ତୀଟି ତିଆରି କରିବାକୁ ଟ୍ୟାପ୍ କରନ୍ତୁ।';
  }

  @override
  String get compExpiring =>
      'Wren ଆପଣଙ୍କ ମାଗଣା ଆକ୍ସେସ୍ ନିଶ୍ଚିତ କରିପାରିଲା ନାହିଁ। ଏହା ରଖିବା ପାଇଁ ଆଗାମୀ କିଛି ଦିନ ମଧ୍ୟରେ ଇଣ୍ଟରନେଟ୍ ସହ ସଂଯୋଗ କରନ୍ତୁ।';
}
