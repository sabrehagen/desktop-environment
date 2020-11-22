REPO_ROOT=$(dirname $(readlink -f $0))/../../..
IMAGE=$(basename $(dirname $0))

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Start the desktop environment container
docker run \
  --cap-add NET_ADMIN \
  --cap-add SYS_ADMIN \
  --cap-add SYS_PTRACE \
  --cap-add SYS_TTY_CONFIG \
  --detach \
  --device /dev/dri \
  --device /dev/fuse \
  --device /dev/input \
  --device /dev/snd \
  --device /dev/tty4 \
  --device /dev/video0 \
  --group-add audio \
  --group-add docker \
  --group-add input \
  --group-add plugdev \
  --group-add tty \
  --group-add video \
  --interactive \
  --network host \
  --rm \
  --volume /var/lib/docker:/var/lib/docker \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume DESKTOP_ENVIRONMENT_CACHE_SSH:$DESKTOP_ENVIRONMENT_CACHE_SSH \
  --volume DESKTOP_ENVIRONMENT_CACHE_YARN:$DESKTOP_ENVIRONMENT_CACHE_YARN \
  --volume DESKTOP_ENVIRONMENT_CACHE_ZSH:$DESKTOP_ENVIRONMENT_CACHE_ZSH \
  --volume DESKTOP_ENVIRONMENT_STATE_JUMP:$DESKTOP_ENVIRONMENT_STATE_JUMP \
  --volume DESKTOP_ENVIRONMENT_STATE_MUSIKCUBE:$DESKTOP_ENVIRONMENT_STATE_MUSIKCUBE \
  --volume DESKTOP_ENVIRONMENT_STATE_RESCUETIME:$DESKTOP_ENVIRONMENT_STATE_RESCUETIME \
  --volume DESKTOP_ENVIRONMENT_STATE_SLACK:$DESKTOP_ENVIRONMENT_STATE_SLACK \
  --volume DESKTOP_ENVIRONMENT_STATE_X11:/tmp/.X11-unix \
  --volume DESKTOP_ENVIRONMENT_USER_DOCUMENTS:$DESKTOP_ENVIRONMENT_USER_DOCUMENTS \
  --volume DESKTOP_ENVIRONMENT_USER_DOWNLOADS:$DESKTOP_ENVIRONMENT_USER_DOWNLOADS \
  --volume DESKTOP_ENVIRONMENT_USER_GO:$DESKTOP_ENVIRONMENT_USER_GO \
  --volume DESKTOP_ENVIRONMENT_USER_MUSIC:$DESKTOP_ENVIRONMENT_USER_MUSIC \
  --volume DESKTOP_ENVIRONMENT_USER_PICTURES:$DESKTOP_ENVIRONMENT_USER_PICTURES \
  --volume DESKTOP_ENVIRONMENT_USER_REPOSITORIES:$DESKTOP_ENVIRONMENT_USER_REPOSITORIES \
  --volume DESKTOP_ENVIRONMENT_USER_TORRENTS:$DESKTOP_ENVIRONMENT_USER_TORRENTS \
  --workdir $DESKTOP_ENVIRONMENT_USER_HOME \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE:$DESKTOP_ENVIRONMENT_CONTAINER_TAG \
  $@
