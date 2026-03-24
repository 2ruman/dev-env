
set -euo pipefail

sudo apt-get install wget gpg &&
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg &&
sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg &&
rm -f microsoft.gpg

# https://code.visualstudio.com/docs/setup/linux
APT_VSCODE_SRCS="/etc/apt/sources.list.d/vscode.sources"
if [[ ! -f $APT_VSCODE_SRCS ]]; then
    sudo cat << EOF | sudo tee "$APT_VSCODE_SRCS" > /dev/null
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF
fi

sudo apt install apt-transport-https &&
sudo apt update &&
sudo apt install code

echo "Done"
