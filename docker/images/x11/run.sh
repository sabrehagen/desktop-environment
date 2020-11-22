REPO_ROOT=$(dirname $(readlink -f $0))/../../..
IMAGE=$(basename $(dirname $0))

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

docker run \
  --cap-add SYS_TTY_CONFIG \
  --detach \
  --device /dev/dri \
  --device /dev/input \
  --device /dev/snd \
  --device /dev/tty3 \
  --device /dev/video0 \
  --env DESKTOP_ENVIRONMENT_USER \
  --group-add audio \
  --group-add input \
  --group-add plugdev \
  --group-add tty \
  --group-add video \
  --interactive \
  --network host \
  --rm \
  --volume /dev/displaylink:/dev/displaylink \
  --volume /dev/shm:/dev/shm \
  --volume /run/udev:/run/udev \
  --volume DESKTOP_ENVIRONMENT_STATE_X11:$DESKTOP_ENVIRONMENT_STATE_X11 \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE-$IMAGE:$DESKTOP_ENVIRONMENT_CONTAINER_TAG
