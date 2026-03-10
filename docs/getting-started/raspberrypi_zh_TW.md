---
layout: docs-getting-started
toc: toc-user-guide.html
title: 在 Raspberry Pi 上運行
slug: raspberry pi
redirect_from:
  - /docs/hardware/raspberrypi
---

### 安裝和升級 Node-RED

我們提供了一個腳本，用於在 Raspberry Pi 以及其他運行基於 Debian 的操作系統的平台上安裝 Node.js、npm 和 Node-RED。當有新版本可用時，該腳本還可用於升級現有的安裝。

運行以下命令將下載並運行該腳本。如果您想先查看腳本的內容，可以[在 Github 上](https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)查看。

```
bash <(curl -sL https://github.com/node-red/linux-installers/releases/latest/download/update-nodejs-and-nodered-deb)
```

您可以向腳本傳遞額外的參數。在上述命令的末尾添加 <code> --help</code> 即可查看這些參數。

<div class="doc-callout">
<div style="float: left; margin-right: 10px; margin-bottom: 30px;">
<img src="/images/logos/debian.svg" height="30">
<img src="/images/logos/ubuntu.svg" height="30">
</div>
此腳本適用於任何<b>基於 Debian</b> 的操作系統，包括 <b>Ubuntu</b> 和 <b>Diet-Pi</b>。您可能需要先運行 <code>sudo apt install build-essential git curl</code>，以確保 npm 能夠獲取並構建它需要安裝的任何二進制模組。
</div>

此腳本將：

 - 如果存在舊版本的 Node-RED，則將其刪除。
 - 如果檢測到已安裝 Node.js，它將確保其版本至少為 v20。如果未找到，它將使用 [NodeSource](https://nodesource.com/products/distributions) 軟體包安裝 Node.js v22 LTS 版本。
 - 使用 npm 安裝最新版本的 Node-RED。
 - （可選）安裝一系列有用的 Pi 專用節點。
 - 將 Node-RED 設置為以服務形式運行，並提供一組用於操作該服務的命令。

<div class="doc-callout">
<div style="float: left; margin-right: 10px;margin-bottom: 40px;">
<img src="/images/logos/raspberrypi.svg" height="30">
**注意**：從 Node v24 開始，不再提供 32 位版本 - 因此將不再支援基於 armv6 的 Pi 設備。
</div>

</div>

### 在本地運行

與[在本地運行 Node-RED](/docs/getting-started/local_zh_TW.html) 一樣，您可以使用 `node-red` 命令在終端中運行 Node-RED。然後可以通過按 `Ctrl-C` 或關閉終端窗口來停止它。

由於 Raspberry Pi 的內存有限，您可能需要帶有額外參數來啟動 Node-RED，以告知底層 Node.js 進程比平時更早地釋放未使用的內存。

為此，您應該使用替代的 `node-red-pi` 命令並傳入 `max-old-space-size` 參數。

```
node-red-pi --max-old-space-size=256
```

### 作為服務運行

安裝腳本還將其設置為以服務形式運行。這意味著它可以在後台運行，並設置為在開機時自動啟動。

提供以下命令來操作該服務：

 - `node-red-start` - 啟動 Node-RED 服務並顯示其日誌輸出。按 `Ctrl-C` 或關閉窗口*不會*停止服務；它會繼續在後台運行。使用 `node-red-log` 重新附加並查看日誌。
 - `node-red-stop` - 停止 Node-RED 服務
 - `node-red-restart` - 重啟 Node-RED 服務
 - `node-red-reload` - 停止然後啟動 Node-RED 服務
 - `node-red-log` - 顯示服務的日誌輸出

您還可以通過選擇 `Menu -> Programming -> Node-RED` 菜單選項在 Raspberry Pi OS 桌面啟動 Node-RED 服務。

### 開機時自動啟動

如果您希望在設備開啟或重啟時運行 Node-RED，可以通過運行以下命令啟用服務自動啟動：

```
sudo systemctl enable nodered.service
```

要禁用該服務，請運行以下命令：
```
sudo systemctl disable nodered.service
```

### 打開編輯器

Node-RED 運行後，您可以在瀏覽器中訪問編輯器。

如果您使用的是 Pi 桌面上的瀏覽器，可以打開地址：<http://localhost:1880>。

<div class="doc-callout">我們建議使用 Pi 以外的瀏覽器，並將其指向在 Pi 上運行的 Node-RED。但是，您可以使用內置瀏覽器，如果是這樣，我們建議使用 Chromium 或 Firefox。

從另一台機器瀏覽時，應使用 Pi 的主機名或 IP 地址：`http://<hostname>:1880`。您可以通過在 Pi 上運行 `hostname -I` 來查找 IP 地址。


### 下一步

- [了解如何保護您的編輯器](/docs/user-guide/runtime/securing-node-red_zh_TW.html)
- [創建您的第一個流程](/docs/tutorials/first-flow_zh_TW.html)
- [將節點添加到面板](/docs/user-guide/runtime/adding-nodes_zh_TW.html)
