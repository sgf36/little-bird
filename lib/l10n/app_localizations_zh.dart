// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class LZh extends L {
  LZh([String locale = 'zh']) : super(locale);

  @override
  String get tagline => '一只小鸟告诉我的。';

  @override
  String get emptyTitle => '地方，收着。';

  @override
  String get emptyBody =>
      '把别人推荐给你的东西截个图 — 一条 Reel、一个帖子、一条消息、旅行指南的一页。Wren 会读出名字，放进地图。';

  @override
  String get emptyNote => '单个地点会加进你已有的指南。多个地点会新建一个 — 地图无法合并指南。';

  @override
  String get addScreenshots => '添加截屏';

  @override
  String get readingShort => '读取中…';

  @override
  String readingProgress(int done, int total) {
    return '正在读取第 $done 张，共 $total 张…';
  }

  @override
  String get addToGuide => '添加到指南';

  @override
  String makeGuide(int count) {
    return '创建指南（$count）';
  }

  @override
  String get notFoundOnMap => '地图上没找到';

  @override
  String get tapToSearchForIt => '轻点以搜索';

  @override
  String readAs(String text) {
    return '读作“$text”';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '有 $count 个地点没找到。轻点以搜索。',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => '这些地方在哪里？';

  @override
  String get regionDetected => '从图片说明中读出。不对的话请修改。';

  @override
  String get regionNotDetected => '截屏里没有说明这些地方在哪里。填上城市，搜索会准确得多。';

  @override
  String get cityOrRegion => '城市或地区';

  @override
  String get cityExample => '例如：上海';

  @override
  String get searchAnywhere => '全球搜索';

  @override
  String get findPlaces => '查找地点';

  @override
  String searchedIn(String region) {
    return '已在$region搜索';
  }

  @override
  String get nameThisGuide => '给这个指南起个名字';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '它会以这个名字出现在地图里，包含 $count 个地点。',
    );
    return '$_temp0';
  }

  @override
  String get guideName => '指南名称';

  @override
  String get guideNameExample => '例如：罗马，十月';

  @override
  String get createGuide => '创建指南';

  @override
  String get cancel => '取消';

  @override
  String get guidesOfAnySize => '不限数量的指南';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren 免费为一个指南保存最多 $limit 个地点。你选了 $selected 个，多出 $over 个。';
  }

  @override
  String get onePaymentKept => '一次付费，永久保留。不是订阅。';

  @override
  String unlockFor(String price) {
    return '$price 解锁';
  }

  @override
  String saveFirstInstead(int limit) {
    return '改为保存前 $limit 个';
  }

  @override
  String get restorePrevious => '恢复以前的购买';

  @override
  String get restorePurchase => '恢复购买';

  @override
  String overFreeLimit(int over, int limit) {
    return '超出免费上限 $limit 个共 $over 个。你可以解锁，也可以只保存前 $limit 个。';
  }

  @override
  String get findThisPlace => '查找这个地点';

  @override
  String get searchAppleMaps => '在地图中搜索';

  @override
  String searchInRegion(String region) {
    return '在$region搜索';
  }

  @override
  String get searching => '搜索中…';

  @override
  String get typeTwoCharacters => '请至少输入两个字符。';

  @override
  String get nothingFound => '什么都没找到。试试街道名，或者更短的名字。';

  @override
  String get rateLimited => '地图正在限制搜索次数。稍等片刻再试。';

  @override
  String rateLimitedDuringImport(int added) {
    return '地图正在限制搜索次数 — 目前已添加 $added 个，其余的稍后再试。';
  }

  @override
  String importSummary(int found) {
    return '找到 $found 个';
  }

  @override
  String importSummaryIn(String region) {
    return '（$region）';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count 个需要确认';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count 个无法读取';
  }

  @override
  String nothingReadable(int count) {
    return '$count 张截屏里没有可读的内容';
  }

  @override
  String get couldNotOpenMaps => '无法打开地图';

  @override
  String get checkingAppleAccount => '正在检查你的 Apple 账户…';

  @override
  String get restoredUnlocked => '已恢复。不限数量的指南已解锁。';

  @override
  String get noPreviousPurchase => '这个 Apple 账户上没有找到以前的购买。';

  @override
  String get purchaseDidNotComplete => '购买没有完成，所以没有扣款。';

  @override
  String alreadyInTheList(String name) {
    return '“$name”已经在列表里了。';
  }

  @override
  String get ocrUnavailable => '读取截屏需要 iPhone — 这个平台上没有文字识别。';

  @override
  String get lookupUnavailable => '查找地点需要 iPhone — 这个平台上没有地图搜索。';

  @override
  String get compAccess => '免费使用权限';

  @override
  String get code => '代码';

  @override
  String get unlock => '解锁';

  @override
  String get compChecking => '正在检查这个代码…';

  @override
  String get compEnabled => '已开启免费使用权限。';

  @override
  String get compRefused => '无法识别这个代码，或者它已经用过了。';

  @override
  String get compTooOften => '尝试次数太多。等几分钟再试。';

  @override
  String get compUnreachable => '无法连接服务器。检查你的网络连接，然后再试。';

  @override
  String get compUntrusted => '无法验证服务器的回复，所以没有解锁任何内容。';

  @override
  String get addPlaces => '添加';

  @override
  String get fromFile => '从文件';

  @override
  String get fromExistingGuide => '从已有的指南';

  @override
  String get importGuideTitle => '添加到已有的指南';

  @override
  String get importGuideBody =>
      '在地图里打开那个指南并共享，然后选择“拷贝链接”。粘贴到下面，Wren 会读出它已经收着的地点。';

  @override
  String get guideLinkLabel => '指南链接';

  @override
  String get readGuide => '读取指南';

  @override
  String get importGuideNotALink => '这不是地图指南的链接。在地图里打开指南并共享，然后选择“拷贝链接”。';

  @override
  String get importGuideNothing => '那个指南里没有 Wren 能添加的东西。';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '从那个指南读出 $count 个地点',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '其中 $count 个地点无法转移过来',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个地点已经在这个指南里',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '来自“$name”';
  }

  @override
  String get republishTitle => '地图会新建一个指南';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Apple 没有提供往已有指南里添加地点的办法，所以 Wren 会新建一个，收下这 $count 个地点。',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => '留下新指南，删掉旧的。';

  @override
  String get republishKeepsPlaces => 'Wren 会保留这些地点，万一出了问题，你可以再做一次指南。';

  @override
  String get makeCombinedGuide => '创建合并后的指南';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '从那个文件读出 $count 个地点',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '有 $count 行没有名字',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => '那个文件里没有地点。';

  @override
  String get fileUnreadable =>
      'Wren 读不了那个文件。它能读 CSV、KML、KMZ、GPX、GeoJSON 和 Google Takeout 导出的文件。';

  @override
  String lookingUpProgress(int done, int total) {
    return '正在查找第 $done 个，共 $total 个…';
  }

  @override
  String get combineNeedsUnlock => '创建合并后的指南需要解锁。';

  @override
  String get unlockCombineTitle => '添加到你已有的指南';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wren 会新建一个指南，把你指南里原有的 $count 个地点和新找到的地点收在一起。',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      '也能读别的应用导出的列表：CSV、KML、KMZ、GPX、GeoJSON 或 Google Takeout。';

  @override
  String get clearList => '清空列表';

  @override
  String get clearListTitle => '清空列表';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '要把这 $count 个地点从 Wren 里移除吗？已经在地图里做好的指南不受影响。',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => '清除';

  @override
  String get listCleared => '列表已清空。';

  @override
  String get expandingLink => '正在读取那个链接…';

  @override
  String get linkUnreachable => '无法连接 Apple 来读取那个链接。检查你的网络连接，然后再试。';

  @override
  String get splitTitle => '这会生成多个指南';

  @override
  String splitBody(int guides, int count) {
    return '一个指南链接能带多少个地点是 Apple 定的上限。Wren 会做 $guides 个指南，按顺序编号，一起收下这 $count 个地点。';
  }

  @override
  String splitConfirm(int guides) {
    return '创建 $guides 个指南';
  }

  @override
  String splitProgress(int done, int total) {
    return '第 $done 个指南已打开，共 $total 个。轻点以创建下一个。';
  }

  @override
  String get sendPlacesTo => '将地点发送到';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个地点已准备好发送',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个地点没有位置，无法发送',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => '其他应用';

  @override
  String get sendPlacesFailed => '该应用没有接收文件';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已从文件保留 $count 个地点，可发送到其他地图应用',
    );
    return '$_temp0';
  }
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class LZhHant extends LZh {
  LZhHant() : super('zh_Hant');

  @override
  String get tagline => '一隻小鳥告訴我的。';

  @override
  String get emptyTitle => '地方，收著。';

  @override
  String get emptyBody =>
      '把別人推薦給你的東西截個圖 — 一則 Reel、一篇貼文、一則訊息、旅遊指南的一頁。Wren 會讀出名字，放進地圖。';

  @override
  String get emptyNote => '單一地點會加進你已有的指南。多個地點會新建一個 — 地圖無法合併指南。';

  @override
  String get addScreenshots => '加入截圖';

  @override
  String get readingShort => '讀取中…';

  @override
  String readingProgress(int done, int total) {
    return '正在讀取第 $done 張，共 $total 張…';
  }

  @override
  String get addToGuide => '加入指南';

  @override
  String makeGuide(int count) {
    return '製作指南（$count）';
  }

  @override
  String get notFoundOnMap => '地圖上找不到';

  @override
  String get tapToSearchForIt => '點一下來搜尋';

  @override
  String readAs(String text) {
    return '讀作「$text」';
  }

  @override
  String notFoundBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '有 $count 個地點找不到。點一下來搜尋。',
    );
    return '$_temp0';
  }

  @override
  String get whereAreThesePlaces => '這些地方在哪裡？';

  @override
  String get regionDetected => '從圖片說明讀出。不對的話請修改。';

  @override
  String get regionNotDetected => '截圖裡沒有說這些地方在哪裡。填上城市，搜尋會準確得多。';

  @override
  String get cityOrRegion => '城市或地區';

  @override
  String get cityExample => '例如：台北';

  @override
  String get searchAnywhere => '全球搜尋';

  @override
  String get findPlaces => '尋找地點';

  @override
  String searchedIn(String region) {
    return '已在$region搜尋';
  }

  @override
  String get nameThisGuide => '為這個指南取名';

  @override
  String nameThisGuideBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '它會以這個名稱出現在地圖中，包含 $count 個地點。',
    );
    return '$_temp0';
  }

  @override
  String get guideName => '指南名稱';

  @override
  String get guideNameExample => '例如：羅馬，十月';

  @override
  String get createGuide => '製作指南';

  @override
  String get cancel => '取消';

  @override
  String get guidesOfAnySize => '不限數量的指南';

  @override
  String unlockExplain(int limit, int selected, int over) {
    return 'Wren 免費為一個指南儲存最多 $limit 個地點。你選了 $selected 個，多出 $over 個。';
  }

  @override
  String get onePaymentKept => '一次付費，永久保留。不是訂閱。';

  @override
  String unlockFor(String price) {
    return '$price 解鎖';
  }

  @override
  String saveFirstInstead(int limit) {
    return '改為儲存前 $limit 個';
  }

  @override
  String get restorePrevious => '回復先前的購買項目';

  @override
  String get restorePurchase => '回復購買項目';

  @override
  String overFreeLimit(int over, int limit) {
    return '超出免費上限 $limit 個共 $over 個。你可以解鎖，也可以只儲存前 $limit 個。';
  }

  @override
  String get findThisPlace => '尋找這個地點';

  @override
  String get searchAppleMaps => '在地圖中搜尋';

  @override
  String searchInRegion(String region) {
    return '在$region搜尋';
  }

  @override
  String get searching => '搜尋中…';

  @override
  String get typeTwoCharacters => '請至少輸入兩個字元。';

  @override
  String get nothingFound => '什麼都找不到。試試街道名，或更短的名字。';

  @override
  String get rateLimited => '地圖正在限制搜尋次數。稍等片刻再試一次。';

  @override
  String rateLimitedDuringImport(int added) {
    return '地圖正在限制搜尋次數 — 目前已加入 $added 個，其餘的稍後再試。';
  }

  @override
  String importSummary(int found) {
    return '找到 $found 個';
  }

  @override
  String importSummaryIn(String region) {
    return '（$region）';
  }

  @override
  String importSummaryNeedLook(int count) {
    return '$count 個需要確認';
  }

  @override
  String importSummaryUnreadable(int count) {
    return '$count 個無法讀取';
  }

  @override
  String nothingReadable(int count) {
    return '$count 張截圖裡沒有可讀的內容';
  }

  @override
  String get couldNotOpenMaps => '無法打開地圖';

  @override
  String get checkingAppleAccount => '正在檢查你的 Apple 帳號…';

  @override
  String get restoredUnlocked => '已回復。不限數量的指南已解鎖。';

  @override
  String get noPreviousPurchase => '這個 Apple 帳號上找不到先前的購買項目。';

  @override
  String get purchaseDidNotComplete => '購買沒有完成，所以沒有扣款。';

  @override
  String alreadyInTheList(String name) {
    return '「$name」已經在列表中了。';
  }

  @override
  String get ocrUnavailable => '讀取截圖需要 iPhone — 這個平台上沒有文字辨識。';

  @override
  String get lookupUnavailable => '尋找地點需要 iPhone — 這個平台上沒有地圖搜尋。';

  @override
  String get compAccess => '免費使用權限';

  @override
  String get code => '代碼';

  @override
  String get unlock => '解鎖';

  @override
  String get compChecking => '正在檢查這個代碼…';

  @override
  String get compEnabled => '已開啟免費使用權限。';

  @override
  String get compRefused => '無法辨識這個代碼，或者它已經用過了。';

  @override
  String get compTooOften => '嘗試次數太多。等幾分鐘再試一次。';

  @override
  String get compUnreachable => '無法連線伺服器。檢查你的網路連線，然後再試一次。';

  @override
  String get compUntrusted => '無法驗證伺服器的回覆，所以沒有解鎖任何內容。';

  @override
  String get addPlaces => '加入';

  @override
  String get fromFile => '從檔案';

  @override
  String get fromExistingGuide => '從已有的指南';

  @override
  String get importGuideTitle => '加入已有的指南';

  @override
  String get importGuideBody =>
      '在地圖裡打開那個指南並分享，然後選擇「拷貝連結」。貼到下面，Wren 會讀出它已經收著的地點。';

  @override
  String get guideLinkLabel => '指南連結';

  @override
  String get readGuide => '讀取指南';

  @override
  String get importGuideNotALink => '這不是地圖指南的連結。在地圖裡打開指南並分享，然後選擇「拷貝連結」。';

  @override
  String get importGuideNothing => '那個指南裡沒有 Wren 能加入的東西。';

  @override
  String importedGuideSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '從那個指南讀出 $count 個地點',
    );
    return '$_temp0';
  }

  @override
  String importedGuideUnusable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '其中 $count 個地點無法移過去',
    );
    return '$_temp0';
  }

  @override
  String alreadyInGuide(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個地點已經在這個指南裡',
    );
    return '$_temp0';
  }

  @override
  String fromGuideNamed(String name) {
    return '來自「$name」';
  }

  @override
  String get republishTitle => '地圖會新建一個指南';

  @override
  String republishBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Apple 沒有提供往已有指南加入地點的方法，所以 Wren 會新建一個，收下這 $count 個地點。',
    );
    return '$_temp0';
  }

  @override
  String get republishThenDelete => '留下新的指南，刪掉舊的。';

  @override
  String get republishKeepsPlaces => 'Wren 會保留這些地點，萬一出了問題，你可以再做一次指南。';

  @override
  String get makeCombinedGuide => '製作合併後的指南';

  @override
  String fileImportSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '從那個檔案讀出 $count 個地點',
    );
    return '$_temp0';
  }

  @override
  String fileImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '有 $count 列沒有名字',
    );
    return '$_temp0';
  }

  @override
  String get fileNoPlaces => '那個檔案裡沒有地點。';

  @override
  String get fileUnreadable =>
      'Wren 讀不了那個檔案。它能讀 CSV、KML、KMZ、GPX、GeoJSON 和 Google Takeout 匯出的檔案。';

  @override
  String lookingUpProgress(int done, int total) {
    return '正在尋找第 $done 個，共 $total 個…';
  }

  @override
  String get combineNeedsUnlock => '製作合併後的指南需要解鎖。';

  @override
  String get unlockCombineTitle => '加入你已有的指南';

  @override
  String unlockCombineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wren 會新建一個指南，把你指南裡原有的 $count 個地點和新找到的地點收在一起。',
    );
    return '$_temp0';
  }

  @override
  String get acceptedFormats =>
      '也能讀別的應用程式匯出的列表：CSV、KML、KMZ、GPX、GeoJSON 或 Google Takeout。';

  @override
  String get clearList => '清空列表';

  @override
  String get clearListTitle => '清空列表';

  @override
  String clearListBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '要把這 $count 個地點從 Wren 裡移除嗎？已經在地圖裡做好的指南不受影響。',
    );
    return '$_temp0';
  }

  @override
  String get clearListConfirm => '清除';

  @override
  String get listCleared => '列表已清空。';

  @override
  String get expandingLink => '正在讀取那個連結…';

  @override
  String get linkUnreachable => '無法連線 Apple 來讀取那個連結。檢查你的網路連線，然後再試一次。';

  @override
  String get splitTitle => '這會產生多個指南';

  @override
  String splitBody(int guides, int count) {
    return '一個指南連結能帶多少個地點是 Apple 定的上限。Wren 會做 $guides 個指南，依順序編號，一起收下這 $count 個地點。';
  }

  @override
  String splitConfirm(int guides) {
    return '製作 $guides 個指南';
  }

  @override
  String splitProgress(int done, int total) {
    return '第 $done 個指南已打開，共 $total 個。點一下來製作下一個。';
  }

  @override
  String get sendPlacesTo => '將地點傳送到';

  @override
  String sendPlacesReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個地點已準備好傳送',
    );
    return '$_temp0';
  }

  @override
  String sendPlacesNoLocation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個地點沒有位置，無法傳送',
    );
    return '$_temp0';
  }

  @override
  String get sendPlacesOtherApp => '其他應用程式';

  @override
  String get sendPlacesFailed => '該應用程式沒有接收檔案';

  @override
  String fileImportPositioned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已從檔案保留 $count 個地點，可傳送到其他地圖應用程式',
    );
    return '$_temp0';
  }
}
