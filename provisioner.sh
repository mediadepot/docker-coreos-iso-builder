FROM debian:jessie-slim

## Prerequisites

# meteor installer doesn't work with the default tar binary
apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    sudo \
    bzip2 && \
    rm -rf /var/lib/apt/lists/*

cd /usr/bin && \
    curl -L -o cork https://github.com/coreos/mantle/releases/download/v0.11.1/cork-0.11.1-amd64 && \
    chmod +x cork && \
    which cork && \
    git config --global user.email "jason@thesparktree.com" && \
    git config --global user.name "Jason Kulatunga"

## Using Cork
# https://coreos.com/os/docs/latest/sdk-modifying-coreos.html

mkdir -p /coreos-sdk

cd /coreos-sdk && \
    mkdir -p /home/root/ && \
    /usr/bin/cork create

/usr/bin/cork enter && \
    grep NAME /etc/os-release # Verify you are in the SDK chroot

## Building an image

