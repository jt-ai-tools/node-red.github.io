---
layout: blog
title: 0.6.0 版本已發佈
author: nick
---

Node-RED 0.6.0 現在已經可以 [下載](https://github.com/node-red/node-red/archive/0.6.0.zip) 或透過 [npm 安裝](https://npmjs.org/package/node-red)。請閱讀 [升級說明](/docs/getting-started/upgrading_zh_TW.html)。

如果您正在另一個應用程式中嵌入 Node-RED，此版本帶來的一些 API 變更將會影響您。請務必閱讀下面的版本說明和更新後的文件。

### 有什麼新進展

#### 流程庫 (Flow library)
雖然這不嚴格屬於此版本的一部分，但趁著大家關注之際，我們建立了 [flows.nodered.org](http://flows.nodered.org)，讓任何人都能分享他們建立的有趣流程。

在添加流程之前，您必須透過 GitHub 登入該網站。我們這樣做是因為當您添加流程時，我們會將流程以 Gist 的形式儲存在您的 GitHub 帳戶下。這意味著它仍然是「您的」—— 並且您可以隨時從庫中將其移除。這也意味著目前如果您想編輯流程，必須透過 GitHub 上的流程頁面（連結自庫中的側邊欄）進行。編輯完成後，點擊側邊欄中的「重新整理 (refresh)」連結，我們就會在後台抓取最新版本。我們將在未來的版本中加入行內編輯功能。

首頁目前列出了所有已添加的流程以及使用的標籤。隨著內容的增加，我們將努力尋找讓您更容易找到相關流程的方法。


#### 分離 HTTP 設定

目前，Node-RED 有一對設定設定，可用於修改管理 UI 的提供方式。

 - `httpRoot` 定義了提供 UI 的根路徑。
 - `httpAuth`（如果設定）透過指定所需的使用者名稱/密碼來定義基本身份驗證。

這種方法的一個問題是，這些設定也會應用於 HTTP-In 節點建立的端點。這意味著無法在保護 UI 免受未經授權使用者存取的同時，允許這些使用者存取 HTTP In 端點。這也意味著如果您建立了一個在管理 UI 已經使用的端點（如 `/flows`）上監聽的 HTTP-In 節點，很容易發生衝突。

在此版本中，提供 Node-RED 管理部分的設定已與提供 HTTP 端點的節點設定分離。現在可以使用以下屬性：

 - `httpAdminRoot` 定義了提供 UI 的根路徑。
 - `httpAdminAuth`（如果設定）定義了基本身份驗證的使用者名稱/密碼。

 - `httpNodeRoot` 定義了節點使用的根路徑。
 - `httpNodeAuth`（如果設定）定義了存取節點端點的基本身份驗證。

這些變更大多是向後相容的 —— 如果未設定這些新屬性，但設定了 `httpRoot`/`httpAuth`，則新屬性會自動採用它們對應的值。

為了完整起見，還有一個新選項可以為 `httpStatic` 內容提供基本身份驗證詳細資訊 —— `httpStaticAuth` —— 如果未另外設定，它也會採用 `httpAuth` 的值。

在內部，節點存取 express 應用程式以附加其 HTTP 請求處理程序的方式發生了變更。以前，節點只需使用 `RED.app`。例如，來自 Inject 節點：

    RED.app.post("/inject/:id", function(req,res) {

`RED.app` 的使用已被棄用。如果您使用它，您將在控制台中看到一條關於使用已棄用 API 的日誌訊息 —— 儘管目前一切仍能正常運作。

現在有兩個新的 `RED` 屬性可以使用：

 - `RED.httpAdmin` - 應當用於所有管理相關的 HTTP 端點。例如，像 MQTT 節點那樣管理使用者憑據。顧名思義，附加在此處的端點受 `httpAdmin*` 設定設定的約束。任何使用已棄用的 `RED.app` 的程式碼實際上都會在底層使用此屬性。
 - `RED.httpNode` - 應當用於非管理的 HTTP 端點。同樣地，`httpNode*` 設定適用於此處。

如果您在自己的 node.js 應用程式中嵌入了 Node-RED，由於現在有兩個 express 應用程式需要附加，因此需要一個額外的步驟。使用文件（[docs](/docs/embedding_zh_TW.html)）中的範例，不再只是執行：

    app.use(settings.httpRoot,RED.app);

您必須執行：

    app.use(settings.httpAdminRoot,RED.httpAdmin);
    app.use(settings.httpNodeRoot,RED.httpNode);


#### UI 變更
 - 匯入流程現在變得更容易了，您可以直接將流程 JSON 拖放到畫布上。這是一個從新流程庫中拖動的範例。

![拖放](/blog/content/images/2014/Apr/nr_drag_and_drop.gif)

 - 為了讓在調色板 (palette) 中尋找東西變得更容易，我們增加了搜尋過濾器。

![調色板過濾器](/blog/content/images/2014/Apr/nr_palette_filter.gif)

 - 為了幫助管理流程中使用的設定節點，我們增加了設定節點側邊欄標籤。它列出了流程中所有的設定節點，並突顯了正在使用每個節點的對象。這意味著您可以快速發現任何不再使用且可以刪除的設定節點。

![設定側邊欄](/blog/content/images/2014/Apr/nr_config_sb.gif)




### 節點更新

 - 在 [node-red-nodes](https://github.com/node-red/node-red-nodes) 儲存庫中增加了 Emoncms、Postgres 和 Amazon DynamoDB 的節點。
 - 在 settings.js 中為 TCP 伺服器插座增加了 `socketTimeout`。
 - 為 Change 節點增加了正確的正則表達式 (Regex) 支援選項。
 - 修復了 MQTT 用戶端中的 keepalive 處理。
 - 增加了 WiringPi 中所有 17 個引腳的選項。
 - 增加了新的 Range 節點。
 - 改進了 Inject 節點的 payload 選項 —— 允許注入「空」payload。
 - File 節點：檔案名稱可以由傳入訊息的 `filename` 屬性覆蓋。如果訊息具有 `delete` 屬性，它將刪除該檔案。
 - 為 Mongo 節點增加了使用者名稱/密碼。
 - 在 settings.js 中增加了 `httpNodeCors` 以允許進行跨來源請求。
 - 為 HTTP Request 節點增加了可選的基本身份驗證。
