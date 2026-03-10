---
layout: blog
title: 了解節點何時處理完成
author: nick
description: Node-RED 1.0 中有一個用於處理訊息的新回呼函數 (callback function) 簽署。如果您建立了自己的節點，請了解有哪些變化、需要更新什麼以及如何保持向下相容。
---

**9/26 更新：** *更新了推薦的保持向下相容的方法*

為了處理訊息，節點會為 `input` 事件註冊一個監聽器。每當觸發該事件時，就會使用該訊息呼叫註冊的回呼函數：

```javascript
this.on('input', function(msg) {

})
```

在此函數中，節點可以執行它需要執行的任何工作，並且在某個時刻它可能會呼叫 `node.send()` 以發送訊息。我說「在某個時刻」，是因為執行環境並不知道節點計劃做什麼。有許多種可能性，例如：

 - 它可能是一個完全同步的函數，並在返回之前呼叫 `node.send()`。
 - 它可能會執行一些非同步操作，並在事件處理函數返回後的未來某個時間呼叫 `node.send()`。
 - 它可能會多次呼叫 `node.send()`。
 - 它可能什麼都不發送。

這使得執行環境無法確定節點何時完成了訊息處理。這也意味著，當節點發送訊息時，無法知道它*為什麼*發送訊息。

### 為什麼這很重要？

到目前為止，即使執行環境不知道這些事情，Node-RED 也運作得非常好。然而，當我們展望 1.0 版本之後，有許多新功能將需要這些額外資訊。

例如，我在[之前的部落格文章](/blog/2019/08/16/going-async_zh_TW#node-timeouts)中提到，我們正在研究執行環境如何更好地監控流經流程的訊息，並提供一種標準方法來為任何耗時過長的節點設定逾時。

另一個正在研究的功能是能夠更優雅地關閉流程 — 以便流程可以停止接受新工作，但允許正在傳輸中的訊息完成在流程中的傳遞。

只有當執行環境知道節點何時處理完一條訊息時，這些功能才有可能實現。

### 有哪些變化？

為了探討這個問題，我們將在 1.0 版本中為 `input` 事件回呼函數引入一個新簽署。

```javascript
this.on('input', function(msg, send, done) {

})
```

除了接收訊息物件外，該函數還被賦予了專門用於*該*訊息的 `send` 和 `done` 函數。

`send` 函數是 `node.send()` 的直接替代品。關鍵區別在於，當它被呼叫時，執行環境將能夠將其與接收到的原始 `msg` 物件關聯起來。

處理完訊息後，必須呼叫 `done` 函數。它接受一個可選參數，即如果節點由於某種原因無法處理訊息時的 `error` 物件。

例如：

```javascript
this.on('input', function(msg, send, done) {
    // 對 msg 執行一些工作
    someImaginaryLibrary(msg, (err, result) => {
        if (err) {
            // 回報錯誤。這相當於
            //    node.error(err,msg)
            // 但同時也處理了逾時問題
            done(err);
        } else {
            msg.payload = result;
            send(msg);
            done();
        }
    })
})
```

### 新增 Complete 節點

此新 API 的用途之一是在沒有輸出的節點（例如 Email 節點）處理完成時觸發流程。這就是新的「Complete」節點發揮作用的地方。

如果一個節點呼叫了 `done()`，它將觸發工作區中配置為針對該節點的任何「Complete」節點。如果呼叫 `done` 時帶有錯誤，則它將觸發任何「Catch」節點，就像現有的 `node.error(err,msg)` 呼叫一樣。


### 向下相容性

在我撰寫本文時，流程庫中已有 2200 多個節點模組。顯然，它們不會在一夜之間更新到這個新的回呼簽署。但這沒問題，因為執行環境能夠檢測節點註冊的是「舊式」還是「新式」回呼函數，並進行相應處理。

我們希望節點作者能隨著時間的推移將他們的節點遷移到這種新格式。

我們也體認到並非所有人會立即升級到 Node-RED 1.0。那麼，如果一個節點使用了新的回呼簽署，但它被安裝在 1.0 之前的 Node-RED 版本中，會發生什麼呢？

為了讓其正常運作，可以採用防禦性寫法，使其在任何一種情況下都能工作：

```javascript
let node = this;
this.on('input', function(msg, send, done) {
    // 如果是 1.0 之前版本，'send' 將未定義，因此回退到 node.send
    send = send || function() { node.send.apply(node,arguments) }
    // 對 msg 執行一些工作
    someImaginaryLibrary(msg, (err, result) => {
        if (err) {
            // 回報錯誤
            if (done) {
                 // 如果已定義，使用 done (1.0+)
                done(err)
            } else {
                // 回退到 node.error (1.0 之前版本)
                node.error(err, msg);
            }
        } else {
            msg.payload = result;
            send(msg);
            // 檢查 done 是否存在 (1.0+)
            if (done) {
                done();
            }
        }
    })
})
```

我們將為 1.0 版本的發佈準備好所有相關的完整文件。
