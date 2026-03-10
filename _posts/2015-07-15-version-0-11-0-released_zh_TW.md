---
layout: blog
title: 0.11.0 版本已發佈
author: nick
---

Node-RED 0.11.1 現在已經可以 [下載](https://github.com/node-red/node-red/releases/download/0.11.1/node-red-0.11.1.zip) 或透過 [npm 安裝](https://npmjs.org/package/node-red)。

如果升級，請閱讀 [升級說明](/docs/getting-started/upgrading_zh_TW.html)。

---

此版本包括三個重大更新、一個新節點以及一些雖然規模較小但同樣完美的更新。


### Node.js 0.12

最近幾週，[GitHub 上提出的問題](https://github.com/node-red/node-red/issues) 或在 [Stack Overflow 上提問](http://stackoverflow.com/questions/tagged/node-red) 的數量穩步增加，因為我們無法在最新穩定版本的 node 下工作。儘管我們的版本說明和安裝說明強調了這一點，使用者仍然會遇到問題。

我們終於追蹤並解決了最後一些破壞我們在 node 0.12 上單元測試的問題，並且我們已將其添加到 [每次提交到儲存庫時](https://travis-ci.org/node-red/node-red) 都會檢查的版本列表中。

重要的是要注意，我們只測試了核心運行時和節點。第三方節點可能仍有潛在問題 —— 因此在躍進之前，請務必測試您的流程。

### 國際化 (Internationalisation)

... 簡稱 i18n。

運行時、編輯器和核心節點都已將其所有文本提取到準備翻譯的訊息目錄中。我們目前還沒有內容翻譯的計劃，但完成底層工程以實現它是重要的一步。

「[如何編寫節點](/docs/creating-nodes/index_zh_TW.html)」文件將很快更新，以涵蓋第三方節點如何根據需要做同樣的事情。關於此運作方式的一些設計筆記可以在 [wiki](https://github.com/node-red/node-red/wiki/Design%3A-i18n) 上找到。

### 編輯器設計更新

雖然上述兩項對終端使用者來說應該是相當透明的，但第三項對每個人來說都會更加明顯。

編輯器 UI 的外觀進行了全面更新。在保持核心視覺標識不變的同時，我們對編輯器進行了修飾，使其更乾淨、更清脆、更一致。

在底層，它也朝著移除我們對 [bootstrap](http://getbootstrap.com/2.3.2/) 依賴的方向又邁出了一步。在那個方面還有很長的路要走，但我們正在取得良好的進展。

讓我們知道您的想法。

### 新的 Report-By-Exception 節點

Report-By-Exception (rbe) 節點一直存在於 [node-red-nodes 儲存庫](https://github.com/node-red/node-red-nodes/tree/master/function/rbe) 中，並且 [在 npm 上可用](http://flows.nodered.org/node/node-red-node-rbe) 已有一段時間。

在此版本中，我們已將其添加到 Node-RED 預設安裝的集合中。

該節點僅根據以下兩個可能條件之一允許訊息通過：

 - 對於字串或數值，如果它們的 `msg.payload` 與前一條訊息的值不同。
 - 對於數值，如果它們的 `msg.payload` 與前一個值的差至少達到某個範圍（絕對值或百分比）。

例如，如果您正在報告傳感器值，這特別有用。每天每隔幾秒報告一次溫度未發生變化並不一定有用。報告值何時發生變化則有用得多。

### 其他變更

除了幾個錯誤修復外，此版本中的唯一其他變更是：

 - File 輸出節點可以配置為在需要時建立目錄
 - Function 節點已經有了 `setTimeout` —— 我們增加了 `clearTimeout`，這看起來才合乎禮儀
