REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Ensure the desktop environment network exists
docker network create $DESKTOP_ENVIRONMENT_DOCKER_NETWORK

# Start the desktop environment container
docker run \
  --cap-add IPC_LOCK \
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
  --env DESKTOP_ENVIRONMENT_TTY \
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
  --publish 8022:22 \
  --publish 8080 \
  --publish 8081 \
  --publish 8082 \
  --rm \
  --security-opt apparmor:unconfined \
  --volume /dev/displaylink:/dev/displaylink \
  --volume /dev/shm:/dev/shm \
  --volume /mnt/mmc:/mnt/mmc \
  --volume /run/dbus/system_bus_socket:/run/dbus/system_bus_socket \
  --volume /run/udev:/run/udev \
  --volume /var/lib/docker:/var/lib/docker \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume DESKTOP_ENVIRONMENT_CACHE_AWS:$DESKTOP_ENVIRONMENT_CACHE_AWS \
  --volume DESKTOP_ENVIRONMENT_CACHE_CODE:$DESKTOP_ENVIRONMENT_CACHE_CODE \
  --volume DESKTOP_ENVIRONMENT_CACHE_CURSOR:$DESKTOP_ENVIRONMENT_CACHE_CURSOR \
  --volume DESKTOP_ENVIRONMENT_CACHE_KDENLIVE:$DESKTOP_ENVIRONMENT_CACHE_KDENLIVE \
  --volume DESKTOP_ENVIRONMENT_CACHE_SSH:$DESKTOP_ENVIRONMENT_CACHE_SSH \
  --volume DESKTOP_ENVIRONMENT_CACHE_THORIUM:$DESKTOP_ENVIRONMENT_CACHE_THORIUM \
  --volume DESKTOP_ENVIRONMENT_CACHE_TMUX:$DESKTOP_ENVIRONMENT_CACHE_TMUX \
  --volume DESKTOP_ENVIRONMENT_CACHE_YARN:$DESKTOP_ENVIRONMENT_CACHE_YARN \
  --volume DESKTOP_ENVIRONMENT_CACHE_ZSH:$DESKTOP_ENVIRONMENT_CACHE_ZSH \
  --volume DESKTOP_ENVIRONMENT_STATE_BEEKEEPER:$DESKTOP_ENVIRONMENT_STATE_BEEKEEPER \
  --volume DESKTOP_ENVIRONMENT_STATE_CHATGPT:$DESKTOP_ENVIRONMENT_STATE_CHATGPT \
  --volume DESKTOP_ENVIRONMENT_STATE_CLAUDEAI:$DESKTOP_ENVIRONMENT_STATE_CLAUDEAI \
  --volume DESKTOP_ENVIRONMENT_STATE_CODE:$DESKTOP_ENVIRONMENT_STATE_CODE \
  --volume DESKTOP_ENVIRONMENT_STATE_CURSOR:$DESKTOP_ENVIRONMENT_STATE_CURSOR \
  --volume DESKTOP_ENVIRONMENT_STATE_DISCORD:$DESKTOP_ENVIRONMENT_STATE_DISCORD \
  --volume DESKTOP_ENVIRONMENT_STATE_I3:$DESKTOP_ENVIRONMENT_STATE_I3 \
  --volume DESKTOP_ENVIRONMENT_STATE_JUMP:$DESKTOP_ENVIRONMENT_STATE_JUMP \
  --volume DESKTOP_ENVIRONMENT_STATE_KDENLIVE:$DESKTOP_ENVIRONMENT_STATE_KDENLIVE \
  --volume DESKTOP_ENVIRONMENT_STATE_KEYRING:$DESKTOP_ENVIRONMENT_STATE_KEYRING \
  --volume DESKTOP_ENVIRONMENT_STATE_SIGNAL:$DESKTOP_ENVIRONMENT_STATE_SIGNAL \
  --volume DESKTOP_ENVIRONMENT_STATE_SLACK:$DESKTOP_ENVIRONMENT_STATE_SLACK \
  --volume DESKTOP_ENVIRONMENT_STATE_TELEGRAM:$DESKTOP_ENVIRONMENT_STATE_TELEGRAM \
  --volume DESKTOP_ENVIRONMENT_STATE_THORIUM:$DESKTOP_ENVIRONMENT_STATE_THORIUM \
  --volume DESKTOP_ENVIRONMENT_STATE_WHATSDESK:$DESKTOP_ENVIRONMENT_STATE_WHATSDESK \
  --volume DESKTOP_ENVIRONMENT_STATE_X11:$DESKTOP_ENVIRONMENT_STATE_X11 \
  --volume DESKTOP_ENVIRONMENT_USER_DOCUMENTS:$DESKTOP_ENVIRONMENT_USER_DOCUMENTS \
  --volume DESKTOP_ENVIRONMENT_USER_DOWNLOADS:$DESKTOP_ENVIRONMENT_USER_DOWNLOADS \
  --volume DESKTOP_ENVIRONMENT_USER_GO:$DESKTOP_ENVIRONMENT_USER_GO \
  --volume DESKTOP_ENVIRONMENT_USER_MUSIC:$DESKTOP_ENVIRONMENT_USER_MUSIC \
  --volume DESKTOP_ENVIRONMENT_USER_PICTURES:$DESKTOP_ENVIRONMENT_USER_PICTURES \
  --volume DESKTOP_ENVIRONMENT_USER_REPOSITORIES:$DESKTOP_ENVIRONMENT_USER_REPOSITORIES \
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
