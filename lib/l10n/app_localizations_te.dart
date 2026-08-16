// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class LTe extends L {
  LTe([String locale = 'te']) : super(locale);

  @override
  String get tagline => 'ఒక చిన్న పిట్ట చెప్పింది.';

  @override
  String get emptyTitle => 'ప్రదేశాలు, భద్రంగా.';

  @override
  String get emptyBody =>
      'ఎవరైనా సూచించినదాన్ని స్క్రీన్‌షాట్ తీసుకోండి — ఒక రీల్, ఒక పోస్ట్, ఒక సందేశం, ప్రయాణ పుస్తకంలోని ఒక పేజీ. Wren పేర్లను చదివి వాటిని Apple Maps‌లో పెడుతుంది.';

  @override
  String get emptyNote =>
      'ఒకే ప్రదేశం మీ దగ్గర ఇప్పటికే ఉన్న గైడ్‌లో చేరుతుంది. చాలా ప్రదేశాలు కొత్తది తయారుచేస్తాయి — Apple Maps గైడ్‌లను కలపలేదు.';

  @override
  String get addScreenshots => 'స్క్రీన్‌షాట్‌లు జోడించండి';

  @override
  String get readingShort => 'చదువుతోంది…';

  @override
  String readingProgress(int done, int total) {
    return '$totalలో $done చదువుతోంది…';
  }

  @override
  String get addToGuide => 'ఒక గైడ్‌లో జోడించండి';

  @override
  String makeGuide(int count) {
    return 'గైడ్ తయారుచేయండి ($count)';
  }

  @override
  String get notFoundOnMap => 'మ్యాప్‌లో దొరకలేదు';

  @override
  String get tapToSearchForIt => 'వెతకడానికి నొక్కండి';

  @override
  String readAs(String text) {
    return 'ఇలా చదవబడింది: “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ప్రదేశాలు దొరకలేదు. వెతకడానికి నొక్కండి.',
      one: '1 ప్రదేశం దొరకలేదు. వెతకడానికి నొక్కండి.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'ఈ ప్రదేశాలు ఎక్కడ ఉన్నాయి?';

  @override
  String get regionDetected => 'శీర్షికల నుంచి చదవబడింది. తప్పైతే మార్చండి.';

  @override
  String get regionNotDetected =>
      'ఇవి ఎక్కడ ఉన్నాయో స్క్రీన్‌షాట్‌లలో లేదు. నగరం ఇస్తే వెతుకులాట చాలా కచ్చితంగా ఉంటుంది.';

  @override
  String get cityOrRegion => 'నగరం లేదా ప్రాంతం';

  @override
  String get cityExample => 'ఉదా. హైదరాబాద్';

  @override
  String get searchAnywhere => 'ఎక్కడైనా వెతకండి';

  @override
  String get findPlaces => 'ప్రదేశాలను కనుగొనండి';

  @override
  String searchedIn(String region) {
    return '$regionలో వెతికాం';
  }

  @override
  String get nameThisGuide => 'ఈ గైడ్‌కు పేరు పెట్టండి';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ఇదే పేరుతో Apple Maps‌లో కనిపిస్తుంది, అందులో $count ప్రదేశాలు ఉంటాయి.',
      one: 'ఇదే పేరుతో Apple Maps‌లో కనిపిస్తుంది, అందులో 1 ప్రదేశం ఉంటుంది.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'గైడ్ పేరు';

  @override
  String get guideNameExample => 'ఉదా. రోమ్, అక్టోబర్';

  @override
  String get createGuide => 'గైడ్ తయారుచేయండి';

  @override
  String get cancel => 'రద్దు చేయండి';

  @override
  String get guidesOfAnySize => 'ఎంత పెద్ద గైడ్‌లైనా';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren ఒక గైడ్‌లో ఉచితంగా $limit ప్రదేశాల వరకు భద్రపరుస్తుంది. మీరు $selected ఎంచుకున్నారు — $over ఎక్కువ.';
  }

  @override
  String get onePaymentKept =>
      'ఒక్కసారి చెల్లింపు, ఎప్పటికీ మీదే. సబ్‌స్క్రిప్షన్ కాదు.';

  @override
  String unlockFor(String price) {
    return '$priceకు అన్‌లాక్ చేయండి';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'బదులుగా మొదటి $limit భద్రపరచండి';
  }

  @override
  String get restorePrevious => 'గత కొనుగోలును పునరుద్ధరించండి';

  @override
  String get restorePurchase => 'కొనుగోలును పునరుద్ధరించండి';

  @override
  String overFreeLimit(int over, int limit) {
    return 'ఉచిత పరిమితి $limit కంటే $over ఎక్కువ. అన్‌లాక్ చేయవచ్చు, లేదా మొదటి $limit భద్రపరచవచ్చు.';
  }

  @override
  String get findThisPlace => 'ఈ ప్రదేశాన్ని కనుగొనండి';

  @override
  String get searchAppleMaps => 'Apple Maps‌లో వెతకండి';

  @override
  String searchInRegion(String region) {
    return '$regionలో వెతకండి';
  }

  @override
  String get searching => 'వెతుకుతోంది…';

  @override
  String get typeTwoCharacters => 'కనీసం రెండు అక్షరాలు టైప్ చేయండి.';

  @override
  String get nothingFound =>
      'ఏమీ దొరకలేదు. వీధి పేరు, లేదా చిన్న పేరు ప్రయత్నించండి.';

  @override
  String get rateLimited =>
      'Apple Maps వెతుకులాటలను పరిమితం చేస్తోంది. కాసేపు ఆగి మళ్లీ ప్రయత్నించండి.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Apple Maps వెతుకులాటలను పరిమితం చేస్తోంది — ఇప్పటివరకు $added జోడించాం, మిగిలినవి కాసేపటికి ప్రయత్నించండి.';
  }

  @override
  String importSummary(int found) {
    return '$found దొరికాయి';
  }

  @override
  String importSummaryIn(String region) {
    return '$regionలో';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count చూడాలి';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count చదవలేకపోయాం';
  }

  @override
  String nothingReadable(int count) {
    return '$count స్క్రీన్‌షాట్‌లలో చదవదగినది ఏమీ లేదు';
  }

  @override
  String get couldNotOpenMaps => 'Maps తెరవలేకపోయాం';

  @override
  String get checkingAppleAccount => 'మీ Apple ఖాతాను తనిఖీ చేస్తోంది…';

  @override
  String get restoredUnlocked =>
      'పునరుద్ధరించబడింది. ఎంత పెద్ద గైడ్‌లైనా అన్‌లాక్ అయ్యాయి.';

  @override
  String get noPreviousPurchase => 'ఈ Apple ఖాతాలో గత కొనుగోలు ఏదీ దొరకలేదు.';

  @override
  String get purchaseDidNotComplete =>
      'కొనుగోలు పూర్తి కాలేదు, కాబట్టి ఏమీ వసూలు చేయలేదు.';

  @override
  String alreadyInTheList(String name) {
    return '$name అప్పటికే జాబితాలో ఉంది.';
  }

  @override
  String get ocrUnavailable =>
      'స్క్రీన్‌షాట్‌లు చదవడానికి iPhone కావాలి — ఈ ప్లాట్‌ఫారమ్‌లో టెక్స్ట్ గుర్తింపు లేదు.';

  @override
  String get lookupUnavailable =>
      'ప్రదేశాలు వెతకడానికి iPhone కావాలి — ఈ ప్లాట్‌ఫారమ్‌లో మ్యాప్ శోధన లేదు.';

  @override
  String get compAccess => 'ఉచిత ప్రవేశం';

  @override
  String get code => 'కోడ్';

  @override
  String get unlock => 'అన్‌లాక్ చేయండి';

  @override
  String get compChecking => 'ఆ కోడ్‌ను తనిఖీ చేస్తోంది…';

  @override
  String get compEnabled => 'ఉచిత ప్రవేశం ఆన్ చేయబడింది.';

  @override
  String get compRefused => 'ఆ కోడ్ గుర్తించబడలేదు, లేదా ఇప్పటికే వాడబడింది.';

  @override
  String get compTooOften =>
      'చాలాసార్లు ప్రయత్నించారు. కొన్ని నిమిషాలు ఆగి మళ్లీ ప్రయత్నించండి.';

  @override
  String get compUnreachable =>
      'సర్వర్‌ను చేరుకోలేకపోయాం. మీ కనెక్షన్ చూసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get compUntrusted =>
      'ఆ సమాధానాన్ని ధృవీకరించలేకపోయాం, కాబట్టి ఏమీ అన్‌లాక్ కాలేదు.';
}
