REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Ensure the desktop environment network exists
docker network create $DESKTOP_ENVIRONMENT_DOCKER_NETWORK

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
  --device /dev/tty3 \
  --device /dev/video0 \
  --env DESKTOP_ENVIRONMENT_GITHUB_TOKEN \
  --env DESKTOP_ENVIRONMENT_USER \
  --group-add audio \
  --group-add docker \
  --group-add input \
  --group-add plugdev \
  --group-add tty \
  --group-add video \
  --hostname $(hostname) \
  --interactive \
  --name $DESKTOP_ENVIRONMENT_CONTAINER_NAME \
  --network $DESKTOP_ENVIRONMENT_DOCKER_NETWORK \
  --rm \
  --security-opt apparmor:unconfined \
  --volume /dev/displaylink:/dev/displaylink \
  --volume /dev/shm:/dev/shm \
  --volume /run/udev:/run/udev \
  --volume /var/lib/docker:/var/lib/docker \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume DESKTOP_ENVIRONMENT_CACHE_CHROME:$DESKTOP_ENVIRONMENT_CACHE_CHROME \
  --volume DESKTOP_ENVIRONMENT_CACHE_SSH:$DESKTOP_ENVIRONMENT_CACHE_SSH \
  --volume DESKTOP_ENVIRONMENT_CACHE_TMUX:$DESKTOP_ENVIRONMENT_CACHE_TMUX \
  --volume DESKTOP_ENVIRONMENT_CACHE_YARN:$DESKTOP_ENVIRONMENT_CACHE_YARN \
  --volume DESKTOP_ENVIRONMENT_CACHE_ZSH:$DESKTOP_ENVIRONMENT_CACHE_ZSH \
  --volume DESKTOP_ENVIRONMENT_STATE_BEEKEEPER:$DESKTOP_ENVIRONMENT_STATE_BEEKEEPER \
  --volume DESKTOP_ENVIRONMENT_STATE_CHROME:$DESKTOP_ENVIRONMENT_STATE_CHROME \
  --volume DESKTOP_ENVIRONMENT_STATE_CODE:$DESKTOP_ENVIRONMENT_STATE_CODE \
  --volume DESKTOP_ENVIRONMENT_STATE_DISCORD:$DESKTOP_ENVIRONMENT_STATE_DISCORD \
  --volume DESKTOP_ENVIRONMENT_STATE_I3:$DESKTOP_ENVIRONMENT_STATE_I3 \
  --volume DESKTOP_ENVIRONMENT_STATE_JUMP:$DESKTOP_ENVIRONMENT_STATE_JUMP \
  --volume DESKTOP_ENVIRONMENT_STATE_RESCUETIME:$DESKTOP_ENVIRONMENT_STATE_RESCUETIME \
  --volume DESKTOP_ENVIRONMENT_STATE_TELEGRAM:$DESKTOP_ENVIRONMENT_STATE_TELEGRAM \
  --volume DESKTOP_ENVIRONMENT_STATE_WHATSDESK:$DESKTOP_ENVIRONMENT_STATE_WHATSDESK \
  --volume DESKTOP_ENVIRONMENT_STATE_X11:/tmp/.X11-unix \
  --volume DESKTOP_ENVIRONMENT_USER_APPS:$DESKTOP_ENVIRONMENT_USER_APPS \
  --volume DESKTOP_ENVIRONMENT_USER_DOCUMENTS:$DESKTOP_ENVIRONMENT_USER_DOCUMENTS \
  --volume DESKTOP_ENVIRONMENT_USER_DOWNLOADS:$DESKTOP_ENVIRONMENT_USER_DOWNLOADS \
  --volume DESKTOP_ENVIRONMENT_USER_GO:$DESKTOP_ENVIRONMENT_USER_GO \
  --volume DESKTOP_ENVIRONMENT_USER_MUSIC:$DESKTOP_ENVIRONMENT_USER_MUSIC \
  --volume DESKTOP_ENVIRONMENT_USER_PICTURES:$DESKTOP_ENVIRONMENT_USER_PICTURES \
  --volume DESKTOP_ENVIRONMENT_USER_REPOSITORIES:$DESKTOP_ENVIRONMENT_USER_REPOSITORIES \
  --volume DESKTOP_ENVIRONMENT_USER_TORRENTS:$DESKTOP_ENVIRONMENT_USER_TORRENTS \
  --volume DESKTOP_ENVIRONMENT_USER_VIDEOS:$DESKTOP_ENVIRONMENT_USER_VIDEOS \
  --workdir $DESKTOP_ENVIRONMENT_USER_HOME \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE:$DESKTOP_ENVIRONMENT_CONTAINER_TAG \
  sleep infinity

# Wait until the desktop environment container is running before proceeding
until docker inspect $DESKTOP_ENVIRONMENT_CONTAINER_NAME | grep Status | grep -m 1 running >/dev/null; do sleep 1; done

# Make the container docker group id the same as the host docker group id so mounted docker socket permissions match
$REPO_ROOT/docker/scripts/exec-root.sh groupmod -g $(grep docker /etc/group | cut -f3 -d:) docker

# Start the desktop environment inside the container
$REPO_ROOT/docker/scripts/exec.sh /home/$DESKTOP_ENVIRONMENT_USER/.config/scripts/startup.sh
