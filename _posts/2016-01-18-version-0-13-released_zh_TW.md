---
layout: blog
title: 0.13 版本已發佈
author: nick
---

Node-RED 0.13.0 現在已經可以 [下載](https://github.com/node-red/node-red/releases/download/0.13.0/node-red-0.13.0.zip) 或透過 [npm 安裝](https://npmjs.org/package/node-red)。

如果升級，請閱讀 [升級說明](/docs/getting-started/upgrading_zh_TW.html)。

如果您使用的是 Raspberry Pi Jessie 上的預裝版本，儲存庫將在不久的將來更新。

---

0.13 版本帶來了編輯器中的許多新功能以及運行時的內部變更。

### 編輯器更新

編輯器進行了一些細微的更改，使您在建立流程時有更好的體驗。

#### 網格佈局
我們現有的隱藏功能之一是可以在拖動節點時按下 Shift 鍵將節點對齊到隱形網格。我們通過在新的 `View` 選單下添加 `Show grid` (顯示網格) 和 `Snap to grid` (對齊網格) 選項使這一點更加明顯。如果您喜歡一切都完美對齊，請開啟這些選項。

說到移動節點，我們知道讓你們中的一些人感到煩惱的一點是，僅僅移動一個節點並不會啟用 Deploy 按鈕；您必須對流程進行實質性更改才能保存更改。現在您不再煩惱了 —— 移動節點現在將啟用 Deploy 按鈕。如果您選擇 Modified Nodes (已修改節點) 或 Modified Flows (已修改流程) 部署選項，那麼您的佈局更改將被保存，而不會中斷運行的節點（假設您也沒有進行任何實質性更改...）。

#### 拼接連線 (Splicing wires)

有多少次您想將節點放到現有連線上並讓它自動拼接就位？現在，您可以了。
![](/blog/content/images/2016/01/splice-wire-1.gif)

您只能拼接直接從調色板拖出的新節點，或者沒有現有連線的節點。

#### 分離連線 (Detaching wires)

有多少次您想更換一個連入大量連線的節點，但隨後不得不手動重新連線？現在，這變得容易多了。如果您在開始拖動節點端口時按住 Shift 鍵，它將分離現有的連線並允許您將其重新連接到其他地方。

![](/blog/content/images/2016/01/rewire-node.gif)

#### 配置節點 (再次提報)

在上一個版本中，我們在部署時增加了一些警告，以讓您了解潛在的問題。其中一個警告是如果您的工作區中有任何未使用的配置節點。這對我們以前的做法（什麼都不告訴您）是一種改進 —— 但它並沒有贏得多少支持者，因為它妨礙了部署，而且本身並不是錯誤。

在此版本中，我們取消了該警告。取而代之的是，如果您在有未使用配置節點的情況下進行部署，正常的「Successfully deployed」通知已擴展為告知您未使用的節點。由於此通知在大約 8 秒後消失，因此它不會妨礙您的工作流程。顯著的是，消息中還包含一個鏈接，可打開配置節點側邊欄，向您顯示它正在告訴您的未使用節點。

![](/blog/content/images/2016/01/Node-RED.png)

配置節點側邊欄也已更新，以顯示按其所在的流程（標籤頁）或子流程組織的所有配置節點。視圖頂部有控件，可以只顯示未使用的節點。

我們認為這解決了我們收到的關於此特定領域的所有評論 —— 請讓我們知道您的想法。

#### 編輯對話框

節點編輯對話框的自由形式性質意味著編輯器很難知道對話框中是否有未保存的更改。因此，我們禁用了您可能在此類對話框中期望的「點擊 Escape 關閉」行為 —— 以免您意外丟失更改。對於那些不喜歡離開鍵盤的人，現在可以使用 Ctrl-Escape (Cmd-Escape) 關閉對話框並放棄任何更改。同樣，Ctrl-Enter (Cmd-Enter) 點擊 Okay 按鈕並應用更改。

我們在自己的節點中注意到一件事，即在調整編輯對話框大小時，有很多重複的樣板代碼來處理佈局更改。為了使其更容易，節點的定義現在可以包含一個 `oneditresize` 函數，該函數在調整對話框大小時被調用。核心節點已更新以使用它，因此您可以看到它是如何使用的，例如與 [Catch 節點](https://github.com/node-red/node-red/blob/03558b012c825caa3d5ea981bfe125997ca357fd/nodes/core/core/25-catch.html#L275) 一起使用。

#### TypedInput 組件

Change 節點已更新，支持更豐富的屬性類型集。以前，它只能將消息屬性設置為字串值。現在，您可以使用此版本中增加的新 `TypedInput` 組件從多種類型中進行選擇。

![](/blog/content/images/2016/01/Node-RED-1.png)

在那個列表中，您會看到 `msg.` —— 將一個消息屬性複製到另一個。您還會看到 `flow.` 和 `global.` —— 稍後會詳細介紹。

JSON 選項允許您提供一個 JSON 字串，它將被解析為等效的 JavaScript 對象。總而言之，非常方便。

Switch 節點也已更新為使用此組件。Switch 節點特有的一個額外選項是能夠將屬性設置為「previous value」(前一個值)。這讓您可以建立根據屬性值是否已更改來路由消息的流程。我們有 `rbe` 節點 (report-by-exception) 也可以執行此操作，但將其添加到 Switch 節點使其更容易完成。

Inject 節點也進行了更新，因此對於它注入的內容，您有更豐富的選擇。

`TypedInput` 組件是 Node-RED 特有的 jQuery 組件，可在編輯器中供任何節點使用。我們將在不久的將來分享它的文件 —— 但您可以查看更新後的節點以了解其用法。

#### 上下文 (Context)

Function 節點一直可以訪問 `context` 對象，為它們提供一個在調用之間存儲狀態的空間。它們也可以訪問 `context.global` —— 所有 Function 節點共享的全域上下文。

在此版本中，我們對存取上下文的方式進行了一些更新，使其對所有節點可用，並更改了其使用方式。

在 Function 節點中，`context` 已加入 `flow` 和 `global`。這是上下文的三個獨立範圍 —— 分別在節點內、流程（標籤頁）內以及跨所有節點。

這些上下文中的每一個現在都提供了一對 `get(key)` 和 `set(key,value)` 函數，用於存取其中的數據。您仍然可以直接將屬性附加到這些對象，例如 `context.foo = 1;`，因此現有流程不會受到影響，但現在不鼓勵這樣做，而建議使用 `context.set('foo',1);`。這是實現能夠在 Node-RED 重啟後保存和恢復上下文對象目標的第一步。

如前所述，Inject、Switch 和 Change 節點現在都能夠存取 `flow` 和 `global` 上下文，Template 節點可用於設置上下文屬性。

[關於編寫 Function 的文件](/docs/writing-functions_zh_TW.html#storing-data) 已更新，增加了更多細節。

### 運行時更新

管理 API 有一些新增加的功能：

 - [`/flows` 端點](/docs/api/admin/methods/post/flows/) 現在可以通過將 `Node-RED-Deployment-Type` 標頭設置為 `reload` 來觸發活動流程配置的重新載入和重新啟動。
 - 增加了新的 `/flow` 端點，帶有 [添加](/docs/api/admin/methods/post/flow/)、[獲取](/docs/api/admin/methods/get/flow/)、[更新](/docs/api/admin/methods/put/flow/) 和 [刪除](/docs/api/admin/methods/delete/flow/) 個別流程（標籤頁）的動作，而不會中斷其他流程。

運行時本身已重新組織，以更好地將核心運行時與提供管理 API 和編輯器的部分分開。我們還穩定運行時 API 到可以開始 [編寫其文件](/docs/api/runtime/index_zh_TW.html) 的程度。我們希望在發佈時完成其全部文件，但不可避免地這還沒有發生 —— 我們正在努力。

提醒任何已經開始建立自己的消息翻譯的人，編輯器和運行時的目錄文件已移動。它們現在是：

 - `red/api/locales/en-US/editor.json`
 - `red/runtime/locales/en-US/runtime.json`
