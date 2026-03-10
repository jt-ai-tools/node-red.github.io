---
layout: blog
title: 移至 JS 基金會 (JS Foundation)
author: nick
---

_[Nick O'Leary](https://twitter.com/knolleary) 與 [Dave Conway-Jones](https://twitter.com/ceejay)，[IBM 新興技術 (IBM Emerging Technologies)](https://www.ibm.com/blogs/emerging-technology/)_。


在 2013 年 1 月一個陰雨綿綿的日子裡，我開始嘗試如何將 MQTT 主題之間的訊息映射視覺化。在網頁瀏覽器中完成初步原型後，我向 Dave 展示，並表示只需點擊一個按鈕，就能讓視覺化介面更新運行中的系統。他毫不猶豫地回答：「那就做吧」，於是 Node-RED 誕生了。

不久後，我們為 Dave 正在處理的一個專案增加了一個序列埠節點，以便將 GPS 數據導入 MQTT。幾個月後，我們已經在客戶生產線的一組 Raspberry Pi 上運行它了。

那時這只是一個業餘專案；是在日常工作之餘擠出時間做的。隨著我們意識到這是一個非常有用的工具，問題變成了如何充分發揮它的潛力。

對我們來說，明顯的答案是將其開源並在公開環境中繼續開發。我們很快說服了管理層這是正確的路線，並在 2013 年 9 月將第一次提交推送到 GitHub。

轉眼三年過去了，我們發現自己擁有超過 325,000 次 npm 安裝量，超過 600 個節點貢獻給了社群，並且有超過 50 位非 IBM 員工為專案貢獻了程式碼。

Node-RED 已包含在 Raspberry Pi Raspbian 的主分發版中 —— 可以直接從桌面選單中存取。

[SenseTecnic](https://fred.sensetecnic.com/)、[AT&T](https://flow.att.com/) 和 [Red Ant](https://www.redconnect.io/) 等公司提供 Node-RED 服務。

硬體設備在出廠時已安裝 Node-RED 以便終端使用者進行配置 —— 例如 [Multitech MultiConnect Conduit](http://www.multitech.co.uk/brands/multiconnect-conduit) 和 Intel 的 IoT Gateway Developer Hub。

在貢獻給社群的眾多節點中，[Opto 22](http://www.opto22.com/) 等公司正在為其自己的設備提供 [節點](http://flows.nodered.org/node/node-red-contrib-pac)。

它已被用於建立 [精美的互動式燈光展示](https://momentfactory.com/work/all/all/nova-lumina)，幫助 [翻修運送救援物資的氣墊船](https://kk4oyj.wordpress.com/2016/10/09/hovercraft-instrumentation/)，以及讓 [恐龍栩栩如生](https://www.ibm.com/blogs/internet-of-things/bring-dinosaur-life/)。


當然，Node-RED 是 [IBM Watson IoT 平台開發者體驗](https://www.ibm.com/internet-of-things/roles/iot-developer/) 的關鍵部分，它可以輕鬆建立結合 IBM Bluemix 所提供之精華的物聯網應用程式。

這一切都得益於開放技術的力量。如果 Dave 和我把它留給自己，我們只會繼續處理我們的客戶專案，僅在需要時才進行增量更改。但透過公開開發，我們看到了一個社群圍繞它建立起來，幫助它推向了超出我們想像的高度。

### 邁向未來

這就引出了今天的公告。

[JS 基金會 (JS Foundation)](https://js.foundation/)，IBM 是其創始成員之一，旨在推動關鍵 JavaScript 解決方案及相關技術的廣泛採用和持續開發。透過與 Node.js 基金會的正式合作，它正在為 JavaScript 的一切建立一個重心。

作為啟動的一部分，我們很高興地宣布 Node-RED 正成為基金會內的一個專案。

<div style="text-align:center">
<img style="width:150px;" src="/blog/content/images/2016/10/jsf-hex.png" />
<img style="width:150px;" src="/blog/content/images/2016/10/nr-hex.png" />
</div>

成為基金會的一部分意味著我們將從各種專案之間增加的協作和交叉授權中受益。我們將擁有開放的技術治理結構，並可以使用指導計劃 (Mentorship Program)，幫助我們繼續推動創新並增加參與度。

在未來的幾天和幾週內，我們將與基金會內的其他專案一起將這些事情正式化。

但最重要的是，我們仍然是一個開放專案，繼續歡迎來自任何人的任何形式的貢獻。我們的 GitHub 組織不會改變，Dave 和我也不會離開，我們仍然致力於使 Node-RED 成為物聯網不可或缺的工具。


### 社群驅動

沒有你們（社群），我們今天就不會在這裡。此舉是對我們在短時間內共同取得的一切成就的極大肯定。

所以從 Dave 和我自己開始，衷心感謝您的熱情、您的貢獻，甚至是您在 GitHub 上提出的問題。

### 更多資訊

要了解有關此新聞的更多資訊，請查看：

 - [Linux 基金會的新聞稿](https://www.linuxfoundation.org/press-release/the-linux-foundation-unites-javascript-community-for-open-web-development/)
 - 來自 IBM 雲端架構與技術副總裁 [Angel Diaz 的部落格文章](https://www.ibm.com/blogs/cloud-computing/2016/10/ibm-partners-js-foundation/)

要了解如何將 Node-RED 與 IBM Watson IoT 結合使用，請嘗試 IBM Bluemix 中的 [入門應用程式](https://new-console.ng.bluemix.net/catalog/starters/internet-of-things-platform-starter/)。
