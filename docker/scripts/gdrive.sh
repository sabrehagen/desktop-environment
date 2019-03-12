docker run \
  --cap-add mknod \
  --cap-add sys_admin \
  --detach \
  --device=/dev/fuse \
  --name gdrive \
  --security-opt apparmor:unconfined \
  --volume /mnt/drive:/mnt/gdrive:shared \
  --volume DESKTOP_ENVIRONMENT_CACHE_GDRIVE:/config/.gdfuse \
  --volume /mnt/drive:/mnt/gdrive:shared \
  mitcdh/google-drive-ocamlfuse
