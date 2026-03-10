---
layout: blog
title: 0.4.0 版本已發佈
author: nick
---

Node-RED 0.4.0 現在已經可以 [下載](https://github.com/node-red/node-red/archive/0.4.0.zip) 或透過 [npm 安裝](https://npmjs.org/package/node-red)。請閱讀 [升級說明](/docs/getting-started/upgrading_zh_TW.html)。

### 新的設定選項

此版本帶來了一些新的設定選項。它們都記錄在 [此處](/docs/configuration_zh_TW.html)，但有幾個值得特別提出。

預設情況下，所有使用者數據通常存放在 Node-RED 安裝目錄中。當您使用 `npm` 安裝時，這並不理想，因為在您執行 `npm update` 升級到下一個版本時，這些數據都會遺失。同樣地，您添加到 `nodes` 目錄的任何自定義節點也會被移除。

為了解決這個問題，我們增加了兩個新的設定選項：

- `userDir` 指向存放所有數據的目錄。如果未設定，它將像以前一樣使用安裝目錄。
- `nodesDir` 指向包含您想要添加到調色板 (palette) 的節點的目錄。除了現有的 `nodes` 目錄外，還會搜尋此目錄，因此您可以兩者都使用。

嵌入 Node-RED 的一個常見場景是將其放在展示生成數據的儀表板後面。以前，您必須將 Node-RED [嵌入](/docs/embedding_zh_TW.html) 到另一個 node.js 應用程式中才能實現這一點。

為了使這更加容易，新的 `httpStatic` 屬性可用於指向一個檔案目錄，當有人將瀏覽器指向 http://localhost:1880（或您設定 Node-RED 監聽的任何地方）時，將提供這些檔案。為了使此功能正常運作，您 *必須* 同時設定 `httpRoot` 以將編輯器 UI 從 `/` 移開。

現有的 `httpAuth` 屬性（可用於啟用身份驗證）*僅* 適用於編輯器 UI，而不適用於靜態檔案。這意味著目前無法使用這些選項來保護靜態內容 —— 如果您需要這一點，您應該使用嵌入方法。我們將在未來的版本中解決這個問題。


### 節點更新
現有節點已進行了各種錯誤修復。值得一提的一個新功能是 Delay 節點現在可以設定為在兩個值之間延遲隨機的時間量。

我們已將 `json2xml` 添加到核心儲存庫中，以提供現有 `xml2js` 節點的反向映射。

在 [node-red-nodes](https://github.com/node-red/node-red-nodes) 儲存庫中，添加了一些新節點：

 - `wemo` - 控制 Wemo 插座和開關，
 - `twilio` - 使用 Twilio 服務發送簡訊（由 [Andrew Lindsay](http://blog.thiseldo.co.uk/) 貢獻）
 - `rawserial` - 僅適用於未安裝 `serialport` 的 Windows 機器。使用簡單的序列埠讀取作為檔案來輸入數據。在啟動 Node-RED 之前，您必須在外部設定波特率等。此節點未實現連接池，因此每個埠只能使用一個實例 —— 意即只能輸入或輸出，不能兩者兼具。
 - `mdp` - MPD 音樂控制節點。輸出節點預期 payload 為有效的 mpc 指令。目前僅支援不需要回覆的簡單指令。輸入節點建立一個包含演出者、專輯、曲名、類型和日期的 payload 物件。
 - `mysql` - 允許對 MySQL 資料庫進行基本存取。
 - `swearfilter` - 分析 payload 並嘗試過濾掉任何包含髒話的訊息。適合向您的父母展示現場 Twitter 演示。

### 下一步是什麼？

目前有大量的 [待處理問題 (issues)](https://github.com/node-red/node-red/issues?state=open)，我們還有一堆想法待處理。

清單頂部附近的一些項目包括：

 - 如果您有未部署更改的節點，使其更加明顯
 - 為 MQTT 節點添加用戶端 ID、使用者名稱和密碼支援。甚至可能加入遺囑 (Last Will and Testament) 支援。
 - 在 TCP 節點中啟用面向連線 (session-oriented) 的連接。



### 即將舉行的活動

即將有幾個活動，我們將在會中談論 Node-RED。

[IOT London Meetup](http://www.meetup.com/iotlondon/events/145842362/) 是下週二。像往常一樣，報名人數已高度超額，希望您已經在名單上。

12 月 2 日和 3 日是 [ThingMonk](http://redmonk.com/thingmonk/)，這是一個為期兩天、關於物聯網的活動。我將以「集成 (Integration)」為主題發表演講：
> 物聯網不是技術、方法或哲學的單一選擇。它的存在是多個平台、產品和協議的匯集，其整體大於部分的總和。

>我們需要讓開發者盡可能輕鬆地製作東西，無論是為了娛樂還是獲利，嚴肅還是異想天開，專業還是業餘。

請務必 [購買您的門票](http://redmonk.com/thingmonk/tickets/)，我們在那裡見。
