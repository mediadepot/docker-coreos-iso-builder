# docker-coreos-iso-builder
Docker container to help MediaDepot build a custom CoreOS kernel with additional kernel options enabled (HW decoding, fs changes, etc)

# Usage
If you would like to install this MediaDepot customized build of CoreOS, check the [mediadepot/docs](https://www.github.com/mediadepot/docs) repo for instructions

# Image Hosting
- Create a Google Cloud Platform (GCP) account and create a new Project.
- The Project ID should be recorded (it will be passed in as an ENV variable)
- Make a new bucket in the Cloud Storage tab. This bucket ID should be recorded (it will be passed in as an ENV variable)
- Make the [bucket (or individual files) publically readable](https://cloud.google.com/storage/docs/access-control/making-data-public)
- Use `gsutil config` to generate a `.boto` config file and record the `gs_oauth2_refresh_token` (it will be passed in as an ENV variable)

- Upload format is as follows:
    - IMAGE_NAME="coreos_production_image.bin.bz2"
    - BASE_URL="https://storage.googleapis.com/mediadepot-coreos/boards/amd64-usr"
    - VERSIONTXT_URL="${BASE_URL}/current/version.txt"
    - VERSION_ID=$(wget -qO- "${VERSIONTXT_URL}" | sed -n 's/^COREOS_VERSION=//p')
    - IMAGE_URL="${BASE_URL}/${VERSION_ID}/${IMAGE_NAME}"
    - SIG_URL="${BASE_URL}/${VERSION_ID}/${SIG_NAME}"

# References
- https://coreos.com/os/docs/latest/sdk-modifying-coreos.html
- https://coreos.com/os/docs/latest/sdk-tips-and-tricks.html
- http://tdoc.info/en/blog/2014/04/02/coreos_sdk_image.html

