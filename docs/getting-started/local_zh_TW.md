---
layout: docs-getting-started
toc: toc-user-guide.html
title: 在本地運行 Node-RED
slug: local
redirect_from:
  - /docs/getting-started/installation
  - /docs/getting-started/running
  - /docs/getting-started/upgrading

---

<div class="doc-callout">
<div style="float: left; margin-right: 10px;"><img src="/images/logos/raspberrypi.svg" height="30">
<img src="/images/logos/debian.svg" height="30">
<img src="/images/logos/ubuntu.svg" height="30">
</div>
如果您使用的是 Raspberry Pi 或任何基於 Debian 的操作系統（包括 Ubuntu 和 Diet-Pi），您可以使用<a href="raspberrypi_zh_TW.html">此處</a>提供的 Pi 安裝腳本。
</div>

<div class="doc-callout">
<div style="float: left; margin-right: 10px;"><img src="/images/logos/redhat.svg" height="30">
<img src="/images/logos/fedora.svg" height="30">
<img src="/images/logos/centos.svg" height="40">
</div>
如果您使用的是基於 RPM 的操作系統（包括 RedHat、Fedora 和 CentOS），您可以使用<a href="https://github.com/node-red/linux-installers">此處</a>提供的 RPM 安裝腳本。
</div>

<div class="doc-callout">
<div style="float: left; margin-right: 10px; margin-bottom: 10px;">
<img src="/images/logos/windows.svg" height="30">
</div>
如果您使用的是 Windows，可以在<a href="/docs/getting-started/windows_zh_TW.html">此處</a>找到安裝 Node-RED 的詳細說明。
</div>

### 先決條件

要在本地安裝 Node-RED，您需要一個[受支援的 Node.js 版本](/docs/faq/node-versions_zh_TW.html)。

### 使用 npm 安裝

要安裝 Node-RED，您可以使用 Node.js 附帶的 `npm` 命令：

```
sudo npm install -g node-red
```

如果您使用的是 Windows，請不要在命令開頭使用 <code>sudo</code>。

該命令將把 Node-RED 及其依賴項安裝為全局模組。

如果命令輸出的末尾看起來與以下內容相似，則可以確認安裝成功：

```
+ node-red@4.1.7
added 227 packages in 13s
found 0 vulnerabilities
```

### 使用 Docker 安裝

要以最簡單的形式在 Docker 中運行，只需執行：
```
docker run -it -p 1880:1880 --name mynodered nodered/node-red
```
有關更多詳細信息，請參閱我們的 [Docker](/docs/getting-started/docker_zh_TW.html) 指南。

### 使用 Snap 安裝

