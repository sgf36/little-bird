// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class LFr extends L {
  LFr([String locale = 'fr']) : super(locale);

  @override
  String get tagline => 'Mon petit doigt me l\'a dit.';

  @override
  String get emptyTitle => 'Des lieux, gardés.';

  @override
  String get emptyBody =>
      'Faites une capture de ce qu\'on vous recommande — un reel, une publication, un message, la page d\'un guide de voyage. Wren lit les noms et les place dans Plans.';

  @override
  String get emptyNote =>
      'Un lieu seul rejoint un guide que vous avez déjà. Plusieurs en créent un nouveau — Plans ne sait pas fusionner les guides.';

  @override
  String get addScreenshots => 'Ajouter des captures';

  @override
  String get readingShort => 'Lecture…';

  @override
  String readingProgress(int done, int total) {
    return 'Lecture de $done sur $total…';
  }

  @override
  String get addToGuide => 'Ajouter à un guide';

  @override
  String makeGuide(int count) {
    return 'Créer un guide ($count)';
  }

  @override
  String get notFoundOnMap => 'Introuvable sur la carte';

  @override
  String get tapToSearchForIt => 'Touchez pour le rechercher';

  @override
  String readAs(String text) {
    return 'lu comme « $text »';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lieux sont introuvables. Touchez pour les rechercher.',
      one: '1 lieu est introuvable. Touchez pour le rechercher.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Où se trouvent ces lieux ?';

  @override
  String get regionDetected =>
      'Lu dans les légendes. Modifiez si ce n\'est pas le bon.';

  @override
  String get regionNotDetected =>
      'Rien dans les captures n\'indiquait où se trouvent ces lieux. Une ville rend la recherche bien plus précise.';

  @override
  String get cityOrRegion => 'Ville ou région';

  @override
  String get cityExample => 'ex. Paris';

  @override
  String get searchAnywhere => 'Chercher partout';

  @override
  String get findPlaces => 'Trouver les lieux';

  @override
  String searchedIn(String region) {
    return 'Recherche dans $region';
  }

  @override
  String get nameThisGuide => 'Nommer ce guide';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Il apparaîtra sous ce nom dans Plans, avec $count lieux.',
      one: 'Il apparaîtra sous ce nom dans Plans, avec 1 lieu.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Nom du guide';

  @override
  String get guideNameExample => 'ex. Rome, octobre';

  @override
  String get createGuide => 'Créer le guide';

  @override
  String get cancel => 'Annuler';

  @override
  String get guidesOfAnySize => 'Des guides sans limite';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren enregistre gratuitement jusqu\'à $limit lieux par guide. Vous en avez sélectionné $selected — soit $over de plus.';
  }

  @override
  String get onePaymentKept =>
      'Un seul paiement, acquis pour de bon. Aucun abonnement.';

  @override
  String unlockFor(String price) {
    return 'Débloquer pour $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Enregistrer plutôt les $limit premiers';
  }

  @override
  String get restorePrevious => 'Restaurer un achat précédent';

  @override
  String get restorePurchase => 'Restaurer l\'achat';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over au-delà de la limite gratuite de $limit. Vous pouvez débloquer, ou enregistrer les $limit premiers.';
  }

  @override
  String get findThisPlace => 'Trouver ce lieu';

  @override
  String get searchAppleMaps => 'Rechercher dans Plans';

  @override
  String searchInRegion(String region) {
    return 'Rechercher dans $region';
  }

  @override
  String get searching => 'Recherche…';

  @override
  String get typeTwoCharacters => 'Saisissez au moins deux caractères.';

  @override
  String get nothingFound =>
      'Aucun résultat. Essayez la rue, ou un nom plus court.';

  @override
  String get rateLimited =>
      'Plans limite les recherches. Patientez un instant et réessayez.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Plans limite les recherches — $added ajoutés jusqu\'ici, réessayez le reste dans un instant.';
  }

  @override
  String importSummary(int found) {
    return '$found trouvés';
  }

  @override
  String importSummaryIn(String region) {
    return 'à $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count à vérifier';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count illisibles';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rien de lisible dans $count captures',
      one: 'Rien de lisible dans cette capture',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Impossible d\'ouvrir Plans';

  @override
  String get checkingAppleAccount => 'Vérification de votre compte Apple…';

  @override
  String get restoredUnlocked =>
      'Restauré. Les guides sans limite sont débloqués.';

  @override
  String get noPreviousPurchase =>
      'Aucun achat précédent trouvé sur ce compte Apple.';

  @override
  String get purchaseDidNotComplete =>
      'L\'achat n\'a pas abouti, rien n\'a été débité.';

  @override
  String alreadyInTheList(String name) {
    return '$name figurait déjà dans la liste.';
  }

  @override
  String get ocrUnavailable =>
      'La lecture des captures nécessite un iPhone — il n\'y a pas de reconnaissance de texte sur cette plateforme.';

  @override
  String get lookupUnavailable =>
      'La recherche de lieux nécessite un iPhone — il n\'y a pas de recherche cartographique sur cette plateforme.';

  @override
  String get compAccess => 'Accès à titre gracieux';

  @override
  String get code => 'Code';

  @override
  String get unlock => 'Débloquer';

  @override
  String get compChecking => 'Vérification du code…';

  @override
  String get compEnabled => 'Accès à titre gracieux activé.';

  @override
  String get compRefused =>
      'Ce code n\'a pas été reconnu, ou il a déjà été utilisé.';

  @override
  String get compTooOften =>
      'Trop de tentatives. Patientez quelques minutes et réessayez.';

  @override
  String get compUnreachable =>
      'Impossible de joindre le serveur. Vérifiez votre connexion et réessayez.';

  @override
  String get compUntrusted =>
      'Cette réponse n\'a pas pu être vérifiée, rien n\'a été débloqué.';

  @override
  String get addPlaces => 'Ajouter';

  @override
  String get fromFile => 'Depuis un fichier';

  @override
  String get fromExistingGuide => 'Depuis un guide existant';

  @override
  String get importGuideTitle => 'Ajouter à un guide existant';

  @override
  String get importGuideBody =>
      'Dans Plans, ouvrez le guide et partagez-le, puis choisissez Copier le lien. Collez-le ci-dessous et Wren lira les lieux qu\'il contient déjà.';

  @override
  String get guideLinkLabel => 'Lien du guide';

  @override
  String get readGuide => 'Lire le guide';

  @override
  String get importGuideNotALink =>
      'Ce n\'est pas le lien d\'un guide Plans. Ouvrez le guide dans Plans, partagez-le, puis choisissez Copier le lien.';

  @override
  String get importGuideNothing =>
      'Ce guide ne contient aucun lieu que Wren puisse reprendre.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lieux lus dans ce guide',
      one: '1 lieu lu dans ce guide',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lieux ne peuvent pas être repris',
      one: '1 lieu ne peut pas être repris',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lieux déjà dans ce guide',
      one: '1 lieu déjà dans ce guide',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Depuis « $name »';
  }

  @override
  String get republishTitle => 'Plans crée un nouveau guide';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple ne permet pas d\'ajouter des lieux à un guide existant. Wren en crée donc un nouveau, contenant les $count lieux.',
      one:
          'Apple ne permet pas d\'ajouter des lieux à un guide existant. Wren en crée donc un nouveau, contenant ce seul lieu.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Conservez le nouveau guide et supprimez l\'ancien.';

  @override
  String get republishKeepsPlaces =>
      'Wren garde ces lieux, vous pourrez donc recréer le guide en cas de problème.';

  @override
  String get makeCombinedGuide => 'Créer le guide combiné';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lieux lus dans ce fichier',
      one: '1 lieu lu dans ce fichier',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lignes sans nom',
      one: '1 ligne sans nom',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Aucun lieu dans ce fichier.';

  @override
  String get fileUnreadable =>
      'Wren n\'a pas pu lire ce fichier. Il lit les exports CSV, KML, KMZ, GPX, GeoJSON et Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Recherche de $done sur $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'La création du guide combiné nécessite le déblocage.';

  @override
  String get unlockCombineTitle => 'Ajouter à un guide que vous avez déjà';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren créera un seul guide contenant les $count lieux déjà présents dans le vôtre et les nouveaux.',
      one:
          'Wren créera un seul guide contenant le lieu déjà présent dans le vôtre et le nouveau.',
    );
    return '$_temp0';
  }
}

