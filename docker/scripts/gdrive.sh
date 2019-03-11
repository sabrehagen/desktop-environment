docker run \
  --cap-add mknod \
  --cap-add sys_admin \
  --detach \
  --device=/dev/fuse \
  --name gdrive \
  --security-opt apparmor:unconfined \
  --volume /mnt/drive:/mnt/gdrive:shared \
  --volume DESKTOP_ENVIRONMENT_CACHE_GDRIVE:~/.gdfuse \
  --volume /mnt/gdrive:/mnt/gdrive:shared \
  mitcdh/google-drive-ocamlfuse

# google-drive-ocamlfuse -headless -id 502305750839-286hf5btkfk90o1idtbqdm4dlab3d0gu.apps.googleusercontent.com -secret -o89GAAhKaCQnlQa0WWvjv5f
