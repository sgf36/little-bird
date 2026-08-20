// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class LJa extends L {
  LJa([String locale = 'ja']) : super(locale);

  @override
  String get tagline => '小鳥が教えてくれました。';

  @override
  String get emptyTitle => '場所を、とっておく。';

  @override
  String get emptyBody =>
      'すすめられたものをスクリーンショットで撮るだけ。リール、投稿、メッセージ、ガイドブックのページ。Wrenが名前を読み取って、マップに登録します。';

  @override
  String get emptyNote =>
      '1件なら、すでにあるガイドに追加できます。複数だと新しいガイドになります — マップはガイドを結合できません。';

  @override
  String get addScreenshots => 'スクリーンショットを追加';

  @override
  String get readingShort => '読み取り中…';

  @override
  String readingProgress(int done, int total) {
    return '$total件中$done件を読み取り中…';
  }

  @override
  String get addToGuide => 'ガイドに追加';

  @override
  String makeGuide(int count) {
    return 'ガイドを作成（$count件）';
  }

  @override
  String get notFoundOnMap => 'マップで見つかりませんでした';

  @override
  String get tapToSearchForIt => 'タップして検索';

  @override
  String readAs(String text) {
    return '読み取り結果：「$text」';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件が見つかりませんでした。タップして検索してください。',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => 'これらの場所はどこですか？';

  @override
  String get regionDetected => 'キャプションから読み取りました。違う場合は変更してください。';

  @override
  String get regionNotDetected =>
      'スクリーンショットには場所の記載がありませんでした。都市を入力すると検索精度が大きく上がります。';

  @override
  String get cityOrRegion => '都市または地域';

  @override
  String get cityExample => '例：東京';

  @override
  String get searchAnywhere => 'すべての地域で検索';

  @override
  String get findPlaces => '場所を検索';

  @override
  String searchedIn(String region) {
    return '$regionで検索しました';
  }

  @override
  String get nameThisGuide => 'ガイドに名前を付ける';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'この名前でマップに表示されます。$count件の場所が含まれます。',
    );
    return '$_temp0';
  }

  @override
  String get guideName => 'ガイド名';

  @override
  String get guideNameExample => '例：ローマ、10月';

  @override
  String get createGuide => 'ガイドを作成';

  @override
  String get cancel => 'キャンセル';

  @override
  String get guidesOfAnySize => '件数無制限のガイド';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wrenは1つのガイドに$limit件まで無料で保存できます。現在$selected件を選択中で、$over件超えています。';
  }

  @override
  String get onePaymentKept => '買い切り、ずっと使えます。サブスクリプションではありません。';

  @override
  String unlockFor(String price) {
    return '$priceでロック解除';
  }

  @override
  String saveFirstInstead(int limit) {
    return '代わりに最初の$limit件を保存';
  }

  @override
  String get restorePrevious => '以前の購入を復元';

  @override
  String get restorePurchase => '購入を復元';

  @override
  String overFreeLimit(int over, int limit) {
    return '無料の上限$limit件を$over件超えています。ロックを解除するか、最初の$limit件を保存できます。';
  }

  @override
  String get findThisPlace => 'この場所を検索';

  @override
  String get searchAppleMaps => 'マップで検索';

  @override
  String searchInRegion(String region) {
    return '$regionで検索';
  }

  @override
  String get searching => '検索中…';

  @override
  String get typeTwoCharacters => '2文字以上入力してください。';

  @override
  String get nothingFound => '見つかりませんでした。通り名や、短い名前で試してください。';

  @override
  String get rateLimited => 'マップが検索を制限しています。少し待ってからもう一度お試しください。';

  @override
  String rateLimitedDuringImport(int added) {
    return 'マップが検索を制限しています — これまでに$added件追加しました。残りは少し後でお試しください。';
  }

  @override
  String importSummary(int found) {
    return '$found件見つかりました';
  }

  @override
  String importSummaryIn(String region) {
    return '（$region）';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count件は要確認';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count件は読み取れず';
  }

  @override
  String nothingReadable(int count) {
    return '$count件のスクリーンショットから何も読み取れませんでした';
  }

  @override
  String get couldNotOpenMaps => 'マップを開けませんでした';

  @override
  String get checkingAppleAccount => 'Appleアカウントを確認中…';

  @override
  String get restoredUnlocked => '復元しました。件数無制限のガイドが使えます。';

  @override
  String get noPreviousPurchase => 'このAppleアカウントに以前の購入は見つかりませんでした。';

  @override
  String get purchaseDidNotComplete => '購入は完了しなかったため、料金は発生していません。';

  @override
  String alreadyInTheList(String name) {
    return '「$name」はすでにリストにありました。';
  }

  @override
  String get ocrUnavailable =>
      'スクリーンショットの読み取りにはiPhoneが必要です — このプラットフォームにはテキスト認識がありません。';

  @override
  String get lookupUnavailable =>
      '場所の検索にはiPhoneが必要です — このプラットフォームにはマップ検索がありません。';

  @override
  String get compAccess => '無料アクセス';

  @override
  String get code => 'コード';

  @override
  String get unlock => 'ロック解除';

  @override
  String get compChecking => 'コードを確認中…';

  @override
  String get compEnabled => '無料アクセスを有効にしました。';

  @override
  String get compRefused => 'そのコードは認識されないか、すでに使用されています。';

  @override
  String get compTooOften => '試行回数が多すぎます。数分待ってからもう一度お試しください。';

  @override
  String get compUnreachable => 'サーバーに接続できませんでした。接続を確認してもう一度お試しください。';

  @override
  String get compUntrusted => '応答を検証できなかったため、何もロック解除されませんでした。';

  @override
  String get addPlaces => '追加';

  @override
  String get fromFile => 'ファイルから';

  @override
  String get fromExistingGuide => '既存のガイドから';

  @override
  String get importGuideTitle => '既存のガイドに追加';

  @override
  String get importGuideBody =>
      'マップでそのガイドを開いて共有し、「リンクをコピー」を選びます。下に貼り付けると、Wrenがそのガイドにある場所を読み取ります。';

  @override
  String get guideLinkLabel => 'ガイドのリンク';

  @override
  String get readGuide => 'ガイドを読み取る';

  @override
  String get importGuideNotALink =>
      'マップのガイドのリンクではありません。マップでガイドを開いて共有し、「リンクをコピー」を選んでください。';

  @override
  String get importGuideNothing => 'そのガイドには、Wrenが追加できるものがありません。';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'そのガイドから$count件を読み取りました',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'そのうち$count件は引き継げません',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件はすでにこのガイドにあります',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '「$name」から';
  }

  @override
  String get republishTitle => 'マップは新しいガイドを作ります';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Appleは既存のガイドに追加する方法を用意していないため、Wrenが$count件の場所をまとめた新しいガイドを作ります。',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => '新しいガイドを残して、古いガイドを削除してください。';

  @override
  String get republishKeepsPlaces =>
      'Wrenはこれらの場所を保持するので、うまくいかなかった場合はもう一度ガイドを作れます。';

  @override
  String get makeCombinedGuide => 'まとめたガイドを作成';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'そのファイルから$count件を読み取りました',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count行に名前がありませんでした',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => 'そのファイルには場所がありません。';

  @override
  String get fileUnreadable =>
      'Wrenはそのファイルを読み取れませんでした。CSV、KML、KMZ、GPX、GeoJSON、Google Takeoutの書き出しに対応しています。';

  @override
  String lookingUpProgress(int done, int total) {
    return '$total件中$done件を検索中…';
  }

  @override
  String get combineNeedsUnlock => 'まとめたガイドの作成にはロック解除が必要です。';

  @override
  String get unlockCombineTitle => 'すでにあるガイドに追加';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wrenが、お持ちのガイドにある$count件の場所と新しく見つけた場所をまとめて、1つのガイドを作ります。',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      '他のアプリから書き出したリストも読み取れます：CSV、KML、KMZ、GPX、GeoJSON、Google Takeout。';

  @override
  String get clearList => 'リストを空にする';

  @override
  String get clearListTitle => 'リストを空にする';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の場所をWrenから削除しますか？マップですでに作ったガイドには影響しません。',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => '消去';

  @override
  String get listCleared => 'リストを空にしました。';

  @override
  String get expandingLink => 'リンクを読み取り中…';

  @override
  String get linkUnreachable =>
      'リンクを読み取るためにAppleに接続できませんでした。接続を確認してもう一度お試しください。';

  @override
  String get splitTitle => 'ガイドは複数に分かれます';

  @override
  String splitBody(int guides, int count) {
    return '1つのガイドのリンクに入れられる場所の数はAppleによって制限されています。Wrenが$guides個のガイドを作り、順番が保たれるよう番号を付けて、合わせて$count件の場所を収めます。';
  }

  @override
  String splitConfirm(int guides) {
    return '$guides個のガイドを作成';
  }

  @override
  String splitProgress(int done, int total) {
    return '$total個中$done個目のガイドを開きました。タップして次を作成します。';
  }

  @override
  String get sendPlacesTo => '場所の送信先';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の場所を送信できます',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の場所に位置情報がなく、送信できません',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => 'ほかのアプリ';

  @override
  String get sendPlacesFailed => 'そのアプリはファイルを受け取りませんでした';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ファイルから$count件の場所を保持しました。ほかの地図アプリに送信できます',
    );
    return '$_temp0';
  }
}
