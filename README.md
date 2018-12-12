# docker-coreos-iso-builder
Docker container to help MediaDepot build a custom CoreOS kernel with additional kernel options enabled (HW decoding, fs changes, etc)


# Notes
- When building locally on MacOS, make sure that `"storage-driver":"overlay2"` otherwise you'll see tar errors:
 ["Directory renamed before its status could be extracted"](https://github.com/docker/hub-feedback/issues/727)
- https://github.com/dokku/dokku/issues/2953

# References
- https://coreos.com/os/docs/latest/sdk-modifying-coreos.html
- https://coreos.com/os/docs/latest/sdk-tips-and-tricks.html

http://tdoc.info/en/blog/2014/04/02/coreos_sdk_image.html