// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class LPt extends L {
  LPt([String locale = 'pt']) : super(locale);

  @override
  String get tagline => 'Um passarinho me contou.';

  @override
  String get emptyTitle => 'Lugares, guardados.';

  @override
  String get emptyBody =>
      'Tire uma captura de tela do que te recomendarem — um reel, um post, uma mensagem, a página de um guia de viagem. O Wren lê os nomes e coloca tudo no Mapas.';

  @override
  String get emptyNote =>
      'Um lugar sozinho entra em um guia que você já tem. Vários criam um novo — o Mapas não consegue juntar guias.';

  @override
  String get addScreenshots => 'Adicionar capturas';

  @override
  String get readingShort => 'Lendo…';

  @override
  String readingProgress(int done, int total) {
    return 'Lendo $done de $total…';
  }

  @override
  String get addToGuide => 'Adicionar a um guia';

  @override
  String makeGuide(int count) {
    return 'Criar um guia ($count)';
  }

  @override
  String get notFoundOnMap => 'Não encontrado no mapa';

  @override
  String get tapToSearchForIt => 'Toque para procurar';

  @override
  String readAs(String text) {
    return 'lido como “$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares não foram encontrados. Toque para procurar.',
      one: '1 lugar não foi encontrado. Toque para procurar.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Onde ficam esses lugares?';

  @override
  String get regionDetected => 'Lido nas legendas. Mude se não estiver certo.';

  @override
  String get regionNotDetected =>
      'Nas capturas não dizia onde eles ficam. Com uma cidade a busca fica bem mais precisa.';

  @override
  String get cityOrRegion => 'Cidade ou região';

  @override
  String get cityExample => 'ex.: São Paulo';

  @override
  String get searchAnywhere => 'Buscar em qualquer lugar';

  @override
  String get findPlaces => 'Encontrar lugares';

  @override
  String searchedIn(String region) {
    return 'Buscado em $region';
  }

  @override
  String get nameThisGuide => 'Dê um nome a este guia';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ele vai aparecer com este nome no Mapas, com $count lugares.',
      one: 'Ele vai aparecer com este nome no Mapas, com 1 lugar.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Nome do guia';

  @override
  String get guideNameExample => 'ex.: Roma, outubro';

  @override
  String get createGuide => 'Criar guia';

  @override
  String get cancel => 'Cancelar';

  @override
  String get guidesOfAnySize => 'Guias de qualquer tamanho';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'O Wren salva até $limit lugares por guia de graça. Você selecionou $selected: $over a mais.';
  }

  @override
  String get onePaymentKept =>
      'Um pagamento só, seu para sempre. Sem assinatura.';

  @override
  String unlockFor(String price) {
    return 'Desbloquear por $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Salvar só os $limit primeiros';
  }

  @override
  String get restorePrevious => 'Restaurar uma compra anterior';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over acima do limite gratuito de $limit. Você pode desbloquear ou salvar os $limit primeiros.';
  }

  @override
  String get findThisPlace => 'Encontrar este lugar';

  @override
  String get searchAppleMaps => 'Buscar no Mapas';

  @override
  String searchInRegion(String region) {
    return 'Buscar em $region';
  }

  @override
  String get searching => 'Buscando…';

  @override
  String get typeTwoCharacters => 'Digite pelo menos dois caracteres.';

  @override
  String get nothingFound =>
      'Nada encontrado. Tente a rua ou um nome mais curto.';

  @override
  String get rateLimited =>
      'O Mapas está limitando as buscas. Espere um momento e tente de novo.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'O Mapas está limitando as buscas — $added adicionados até agora, tente o resto daqui a pouco.';
  }

  @override
  String importSummary(int found) {
    return '$found encontrados';
  }

  @override
  String importSummaryIn(String region) {
    return 'em $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count para conferir';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count ilegíveis';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nada legível em $count capturas',
      one: 'Nada legível nessa captura',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Não foi possível abrir o Mapas';

  @override
  String get checkingAppleAccount => 'Verificando sua Conta Apple…';

  @override
  String get restoredUnlocked =>
      'Restaurado. Guias de qualquer tamanho estão desbloqueados.';

  @override
  String get noPreviousPurchase =>
      'Nenhuma compra anterior encontrada nesta Conta Apple.';

  @override
  String get purchaseDidNotComplete =>
      'A compra não foi concluída, então nada foi cobrado.';

  @override
  String alreadyInTheList(String name) {
    return '$name já estava na lista.';
  }

  @override
  String get ocrUnavailable =>
      'Para ler capturas é preciso um iPhone: nesta plataforma não há reconhecimento de texto.';

  @override
  String get lookupUnavailable =>
      'Para buscar lugares é preciso um iPhone: nesta plataforma não há busca em mapas.';

  @override
  String get compAccess => 'Acesso de cortesia';

  @override
  String get code => 'Código';

  @override
  String get unlock => 'Desbloquear';

  @override
  String get compChecking => 'Verificando esse código…';

  @override
  String get compEnabled => 'Acesso de cortesia ativado.';

  @override
  String get compRefused => 'Esse código não foi reconhecido, ou já foi usado.';

  @override
  String get compTooOften =>
      'Tentativas demais. Espere alguns minutos e tente de novo.';

  @override
  String get compUnreachable =>
      'Não foi possível conectar ao servidor. Verifique sua conexão e tente de novo.';

  @override
  String get compUntrusted =>
      'Não foi possível verificar essa resposta, então nada foi desbloqueado.';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class LPtPt extends LPt {
  LPtPt() : super('pt_PT');

  @override
  String get tagline => 'Disse-me um passarinho.';

  @override
  String get emptyTitle => 'Lugares, guardados.';

  @override
  String get emptyBody =>
      'Faça uma captura de ecrã do que lhe recomendarem — um reel, uma publicação, uma mensagem, a página de um guia de viagem. O Wren lê os nomes e coloca-os no Mapas.';

  @override
  String get emptyNote =>
      'Um lugar sozinho junta-se a um guia que já tem. Vários criam um novo — o Mapas não consegue juntar guias.';

  @override
  String get addScreenshots => 'Adicionar capturas de ecrã';

  @override
  String get readingShort => 'A ler…';

  @override
  String readingProgress(int done, int total) {
    return 'A ler $done de $total…';
  }

  @override
  String get addToGuide => 'Adicionar a um guia';

  @override
  String makeGuide(int count) {
    return 'Criar um guia ($count)';
  }

  @override
  String get notFoundOnMap => 'Não encontrado no mapa';

  @override
  String get tapToSearchForIt => 'Toque para o procurar';

  @override
  String readAs(String text) {
    return 'lido como «$text»';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares não foram encontrados. Toque para os procurar.',
      one: '1 lugar não foi encontrado. Toque para o procurar.',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'Onde ficam estes lugares?';

  @override
  String get regionDetected =>
      'Lido nas legendas. Altere se não estiver correto.';

  @override
  String get regionNotDetected =>
      'Nas capturas de ecrã não dizia onde ficam. Com uma cidade a pesquisa fica muito mais precisa.';

  @override
  String get cityOrRegion => 'Cidade ou região';

  @override
  String get cityExample => 'p. ex. Lisboa';

  @override
  String get searchAnywhere => 'Pesquisar em todo o lado';

  @override
  String get findPlaces => 'Encontrar lugares';

  @override
  String searchedIn(String region) {
    return 'Pesquisado em $region';
  }

  @override
  String get nameThisGuide => 'Dê um nome a este guia';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vai aparecer com este nome no Mapas, com $count lugares.',
      one: 'Vai aparecer com este nome no Mapas, com 1 lugar.',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'Nome do guia';

  @override
  String get guideNameExample => 'p. ex. Roma, outubro';

  @override
  String get createGuide => 'Criar guia';

  @override
  String get cancel => 'Cancelar';

  @override
  String get guidesOfAnySize => 'Guias de qualquer tamanho';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'O Wren guarda até $limit lugares por guia gratuitamente. Selecionou $selected: $over a mais.';
  }

  @override
  String get onePaymentKept =>
      'Um único pagamento, seu para sempre. Sem subscrição.';

  @override
  String unlockFor(String price) {
    return 'Desbloquear por $price';
  }

  @override
  String saveFirstInstead(int limit) {
    return 'Guardar apenas os $limit primeiros';
  }

  @override
  String get restorePrevious => 'Restaurar uma compra anterior';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String overFreeLimit(int over, int limit) {
    return '$over acima do limite gratuito de $limit. Pode desbloquear ou guardar os $limit primeiros.';
  }

  @override
  String get findThisPlace => 'Encontrar este lugar';

  @override
  String get searchAppleMaps => 'Pesquisar no Mapas';

  @override
  String searchInRegion(String region) {
    return 'Pesquisar em $region';
  }

  @override
  String get searching => 'A pesquisar…';

  @override
  String get typeTwoCharacters => 'Escreva pelo menos dois caracteres.';

  @override
  String get nothingFound =>
      'Nada encontrado. Tente a rua ou um nome mais curto.';

  @override
  String get rateLimited =>
      'O Mapas está a limitar as pesquisas. Aguarde um momento e tente novamente.';

  @override
  String rateLimitedDuringImport(int added) {
    return 'O Mapas está a limitar as pesquisas — $added adicionados até agora, tente os restantes daqui a pouco.';
  }

  @override
  String importSummary(int found) {
    return '$found encontrados';
  }

  @override
  String importSummaryIn(String region) {
    return 'em $region';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count por verificar';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count ilegíveis';
  }

  @override
  String nothingReadable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nada legível em $count capturas de ecrã',
      one: 'Nada legível nessa captura de ecrã',
    );
    return '$_temp0';
  }

  @override
  String get couldNotOpenMaps => 'Não foi possível abrir o Mapas';

  @override
  String get checkingAppleAccount => 'A verificar a sua Conta Apple…';

  @override
  String get restoredUnlocked =>
      'Restaurado. Os guias de qualquer tamanho estão desbloqueados.';

  @override
  String get noPreviousPurchase =>
      'Não foi encontrada nenhuma compra anterior nesta Conta Apple.';

  @override
  String get purchaseDidNotComplete =>
      'A compra não foi concluída, por isso não foi cobrado nada.';

  @override
  String alreadyInTheList(String name) {
    return '$name já estava na lista.';
  }

  @override
  String get ocrUnavailable =>
      'Para ler capturas de ecrã é preciso um iPhone: nesta plataforma não há reconhecimento de texto.';

  @override
  String get lookupUnavailable =>
      'Para procurar lugares é preciso um iPhone: nesta plataforma não há pesquisa em mapas.';

  @override
  String get compAccess => 'Acesso de cortesia';

  @override
  String get code => 'Código';

  @override
  String get unlock => 'Desbloquear';

  @override
  String get compChecking => 'A verificar esse código…';

  @override
  String get compEnabled => 'Acesso de cortesia ativado.';

  @override
  String get compRefused =>
      'Esse código não foi reconhecido ou já foi utilizado.';

  @override
  String get compTooOften =>
      'Demasiadas tentativas. Aguarde alguns minutos e tente novamente.';

  @override
  String get compUnreachable =>
      'Não foi possível contactar o servidor. Verifique a sua ligação e tente novamente.';

  @override
  String get compUntrusted =>
      'Não foi possível verificar essa resposta, por isso não foi desbloqueado nada.';
}
