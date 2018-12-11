FROM debian:jessie-slim

## Prerequisites

# meteor installer doesn't work with the default tar binary
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    sudo \
    bzip2 && \
    rm -rf /var/lib/apt/lists/*

RUN cd /usr/bin && \
    curl -L -o cork https://github.com/coreos/mantle/releases/download/v0.11.1/cork-0.11.1-amd64 && \
    chmod +x cork && \
    which cork && \
    git config --global user.email "jason@thesparktree.com" && \
    git config --global user.name "Jason Kulatunga"

## Using Cork
# https://coreos.com/os/docs/latest/sdk-modifying-coreos.html

WORKDIR /coreos-sdk

RUN cd /coreos-sdk && \
    alias tar="tar --absolute-names" && \
    /usr/bin/cork create

RUN /usr/bin/cork enter && \
    grep NAME /etc/os-release # Verify you are in the SDK chroot

## Building an image