通常不推薦，但如果您的操作系統支持 [Snap](https://snapcraft.io/docs/core/install)，您可以使用以下命令安裝 Node-RED：

```
sudo snap install node-red
```

當作為 Snap 軟體包安裝時，它將在一個安全的容器中運行，該容器**無法訪問**您可能需要使用的一些額外設施，例如：

 - 訪問主系統存儲。只能讀取/寫入本地用戶目錄。
 - `gcc` - 用於編譯您想要安裝的節點的任何二進制組件
 - `git` - 如果您想使用專案 (Projects) 功能則需要
 - 直接訪問 GPIO 硬體
 - 訪問您的流程想要與 Exec 節點（例如）一起使用的任何外部命令。

<div class="doc-callout">
如果您需要訪問系統硬體或添加需要編譯的節點，那麼我們建議使用完整安裝的 Node-RED，而不是使用 snap。
</div>

### 運行

一旦安裝為全局模組，您可以使用 `node-red` 命令在終端中啟動 Node-RED。您可以使用 `Ctrl-C` 或關閉終端窗口來停止 Node-RED。

```
$ node-red

Welcome to Node-RED
===================
06 Mar 21:51:27 - [info] Node-RED version: v4.1.7
06 Mar 21:51:27 - [info] Node.js  version: v22.22.1
06 Mar 21:51:27 - [info] Linux 6.8.0-90-generic x64 LE
06 Mar 21:51:27 - [info] Loading palette nodes
06 Mar 21:51:30 - [info] Settings file  : /home/pi/.node-red/settings.js
06 Mar 21:51:30 - [info] Context store  : 'default' [module=memory]
06 Mar 21:51:30 - [info] User directory : /home/pi/.node-red
06 Mar 21:51:30 - [warn] Projects disabled : editorTheme.projects.enabled=false
06 Mar 21:51:30 - [info] Flows file     : /home/pi/.node-red/flows.json
06 Mar 21:51:30 - [info] Server now running at http://127.0.0.1:1880/
06 Mar 21:51:30 - [info] Starting flows
```

然後，您可以通過將瀏覽器指向 <http://localhost:1880> 來訪問 Node-RED 編輯器。

日誌輸出為您提供各種信息：

 - Node-RED 和 Node.js 的版本
 - 嘗試加載節點面板時遇到的任何錯誤
 - 設置文件 (Settings file) 和用戶目錄 (User Directory) 的位置
 - 正在使用的流程文件的名稱。

Node-RED 使用 `flows.json` 作為預設流程文件。您可以通過將流程文件名作為 `node-red` [命令](/docs/getting-started/local_zh_TW.html#命令行用法)的參數來更改此設置。

### 命令行用法

可以使用 `node-red` 命令啟動 Node-RED。此命令可以帶有各種參數：

```
node-red [-v] [-?] [--settings settings.js] [--userDir DIR]
         [--port PORT] [--title TITLE] [--safe] [flows.json|projectName]
         [-D X=Y|@file]
```

選項                    | 描述            |
------------------------|-----------------|
`-p`, `--port PORT`     | 設置運行時偵聽的 TCP 端口。預設值：`1880` |
`--safe`                | 在不啟動流程的情況下啟動 Node-RED。這允許您在編輯器中打開流程並進行更改，而無需運行流程。當您部署更改時，流程隨後會啟動。 |
`-s`, `--settings FILE` | 設置要使用的設置文件。預設值：`userDir` 中的 `settings.js` |
`--title TITLE`         | 設置程序窗口標題 |
`-u`, `--userDir DIR`   | 設置要使用的用戶目錄。預設值：`~/.node-red` |
`-v`                    | 啟用詳細輸出 |
`-D X=Y|@file`          | [覆蓋單個設置](#覆蓋單個設置) |
`-?`, `--help`          | 顯示命令行用法說明並退出 |
`flows.json|projectName`| 如果未啟用專案功能，這將設置您要處理的流程文件。如果啟用了專案功能，這將標識應啟動哪個專案。 |

Node-RED 使用 `flows.json` 作為預設流程文件。您可以提供不同的文件名；可以作為命令行參數，也可以使用[設置文件](/docs/user-guide/runtime/settings-file_zh_TW.html)中的 `flowsFile` 選項。

#### 覆蓋單個設置

您可以使用 `-D`（或 `--define`）選項在命令行上覆蓋單個設置。

例如，要更改日誌級別，您可以使用：
```
-D logging.console.level=trace
```

您也可以將自定義設置作為文件提供：
```
-D @./custom-settings.txt
```

該文件應包含要覆蓋的設置列表：
```
logging.console.level=trace
logging.console.audit=true
```


### 將參數傳遞給底層 Node.js 進程

有時需要將參數傳遞給底層 Node.js 進程。例如，在內存受限的設備（如 Raspberry Pi 或 BeagleBone Black）上運行時。

為此，您必須使用 `node-red-pi` 啟動腳本代替 `node-red`。
_注意_：此腳本在 Windows 上不可用。

或者，如果您使用 `node` 命令運行 Node-RED，則必須在指定 `red.js` 和要傳遞給 Node-RED 本身的參數之前，為 node 進程提供參數。

以下兩個命令顯示了這兩種方法：

    node-red-pi --max-old-space-size=128 --userDir /home/user/node-red-data/
    node --max-old-space-size=128 red.js --userDir /home/user/node-red-data/

### 升級 Node-RED

<div class="doc-callout">
<div style="float: left; margin-right: 10px;"><img src="/images/logos/raspberrypi.svg" height="30">
<img src="/images/logos/debian.svg" height="30">
<img src="/images/logos/ubuntu.svg" height="30">
</div>
如果您使用 Pi 腳本安裝了 Node-RED，可以重新運行它進行升級。該腳本在<a href="/docs/hardware/raspberrypi_zh_TW.html">此處</a>可用。</div>

如果您已將 Node-RED 安裝為全局 npm 軟體包，則可以使用以下命令升級到最新版本：

```
sudo npm install -g node-red
```

如果您使用的是 Windows，請不要在命令開頭使用 <code>sudo</code>。


### 下一步

 - [了解如何保護您的編輯器](/docs/user-guide/runtime/securing-node-red_zh_TW.html)
 - [創建您的第一個流程](/docs/tutorials/first-flow_zh_TW.html)
 - [開機時啟動 Node-RED](/docs/faq/starting-node-red-on-boot_zh_TW.html)
