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
  String get emptyBodyAndroid =>
      'ఎవరైనా సూచించినదాన్ని స్క్రీన్‌షాట్ తీసుకోండి — ఒక రీల్, ఒక పోస్ట్, ఒక సందేశం, ప్రయాణ పుస్తకంలోని ఒక పేజీ. Wren పేర్లను చదివి వాటిని మీ ఫోన్‌లోని మ్యాప్ యాప్‌కు పంపుతుంది.';

  @override
  String get emptyNoteAndroid =>
      'మీ దగ్గర ఇప్పటికే ఉన్న జాబితాను కూడా ఇది చదువుతుంది, ఏదైనా పంపే ముందు ప్రతి ప్రదేశాన్ని చూపిస్తుంది.';

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
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count స్క్రీన్‌షాట్‌లలో చదవదగినది ఏమీ లేదు',
      one: '$count స్క్రీన్‌షాట్‌లో చదవదగినది ఏమీ లేదు',
    );
    return '$_temp0';
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

  @override
  String get addPlaces => 'జోడించండి';

  @override
  String get fromFile => 'ఫైల్ నుంచి';

  @override
  String get fromExistingGuide => 'ఇప్పటికే ఉన్న గైడ్ నుంచి';

  @override
  String get importGuideTitle => 'ఇప్పటికే ఉన్న గైడ్‌లో జోడించండి';

  @override
  String get importGuideBody =>
      'Apple Maps‌లో గైడ్‌ను తెరిచి షేర్ చేయండి, తర్వాత లింక్‌ను కాపీ చేయండి అనే ఎంపికను ఎంచుకోండి. దాన్ని కింద పేస్ట్ చేస్తే, అందులో ఇప్పటికే ఉన్న ప్రదేశాలను Wren చదువుతుంది.';

  @override
  String get guideLinkLabel => 'గైడ్ లింక్';

  @override
  String get readGuide => 'గైడ్ చదవండి';

  @override
  String get importGuideNotALink =>
      'అది Apple Maps గైడ్ లింక్ కాదు. Maps‌లో గైడ్‌ను తెరిచి షేర్ చేయండి, తర్వాత లింక్‌ను కాపీ చేయండి అనే ఎంపికను ఎంచుకోండి.';

  @override
  String get importGuideNothing => 'ఆ గైడ్‌లో Wren జోడించగలిగేది ఏదీ లేదు.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ఆ గైడ్ నుంచి $count ప్రదేశాలు చదివాం',
      one: 'ఆ గైడ్ నుంచి 1 ప్రదేశం చదివాం',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'అందులోని $count ప్రదేశాలను తీసుకెళ్లడం కుదరదు',
      one: 'అందులోని 1 ప్రదేశాన్ని తీసుకెళ్లడం కుదరదు',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ప్రదేశాలు ఇప్పటికే ఈ గైడ్‌లో ఉన్నాయి',
      one: '1 ప్రదేశం ఇప్పటికే ఈ గైడ్‌లో ఉంది',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '“$name” గైడ్ నుంచి';
  }

  @override
  String get republishTitle => 'Maps కొత్త గైడ్ తయారుచేస్తుంది';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ఇప్పటికే ఉన్న గైడ్‌లో జోడించే మార్గం Apple ఇవ్వదు, కాబట్టి $count ప్రదేశాలన్నింటితో Wren కొత్తది తయారుచేస్తుంది.',
      one:
          'ఇప్పటికే ఉన్న గైడ్‌లో జోడించే మార్గం Apple ఇవ్వదు, కాబట్టి ఆ 1 ప్రదేశంతో Wren కొత్తది తయారుచేస్తుంది.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'కొత్త గైడ్‌ను ఉంచుకుని పాతదాన్ని తొలగించండి.';

  @override
  String get republishKeepsPlaces =>
      'ఈ ప్రదేశాలను Wren ఉంచుకుంటుంది, కాబట్టి ఏదైనా తప్పు జరిగితే గైడ్‌ను మళ్లీ తయారుచేయవచ్చు.';

  @override
  String get makeCombinedGuide => 'కలిపిన గైడ్ తయారుచేయండి';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ఆ ఫైల్ నుంచి $count ప్రదేశాలు చదివాం',
      one: 'ఆ ఫైల్ నుంచి 1 ప్రదేశం చదివాం',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count వరుసల్లో పేరు లేదు',
      one: '1 వరుసలో పేరు లేదు',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'ఆ ఫైల్‌లో ప్రదేశాలు లేవు.';

  @override
  String get fileUnreadable =>
      'ఆ ఫైల్‌ను Wren చదవలేకపోయింది. ఇది CSV, KML, KMZ, GPX, GeoJSON మరియు Google Takeout ఫైల్‌లను చదువుతుంది.';

  @override
  String lookingUpProgress(int done, int total) {
    return '$totalలో $done వెతుకుతోంది…';
  }

  @override
  String get combineNeedsUnlock =>
      'కలిపిన గైడ్ తయారుచేయడానికి అన్‌లాక్ కావాలి.';

  @override
  String get unlockCombineTitle => 'ఇప్పటికే ఉన్న మీ గైడ్‌లో జోడించండి';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'మీ గైడ్‌లో ఇప్పటికే ఉన్న $count ప్రదేశాలను, కొత్త ప్రదేశాలను కలిపి Wren ఒకే గైడ్ తయారుచేస్తుంది.',
      one:
          'మీ గైడ్‌లో ఇప్పటికే ఉన్న 1 ప్రదేశాన్ని, కొత్త ప్రదేశాన్ని కలిపి Wren ఒకే గైడ్ తయారుచేస్తుంది.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'మరో యాప్ నుంచి ఎక్స్‌పోర్ట్ చేసిన జాబితాను కూడా చదువుతుంది: CSV, KML, KMZ, GPX, GeoJSON లేదా Google Takeout.';

  @override
  String get clearList => 'జాబితాను ఖాళీ చేయండి';

  @override
  String get clearListTitle => 'జాబితాను ఖాళీ చేయండి';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren నుంచి $count ప్రదేశాలన్నింటినీ తీసేయాలా? Apple Maps‌లో ఇప్పటికే తయారుచేసిన గైడ్‌లపై ఎలాంటి ప్రభావం ఉండదు.',
      one:
          'Wren నుంచి ఆ ఒక ప్రదేశాన్ని తీసేయాలా? Apple Maps‌లో ఇప్పటికే తయారుచేసిన గైడ్‌లపై ఎలాంటి ప్రభావం ఉండదు.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'తీసేయండి';

  @override
  String get listCleared => 'జాబితా ఖాళీ అయింది.';

  @override
  String get expandingLink => 'ఆ లింక్‌ను చదువుతోంది…';

  @override
  String get linkUnreachable =>
      'ఆ లింక్‌ను చదవడానికి Apple‌ను చేరుకోలేకపోయాం. మీ కనెక్షన్ చూసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get splitTitle => 'ఇది ఒకటి కంటే ఎక్కువ గైడ్‌లు తయారుచేస్తుంది';

  @override
  String splitBody(int guides, int count) {
    return 'ఒక గైడ్ లింక్‌లో ఎన్ని ప్రదేశాలు ఉండగలవో Apple పరిమితం చేస్తుంది. Wren $guides గైడ్‌లు తయారుచేస్తుంది, వరుస చెడకుండా వాటికి నంబర్లు ఉంటాయి, అన్నింటిలో కలిపి $count ప్రదేశాలు ఉంటాయి.';
  }

  @override
  String splitConfirm(int guides) {
    return '$guides గైడ్‌లు తయారుచేయండి';
  }

  @override
  String splitProgress(int done, int total) {
    return '$totalలో $done గైడ్ తెరిచాం. తర్వాతది తయారుచేయడానికి నొక్కండి.';
  }

  @override
  String get sendPlacesTo => 'స్థలాలను పంపు';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count స్థలాలు పంపడానికి సిద్ధం',
      one: '1 స్థలం పంపడానికి సిద్ధం',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count స్థలాలకు స్థానం లేదు, పంపలేము',
      one: '1 స్థలానికి స్థానం లేదు, పంపలేము',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'మరే యాప్ అయినా';

  @override
  String get sendPlacesFailed => 'ఆ యాప్ ఫైల్‌ను తీసుకోలేదు';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'ఫైల్ నుండి $count స్థలాలు ఉంచబడ్డాయి, మరో మ్యాప్ యాప్‌కు పంపడానికి సిద్ధం',
      one: 'ఫైల్ నుండి 1 స్థలం ఉంచబడింది, మరో మ్యాప్ యాప్‌కు పంపడానికి సిద్ధం',
    );
    return '$_temp0';
  }

  @override
  String get compExpiring =>
      'మీ ఉచిత యాక్సెస్‌ను Wren నిర్ధారించలేకపోయింది. దాన్ని కొనసాగించడానికి రాబోయే కొద్ది రోజుల్లో ఇంటర్నెట్‌కు కనెక్ట్ అవ్వండి.';
}