/// The translations for French, as used in Canada (`fr_CA`).
class LFrCa extends LFr {
  LFrCa() : super('fr_CA');

  @override
  String get tagline => 'C\'est un petit oiseau qui me l\'a dit.';

  @override
  String get emptyTitle => 'Des lieux, gardés.';

  @override
  String get emptyBody =>
      'Faites une saisie d\'écran de ce qu\'on vous recommande — un reel, une publication, un message, la page d\'un guide de voyage. Wren lit les noms et les place dans Plans.';

  @override
  String get emptyNote =>
      'Un lieu seul s\'ajoute à un guide que vous avez déjà. Plusieurs en créent un nouveau — Plans ne peut pas fusionner les guides.';

  @override
  String get addScreenshots => 'Ajouter des saisies d\'écran';

  @override
  String get readingShort => 'Lecture…';

  @override
  String readingProgress(int done, int total) {
    return 'Lecture de $done sur $total…';
  }

  @override
  String get addToGuide => 'Ajouter à un guide';

  @override
  String makeGuide(int count) {
    return 'Créer un guide ($count)';
  }

  @override
  String get notFoundOnMap => 'Introuvable sur la carte';

  @override
  String get tapToSearchForIt => 'Touchez pour le chercher';

  @override
  String readAs(String text) {
    return 'lu comme « $text »';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lieux sont introuvables. Touchez pour les chercher.',
      one: '1 lieu est introuvable. Touchez pour le chercher.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Où se trouvent ces lieux?';

  @override
  String get regionDetected =>
      'Lu dans les légendes. Modifiez si ce n\'est pas le bon.';

  @override
  String get regionNotDetected =>
      'Rien dans les saisies d\'écran n\'indiquait où se trouvent ces lieux. Une ville rend la recherche bien plus précise.';

  @override
  String get cityOrRegion => 'Ville ou région';

  @override
  String get cityExample => 'ex. Montréal';

  @override
  String get searchAnywhere => 'Chercher partout';

  @override
  String get findPlaces => 'Trouver les lieux';

  @override
  String searchedIn(String region) {
    return 'Recherche dans $region';
  }

  @override
  String get nameThisGuide => 'Nommer ce guide';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Il apparaîtra sous ce nom dans Plans, avec $count lieux.',
      one: 'Il apparaîtra sous ce nom dans Plans, avec 1 lieu.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Nom du guide';

  @override
  String get guideNameExample => 'ex. Rome, octobre';

  @override
  String get createGuide => 'Créer le guide';

  @override
  String get cancel => 'Annuler';

  @override
  String get guidesOfAnySize => 'Des guides sans limite';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren enregistre gratuitement jusqu\'à $limit lieux par guide. Vous en avez sélectionné $selected — soit $over de plus.';
  }

