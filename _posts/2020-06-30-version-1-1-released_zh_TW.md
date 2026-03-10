---
layout: blog
title: 版本 1.1 正式發佈
author: nick
---

Node-RED 1.1 現在可以[安裝](https://npmjs.org/package/node-red)了。

如果正在升級，請閱讀[升級說明](http://nodered.org/docs/getting-started/upgrading_zh_TW.html)。

---

<iframe width="560" height="315" src="https://www.youtube.com/embed/FHP7qsaz7ZI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

---


- [編輯器更新](#編輯器更新)
   - [資訊側邊欄重新設計](#資訊側邊欄重新設計)
   - [新的說明側邊欄](#新的說明側邊欄)
   - [節點分組](#節點分組)
- [執行環境功能](#執行環境功能)
   - [內建 node-red-admin](#內建-node-red-admin)
   - [覆蓋個別設定](#覆蓋個別設定)
   - [`httpAdminMiddleware` 設定](#httpadminmiddleware-設定)
   - [自定義 `adminAuth` 權杖處理](#自定義-adminauth-權杖處理)
   - [從其他位置安裝節點](#從其他位置安裝節點)
   - [重新整理 HTTPS 憑證](#重新整理-https-憑證)
- [節點更新](#節點更新)
   - [JSONata `$moment` 支援](#jsonata-moment-支援)
   - [Inject 節點屬性](#inject-節點屬性)
   - [Function 節點生命週期](#function-節點生命週期)
   - [Debug 節點狀態](#debug-節點狀態)
   - [Trigger 節點](#trigger-節點)



## 編輯器更新

### 資訊側邊欄重新設計

資訊側邊欄現在包含流程的樹狀檢視 — 我們稱之為大綱檢視 (outliner)。這提供了另一種導航流程並快速查找內容的方法。

![](/blog/content/images/2020/06/info-sidebar.png){:width="40%"}

每個節點都有一個按鈕可以帶您前往其在工作區中的位置、一個啟用/停用按鈕，以及（對於 Inject 和 Debug 節點）一個觸發其動作的按鈕。雙擊節點將彈出其編輯對話框。

[更多資訊...](/docs/user-guide/editor/sidebar/info_zh_TW)

### 新的說明側邊欄

為了給大綱檢視騰出空間，側邊欄的說明區塊現在移到了自己的側邊欄分頁中。將說明放在獨立分頁中的額外好處是，您現在可以瀏覽所有可用的說明主題，而無需在工作區中選擇相應類型的節點。

這也將為我們未來在編輯器中新增其他說明主題提供空間。

[更多資訊...](/docs/user-guide/editor/sidebar/help_zh_TW)

### 節點分組

為了幫助組織您的流程，您現在可以在編輯器中將節點分組。群組可以有自定義的邊框和背景顏色，以及可選的標籤。

![](/blog/content/images/2020/06/groups-one.gif)

群組作為一種新型節點添加到流程中。隨著人們開始使用它們，與尚未升級的使用者分享流程將變得更加困難。為了提供幫助，我們發佈了 [`node-red-node-group`](https://flows.nodered.org/node/node-red-node-group)，它註冊了一個 `group` 節點類型，但實際上什麼也不做。安裝此模組將允許舊版本的 Node-RED 匯入包含群組的流程 — 儘管它們在編輯器中看不到群組。而且該模組知道在不需要時不註冊自己，因此安裝了它再升級到 1.1 也沒有問題。

[更多資訊...](/docs/user-guide/editor/workspace/groups_zh_TW)

## 執行環境功能

### 內建 node-red-admin

`node-red-admin` 命令列工具自專案啟動以來就已存在，但它並不是廣為人知或廣泛使用的工具。它可以用於遠端管理 Node-RED 執行環境。

為了使其更有用，它現在已整合到 `node-red` 命令中。您可以透過以下方式執行：

```
node-red admin
```

它提供的有用命令之一是為 `adminAuth` 生成密碼雜湊的方法。它會提示您輸入要使用的密碼，並返回可以貼上到設定檔案中的雜湊值。

```
$ node-red admin hash-pw
Password:
$2b$08$sjxLvq8MmycyWJpxPLyweuw/WlYt1MX56eG5Q5nlyxJs2fASGm2jm
```

其他命令讓您可以列出已安裝的節點、啟用/停用它們、安裝新節點或移除舊節點。您還可以搜尋流程庫。

[更多資訊...](/docs/user-guide/node-red-admin_zh_TW)

### 覆蓋個別設定

`node-red` 命令現在支援 `-D` 選項來覆蓋個別設定。例如，要臨時以不同的日誌層級執行，您可以使用：

```
node-red -D logging.console.level=trace
```

[更多資訊...](/docs/getting-started/local_zh_TW#override-individual-settings)


### `httpAdminMiddleware` 設定

我們已經提供 `httpNodeMiddleware` 選項有一段時間了 — 允許將自定義中介軟體添加到 HTTP In 節點路由中。此版本增加了 `httpAdminMiddleware`，它對所有管理路由（包括編輯器本身）執行相同的操作。這可以用於（例如）向所有管理請求添加自定義 HTTP 標頭。這不是大多數終端使用者需要的，但對於那些將編輯器嵌入到自己應用程式中的使用者來說，這是一項要求。

[更多資訊...](/docs/user-guide/runtime/securing-node-red_zh_TW#custom-middleware)

### 自定義 `adminAuth` 權杖處理

`adminAuth` 現在支援自定義 `tokens` 函數，可用於驗證傳遞給管理 API 的任何認證權杖。這為將 Node-RED 管理安全性與其他身份驗證系統整合開闢了一些更靈活的選項。

[更多資訊...](/docs/user-guide/runtime/securing-node-red_zh_TW#custom-authentication-tokens)

### 從其他位置安裝節點

用於安裝新節點的管理 API 已擴展，支援 'url' 參數 — 該參數應該是包含要安裝節點的 `tgz` 的完整 URL。

這部分尚未寫入文件，但目前您可以閱讀原始的[設計說明](https://github.com/node-red/designs/tree/master/designs/node-installation)。

### 重新整理 HTTPS 憑證

現在可以將執行環境配置為定期重新整理其 HTTPS 憑證。此功能需要 Node.js 12 或更高版本。

預設的[設定檔案已更新](https://github.com/node-red/node-red/blob/c048b1a25b36040f169f443701b9a0dde2f57914/packages/node_modules/node-red/settings.js#L139-L171)，並提供了如何配置此功能的範例。

[更多資訊...](/docs/user-guide/runtime/securing-node-red_zh_TW#refreshing-https-certificates)

## 節點更新

### JSONata `$moment` 支援

我們透過 `$moment` 函數在 JSONata 表達式中增加了對 Moment 日期/時間庫的支援。

這為 Node-RED 核心增加了一些長期需要的時區感知能力。例如，您可以使用以下表達式獲取奧克蘭的目前時間：

```
$moment().tz("Pacific/Auckland")
```

如果您想獲取 2 小時後的時間，可以執行：

```
$moment().add(2, "hours")
```

它在解析日期方面也做得更出色：

```
$moment($.payload, "YYYY-MM-DD")
```

我們也在考慮將 Moment 庫作為 Function 節點的預設內建庫，但這將在未來的版本中實現。

### Inject 節點屬性

Inject 節點現在可以設定發送訊息上的任何屬性 — 您不再侷限於僅設定 `topic` 和 `payload`。

![](/blog/content/images/2020/06/inject-props.png)

### Function 節點生命週期

Function 節點現在允許您提供在部署節點和停止節點時應執行的程式碼。這讓您可以在節點開始處理任何訊息之前初始化其狀態。請注意，每段程式碼都在獨立的範圍內 — 您不能在一段程式碼中宣告變數並在另一段程式碼中存取它們。您需要使用 `context` 在它們之間傳遞內容。

主 Function 也已改為真正的非同步函數 (async Function)，因此如果您喜歡的話，可以在頂層使用 `await`。

![](/blog/content/images/2020/06/func-lifecycle.png)

### Debug 節點狀態

Debug 節點現在可以獨立於傳遞給 Debug 側邊欄的內容來設定其狀態訊息。如果您想在狀態中顯示簡短摘要，同時在有更多空間的側邊欄中顯示更完整的資訊，這將非常有用。

說到 Debug 節點，我們在編輯器中添加了一些動作，以幫助一次啟動/停用大量節點。

您可以在動作列表 (`Ctrl/Cmd-Shift-P` 或 `檢視 -> 動作列表`) 中搜尋它們，並為其分配鍵盤快捷鍵：

 - `core:activate-selected-debug-nodes` (啟動選中的 debug 節點)
 - `core:activate-all-debug-nodes` (啟動所有 debug 節點)
 - `core:activate-all-flow-debug-nodes` (啟動目前流程的所有 debug 節點)
 - `core:deactivate-selected-debug-nodes` (停用選中的 debug 節點)
 - `core:deactivate-all-debug-nodes` (停用所有 debug 節點)
 - `core:deactivate-all-flow-debug-nodes` (停用目前流程的所有 debug 節點)


### Trigger 節點

Trigger 節點現在可以選擇在單獨的輸出上發送其「第二條訊息」。

如果您希望它處理多個訊息串流，您不再受限於使用 `msg.topic` 來識別串流 — 您可以使用任何訊息屬性。
