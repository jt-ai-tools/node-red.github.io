node-red.github.io
==================

[English Version](README.md)

[Node-RED 網站](http://nodered.org)

### 貢獻 / 修復

對於簡單的打字錯誤和單行修復，請直接提出 issue 指出我們的錯誤。對於較大的變更，請在 [論壇](https://discourse.nodered.org) 或 [Slack 團隊](http://nodered.org/slack/) #docs 頻道進行討論。

如果您需要提出 pull request，請在操作前閱讀我們的 [貢獻指南](https://github.com/node-red/node-red/blob/master/CONTRIBUTING.md)。

### 預覽網站
此網站是一個使用 [Jekyll](https://github.com/jekyll/jekyll) 進行靜態網站生成的 Github Pages 網站。要預覽和測試網站，首先請確保已 [安裝 Jekyll](https://jekyllrb.com/docs/installation/)。

Fork 此儲存庫以便您可以進行更改，將其提交到您自己的儲存庫並提出 pull request 供審核。如果您還沒有 clone 該儲存庫，請執行：

    git clone https://github.com/{your-github}/node-red.github.io

第一次運行 jekyll 時，您需要先執行 bundle install 來安裝依賴項：

    cd node-red.github.io
    bundle install
    bundle exec jekyll serve -w

一旦網站構建完成並運行，您可以在 [`http://127.0.0.1:4000/`](http://127.0.0.1:4000/) 進行預覽。
