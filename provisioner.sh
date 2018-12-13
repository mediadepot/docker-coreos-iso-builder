#!/usr/bin/env bash

## Prerequisites

# meteor installer doesn't work with the default tar binary
yum install -y \
    ca-certificates \
    curl \
    git \
    bzip2

cd /usr/bin && \
    curl -L -o cork https://github.com/coreos/mantle/releases/download/v0.10.0/cork-0.10.0-amd64 && \
    chmod +x cork && \
    which cork

## Using Cork
# https://coreos.com/os/docs/latest/sdk-modifying-coreos.html=

exec sudo -u vagrant /bin/sh - << 'EOF'
whoami
git config --global user.email "jason@thesparktree.com" && \
git config --global user.name "Jason Kulatunga"

mkdir -p ~/coreos-sdk
cd ~/coreos-sdk
cork create --sdk-version 1911.4.0 --replace

cork enter
grep NAME /etc/os-release

./set_shared_user_password.sh 12345
./setup_board
./build_packages
./build_image


EOF


