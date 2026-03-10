#!/bin/bash

# 尋找所有需要翻譯的檔案 (.md, .mdx, .html)
# 排除 PROGRESS.md, 已翻譯的 *_zh_TW.* 檔案, 以及隱藏目錄或特定系統目錄
find . -type f \( -name "*.md" -o -name "*.mdx" -o -name "*.html" \) \
    ! -name "PROGRESS.md" \
    ! -name "*_zh_TW.md" \
    ! -name "*_zh_TW.mdx" \
    ! -name "*_zh_TW.html" \
    ! -path "*/.*" \
    ! -path "./vendor/*" \
    ! -path "./_site/*" \
    ! -path "./node_modules/*" \
    ! -path "./scripts/*"
