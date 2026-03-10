---
layout: blog
title: 0.9.0 版本已發佈
author: nick
---

Node-RED 0.9.0 現在已經可以 [下載](https://github.com/node-red/node-red/archive/0.9.0.zip) 或透過 [npm 安裝](https://npmjs.org/package/node-red)。

請閱讀 [升級說明](/docs/getting-started/upgrading_zh_TW.html)，獲取最新程式碼後別忘了運行 `npm update`。

### 有什麼新進展

#### 更快的啟動時間

幾個版本前的一個變化使得 Node-RED 在啟動時解析並壓縮所有的節點 `.html` 定義。這使我們能夠在將輸出提供給編輯器之前對其進行最小化。這一變化的缺點是每次 Node-RED 啟動時需要做的大量工作。這在 Raspberry Pi 等較小的平台上尤為明顯，啟動幾乎需要一分鐘。

在此版本中，我們撤回了該變化；與啟動時間的消耗相比，最小化輸出所帶來的節省是微不足道的。

#### 動態節點調色板

為了讓節點出現在側邊調色板中，傳統上它必須選擇預先存在的類別之一。這有其局限性，因此節點現在可以指定自己的類別。

我們還增加了一個管理 API，用於在運行時添加和刪除節點，而無需重啟 Node-RED。這還處於實驗階段，將在下一個版本中與一些使用它的工具一起穩定下來。如果您想了解更多資訊，請在 [郵件列表](https://groups.google.com/forum/#!forum/node-red) 上詢問。

在不久的將來，我們還將對核心節點進行一些重新組織，所以如果您關注 git 儲存庫，可以預期看到一些節點在調色板中移動以尋找新家。

#### 更快的 Function 節點

Function 節點是許多流程的基本構建塊之一。但它也是主要的瓶頸之一。此版本中對其實現的一些調整帶來了數量級的速度提升。它還改善了運行時的內存使用模式。

#### Awesome 圖示

如前所述，我們正在慢慢減少對 Bootstrap UI 框架的依賴。其中的關鍵部分是可供節點使用的圖示調色板。我們在上一個版本中提供了 [Font Awesome](http://fortawesome.github.io/Font-Awesome/)，現在已將所有核心節點遷移到其 [圖示](http://fortawesome.github.io/Font-Awesome/icons/)。我們建議節點作者也這樣做。

#### 幾乎無頭 (Almost-headless)

我們從 0.7 版本開始支持以無頭模式運行。這允許禁用編輯器和所有的管理 API。

隨著我們擴展 API 的功能，我們意識到我們需要一種「幾乎無頭」模式；在這種模式下，編輯器被禁用，但管理 API 仍然可用。

在此版本中，我們在設置檔案中增加了 `disableEditor` 選項。將此設置為 `true` 會停止運行時提供編輯器。所有的管理 API 端點保持可用。

#### 憑據文件 (Credential documentation)

節點現在有一種更容易與憑據系統交互的方式。隨著所有核心節點的更新以使用它，[文件](/docs/creating-nodes/credentials_zh_TW.html) 已更新以匹配。


#### Web 節點

我們為流行的 Web 服務建立了一個新的節點儲存庫。這會隨著時間推移而增長，但在此版本中，我們擁有的節點包括：

 - 將書籤保存到 [Delicious](http://delicious.com) 和 [Pinboard](http://pinboard.in)
 - 將照片上傳到 [Flickr](http://flickr.com)
 - 將文件保存到 [Dropbox](http://dropbox.com) 和 [Amazon S3](http://aws.amazon.com/s3)

要將這些節點添加到您的調色板，運行：

    $ npm install node-red-node-web-nodes


#### 節點更新

 - CSV 解析器節點現在可以處理更多類型的數據
 - Mongo 節點現在支持 `update`、`count` 和 `aggregate` 函數
 - TCP 節點可以配置為在每次傳輸後斷開連接。方便通知遠端傳輸已完成。
 - MQTT 節點現在支持在訊息上配置 qos 和 retain 選項。
 - Twitter 節點可以發布照片
 - RaspberryPi GPIO 節點支持 B+ 型號的引腳

#### 已棄用的節點

 我們在幾個版本前棄用了 `httpget` 節點，但它仍然存在。加入該名單的還有：

  - `imap` - 核心 email 節點提供了此功能
  - `parsexml`、`js2xml` - XML 解析器節點做得比這兩個中的任何一個都要好得多

所有這四個節點都已從調色板中移除，但在底層仍然存在。對它們都增加了棄用警告，它們 *將在下一個版本中被刪除*。

#### 可透過 npm 安裝的節點

發布到 npm 上的 Node-RED 節點集合正在不斷增長。我們已經將 node-red-nodes 儲存庫中的大多數節點發布到那裡，使它們非常容易安裝。

我們建議作者為他們的節點打上 `node-red` 標籤，以便它們出現在 [此搜索](https://www.npmjs.org/browse/keyword/node-red) 中。
