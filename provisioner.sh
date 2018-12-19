#!/usr/bin/env bash
set -e
set -o pipefail
## Prerequisites

# meteor installer doesn't work with the default tar binary
yum install -y \
    ca-certificates \
    curl \
    git \
    bzip2

cd /usr/bin && \
    curl -L -o cork https://github.com/coreos/mantle/releases/download/v0.11.1/cork-0.11.1-amd64 && \
    chmod +x cork && \
    which cork

## Using Cork
# https://coreos.com/os/docs/latest/sdk-modifying-coreos.html=

exec sudo -u vagrant GITHUB_RELEASE_REPO=${GITHUB_RELEASE_REPO} GITHUB_RELEASE_ID=${GITHUB_RELEASE_ID} GITHUB_ACCESS_TOKEN=${GITHUB_ACCESS_TOKEN} /bin/sh - << 'EOF'
set -e
set -o pipefail
whoami

git config --global user.email "jason@thesparktree.com" && \
git config --global user.name "Jason Kulatunga"

mkdir -p ~/coreos-sdk
cd ~/coreos-sdk
cork create --manifest-url=https://github.com/mediadepot/coreos-manifest.git --manifest-branch=mediadepot

cork enter
grep NAME /etc/os-release

./set_shared_user_password.sh 12345 && \
./setup_board --board 'amd64-usr' && \
./build_packages --board 'amd64-usr' && \
./build_image --board 'amd64-usr' && \
./image_to_vm.sh --from=../build/images/amd64-usr/developer-latest --format=iso --board=amd64-usr

# Upload image to Github.
cd ../build/images/amd64-usr/developer-latest
export $(cat version.txt | xargs)
   #COREOS_VERSION=1911.4.0+2018-12-16-0438
   #COREOS_VERSION_ID=1911.4.0
   #COREOS_BUILD_ID="2018-12-16-0438"
   #COREOS_SDK_VERSION=1911.3.0


echo "curl 'https://uploads.github.com/repos/${GITHUB_RELEASE_REPO}/releases/${GITHUB_RELEASE_ID}/assets?access_token=${GITHUB_ACCESS_TOKEN}&name=coreos_production_iso_image_${COREOS_VERSION_ID}_${COREOS_BUILD_ID}.iso' --header 'Content-Type: application/zip' --upload-file coreos_production_iso_image.iso -X POST"
curl 'https://uploads.github.com/repos/${GITHUB_RELEASE_REPO}/releases/${GITHUB_RELEASE_ID}/assets?access_token=${GITHUB_ACCESS_TOKEN}&name=coreos_production_iso_image_${COREOS_VERSION_ID}_${COREOS_BUILD_ID}.iso' --header 'Content-Type: application/zip' --upload-file coreos_production_iso_image.iso -X POST

EOF


