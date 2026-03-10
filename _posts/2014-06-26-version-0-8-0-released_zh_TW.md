---
layout: blog
title: 0.8.0 版本已發佈
author: nick
---

Node-RED 0.8.0 現在已經可以 [下載](https://github.com/node-red/node-red/archive/0.8.0.zip) 或透過 [npm 安裝](https://npmjs.org/package/node-red)。

請閱讀 [升級說明](/docs/getting-started/upgrading_zh_TW.html)，獲取最新程式碼後別忘了運行 `npm update`。

### 有什麼新進展

#### 節點精緻的新外觀

由於我們使用了透明背景的白色圖示，加上節點本身柔和的調色板，有時這種組合會使圖示難以看清。為了幫助提高圖示的對比度，它現在顯示在較深色的背景上。這是一個微妙的變化，但使區分不同節點變得更容易。
![新節點外觀](/blog/content/images/2014/Jun/Selection_077.png)


#### 文件更新

我們現在有了關於 [如何編寫您自己的節點](/docs/creating-nodes/index_zh_TW.html) 的文件。還有幾個更進階的主題仍待涵蓋，但所有的基礎知識都在那裡了。

#### 節點狀態指示器

現在節點可以與 UI 分享它們的狀態並實時更新。此狀態預設是隱藏的，但可以通過選擇右手邊下拉式選單中的「Node Status」選項來開啟。

例如，MQTT 節點已更新為顯示它們是否已連接。

![MQTT 節點狀態](/blog/content/images/2014/Jun/Selection_078.png)

更多資訊請參閱 [新文件](/docs/creating-nodes/status_zh_TW.html)。

#### 可透過 npm 安裝的節點

在此版本中，我們現在支持通過 npm 安裝節點。這使得安裝新節點及其依賴項變得更加容易。

如果您有 [Griffin Powermate](http://www.amazon.co.uk/gp/product/B003VWU2WA)，您可以通過簡單的 `npm install node-red-contrib-powermate` 來安裝它的 Node-RED 節點 —— 感謝 [@hardillb](https://twitter.com/hardillb)。

我們將逐步把現有 node-red-nodes 儲存庫中的節點發佈到 npm。

更多資訊請參閱（沒錯，您猜對了）[新文件](/docs/creating-nodes/packaging_zh_TW.html)。

#### 觸控 UI

為了使 UI 支持觸控，我們做了相當多的工作。這第一步專注於使現有功能能夠通過觸控驅動，而不依賴於滑鼠/鍵盤組合。

仍有一些部分尚未針對觸控/行動裝置進行優化 —— 比如下拉式選單。這是我們將在接下來的幾個版本中努力解決的問題。

感謝 [TJ Koury](https://github.com/TJKoury) 在此領域的貢獻。


#### 流程檔案處理

現在每當部署一組新流程時，流程檔案都會被備份。這意味著備份文件 `flows.backup` 將始終包含之前部署的流程 —— 如果您不小心部署了不想部署的東西，這會非常方便。

以前，流程的憑據會存儲在 `credentials.json` 中。當載入流程檔案時，它會清除與不再存在的節點相關聯的任何憑據。對於經常在流程檔案之間切換的使用者來說，這是一件痛苦的事情。為了解決這個問題，現在用於存儲憑據的文件與流程檔案名稱綁定。例如，在使用 `my_flows.json` 運行時，憑據將存儲在 `my_flows_cred.json` 中。

我們偶爾會收到將流程檔案格式化以使其更具可讀性的請求，而不是緊湊的單行 JSON 字串。現在可以通過在設置檔案中設置 `flowFilePretty` 選項來實現這一點。

#### 節點更新

- 有了一組新的解析器節點，可以輕鬆地在不同格式之間轉換 payload。例如，JSON 節點可以在 JSON 字串和 JavaScript 物件之間進行雙向轉換。還有用於處理 XML 和 CSV payload 的節點。
- HTML 節點允許流程使用類似 jQuery 的選擇器提取文件的元素。
- File In 節點可用於讀取文件的內容
- Trigger 節點可用於脈衝 IO 引腳、設置看門狗 (watchdog) 或許多其他事情
- Serial 節點已更新，允許配置數據位、奇偶校驗和停止位。現在也可以將其配置為處理二進制數據，而不是假設一切都是 ASCII 文本。
