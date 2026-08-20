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
  String get emptyBodyAndroid =>
      'Open a list of places you already keep — a file exported from another map app, or a Google Takeout archive. CSV, KML, KMZ, GPX and GeoJSON are all read.';

  @override
  String get emptyNoteAndroid =>
      'Nothing leaves until you have looked at it. Wren then hands the list to a map app on the phone.';

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

  @override
  String get addPlaces => 'Adicionar';

  @override
  String get fromFile => 'De um arquivo';

  @override
  String get fromExistingGuide => 'De um guia existente';

  @override
  String get importGuideTitle => 'Adicionar a um guia existente';

  @override
  String get importGuideBody =>
      'No Mapas, abra o guia e compartilhe, depois escolha Copiar link. Cole o link abaixo e o Wren vai ler os lugares que ele já tem.';

  @override
  String get guideLinkLabel => 'Link do guia';

  @override
  String get readGuide => 'Ler o guia';

  @override
  String get importGuideNotALink =>
      'Esse não é o link de um guia do Mapas. Abra o guia no Mapas, compartilhe e escolha Copiar link.';

  @override
  String get importGuideNothing =>
      'Esse guia não tem nenhum lugar que o Wren consiga usar.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares lidos desse guia',
      one: '1 lugar lido desse guia',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares não podem ser levados para o novo guia',
      one: '1 lugar não pode ser levado para o novo guia',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares já estão neste guia',
      one: '1 lugar já está neste guia',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'De “$name”';
  }

  @override
  String get republishTitle => 'O Mapas cria um guia novo';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'A Apple não deixa acrescentar lugares a um guia que já existe, então o Wren vai criar um novo com todos os $count lugares.',
      one:
          'A Apple não deixa acrescentar lugares a um guia que já existe, então o Wren vai criar um novo com esse lugar.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Fique com o guia novo e apague o antigo.';

  @override
  String get republishKeepsPlaces =>
      'O Wren guarda esses lugares, então você pode criar o guia de novo se algo der errado.';

  @override
  String get makeCombinedGuide => 'Criar o guia combinado';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares lidos desse arquivo',
      one: '1 lugar lido desse arquivo',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linhas sem nome',
      one: '1 linha sem nome',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Nenhum lugar nesse arquivo.';

  @override
  String get fileUnreadable =>
      'O Wren não conseguiu ler esse arquivo. Ele lê exportações em CSV, KML, KMZ, GPX, GeoJSON e Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'Buscando $done de $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'Criar o guia combinado precisa do desbloqueio.';

  @override
  String get unlockCombineTitle => 'Adicionar a um guia que você já tem';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'O Wren vai criar um único guia com os $count lugares que já estão no seu e com os novos.',
      one:
          'O Wren vai criar um único guia com o lugar que já está no seu e com o novo.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Também lê uma lista exportada de outro app: CSV, KML, KMZ, GPX, GeoJSON ou Google Takeout.';

  @override
  String get clearList => 'Limpar a lista';

  @override
  String get clearListTitle => 'Limpar a lista';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Remover do Wren todos os $count lugares? Os guias que você já criou no Mapas não são afetados.',
      one:
          'Remover do Wren o único lugar? Os guias que você já criou no Mapas não são afetados.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Remover';

  @override
  String get listCleared => 'Lista limpa.';

  @override
  String get expandingLink => 'Lendo esse link…';

  @override
  String get linkUnreachable =>
      'Não foi possível conectar à Apple para ler esse link. Verifique sua conexão e tente de novo.';

  @override
  String get splitTitle => 'Isso vai criar mais de um guia';

  @override
  String splitBody(int guides, int count) {
    return 'A Apple limita quantos lugares o link de um guia pode levar. O Wren vai criar $guides guias, numerados para ficarem em ordem, com $count lugares entre eles.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Criar $guides guias';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Guia $done de $total aberto. Toque para criar o próximo.';
  }

  @override
  String get sendPlacesTo => 'Enviar lugares para';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares prontos para enviar',
      one: '1 lugar pronto para enviar',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares não têm localização e não podem ser enviados',
      one: '1 lugar não tem localização e não pode ser enviado',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Outro app';

  @override
  String get sendPlacesFailed => 'Esse app não aceitou o arquivo';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count lugares mantidos do arquivo, prontos para outro app de mapas',
      one: '1 lugar mantido do arquivo, pronto para outro app de mapas',
    );
    return '$_temp0';
  }
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

  @override
  String get addPlaces => 'Adicionar';

  @override
  String get fromFile => 'De um ficheiro';

  @override
  String get fromExistingGuide => 'De um guia existente';

  @override
  String get importGuideTitle => 'Adicionar a um guia existente';

  @override
  String get importGuideBody =>
      'No Mapas, abra o guia e partilhe-o, depois escolha Copiar hiperligação. Cole-a abaixo e o Wren vai ler os lugares que ele já tem.';

  @override
  String get guideLinkLabel => 'Hiperligação do guia';

  @override
  String get readGuide => 'Ler o guia';

  @override
  String get importGuideNotALink =>
      'Esta não é a hiperligação de um guia do Mapas. Abra o guia no Mapas, partilhe-o e escolha Copiar hiperligação.';

  @override
  String get importGuideNothing =>
      'Esse guia não tem nenhum lugar que o Wren consiga usar.';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares lidos desse guia',
      one: '1 lugar lido desse guia',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares não podem passar para o novo guia',
      one: '1 lugar não pode passar para o novo guia',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares já estão neste guia',
      one: '1 lugar já está neste guia',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return 'De «$name»';
  }

  @override
  String get republishTitle => 'O Mapas cria um guia novo';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'A Apple não permite acrescentar lugares a um guia que já existe, por isso o Wren vai criar um novo com todos os $count lugares.',
      one:
          'A Apple não permite acrescentar lugares a um guia que já existe, por isso o Wren vai criar um novo com esse lugar.',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => 'Fique com o guia novo e elimine o antigo.';

  @override
  String get republishKeepsPlaces =>
      'O Wren guarda estes lugares, por isso pode criar o guia outra vez se algo correr mal.';

  @override
  String get makeCombinedGuide => 'Criar o guia combinado';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares lidos desse ficheiro',
      one: '1 lugar lido desse ficheiro',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linhas sem nome',
      one: '1 linha sem nome',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'Nenhum lugar nesse ficheiro.';

  @override
  String get fileUnreadable =>
      'O Wren não conseguiu ler esse ficheiro. Lê exportações em CSV, KML, KMZ, GPX, GeoJSON e Google Takeout.';

  @override
  String lookingUpProgress(int done, int total) {
    return 'A pesquisar $done de $total…';
  }

  @override
  String get combineNeedsUnlock =>
      'Criar o guia combinado requer o desbloqueio.';

  @override
  String get unlockCombineTitle => 'Adicionar a um guia que já tem';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'O Wren vai criar um único guia com os $count lugares que já estão no seu e com os novos.',
      one:
          'O Wren vai criar um único guia com o lugar que já está no seu e com o novo.',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      'Também lê uma lista exportada de outra app: CSV, KML, KMZ, GPX, GeoJSON ou Google Takeout.';

  @override
  String get clearList => 'Limpar a lista';

  @override
  String get clearListTitle => 'Limpar a lista';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Remover do Wren todos os $count lugares? Os guias já criados no Mapas não são afetados.',
      one:
          'Remover do Wren o único lugar? Os guias já criados no Mapas não são afetados.',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => 'Remover';

  @override
  String get listCleared => 'Lista limpa.';

  @override
  String get expandingLink => 'A ler essa hiperligação…';

  @override
  String get linkUnreachable =>
      'Não foi possível contactar a Apple para ler essa hiperligação. Verifique a sua ligação e tente novamente.';

  @override
  String get splitTitle => 'Isto vai criar mais do que um guia';

  @override
  String splitBody(int guides, int count) {
    return 'A Apple limita quantos lugares a hiperligação de um guia pode levar. O Wren vai criar $guides guias, numerados para ficarem em ordem, com $count lugares entre eles.';
  }

  @override
  String splitConfirm(int guides) {
    return 'Criar $guides guias';
  }

  @override
  String splitProgress(int done, int total) {
    return 'Guia $done de $total aberto. Toque para criar o seguinte.';
  }

  @override
  String get sendPlacesTo => 'Enviar locais para';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count locais prontos a enviar',
      one: '1 local pronto a enviar',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count locais não têm localização e não podem ser enviados',
      one: '1 local não tem localização e não pode ser enviado',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'Outra aplicação';

  @override
  String get sendPlacesFailed => 'Essa aplicação não aceitou o ficheiro';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count locais mantidos do ficheiro, prontos para outra aplicação de mapas',
      one: '1 local mantido do ficheiro, pronto para outra aplicação de mapas',
    );
    return '$_temp0';
  }
}
