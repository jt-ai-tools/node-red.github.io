---
layout: blog
title: 0.10.8 版本已發佈
author: nick
---

**更新**：0.10.10 已發佈，修復了 Raspberry Pi GPIO 節點的權限問題。

~~**更新**：0.10.9 已發佈，修復了 0.10.8 中出現的一個封裝錯誤。~~

Node-RED 0.10.~~89~~10 現在已經可以 [下載](https://github.com/node-red/node-red/releases/download/0.10.10/node-red-0.10.10.zip) 或透過 [npm 安裝](https://npmjs.org/package/node-red)。

如果升級，請閱讀 [升級說明](/docs/getting-started/upgrading_zh_TW.html)。

請記住，目前我們 **不支持** Node.js v0.12 或 io.js。

---

### 節點移動/移除 (Nodes (re)moved)

我們所做的主要變化之一是將我們的一些核心節點移至它們自己的獨立套件中。這使我們能夠獨立於主版本發佈這些節點的修復。其中一些節點已作為 Node-RED 套件的依賴項添加，因此在運行 `npm install` 時它們會被自動包含。有些節點不再包含在內，必須手動添加回來。

以下節點已移至其自己的 npm 套件，並作為 Node-RED 套件的依賴項添加，因此仍會包含：

 - Twitter，現在由 `node-red-node-twitter` 提供
 - Feedparse，現在由 `node-red-node-feedparser` 提供
 - Email，現在由 `node-red-node-email` 提供
 - Serialport，現在由 `node-red-node-serialport` 提供


以下節點已移至其自己的 npm 套件，但 **沒有** 作為 Node-RED 套件的依賴項添加。這意味著，如果您正在使用這些節點中的任何一個，您將需要 *手動安裝它們的新 npm 套件以繼續使用它們。*

 - IRC: `node-red-node-irc`
 - Arduino: `node-red-node-arduino`
 - Redis: `node-red-node-redis`
 - Mongo: `node-red-node-mongodb`

因為我們知道並非所有人都會閱讀這些版本說明，如果 Node-RED 檢測到您正在使用這些已移動的節點，它會非常清楚地指向您應該安裝的適當套件。


### 其他變更

此版本包括對運行時和編輯器的多項修復和改進。一些亮點包括：

- 節點定義現在可以將其圖示定義為函數或靜態字串。這意味著它可以根據節點的配置動態更改，就像它的標籤一樣。

- HTTP Request 節點現在可以在 Web 代理伺服器後使用，因為它遵循標準的 http_proxy 環境變數。

- 新的 `httpNodeMiddleware` 配置設置可用於在所有 HTTP In 節點之前添加 [Express 中間件函數](http://expressjs.com/guide/using-middleware.html#middleware.application)。例如，這可用於在所有節點上實施身份驗證方案。

- `Trigger` 節點進行了重新設計，使其使用起來更加直觀。

- 編輯器可以應用自定義主題 —— 這對於那些想將編輯器嵌入另一個應用程式的使用者來說很方便。我們很快會對其進行適當的文件記錄，但在此之前，您可以從 [wiki](https://github.com/node-red/node-red/wiki/Design%3A-Editor-Themes) 獲取一些原始資訊。

- 編輯器現在會發出警告，如果您嘗試在背景中潛伏著一些未使用的配置節點的情況下進行部署。配置節點不會出現在畫布上，因此除非您從選單打開側邊欄標籤，否則不明顯它們在那裡。

  如果您是有意部署未使用的節點，可以關閉該警告。

- 在上一版本中引入的 `Catch` 節點現在提供了一些保護，防止流程陷入錯誤處理的無限循環。如果 catch 節點檢測到同一條訊息從同一個源節點發送給它超過 10 次，它將丟棄該訊息並記錄警告。有時流程像這樣循環可能是理想的，例如如果它正在重試某些操作直到成功。在這些情況下，流程應該刪除 `msg.error` 屬性以防止觸發此循環檢測。
