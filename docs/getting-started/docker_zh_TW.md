---
layout: docs-getting-started
title: 在 Docker 下運行
toc: toc-user-guide.html
slug: docker
redirect_from:
  - /docs/platforms/docker
---

本指南假設您對 Docker 和 [Docker 命令行](https://docs.docker.com/engine/reference/commandline/cli/) 有一些基本瞭解。它介紹了在 Docker 下運行 Node-RED 的多種方法，並支援多種架構（amd64、arm32v6 arm32v7、arm64v8 和 s390x）。

從 Node-RED 1.0 開始，[Docker Hub](https://hub.docker.com/r/nodered/node-red/) 上的存儲庫已重命名為 `nodered/node-red`。

### 快速入門

要以最簡單的形式在 Docker 中運行，只需執行：

        docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered nodered/node-red

讓我們剖析一下該命令：

        docker run              - 運行此容器，如有必要，最初在本地進行構建
        -it                     - 附加終端會話，以便我們可以看到發生了什麼
        -p 1880:1880            - 將本地端口 1880 連接到公開的內部端口 1880
        -v node_red_data:/data  - 將名為 `node_red_data` 的 docker 具名卷掛載到容器的 /data 目錄，以便對流程所做的任何更改都能持久化
        --name mynodered        - 為此機器提供一個友好的本地名稱
        nodered/node-red        - 作為基礎的鏡像 - 當前為 Node-RED v1.2.0

運行該命令應該會得到一個帶有正在運行的 Node-RED 實例的終端窗口。

        Welcome to Node-RED
        ===================

        10 Oct 12:57:10 - [info] Node-RED version: v1.2.0
        10 Oct 12:57:10 - [info] Node.js  version: v10.22.1
        10 Oct 12:57:10 - [info] Linux 4.19.76-linuxkit x64 LE
        10 Oct 12:57:11 - [info] Loading palette nodes
        10 Oct 12:57:16 - [info] Settings file  : /data/settings.js
        10 Oct 12:57:16 - [info] Context store  : 'default' [module=memory]
        10 Oct 12:57:16 - [info] User directory : /data
        10 Oct 12:57:16 - [warn] Projects disabled : editorTheme.projects.enabled=false
        10 Oct 12:57:16 - [info] Flows file     : /data/flows.json
        10 Oct 12:57:16 - [info] Creating new flow file
        10 Oct 12:57:17 - [warn]

        ---------------------------------------------------------------------
        Your flow credentials file is encrypted using a system-generated key.

        If the system-generated key is lost for any reason, your credentials
        file will not be recoverable, you will have to delete it and re-enter
        your credentials.

        You should set your own key using the 'credentialSecret' option in
        your settings file. Node-RED will then re-encrypt your credentials
        file using your chosen key the next time you deploy a change.
        ---------------------------------------------------------------------

        10 Oct 12:57:17 - [info] Starting flows
        10 Oct 12:57:17 - [info] Started flows
        10 Oct 12:57:17 - [info] Server now running at http://127.0.0.1:1880/

        [...]

然後，您可以瀏覽 `http://{host-ip}:1880` 以獲取熟悉的 Node-RED 桌面。

這樣做的優點是，通過給它一個名稱 (mynodered)，我們可以更輕鬆地操作它，並且通過固定主機端口，我們知道我們處於熟悉的領域。
當然，這確實意味著我們一次只能運行一個實例... 但大家請一步一步來。

如果我們對所看到的感到滿意，我們可以使用 `Ctrl-p` `Ctrl-q` 斷開終端 - 容器將繼續在後台運行。

要重新附加到終端（查看日誌），請運行：

    docker attach mynodered

如果您需要重啟容器（例如，在重啟後或 Docker 守護進程重啟後）：

    docker start mynodered

並在需要時再次停止它：

    docker stop mynodered

### 鏡像版本

Node-RED 鏡像是基於 [官方 Node JS Alpine Linux](https://hub.docker.com/_/node/) 鏡像的，以使其盡可能小。
使用 Alpine Linux 減小了構建鏡像的大小，但刪除了原生模組編譯所需的標準依賴項。如果您想添加具有原生依賴項的依賴項，請在運行的容器上使用缺少的軟體包擴展 Node-RED 鏡像或構建新鏡像，請參閱 [docker-custom](docker-custom_zh_TW.html)，它擴展了 Node-RED Docker 項目中的 [README.md](https://github.com/node-red/node-red-docker/tree/master/docker-custom)。

有關詳細的鏡像、標籤 (Tag) 和清單 (Manifest) 信息，請參閱 [Github 專案 README](https://github.com/node-red/node-red-docker/blob/master/README.md)。

例如：假設您在架構為 `arm32v7` 的 Raspberry PI 3B 上運行。那麼只需運行以下命令來拉取鏡像（標記為 `1.2.0-10-arm32v7`），並運行容器。
```
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered nodered/node-red:latest
```

相同的命令也可用於在 amd64 系統上運行，因為 Docker 會發現它是在 amd64 主機上運行，並拉取具有匹配標籤 (`1.2.0-10-amd64`) 的鏡像。

這樣做的優點是您不需要知道/指定您在哪種架構上運行，並使 docker run 命令和 docker compose 文件更加靈活，且可在系統之間交換。

**注意**：目前 Docker 的架構檢測存在一個錯誤，對於 `arm32v6`（例如 Raspberry Pi Zero 或 1）會失敗。對於這些設備，您目前需要指定完整的鏡像標籤，例如：
```
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered nodered/node-red:1.2.0-10-arm32v6
```

從 Node-RED v3.1.0 開始，我們還為那些在 Alpine 上無法很好運行的帶有原生組件的節點提供基於 Debian 的鏡像。

### 管理用戶數據

一旦您使用 Docker 運行了 Node-RED，我們需要確保如果容器被銷毀，任何添加的節點或流程都不會丟失。
可以通過將數據目錄掛載到容器外部的卷來持久化這些用戶數據。
這可以使用綁定掛載 (bind mount) 或具名數據卷 (named data volume) 來完成。

Node-RED 使用容器內部的 `/data` 目錄來存儲用戶配置數據。

#### 使用主機目錄進行持久化（綁定掛載）

要將容器內部的 Node-RED 用戶目錄保存到容器外部的主機目錄，您可以使用以下命令。為了允許訪問此主機目錄，容器內部的 Node-RED 用戶（預設 uid=1000）必須具有與主機目錄所有者相同的 uid。
```
docker run -it -p 1880:1880 -v /home/pi/.node-red:/data --name mynodered nodered/node-red
```

在此示例中，主機 `/home/pi/.node-red` 目錄被綁定到容器 `/data` 目錄。

**注意**：從版本 0.20 遷移到 1.0 的用戶將需要確保任何現有的 `/data` 目錄具有正確的所有權。從 1.0 開始，這需要是 `1000:1000`。這可以通過命令 `sudo chown -R 1000:1000 path/to/your/node-red/data` 來強制執行。

有關權限的詳細信息，請參閱 [wiki](https://github.com/node-red/node-red-docker/wiki/Permissions-and-Persistence)。

#### 使用具名數據卷

Docker 還支援使用具名 [數據卷](https://docs.docker.com/engine/tutorials/dockervolumes/) 來在容器外部存儲持久或共享數據。

創建一個新的具名數據卷以持久化我們的用戶數據，並使用此卷運行一個新容器。
```
$ docker volume create --name node_red_data
$ docker volume ls
DRIVER              VOLUME NAME
local               node_red_data
$ docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered nodered/node-red
```

如果您需要從掛載的卷中備份數據，可以在容器運行時訪問它。
```
$ docker cp  mynodered:/data  /your/backup/directory
```

使用 Node-RED 創建並部署一些示例流程，我們現在可以在不丟失用戶數據的情況下銷毀容器並啟動新實例。
```
$ docker stop mynodered
$ docker rm mynodered
$ docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered nodered/node-red
```

### 更新

由於 /data 現在保留在容器外部，更新基礎容器鏡像現在變得非常簡單：
```
$ docker pull nodered/node-red
$ docker stop mynodered
$ docker rm mynodered
$ docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered nodered/node-red
```

### Docker Stack / Docker Compose

下面是一個 Docker Compose 文件的示例，它可以由 `docker stack` 或 `docker-compose` 運行。
有關 [Docker stack](https://docs.docker.com/engine/reference/commandline/stack/) 和 [Docker compose](https://docs.docker.com/compose/) 的更多信息，請參閱官方 Docker 頁面。
```
################################################################################
# Node-RED Stack or Compose
################################################################################
# docker stack deploy node-red --compose-file docker-compose-node-red.yml
# docker-compose -f docker-compose-node-red.yml -p myNoderedProject up
################################################################################
version: "3.7"

services:
  node-red:
    image: nodered/node-red:latest
    environment:
      - TZ=Europe/Amsterdam
    ports:
      - "1880:1880"
    networks:
      - node-red-net
    volumes:
      - node-red-data:/data

volumes:
  node-red-data:

networks:
  node-red-net:
```

上述 compose 文件：
 - 創建一個 Node-RED 服務
 - 拉取最新的 Node-RED 鏡像
 - 將時區設置為 Europe/Amsterdam
 - 將容器端口 1880 映射到主機端口 1880
 - 創建一個 node-red-net 網路並將容器連接到此網路
 - 將容器內部的 `/data` 目錄持久化到 Docker 中的 `node-red-data` 卷


### 複製本地資源的 Dockerfile

有時將本地目錄中的文件填充到 Node-RED Docker 鏡像中可能很有用（例如，如果您希望整個專案都保存在 git 存儲庫中）。為此，您需要讓本地目錄看起來像這樣：

```
Dockerfile
README.md
package.json     # 將您的流程需要的任何額外節點添加到您自己的 package.json 中。
flows.json       # Node-RED 存儲流程的正常位置
flows_cred.json  # 您的流程可能需要的憑據
settings.js      # 您的設置文件
```

**注意**：如果您想在外部掛載 /data 卷，則此方法不適用。如果您需要使用外部卷進行持久化，請將您的設置和流程文件複製到該卷。

以下 Dockerfile 以基礎 Node-RED Docker 鏡像為基礎，但另外將您自己的文件移動到該鏡像中的適當位置：

```
FROM nodered/node-red

# 將 package.json 複製到 WORKDIR，以便 npm 為 Node-RED 
# 構建所有添加的節點模組
WORKDIR /data
COPY package.json /data
RUN npm install --no-update-notifier --no-fund --only=production
WORKDIR /usr/src/node-red

# 將 _您的_ Node-RED 專案文件移動到適當位置
# 注意：這僅在您稍後不將 /data 掛載為外部卷時才有效。
#       如果您需要使用外部卷進行持久化，則將您的設置和流程文件
#       複製到該卷。
COPY settings.js /data/settings.js
COPY flows_cred.json /data/flows_cred.json
COPY flows.json /data/flows.json
```

**注意**：`package.json` 文件必須在 script 部分包含啟動選項。例如，預設容器如下所示：

```
    "scripts": {
        "start": "node $NODE_OPTIONS node_modules/node-red/red.js $FLOWS",
        ...
```

#### Dockerfile 順序和構建速度

雖然不是必需的，但在早期執行 `COPY package... npm install...` 步驟是個好主意，因為儘管 `flows.json` 在您在 Node-RED 中工作時會頻繁更改，但您的 `package.json` 僅在您更改專案部分的模組時才會更改。由於當 `package.json` 更改時需要發生的 `npm install` 步驟有時可能很耗時，因此最好在 Dockerfile 中儘早執行耗時且通常不變的步驟，以便可以重用這些構建鏡像，從而使隨後的總體構建速度更快。

#### 憑據、機密和環境變量

當然，您永遠不想在任何地方硬編碼憑據，因此如果您需要在 Node-RED 專案中使用憑據，上述 Dockerfile 將讓您在 `settings.js` 中擁有此內容...

```
module.exports = {
  credentialSecret: process.env.NODE_RED_CREDENTIAL_SECRET // 正好添加這個
}
```

...然後當您在 Docker 中運行時，您可以將環境變量添加到您的 `run` 命令中...

`docker run -e "NODE_RED_CREDENTIAL_SECRET=your_secret_goes_here"`

#### 構建和運行

您正常 *構建* 此 Dockerfile：

```sh
docker build -t your-image-name:your-tag .
```

要在進行開發的本地 *運行*（其中更改會立即寫入且僅寫入您正在工作的本地目錄），請 `cd` 進入專案目錄，然後運行：

```bash
docker run --rm -e "NODE_RED_CREDENTIAL_SECRET=your_secret_goes_here" -p 1880:1880 -v `pwd`:/data --name a-container-name your-image-name
```

### 啟動

可以將環境變量傳遞到容器中以配置 Node-RED 的運行時。

使用環境參數 (**FLOWS**) 設置流程配置文件，預設為 *'flows.json'*。可以使用以下命令行標誌在運行時更改此設置。
```
docker run -it -p 1880:1880 -v node_red_data:/data -e FLOWS=my_flows.json nodered/node-red
```

**注意**：如果您設置 `-e FLOWS=""`，則可以通過 `settings.js` 文件中的 *flowFile* 屬性設置流程文件。

其他有用的環境變量包括：

 - `-e NODE_RED_ENABLE_SAFE_MODE=false` # 設置為 true 以安全模式（不運行）啟動 Node-RED
 - `-e NODE_RED_ENABLE_PROJECTS=false`  # 設置為 true 以在啟用專案功能的情況下啟動 Node-RED

可以使用環境參數 (**NODE_OPTIONS**) 將 Node.js 運行時參數傳遞給容器。例如，要固定 Node.js 垃圾回收器使用的堆大小，您可以使用以下命令。
```
docker run -it -p 1880:1880 -v node_red_data:/data -e NODE_OPTIONS="--max_old_space_size=128" nodered/node-red
```

### 後台運行

要後台運行（即在後台運行），只需將之前大多數命令中的 `-it` 替換為 `-d`，例如：
```
docker run -d -p 1880:1880 -v node_red_data:/data --name mynodered nodered/node-red
```

### 容器 Shell

一旦它在後台運行，您可以使用以下命令重新獲得對容器的訪問權限。
```
$ docker exec -it mynodered /bin/bash
bash-4.4$
```

將在容器內部提供命令行 - 您可以在其中運行所需的 npm install 命令 - 例如：
```
bash-4.4$ npm install node-red-dashboard
bash-4.4$ exit
$ docker stop mynodered
$ docker start mynodered
```

刷新瀏覽器頁面現在應該會顯示面板中新添加的節點。

### 多個實例

運行
```
docker run -d -p 1880 nodered/node-red
```
將創建一個機器的本地運行實例。注意：我們沒有指定名稱。

此容器將有一個 ID 號並運行在一個隨機端口上... 要找出是哪個端口，請運行 `docker ps`：
```
$ docker ps
CONTAINER ID  IMAGE             COMMAND                 CREATED         STATUS        PORTS                    NAMES
860258cab092  nodered/node-red  "npm start -- --user…"  10 seconds ago  Up 9 seconds  0.0.0.0:32768->1880/tcp  dazzling_euler
```

您現在可以將瀏覽器指向報告的 TCP 端口上的主機，因此在上面的示例中瀏覽 `http://{host ip}:32768`

### 連接容器

您可以使用 Docker [用戶定義的橋接網路](https://docs.docker.com/network/bridge/) 在 docker 運行時“內部”連接容器。

在使用橋接網路之前，需要先創建它。下面的命令將創建一個名為 **iot** 的新橋接網路：

    docker network create iot

然後，所有需要通信的容器都需要使用 **--network** 命令行選項添加到同一個橋接網路中：

    docker run -itd --network iot --name mybroker eclipse-mosquitto mosquitto -c /mosquitto-no-auth.conf

（除非您願意，否則無需全局公開端口 1883... 因為我們在下面執行了魔法操作）

然後運行 Node-RED docker，也添加到同一個橋接網路中：

    docker run -itd -p 1880:1880 --network iot --name mynodered nodered/node-red

同一個用戶定義橋接網路上的容器可以利用橋接網路提供的內置名稱解析功能，並將容器名稱（使用 **--name** 選項指定）用作目標主機名。

在上述示例中，可以從 Node-RED 應用程式使用主機名 *mybroker* 訪問代理 (broker)。

然後，像下面這樣的簡單流程顯示了連接到代理的 mqtt 節點：

        [{"id":"c51cbf73.d90738","type":"mqtt in","z":"3fa278ec.8cbaf","name":"","topic":"test","broker":"5673f1d5.dd5f1","x":290,"y":240,"wires":[["7781c73.639b8b8"]]},{"id":"7008d6ef.b6ee38","type":"mqtt out","z":"3fa278ec.8cbaf","name":"","topic":"test","qos":"","retain":"","broker":"5673f1d5.dd5f1","x":517,"y":131,"wires":[]},{"id":"ef5b970c.7c864","type":"inject","z":"3fa278ec.8cbaf","name":"","repeat":"","crontab":"","once":false,"topic":"","payload":"","payloadType":"date","x":290,"y":153,"wires":[["7008d6ef.b6ee38"]]},{"id":"7781c73.639b8b8","type":"debug","z":"3fa278ec.8cbaf","name":"","active":true,"tosidebar":true,"console":false,"tostatus":true,"complete":"payload","targetType":"msg","statusVal":"payload","statusType":"auto","x":505,"y":257,"wires":[]},{"id":"5673f1d5.dd5f1","type":"mqtt-broker","z":"","name":"","broker":"mybroker","port":"1883","clientid":"","usetls":false,"compatmode":false,"keepalive":"15","cleansession":true,"birthTopic":"","birthQos":"0","birthRetain":"false","birthPayload":"","closeTopic":"","closeRetain":"false","closePayload":"","willTopic":"","willQos":"0","willRetain":"false","willPayload":""}]

這樣，內部代理就不會暴露在 docker 主機之外 - 當然，如果您希望電腦之外的其他系統能夠使用代理，您可以在代理運行命令中添加 `-p 1883:1883` 等。

### Raspberry PI - 原生 GPIO 支援

| v1.0 - 重大變更：已停止對 Raspberry PI 的原生 GPIO 支援 |
| --- |
原生 GPIO 的替代方案是 [node-red-node-pi-gpiod](https://github.com/node-red/node-red-nodes/tree/master/hardware/pigpiod)。

原生 GPIO 支援的缺點是：
- 您的 Docker 容器需要部署在您想要控制 GPIO 的同一個 Docker 節點/主機上。
- 獲得對 Docker 節點/主機的 `/dev/mem` 的訪問權限
- `docker stack` 命令不支援 privileged=true

`node-red-node-pi-gpiod` 解決了所有這些缺點。使用 `node-red-node-pi-gpiod`，可以從單個 Node-RED 容器與多個 Raspberry Pi 的 GPIO 進行交互，並且多個容器可以訪問同一台 Pi 上的不同 GPIO。

#### 遷移到 `node-red-node-pi-gpiod` 的快速步驟

  1. 通過 Node-RED 面板安裝 `node-red-node-pi-gpiod`。
  2. 在主機 Pi 上安裝並運行 `PiGPIOd daemon`。有關詳細的安裝說明，請參閱 `node-red-node-pi-gpiod` [README](https://github.com/node-red/node-red-nodes/tree/master/hardware/pigpiod#node-red-node-pi-gpiod)。
  3. 用 `pi gpiod` 節點替換所有原生 GPIO 節點。
  4. 配置 `pi gpiod` 節點以連接到 `PiGPIOd daemon`。主機通常具有 IP 172.17.0.1 端口 8888 - 但不總是這樣。您可以使用 `docker exec -it mynodered ip route show default | awk '/default/ {print $3}'` 來檢查。

**注意**：有一個貢獻的 [gpiod 專案](https://github.com/corbosman/node-red-gpiod)，如果需要，它可以在自己的容器中而不是在主機上運行 gpiod。

### 串口 - Dialout - 添加組

要訪問主機串口，您可能需要將容器添加到 `dialout` 組。這可以通過在啟動命令中添加 `--group-add dialout` 來啟用。例如：
```
docker run -it -p 1880:1880 -v node_red_data:/data --group-add dialout --name mynodered nodered/node-red
```

---

### 常見問題與提示

以下是用戶報告的常見問題及其可能的解決方案列表。

#### 用戶權限錯誤

有關權限的詳細信息，請參閱 [wiki](https://github.com/node-red/node-red-docker/wiki/Permissions-and-Persistence)。

如果您在打開文件或訪問主機設備時看到 *permission denied*（權限被拒絕）錯誤，請嘗試以 root 用戶身份運行容器。

```
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered -u node-red:dialout nodered/node-red
```

參考資料：

https://github.com/node-red/node-red-docker/issues/15

https://github.com/node-red/node-red-docker/issues/8

#### 訪問主機設備

如果您想在容器內部訪問主機中的設備（例如串口），請使用以下命令行標誌來傳遞訪問權限。

```
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered --device=/dev/ttyACM0 nodered/node-red
```
參考資料：
https://github.com/node-red/node-red/issues/15

#### 設置時區

如果您想修改預設時區，請使用 TZ 環境變量和 [相關時區](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)。
```
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered -e TZ=America/New_York nodered/node-red
```

或者在 docker-compose 文件中：
```
  node-red:
    environment:
      - TZ=America/New_York
```

參考資料：
https://groups.google.com/forum/#!topic/node-red/ieo5IVFAo2o
