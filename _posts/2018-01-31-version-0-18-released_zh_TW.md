---
layout: blog
title: 0.18 版本已發佈
author: nick
---

終於，Node-RED 0.18 現在已經可以 [下載](https://github.com/node-red/node-red/releases/download/0.18.0/node-red-0.18.0.zip) 或透過 [npm 安裝](https://npmjs.org/package/node-red)。

如果升級，請閱讀 [升級說明](/docs/getting-started/upgrading_zh_TW.html)。

對於 Raspberry Pi 使用者，請參閱 [Raspberry Pi 文件](/docs/hardware/raspberrypi_zh_TW.html#upgrading) 了解如果您仍在使用預裝版本該如何升級。

---

<iframe width="560" height="315" src="https://www.youtube.com/embed/xOpmYVXG7lU?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

---


我們在去年 7 月發佈了我們的 [1.0 路線圖](/blog/2017/07/17/roadmap-to-1-dot-0_zh_TW.html)，並在文中提到：

> 您會注意到這個路線圖上沒有承諾的時間表；它代表了大量的開發工作，最終設計仍有未解決的問題。但我們的目標是在年底前達到 1.0。

現在已經是 1 月底了，這是自那以來的首次發佈，而且它還不是 1.0。我們曾希望在路線圖上走得比現在更遠，但有些事情就是急不得。

作為一個開源專案，我們依賴於我們優秀的社群來幫助推動事情發展。我們今年的目標之一是擴大貢獻者社群。為專案做貢獻不僅僅是編寫程式碼（當然，這確實有助於加速路線圖的進展）。還有許多方法可以更深入地參與並回饋專案，例如文件、食譜 (cookbook) 或幫助改進流程庫。

如果您想參與其中，歡迎來 Slack 與我們聊天。

現在，繼續閱讀 0.18 的版本說明。


### 專案 (Projects)

新的專案功能是我們邁向 1.0 路線圖的第一個重要步驟。它改變了您管理流程文件的方式，並在編輯器中引入了版本控制。

與其在這裡詳述，我們增加了一些 [文件](/docs/user-guide/projects/index_zh_TW.html) 來解釋更多關於專案功能的資訊，或者您可以觀看這段 [影片](https://www.youtube.com/watch?v=Bto2rz7bY3g)：

<iframe width="560" height="315" src="https://www.youtube.com/embed/Bto2rz7bY3g?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

我們正在逐步推出此功能，因此在此版本中它處於預覽模式 —— 您需要透過設置文件啟用它。這意味著在我們於未來版本中預設開啟它之前，您可以選擇加入並遷移到專案模式。

### 訊息序列 (Message Sequence) 節點

我們在之前的版本中引入了 Split/Join 節點對。這些節點可用於將單個訊息轉換為訊息序列，反之亦然。

在此版本中，我們增加了更多關於訊息序列的功能。

 - `Switch` 節點有一些新規則，用於根據訊息在序列中的位置來路由訊息
 - `Join` 節點可以配置 JSONata 表達式，用於將序列縮減為單個訊息
 - 增加了一個新的 `Sort` 節點，用於對序列中的訊息進行重新排序
 - 增加了一個新的 `Batch` 節點，用於從接收到的訊息中建立新的序列
 - `CSV` 和 `File In` 節點在發送多條訊息時，都會以格式正確的訊息序列發送。這讓您可以更有效地讓大型 CSV 文件流經流程。


例如，給定來自 MQTT 節點的傳感器數據流，`Batch` 節點可用於建立時間片 (time-sliced) 序列，而 `Join` 節點則對其進行縮減，以計算每個時間片內的平均傳感器讀數。

![](/blog/content/images/2018/01/message-seq-01.png)

### 自定義節點的圖示

我們增加了更改節點圖示的功能。當您在一個流程中有很多相同類型的節點並希望幫助區分它們時，這很有用。請注意，這是一個編輯器自定義功能 —— 您無法從流程中動態更改圖示。

要更改圖示，請打開節點編輯對話框的設置部分，您將在端口標籤設置下方看到新選項。在此版本中，您必須從可用圖示列表中挑選，但我們將在未來擴展此功能。

### 支持具名範圍 (Scoped) 模組

我們最近更新了 [流程庫 (Flow Library)](https://flows.nodered.org) 以索引具名範圍的節點模組。在此版本中，我們修復了一些錯誤，因此您現在也可以直接從調色板編輯器內安裝它們。

### 增加核心節點的靈活性

按照慣例，節點使用 `msg.payload` 作為其處理的主要屬性。這就是為什麼許多節點能夠直接協作，但當流程必須在不同點將其屬性搬移以使正確的內容進入 payload 時，這也會導致問題。

有些節點已經比其他節點更靈活，允許您挑選不同的屬性進行處理。我們現在已將此擴展到更多節點。

在核心調色板中，`range`、`HTML`、`JSON` 和 `XML` 節點都已更新，額外節點 `RBE`、`random`、`smooth` 和 `base64` 也是如此 —— 請留意它們模組的新版本。

### 更新至 JSONata 1.5.0

我們已更新到 JSONata 的最新版本，它引入了一些新函數和功能。查看他們的 [版本說明](https://github.com/jsonata-js/jsonata/releases) 了解有關 1.4.0 和 1.5.0 版本的更多資訊。


### 節點更新

一如既往，許多核心節點都有長長的一串改進清單。

 - `JSON` 節點現在可以配置為強制執行特定的編碼，而不是總是在 JSON 和 JavaScript 對象之間切換。例如，當您有一個預期使用者發送 JSON 的 HTTP 端點時，這很有用。`HTTP In` 節點僅在請求正確設置其 `Content-type` 時才會自動解析 JSON —— 而在現實世界中，這正是使用者容易弄錯的地方。將此模式增加到 `JSON` 節點可以讓此類流程更具包容性，並保證訊息 payload 已被解析。

 - 通用的 `TLS` 配置節點允許您為私鑰文件指定密碼。

 - 說到 TLS，我們為 `WebSocket Client` 節點增加了 TLS 支持。

 - 說到 WebSocket，我們為 `MQTT` 節點增加了 WebSocket 支持。

 - `template` 節點已經可以發送解析後的 JSON 而不是文字，現在也可以發送解析後的 YAML。您還可以使用 `msg.template` 動態設置它使用的模板。

 - 說到 YAML，有一個新的 `YAML` 解析器節點用於在該格式之間進行轉換。

 - `Delay` 節點現在可以透過向其發送帶有 `msg.reset` 屬性的訊息來重置，從而丟棄任何排隊的消息。

 - `Debug` 節點現在讓您可以根據接收到的訊息內容更新其狀態文字。對於快速查看流程狀態非常有用。

 - `Inject` 節點現在讓您可以指定在觸發其「啟動時立即注入一次」選項之前的延遲時間。

 - `Trigger` 節點現在可以配置為使用 `msg.topic` 來區分不同的訊息流進行觸發。
