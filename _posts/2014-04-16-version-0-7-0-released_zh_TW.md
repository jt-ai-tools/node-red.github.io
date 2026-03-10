---
layout: blog
title: 0.7.0 版本已發佈
author: nick
---

Node-RED 0.7.0 現在已經可以 [下載](https://github.com/node-red/node-red/archive/0.7.0.zip) 或透過 [npm 安裝](https://npmjs.org/package/node-red)。

請閱讀 [升級說明](/docs/getting-started/upgrading_zh_TW.html)。最重要的一點是，獲取最新程式碼後別忘了運行 `npm update`！

### 有什麼新進展

當您運行 Node-RED 時，它會嘗試載入它找到的所有節點。通常您會有一些缺少依賴項的節點，因此您會看到許多如下訊息：

    16 Apr 21:16:59 - [23-watch.js] Error: Cannot find module 'fs.notify'
    16 Apr 21:16:59 - [32-feedparse.js] Error: Cannot find module 'feedparser'

我們對此進行了整理，使其對新使用者不那麼令人生畏。在此版本中，我們現在預設隱藏這些訊息，僅提供摘要：

    16 Apr 21:23:32 - ------------------------------------------
    16 Apr 21:23:32 - [red] Failed to register 10 node types
    16 Apr 21:23:32 - [red] Run with -v for details
    16 Apr 21:23:32 - ------------------------------------------

如您所見，我們還告訴您如何查看詳細資訊 —— 通過運行帶有 `-v` 選項的命令。

由於我們現在有幾個不同的命令行選項，我們增加了幫助資訊：

    $ node red.js -?
    Usage: node red.js [-v] [-?] [--settings settings.js] [flows.json]

    Options:
      -s, --settings FILE  使用指定的設定檔案
      -v                   啟用詳細輸出
      -?, --help           顯示用法

    文件可以在 http://nodered.org 找到


#### 無頭模式 (Headless Mode)

我們在追蹤器上的首批問題之一是能夠以無頭模式運行 Node-RED —— 即不運行 UI。

在之前的版本中，我們朝著實現此功能邁出了一些小步，最終在此版本中完成了。

如果您還記得在上一個版本中，我們引入了 `httpAdminRoot` 和 `httpNodeRoot` 設定。這些用於定義它們各自 HTTP 端點的根路徑。

您現在可以將這些屬性中的任何一個設置為 `false`（不是字串 `'false'`，而是布林類型 `false`）。這樣做有效地關閉了它們各自的端點。為了便於使用，將 `httpRoot` 設置為 false 是將 `httpAdminRoot` 和 `httpNodeRoot` 都設置為 false 的捷徑。

此外，如果 `httpAdminRoot` 和 `httpNodeRoot` 均為 false（或 `httpRoot` 為 false），且未設置 `httpStatic`，那麼我們甚至不會啟動 http 伺服器。

如果您在流程中有 HTTP-In 節點且將 `httpNodeRoot` 設置為 false，您現在會收到警告訊息，讓您知道這些節點不可訪問。

如果您有 debug 節點且 `httpAdminRoot` 為 false，您將無法訪問 debug 節點輸出，除非您還使用了它們的新選項將輸出發送到 stdout。

#### UI 更新

在 UI 中拖動節點時，您已經可以在開始拖動節點 *之後* 按下 `shift` 來對齊網格。在選中多個節點時，我們計算網格位置的方式存在一些不一致之處，我們已經對此進行了整理。這使得連線對齊變得更加容易。

在此版本中，您現在還可以使用方向鍵實現節點的像素級精確放置。如果您同時按下 `shift`，節點將進行大幅度移動。

我們增加了對在工作區中使用 `Ctrl-X` 剪下節點的支援，以補充現有的複製 (`Ctrl-C`) 和貼上 (`Ctrl-V`) 動作。


#### 移除舊的已棄用節點
正如早些時候在 [郵件列表](https://groups.google.com/forum/#!topic/node-red/-2nG6nKaxFI) 上宣佈的那樣，我們已經移除了一些很久以前就棄用的節點。當我們棄用一個節點時，它會從調色板中消失以防止新用途，但保留在運行時中，以便現有流程不受影響。我們移除的節點有：

 - 30-socketin  - 舊的簡單 TCP 和 UDP 套接字 —— 現在已被單獨的 TCP、UDP 和 HTTP 節點取代
 - 30-socketout - 對應的輸出套接字
 - 32-multicast - 原始的多播節點 —— 現在作為 UDP 節點的一部分被取代
 - 35-rpi-gpio-in - 使用節點庫（不再維護）的原始 Raspberry Pi 輸入節點 —— 現在已被使用 GPIO 的節點取代。
 - 35-rpi-gpio-out - 對應的輸出對

#### 棄用 HTTPGet
在此版本中，我們已經棄用了 httpget 節點。這在一段時間前已在邏輯上被 HTTPRequest 節點取代，但我們一直沒有適當地將其棄用。當我強調這一點時，有人指出 httpget 節點有一個其替代品不具備的功能：在節點內以編程方式構建 URL 的能力。

httpget 節點允許您指定一個「基本 URL」和一個「附加 (append)」選項。當訊息到達時，payload 被插入到這兩者之間以獲取請求的最終 URL。與其在 HTTPRequest 節點中按原樣複製此功能，不如趁機更好地解決這個問題。

當在節點本身中配置時，HTTPRequest 節點的 `url` 屬性現在支持 mustache 風格的模板標籤。這允許使用傳入訊息的任何屬性動態生成 URL。例如，URL 為：

    http://example.com/{{topic}}?s={{user}}

且傳入訊息為：

    {
        topic: "foo",
        user: "fred",
    }

將導致 URL 為：

    http://example.com/foo/?s=fred


您仍然可以自己構建 URL 並通過訊息的 `url` 屬性將其傳入 —— 這將覆蓋您在節點中配置的任何其他內容。

#### 其他節點更新


- Debug 節點現在可以選擇將其輸出發送到 stdout。此外，點擊側邊欄中的 debug 訊息將根據需要切換工作區中的標籤，以顯示訊息的來源。
- Delay 節點有一個新選項，可以在速率限制模式下丟棄中間訊息
- Sentiment 節點接受一組單詞-值對來定製其評分

- 在 [node-red-nodes](https://github.com/node-red/node-red-nodes) 儲存庫中增加了以下節點：
  - Beaglebone Black 硬體 —— 模擬、離散和脈衝 IO
  - Heatmiser 恆溫器
  - Pibrella 板
- 更新了 Emoncms 和 Hue 節點，增加了新功能
- Twilio 節點不再要求您在 `settings.js` 中提供您的帳戶詳細資訊 —— 您可以在節點本身提供它們。
