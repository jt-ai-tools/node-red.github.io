---
layout: blog
title: 版本 0.19 已發佈
author: nick
---

Node-RED 0.19 現在可以[下載](https://github.com/node-red/node-red/releases/download/0.19.0/node-red-0.19.0.zip)或透過 [npm 安裝](https://npmjs.org/package/node-red)。

如果正在升級，請閱讀[升級說明](http://nodered.org/docs/getting-started/upgrading_zh_TW.html)。

對於 Raspberry Pi 使用者，如果您仍在使用預裝版本，請參閱 [Raspberry Pi 文件](https://nodered.org/docs/hardware/raspberrypi_zh_TW#upgrading)瞭解如何升級。

---

<iframe width="560" height="315" src="https://www.youtube.com/embed/_G_lCXoABO0?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

---

### Node.js 版本支援

Node.js 4 已於 4 月達到其生命週期終點（end-of-life），不再接收任何形式的修復。目前的 Node.js LTS 版本為 8.x，10.x 將於 10 月發佈。

隨著 Node 生態系統的不斷髮展，我們看到越來越多我們依賴的模組開始停止支援舊版的 Node.js。

我們藉此機會宣佈，這將是 Node-RED **最後一個支援**任何 **Node 8.x 以前版本**的發佈版本。

隨著我們接近 Node-RED 1.0，我們將建立自己的 LTS 政策，並儘可能與 [Node.JS 時程表](https://github.com/nodejs/Release)保持一致。

### 持久化 Context

此版本帶來了我們 1.0 路線圖上的下一步：將 context 資料儲存在執行環境之外的能力。

Context 資料是儲存在流程（flow）中的狀態，位於流經它的單個訊息之外。以前，這些資料僅儲存在記憶體中，因此每當執行環境重啟時，這些資料就會丟失。

在 0.19 中，這些狀態現在可以儲存在執行環境之外。執行環境提供了一個用於建立 context 儲存的新 API，0.19 提供了兩個現成的實作。

預設儲存仍為記憶體儲存，因此現有流程不會有任何改變。
提供的第二個實作是基於檔案的儲存，其中 context 資料將寫入您使用者目錄下的檔案中。

它還支援在執行環境中配置多個儲存，因此您可以選擇每個 context 資料片段儲存的位置。例如，您可能希望某些值使用非持久化儲存，而其他值使用持久化儲存。

未來我們計劃提供其他實作，例如 Redis，以便在規模執行時支援更具擴展性的方法。

有關如何啟用新 context 功能的文件可在[這裡](https://nodered.org/docs/user-guide/context_zh_TW)找到。

#### Context 瀏覽器

<div style="float: right; width: 200px; margin-left: 10px">
<img src="/blog/content/images/2018/08/editor-sidebar-context.png" />
</div>

為了配合新的持久化 context 功能，我們新增了一個側邊欄，允許您在編輯器中檢視 context 資料。受現有 [node-red-contrib-contextbrowser](https://flows.nodered.org/node/node-red-contrib-contextbrowser) 外掛程式的啓發，新的側邊欄基於新的底層 context API 構建，並完全支援多個 context 儲存。

與 Debug 側邊欄一樣，如果您將滑鼠懸停在任何值上，會出現一個 <i style="font-size: 0.8em; border-radius: 2px; display:inline-block;text-align:center; width: 20px; color: #777; border: 1px solid #777; padding: 3px;" class="fa fa-clipboard"></i> 按鈕，用於將該值複製到剪貼簿。請注意，只有可以進行 JSON 編碼的值才能被複製。


<br style="clear:both;" />


### 編輯器更新

#### 重新設計的側邊欄標籤

隨著新的 context 側邊欄加入，是時候重新設計側邊欄標籤的顯示方式了，因為它們變得過於擠迫。

標籤現在會摺疊為僅顯示圖示，並帶有下拉式功能表以選擇目前不可見的任何標籤。

![](/blog/content/images/2018/08/sidebar-tabs.gif)

#### 更改節點圖示

現在可以自定義流程中任何節點的圖示。這有助於區分執行不同角色的多個同類型節點。

![](/blog/content/images/2018/08/editor-icon-picker.gif)

圖示選項位於每個節點編輯對話框的「節點設定」區塊。它允許您瀏覽並從所有可用圖示中進行選擇。請注意，我們目前尚不支援為節點使用 Font Awesome 圖示。

#### 更改子流程類別

您現在還可以選擇子流程出現在哪種調色盤類別中。這使得組織您的子流程變得更加容易，而不是將它們全部放在調色盤頂部的單一類別中。

#### 流程導航器組件

我們在主工作區的頁尾添加了一個流程導航器組件，可以使用新的 <i style="font-size: 0.8em; border-radius: 2px; display:inline-block;text-align:center; width: 20px; color: #777; border: 1px solid #777; padding: 3px;" class="fa fa-map-o"></i> 按鈕啟用。這會為您提供整個工作區的縮小檢視，並顯示您目前正在查看的部分。您可以拖動檢視以快速到達工作區的任何角落，這應該會讓您更容易找到被拖到遠處角落並遺忘的零星節點。

![](/blog/content/images/2018/08/editor-workspace-navigator.png)


### 更好地處理環境變數

現在可以直接在流程中存取環境變數。

Inject、Switch 和 Change 節點都已更新，在標準 TypedInput 組件中新增了「環境變數（env variable）」選項：

![](/blog/content/images/2018/08/editor-typedInput-envvar.png)

我們還在 JSONata 表達式語言中新增了 `$env()` 函數，以便從表達式中存取環境變數。


### 節點更新

 - `File Out` 節點現在有一個輸出，以便在寫入檔案後流程可以繼續。
 - `Function` 節點現在可以存取其自身的 `id` 和 `name` 屬性。文件已更新，包含了可用物件和函數的完整[參考](/docs/writing-functions_zh_TW#api-reference)。該節點的 JavaScript 編輯器現在也可以展開為更大的編輯器檢視。
 - 如果 `JSON` 節點接收到的訊息具有 `msg.schema` 屬性，則該節點可以進行架構驗證。
 - Pi 專用的 GPIO 節點現在可在所有平台上使用 - 但它們只有在 Pi 上執行時才起作用。這使得在筆記型電腦上查看/編輯預定用於 Pi 的流程變得更加容易。
 - `Switch` 節點有一個新的 'isEmpty' 規則。它匹配為空的字串、陣列和 Buffer。此外還有相應的 'isNotEmpty' 規則。
 - 常用的 `TLS` 節點現在接受 `servername` 配置選項 - 在使用 SNI 時這是必需的。
