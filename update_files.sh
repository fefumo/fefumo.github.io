#!/bin/bash

# for me in future: `-n` for dry run
rsync -avz --progress \
    --exclude=personal \
    --exclude='basic todos.md' \
    --exclude=work \
    ~/Documents/obsidian_vault/ \
    ./content/
