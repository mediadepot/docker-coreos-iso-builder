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

exec sudo -u vagrant GCP_GSUTIL_BUCKET_ID=${GCP_GSUTIL_BUCKET_ID} /bin/sh - << 'EOF'
set -e
set -o pipefail
whoami

git config --global user.email "jason@thesparktree.com" && \
git config --global user.name "Jason Kulatunga"

mkdir -p ~/coreos-sdk
cd ~/coreos-sdk
cork create --manifest-url=https://github.com/mediadepot/coreos-manifest.git --manifest-branch=mediadepot
#
cork enter
grep NAME /etc/os-release
env
cat /home/vagrant/.boto

./set_shared_user_password.sh mediadepot && \
./setup_board --board 'amd64-usr' && \
./build_packages --board 'amd64-usr' && \
./build_image --board 'amd64-usr' prod --upload_root "gs://${GCP_GSUTIL_BUCKET_ID}" --upload && \
./image_to_vm.sh --from=../build/images/amd64-usr/developer-latest --format=iso --board=amd64-usr --upload_root "gs://${GCP_GSUTIL_BUCKET_ID}" --upload && \

# mark this current build as the latest.
gsutil cp ../build/images/amd64-usr/developer-latest/version.txt "gs://${GCP_GSUTIL_BUCKET_ID}/boards/amd64-usr/current/version.txt"

cat ../build/images/amd64-usr/developer-latest/version.txt
EOF


