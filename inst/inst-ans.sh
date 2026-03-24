#!/bin/bash

HTTPS_DEV_ANS_ADDR="https://developer.android.com/studio"
ANS_ARC_LINUX_URL_PTN="^[[:space:]]*href=\"https://.+android-studio-.+linux.tar.gz"

function get_dev_ans_html() {
    wget -qO - $HTTPS_DEV_ANS_ADDR 2>/dev/null
}

function get_ans_arc_addr() {
    local -
    set -euo pipefail

    (get_dev_ans_html | grep -oE $ANS_ARC_LINUX_URL_PTN | sed -E 's|^[[:space:]]*href="||') 2>/dev/null
}

arc_dest=${1:-~/Downloads}
if [ ! -d "$arc_dest" ]; then
    echo "Invalid dest directory: $arc_dest"
fi

arc_addr=$(get_ans_arc_addr)

if [ -n "$arc_addr" ]; then
    echo "Archive found at: " "$arc_addr"

    arc_file=$(echo $arc_addr | sed -E 's/^.+\///')
    if [[ $? != 0 || -z $arc_file ]]; then
        echo "Failed to get archive file name..."
    else
        echo "Archive file name: $arc_file"
        echo "Archive destination: $arc_dest"
        echo "Download will begin in 3 seconds..."
        sleep 3s
    fi
    wget -O "$arc_dest/$arc_file" "$arc_addr"
else
    echo "Archive not found..."
    exit 1
fi

echo "Done"
