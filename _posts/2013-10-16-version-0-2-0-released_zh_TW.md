---
layout: blog
title: 0.2.0 版本已發佈
author: nick
---

我們仍在摸索如何進行定期發佈，但正如我在 GitHub 的 [原始提交](https://github.com/node-red/node-red/commit/32796dd74ca2525e3fea302e79ff3fc596bb1bf3) 中所說，我們必須從某個地方開始。

話雖如此，Node-RED 0.2.0 現在已經可以 [下載](https://github.com/node-red/node-red/archive/v0.2.0.zip) 或透過 [npm 安裝](https://npmjs.org/package/node-red)。

我們需要讓使用者盡可能輕鬆地開始使用。過去我們通常在更新之間使用 git pull，現在我們需要思考使用者如何安全地升級。目前這是一個相當手動的過程 —— 寫到這裡讓我意識到 [文件](/docs/index_zh_TW.html) 需要增加一個升級指南。

展望未來，有各種活動分支。當我坐在此處寫作時，目前最受關注的一些項目包括：

- npm 安裝 vs zip 下載 - 何時應該使用其中之一
- 將除了核心節點以外的所有節點從主儲存庫移至 [node-red-nodes 儲存庫](http://github.com/node-red/node-red-nodes)。
- 思考多標籤工作區和子流程（sub-flows）
- 根據回饋和經驗繼續整理我們現有的節點

請繼續關注有關這些內容的更多想法。

與此同時，如果您有任何想法或建議，請在此處或 [郵件列表](https://groups.google.com/forum/#!forum/node-red) 上留言。
