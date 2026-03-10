---
layout: docs-user-guide
toc: toc-user-guide.html
title: 核心節點
slug: core nodes
---

Node-RED 調色盤包含一組默認節點，它們是建立流程的基本構建塊。本頁面重點介紹您應該了解的核心節點集。

當您選擇一個節點時，所有節點都包含您可以在“信息”側邊欄標籤頁中看到的文檔。

- [注入 (Inject)](#inject)
- [偵錯 (Debug)](#debug)
- [函數 (Function)](#function)
- [變更 (Change)](#change)
- [切換 (Switch)](#switch)
- [模板 (Template)](#template)

***

<img alt="Inject node" style="float: right; margin-top: 20px;" src="/docs/user-guide/images/node_inject.png" width="169px">

### Inject (注入)

Inject 節點可用於通過在編輯器中單擊節點按鈕來手動觸發流程。它還可以用於定期自動觸發流程。

Inject 節點發送的消息可以設置其 `payload` 和 `topic` 屬性。

`payload` 可以設置為多種不同類型：

 - 流程 (flow) 或全局 (global) 上下文屬性值
 - 字串 (String)、數字 (number)、布林值 (boolean)、Buffer 或物件 (Object)
 - 自 1970 年 1 月 1 日起的毫秒時間戳 (Timestamp)

`interval` (間隔) 最多可以設置為 596 小時（大約 24 天）。
如果您尋找大於一天的間隔 - 請考慮使用可以處理斷電和重啟的調度器節點。

“時間間隔” (interval between times) 和 “在特定時間” (at a specific time) 選項使用標準 cron 系統。這意味著 20 分鐘將是在下一個整點、20 分和 40 分 - 而不是 20 分鐘後。如果您想要從現在開始每 20 分鐘一次 - 請使用 `interval` 選項。

*自 Node-RED 1.1.0 起*，Inject 節點現在可以設置消息上的任何屬性。

***

<img alt="Debug node" style="float: right; margin-top: 20px;" src="/docs/user-guide/images/node_debug.png" width="169px">

### Debug (偵錯)

Debug 節點可用於在編輯器內的偵錯側邊欄中顯示消息。

側邊欄提供了其發送的消息的結構化視圖，使其更容易探索消息。

除了每條消息外，偵錯側邊欄還包含有關接收消息的時間以及哪個 Debug 節點發送該消息的信息。單擊源節點 ID 將在工作區中顯示該節點。

節點上的按鈕可用於啟用或禁用其輸出。建議禁用或刪除任何未使用的 Debug 節點。

該節點還可以配置為將所有消息發送到運行時日誌，或將簡短（32 個字符）消息發送到偵錯節點下的狀態文本。

[使用消息](/docs/user-guide/messages_zh_TW.md) 頁面提供了有關使用偵錯側邊欄的更多信息。

***

<img alt="Function node" style="float: right; margin-top: 20px;" src="/docs/user-guide/images/node_function.png" width="169px">

### Function (函數)

Function 節點允許對通過它的消息運行 JavaScript 代碼。

[此處](/docs/user-guide/writing-functions_zh_TW.md) 提供了解使用 Function 節點的完整指南。

***

<img alt="Change node" style="float: right; margin-top: 20px;" src="/docs/user-guide/images/node_change.png" width="169px">

### Change (變更)

Change 節點可用於修改消息屬性並設置上下文屬性，而無需訴諸 Function 節點。

每個節點可以配置多個按順序應用的操作。可用操作包括：

 - **設置 (Set)** - 設置一個屬性。該值可以是多種不同類型，或者可以取自現有的消息或上下文屬性。
 - **變更 (Change)** - 搜索並替換消息屬性的部分內容。
 - **移動 (Move)** - 移動或重命名屬性。
 - **刪除 (Delete)** - 刪除屬性。

設置屬性時，值也可以是 [JSONata 表達式](https://jsonata.org) 的結果。
JSONata 是一種用於 JSON 數據的聲明式查詢 and 轉換語言。

***

<img alt="Switch node" style="float: right; margin-top: 20px;" src="/docs/user-guide/images/node_switch.png" width="169px">

### Switch (切換)


Switch 節點允許通過針對每條消息評估一組規則，將消息路由到流程的不同分支。

<div class="doc-callout">“switch”這個名稱來自許多編程語言中常見的 “switch 語句”。它不是指物理開關</div>

該節點配置了要測試的屬性 - 該屬性可以是消息屬性或上下文屬性。

有四種類型的規則：

 - **值 (Value)** 規則針對配置的屬性進行評估
 - **序列 (Sequence)** 規則可用於消息序列，例如由 Split 節點生成的序列
 - 可以提供 JSONata **表達式 (Expression)**，它將針對整個消息進行評估，如果表達式返回 `true` 值，則匹配。
 - 如果前面的規則都不匹配，可以使用 **否則 (Otherwise)** 規則來匹配。

該節點將消息路由到與匹配規則對應的所有輸出。但它也可以配置為在找到匹配規則時停止評估。

***

<img alt="Template node" style="float: right; margin-top: 20px;" src="/docs/user-guide/images/node_template.png" width="169px">

### Template (模板)


Template 節點可用於使用消息的屬性填寫模板來生成文本。

它使用 [Mustache](https://mustache.github.io/mustache.5.html) 模板語言來生成結果。

例如，模板：

{% raw %}
```
This is the payload: {{payload}} !
```
{% endraw %}

將用消息 `payload` 屬性的值替換 `{% raw %}{{payload}}{% endraw %}`。

默認情況下，Mustache 會用 HTML 轉義代碼替換某些字符。
要停止這種情況發生，您可以使用三重括號：`{% raw %}{{{payload}}}{% endraw %}`。

Mustache 支持對列表進行簡單循環。例如，如果 `msg.payload` 包含一個名稱數組，例如：`["Nick", "Dave", "Claire"]`，以下模板將創建名稱的 HTML 列表：

{% raw %}
```
<ul>
{{#payload}}
  <li>{{.}}</li>
{{/payload}}
</ul>
```
{% endraw %}


```
<ul>
  <li>Nick</li>
  <li>Dave</li>
  <li>Claire</li>
</ul>
```

節點將使用模板的結果設置配置的消息或上下文屬性。如果模板生成有效的 JSON 或 YAML 內容，則可以將其配置為將結果解析為相應的 JavaScript 物件。

***
