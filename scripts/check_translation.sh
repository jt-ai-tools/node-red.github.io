#!/bin/bash

SOURCE_FILES=$(./scripts/list_md_files.sh)
TOTAL=$(echo "$SOURCE_FILES" | wc -l)
TRANSLATED=0
MISSING=0

echo "Translation Progress Check:"
echo "--------------------------"

for FILE in $SOURCE_FILES; do
    EXT="${FILE##*.}"
    BASE="${FILE%.*}"
    TARGET="${BASE}_zh_TW.${EXT}"
    
    if [ -f "$TARGET" ]; then
        ((TRANSLATED++))
    else
        echo "[MISSING] $FILE"
        ((MISSING++))
    fi
done

echo "--------------------------"
echo "Total Files: $TOTAL"
echo "Translated:  $TRANSLATED"
echo "Remaining:   $MISSING"

if [ $MISSING -eq 0 ]; then
    echo "All files translated!"
    exit 0
else
    exit 1
fi
