---
layout: docs-user-guide
title: Node-RED 概念
slug: concepts
---

<ul class="multi-column-toc" id="concept-toc"></ul>

---

<b id="node">節點 (Node)</b>
: 節點是流程的基本構建塊。

  節點通過接收來自流程中前一個節點的消息，或者等待某些外部事件（如傳入的 HTTP 請求、定時器或 GPIO 硬件更改）來觸發。它們處理該消息或事件，然後可以將消息發送到流程中的下一個節點。

  一個節點最多可以有一個輸入端口和根據需要多個輸出端口。

    - [使用節點](/docs/user-guide/editor/workspace/nodes_zh_TW.md)
    - [核心節點](/docs/user-guide/nodes_zh_TW.md)
    - [建立節點](/docs/creating-nodes/index_zh_TW.md)

<b id="config-node">配置節點 (Configuration node)</b>
: 配置（config）節點是一種特殊類型的節點，它持有可在流程中由常規節點共享的可重用配置。

  例如，MQTT In 和 Out 節點使用 MQTT Broker 配置節點來表示與 MQTT 代理的共享連接。

  配置節點不出現在主工作區中，但可以通過打開配置節點側邊欄來查看。

    - [使用配置節點](/docs/user-guide/editor/workspace/nodes_zh_TW.md#configuration-nodes)
    - [配置節點側邊欄](/docs/user-guide/editor/sidebar/config_zh_TW.md)


<b id="flow">流程 (Flow)</b>
: 流程在編輯器工作區中表示為一個標籤頁，是組織節點的主要方式。

  “流程”一詞也用於非正式地描述一組連接的節點。因此，一個流程（標籤頁）可以包含多個流程（連接的節點組）。


    - [使用流程](/docs/user-guide/editor/workspace/flows_zh_TW.md)

<b id="context">上下文 (Context)</b>
: 上下文是一種存儲信息的方式，可以在節點之間共享，而無需使用通過流程傳遞的消息。

  有三種類型的上下文；

    - 節點 (Node) - 僅對設置該值的節點可見
    - 流程 (Flow) - 對同一流程（或編輯器中的標籤頁）上的所有節點可見
    - 全局 (Global) - 對所有節點可見

  默認情況下，Node-RED 使用內存中的上下文存儲，因此值在重啟後不會保存。它可以配置為使用基於文件系統的存儲以使值持久化。也可以插入替代存儲插件。

    - [使用上下文](/docs/user-guide/context_zh_TW.md)
    - [上下文存儲 API](/docs/api/context/index_zh_TW.md)

<b id="message">消息 (Message)</b>
: 消息是在流程中的節點之間傳遞的內容。它們是普通的 JavaScript 對象，可以具有任何屬性集。它們在編輯器中通常被稱為 `msg`。

  按照慣例，它們有一個包含最有用信息的 `payload` 屬性。

  - [使用消息](/docs/user-guide/messages_zh_TW.md)


<b id="subflow">子流程 (Subflow)</b>
: 子流程是工作區中折疊成單個節點的一組節點。

  它們可以用於減少流程的一些視覺複雜性，或者將一組節點封裝為在多個地方使用的可重用組件。

    - [使用子流程](/docs/user-guide/editor/workspace/subflows_zh_TW.md)


<b id="wire">連線 (Wire)</b>
: 連線連接節點並表示消息如何通過流程傳遞。

    - [使用連線](/docs/user-guide/editor/workspace/wires_zh_TW.md)

<b id="palette">調色盤 (Palette)</b>
: 調色盤位於編輯器的左側，列出了可在流程中使用的節點。

  可以使用命令行或調色盤管理器將額外的節點安裝到調色盤中。

    - [使用調色盤](/docs/user-guide/editor/palette/index_zh_TW.md)
    - [將節點添加到調色盤](/docs/user-guide/runtime/adding-nodes_zh_TW.md)
    - [調色盤管理器](/docs/user-guide/editor/palette/manager_zh_TW.md)

<b id="workspace">工作區 (Workspace)</b>
: 工作區是通過從調色盤拖動節點並將它們連線在一起來開發流程的主要區域。

  工作區頂部有一行標籤頁；每個流程和任何已打開的子流程各有一個。

    - [使用工作區](/docs/user-guide/editor/workspace/index_zh_TW.md)

<b id="sidebar">側邊欄 (Sidebar)</b>
: 側邊欄包含提供編輯器內許多有用工具的面板。其中包括查看有關節點的更多信息和幫助的面板、查看調試消息以及查看流程配置節點的面板。

    - [使用側邊欄](/docs/user-guide/editor/sidebar/index_zh_TW.md)


<script>
    $(function() {
        $("dt b").each(function() {
            $('<li><a href="#'+$(this).attr('id')+'">'+$(this).text()+'</a></li>').appendTo("#concept-toc")
        })
    })
</script>
