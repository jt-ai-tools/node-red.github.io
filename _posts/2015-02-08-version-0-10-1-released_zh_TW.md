---
layout: blog
title: 0.10.1 版本已發佈
author: nick
---

Node-RED 0.10.1 現在已經可以 [下載](https://github.com/node-red/node-red/archive/0.10.1.zip) 或透過 [npm 安裝](https://npmjs.org/package/node-red)。

請閱讀 [升級說明](/docs/getting-started/upgrading_zh_TW.html)，獲取最新程式碼後別忘了運行 `npm update`。

### 有什麼新進展

#### 子流程 (Subflows)
此版本的主要新功能之一是引入了子流程。它們允許您將一組節點分組並折疊成一個單一節點，然後該節點會出現在 _subflow_ 調色板類別中。接著，您可以根據需要將任意數量的子流程實例拖到工作區中。

![子流程編輯](/blog/content/images/2015/Feb/Selection_136.png)

要開始使用，請選擇 `Create subflow` 選單選項。

#### 新的部署選單

有時候，僅僅為了添加一個新節點或微調現有節點而重新啟動流程是不方便的。例如，如果您的流程包含 Twitter 輸入節點，並且您在 15 分鐘內過於頻繁地重新部署，您很快就會達到 Twitter API 的速率限制。如果您有一個捕獲數據並將其存儲在資料庫中的節點，重新部署會導致中斷，因此可能會遺漏一些數據。

此版本增加了一些新的部署選項，旨在幫助避免這些問題。現在有三種部署模式：

- Full (完整) —— 我們一直以來使用的模式，也是預設模式
- Modified Nodes (已修改節點) —— 僅停止並重新建立包含更改的節點。如果添加/移除了任何新的連線，它們會被補丁進去，而不需要重新啟動連線兩端的節點（除非它們有其他實質性更改）。
- Modified Flows (已修改流程) —— 與已修改節點處於同一流程中的節點會被停止並重新建立。對流程連線的更改會導致整個流程被停止並重新建立。

為了展示這些選項，Deploy 按鈕現在旁邊有一個下拉選單，用於挑選按下按鈕時執行的部署類型：

![新部署選單](/blog/content/images/2015/Feb/Selection_135.png)

關於子流程的一個附註，因為它們的處理方式略有不同。如果子流程定義中有任何更改，整個子流程將被視為「已更改」節點 —— 換句話說，我們不會將更改補丁到運行的子流程中，我們會始終停止整個子流程並重新建立它。


#### 保護編輯器 (Securing the Editor)

在之前的版本中，可以通過在設置文件中硬編碼使用者名稱/密碼來使用 HTTP 基本身份驗證保護編輯器。雖然這對於簡單的 Node-RED 本地安裝有效，但它從來不是一個真正好的解決方案。

此版本帶來了一個更好的保護編輯器框架。

我們不再使用基本身份驗證，而是轉向了基於存取令牌 (access token) 的系統。當使用者登入時，我們將其使用者名稱/密碼換成存取令牌，然後該令牌可用於向 API 發出經過身份驗證的請求。對於技術人員來說，我們實現了 OAuth 2.0 的資源所有者密碼憑據授權 (Resource Owner Password Credentials Grant) (RFC 6749, Section 4.3)。

如果硬編碼使用者名稱/密碼適合您，您仍然可以這樣做，但您也可以插入自己的程式碼來驗證使用者。

我們還增加了使用者權限的概念；識別單個使用者可以做什麼和不能做什麼。這使得授予使用者對編輯器的唯讀存取權變得簡單 —— 這樣他們可以看到流程，但不能部署回任何更改。

有關如何配置和啟用此功能的更多詳細資訊，請參閱 [文件](/docs/security_zh_TW.html)。


#### 其他編輯器變更

- [節點狀態選項](http://blog.nodered.org/2014/06/26/version-0-8-0-released/#nodestatusindicators) 現在預設啟用。編輯器會記住您將其設置為什麼狀態（以及您是否打開了側邊欄）。
- 調色板類別的順序可以在設置文件中定製 —— 例如，如果您想將一些自定義節點放在調色板的頂部。

#### Raspberry Pi GPIO 節點

Raspberry Pi GPIO 節點進行了重大更新。

它們現在基於內置的 RPi.GPIO python 庫 —— 只要它是 0.5.8 或更新版本，它就使用中斷來檢測輸入，因此響應速度更快，且比之前的輪詢方法佔用更少的 CPU。

它們現在還支持在所有輸出口上使用軟件 PWM，因此現在可以實現 LED 漸變和馬達速度控制。

此 RPI.GPIO 庫是所有近期 Raspbian 發行版的一部分，因此除非您有一段時間沒升級，否則它應該預設存在。如果您的安裝損壞，您將需要升級您的 Pi 以確保您擁有必要的文件。

    sudo apt-get update
    sudo apt-get install python-dev python-rpi.gpio

然後您應該能夠運行

    <node-red install dir>/nodes/core/hardware/nrgpio ver 0

它應該回覆 0.5.8 (或更好) —— 這是 RPi.GPIO 庫的版本。

最新說明在 [這裡](/docs/hardware/raspberrypi_zh_TW.html)。


#### 節點更新
- Function 節點 —— 報告運行時錯誤及其行號
- MQTT —— 接收二進位 (binary) payload
- HTTP Request —— 接收二進位 payload
- IRC 節點 —— 改進了連接可靠性
- Debug 節點 —— 您現在可以設置應將哪個屬性發送到 debug，而不是假設為 `msg.payload`。
- Mongo 節點 —— 增加了新的結果分頁 skip 選項
- Switch 節點 —— 規則可以通過在列表中拖動來重新排序。
- Raspberry Pi Mouse 節點 —— 允許 USB 連接的滑鼠將點擊作為輸入提供給流程。它支持 2 鍵或 3 鍵滑鼠，專門針對 Raspberry Pi。

#### 已棄用的節點
我們在過去幾個版本中 [棄用](http://blog.nodered.org/2014/09/24/version-0-9-0-released/#deprecatednodes) 的節點已被移除。

### 支持的 Node 版本
目前，我們 **不支持** 在新發佈的 [node v0.12](http://blog.nodejs.org/2015/02/06/node-v0-12-0-stable/) 上運行。我們將努力增加支持，但這在很大程度上取決於我們使用的模組維護者是否增加支持。這在一段時間內對許多 node.js 應用程式可能都是如此。

增加對 v0.12 支持的一個後果是，在此版本之後我們將 **停止支持 v0.8**。

### Raspberry Pi 2
隨著 Raspberry Pi 2 的驚喜發佈（嗯，對我們來說是驚喜），人們對在它上面運行 Node-RED 自然產生了濃厚的興趣。主要障礙是在上面獲得正確構建的 node.js 版本。[此頁面](https://github.com/joyent/node/wiki/installing-node.js-via-package-manager#debian-and-ubuntu-based-linux-distributions) 有一個指南可以幫助您安裝。

請注意，目前已知 GPIO 節點無法工作；它們正在等待底層庫的更新，`apt-get upgrade` 最終應該會獲取到該更新。
