#!/bin/bash

source $(realpath $(dirname "${BASH_SOURCE[0]}"))/inst.func

_logo() {
    echo -e "${NOC}\
-------------------------------------------------------------------------
    ${GRN}"
cat << 'EOF'
  ____ _                 _         ____          _
 / ___| | __ _ _   _  __| | ___   / ___|___   __| | ___
| |   | |/ _` | | | |/ _` |/ _ \ | |   / _ \ / _` |/ _ \
| |___| | (_| | |_| | (_| |  __/ | |__| (_) | (_| |  __/
 \____|_|\__,_|\__,_|\__,_|\___|  \____\___/ \__,_|\___|

 ___           _        _ _
|_ _|_ __  ___| |_ __ _| | | ___ _ __
 | || '_ \/ __| __/ _` | | |/ _ \ '__|
 | || | | \__ \ || (_| | | |  __/ |
|___|_| |_|___/\__\__,_|_|_|\___|_|

EOF
    echo -e "${NOC}\
-------------------------------------------------------------------------
    ${NOC}"
}

_logo

CC_INST_URL="https://claude.ai/install.sh"

log_step "Downloading installer..."
log_mark "Request: ${YLW}${CC_INST_URL}${NOC}"

set -o pipefail

curl -fsSL ${CC_INST_URL} | bash
if [ "$?" -ne 0 ]; then
    log_over ""
    exit_err "Failed..."
fi

log_mark "Done."