  @override
  String get onePaymentKept =>
      'Un seul paiement, acquis pour de bon. Aucun abonnement.';

  @override
  String unlockFor(String price) {
    return 'Débloquer pour $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Enregistrer plutôt les $limit premiers';
  }

  @override
  String get restorePrevious => 'Restaurer un achat antérieur';

  @override
  String get restorePurchase => 'Restaurer l\'achat';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over au-delà de la limite gratuite de $limit. Vous pouvez débloquer, ou enregistrer les $limit premiers.';
  }

  @override
  String get findThisPlace => 'Trouver ce lieu';

  @override
  String get searchAppleMaps => 'Chercher dans Plans';

  @override
  String searchInRegion(String region) {
    return 'Chercher dans $region';
  }

  @override
  String get searching => 'Recherche…';

  @override
  String get typeTwoCharacters => 'Saisissez au moins deux caractères.';

  @override
  String get nothingFound =>
      'Aucun résultat. Essayez la rue, ou un nom plus court.';

  @override
  String get rateLimited =>
      'Plans limite les recherches. Patientez un instant et réessayez.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'Plans limite les recherches — $added ajoutés jusqu\'ici, réessayez le reste dans un instant.';
  }

  @override
  String importSummary(int found) {
    return '$found trouvés';
  }

  @override
  String importSummaryIn(String region) {
    return 'à $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count à vérifier';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count illisibles';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rien de lisible dans $count saisies d\'écran',
      one: 'Rien de lisible dans cette saisie d\'écran',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Impossible d\'ouvrir Plans';

  @override
  String get checkingAppleAccount => 'Vérification de votre compte Apple…';

  @override
  String get restoredUnlocked =>
      'Restauré. Les guides sans limite sont débloqués.';

  @override
  String get noPreviousPurchase =>
      'Aucun achat antérieur trouvé sur ce compte Apple.';

  @override
  String get purchaseDidNotComplete =>
      'L\'achat n\'a pas abouti, rien n\'a été débité.';

  @override
  String alreadyInTheList(String name) {
    return '$name figurait déjà dans la liste.';
  }

  @override
  String get ocrUnavailable =>
      'La lecture des saisies d\'écran nécessite un iPhone — il n\'y a pas de reconnaissance de texte sur cette plateforme.';

  @override
  String get lookupUnavailable =>
      'La recherche de lieux nécessite un iPhone — il n\'y a pas de recherche cartographique sur cette plateforme.';

  @override
  String get compAccess => 'Accès à titre gracieux';

  @override
  String get code => 'Code';

  @override
  String get unlock => 'Débloquer';

  @override
  String get compChecking => 'Vérification du code…';

  @override
  String get compEnabled => 'Accès à titre gracieux activé.';

  @override
  String get compRefused =>
      'Ce code n\'a pas été reconnu, ou il a déjà été utilisé.';

  @override
  String get compTooOften =>
      'Trop de tentatives. Patientez quelques minutes et réessayez.';

  @override
  String get compUnreachable =>
      'Impossible de joindre le serveur. Vérifiez votre connexion et réessayez.';

  @override
  String get compUntrusted =>
      'Cette réponse n\'a pas pu être vérifiée, rien n\'a été débloqué.';

  @override
  String get addPlaces => 'Ajouter';

  @override
  String get fromFile => 'Depuis un fichier';

  @override
  String get fromExistingGuide => 'Depuis un guide existant';

  @override
  String get importGuideTitle => 'Ajouter à un guide existant';

  @override
  String get importGuideBody =>
      'Dans Plans, ouvrez le guide et partagez-le, puis choisissez Copier le lien. Collez-le ci-dessous et Wren lira les lieux qu\'il contient déjà.';

  @override
  String get guideLinkLabel => 'Lien du guide';

  @override
  String get readGuide => 'Lire le guide';

  @override
  String get importGuideNotALink =>
      'Ce n\'est pas le lien d\'un guide Plans. Ouvrez le guide dans Plans, partagez-le, puis choisissez Copier le lien.';

  @override
  String get importGuideNothing =>
      'Ce guide ne contient aucun lieu que Wren puisse reprendre.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lieux lus dans ce guide',
      one: '1 lieu lu dans ce guide',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lieux ne peuvent pas être repris',
      one: '1 lieu ne peut pas être repris',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lieux déjà dans ce guide',
      one: '1 lieu déjà dans ce guide',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'Depuis « $name »';
  }

  @override
  String get republishTitle => 'Plans crée un nouveau guide';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Apple ne permet pas d\'ajouter des lieux à un guide existant. Wren en crée donc un nouveau, contenant les $count lieux.',
      one:
          'Apple ne permet pas d\'ajouter des lieux à un guide existant. Wren en crée donc un nouveau, contenant ce seul lieu.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete =>
      'Gardez le nouveau guide et supprimez l\'ancien.';

  @override
  String get republishKeepsPlaces =>
      'Wren garde ces lieux, vous pourrez donc recréer le guide en cas de problème.';

  @override
  String get makeCombinedGuide => 'Créer le guide combiné';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lieux lus dans ce fichier',
      one: '1 lieu lu dans ce fichier',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lignes sans nom',
      one: '1 ligne sans nom',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Aucun lieu dans ce fichier.';

  @override
  String get fileUnreadable =>
      'Wren n\'a pas pu lire ce fichier. Il lit les exportations CSV, KML, KMZ, GPX, GeoJSON et Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Recherche de $done sur $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'La création du guide combiné demande le déblocage.';

  @override
  String get unlockCombineTitle => 'Ajouter à un guide que vous avez déjà';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wren créera un seul guide regroupant les $count lieux déjà présents dans le vôtre et les nouveaux.',
      one:
          'Wren créera un seul guide regroupant le lieu déjà présent dans le vôtre et le nouveau.',
    );
    return '$_temp0';
  }
}
