---
layout: blog
title: 0.5.0 版本已發佈
author: nick
---

比計劃晚了一點，Node-RED 0.5.0 現在已經可以 [下載](https://github.com/node-red/node-red/archive/0.5.0.zip) 或透過 [npm 安裝](https://npmjs.org/package/node-red)。請閱讀 [升級說明](/docs/getting-started/upgrading_zh_TW.html)。

### 有什麼新進展

#### 未部署的更改
我們收到的一個回饋是，僅僅改變部署按鈕的顏色不足以指示有未部署的更改；對於色盲使用者來說，這根本行不通。

為了改善這一點，我們在已添加或編輯但尚未部署的節點上增加了一個新標記。

![更改的節點標記](/blog/content/images/2013/Dec/Selection_001.png)

#### 未知節點
從其他地方匯入流程時，如果其中包含您未安裝的節點，我們現在會使用特殊的未知節點 (unknown-node) 類型替換缺失的節點，而不是拒絕執行匯入。這意味著您可以匯入流程，查看您缺少什麼，然後安裝缺失的節點類型並重新嘗試匯入，或者刪除缺失的節點。

為了使未知節點非常明顯，它們採用了非常獨特的樣式：

![未知節點類型](/blog/content/images/2013/Dec/Selection_002.png)

#### 命令列參數
在上一個版本中，我們增加了將所有使用者數據移動到 Node-RED 安裝目錄之外的位置的功能。這是在 `settings.js` 檔案中設定的，這產生了一個問題 —— 該檔案必須存在於安裝目錄中，以便我們找到它。

在此版本中，您現在可以將該檔案作為命令列參數指向：

    $ node red.js --settings /home/nol/.node-red/settings.js

您可以使用 `--settings` 或 `-s`。

### 節點更新
#### Twitter 節點
Twitter 節點現在可以追蹤特定使用者的推文以及經過身份驗證的使用者的直接訊息 (DM)。這兩項功能都使用輪詢 API，而不是其他搜尋類型中更高效的串流 (streaming) API。這意味著它們受到 Twitter 強加的相當嚴格的速率限制。它們大約每分鐘檢查一次新推文，每兩分鐘檢查一次新 DM。

如果您有多個節點使用這些功能，且都經過同一使用者的身份驗證，您可能會遇到速率限制，而無法獲取您期望的所有推文。

#### TCP 節點
在此版本之前，TCP 節點沒有個人連線的概念；TCP Out 節點會將訊息廣播到所有連線。在此版本中，節點現在具備連線階段 (session) 感知能力。給定一個以 TCP In 節點開始並以 TCP Out 節點結束的流程，Out 節點現在可以設定為僅回覆觸發流程的連線。

這是一個充當 Echo 伺服器的流程：

![一個 TCP Echo 伺服器](/blog/content/images/2013/Dec/Selection_004.png)

    [{"id":"6534336a.9acbcc","type":"tcp in","server":"server","host":"","port":"9001","datamode":"stream","datatype":"buffer","newline":"","topic":"","name":"","base64":false,"x":80,"y":140,"z":"e1c9f85b.1e3608","wires":[["2f63c46b.d09c3c"]]},{"id":"c5d83ebc.3a27c","type":"tcp out","host":"","port":"","beserver":"reply","base64":false,"name":"","x":320,"y":140,"z":"e1c9f85b.1e3608","wires":[]},{"id":"2f63c46b.d09c3c","type":"function","name":"","func":"msg.payload = \"You said: \"+msg.payload.toString();

return msg;","outputs":1,"x":200,"y":140,"z":"e1c9f85b.1e3608","wires":[["c5d83ebc.3a27c"]]}]

部署此流程後，您可以 telnet 到 `localhost:9001`，您輸入的任何內容都會被回顯：

    $ telnet localhost 9001
    Trying 127.0.0.1...
    Connected to localhost.
    Escape character is '^]'.
    Hi There
    You said: Hi There

#### WebSocket 節點
現在建立 Node-RED 生成的事件的即時儀表板變得更加容易。WebSocket 節點允許您在網頁中發送和接收訊息。與 TCP 節點一樣，它們具有連線感知能力。這意味著您可以輕鬆建立一個流程，該流程以透過 WebSocket 連線發送的訊息開始，執行某些查詢，然後透過同一個連線返回結果。

#### 其他核心節點更新
- MQTT 節點現在支援指定用於連線的用戶端 ID、使用者名稱和密碼。
- Switch 節點現在具有「otherwise」選項，以及一旦找到匹配項就停止檢查匹配項的選項。這允許構建傳統的 `if-else` 風格邏輯流程。
- Serial 節點允許您指定分隔符號來拆分傳入數據。它現在有一個選項，可以自動將分隔符號附加到發送回的訊息中
- HTTP Request 節點現在會自動追蹤 301 重定向


#### 新節點
[node-red-nodes](https://github.com/node-red/node-red-nodes) 儲存庫已接受更多新節點的 pull-requests：

- Snapchat 節點
- Phillips Hue 節點

### 下一步是什麼？
npm 安裝式節點已經在待辦清單上有一段時間了；現在可能是時候開始著手這項工作了。

另一個要解決的問題是將管理 UI 與運行時 (runtime) 更好地分離。目前，您可以使用 `httpRoot` 來移動提供管理 UI 的位置以及應用基本身份驗證。一個不幸的副作用是，如果您保護了管理 UI，最終也會保護 HTTP In 節點 —— 這可能不是預期的結果。我們需要將這些分開，但挑戰在於如何以向後相容的方式做到這一點。

還有一些新節點的 [pull-requests](https://github.com/node-red/node-red-nodes/pulls) 正在系統中處理。
