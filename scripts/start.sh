REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $($REPO_ROOT/scripts/environment.sh)

# Ensure the container user has ownership of the volumes before starting
$REPO_ROOT/scripts/bootstrap-volumes.sh

docker run \
  --cap-add=SYS_PTRACE \
  --detach \
  --device /dev/dri \
  --device /dev/snd \
  --device /dev/usb \
  --device /dev/video0 \
  --device /dev/bus/usb \
  --env DISPLAY=${DISPLAY-:0} \
  --env DBUS_SESSION_BUS_ADDRESS \
  --env XAUTHORITY \
  --group-add audio \
  --group-add docker \
  --group-add video \
  --interactive \
  --name $DESKTOP_ENVIRONMENT_CONTAINER \
  --rm \
  --security-opt seccomp:$REPO_ROOT/config/chrome/chrome.json \
  --tty \
  --user $DESKTOP_ENVIRONMENT_USER \
  --volume /dev/shm:/dev/shm \
  --volume /etc/localtime:/etc/localtime:ro \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --volume /var/run/dbus:/var/run/dbus \
  --volume /var/lib/docker:/var/lib/docker \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume $DESKTOP_ENVIRONMENT_HOME/.config/alacritty:$DESKTOP_ENVIRONMENT_HOME/.config/alacritty \
  --volume $DESKTOP_ENVIRONMENT_HOME/Documents:$DESKTOP_ENVIRONMENT_HOME/Documents \
  --volume $DESKTOP_ENVIRONMENT_HOME/Downloads:$DESKTOP_ENVIRONMENT_HOME/Downloads \
  --volume $DESKTOP_ENVIRONMENT_HOME/Music:$DESKTOP_ENVIRONMENT_HOME/Music \
  --volume $DESKTOP_ENVIRONMENT_HOME/notes:$DESKTOP_ENVIRONMENT_HOME/notes \
  --volume $DESKTOP_ENVIRONMENT_HOME/Pictures:$DESKTOP_ENVIRONMENT_HOME/Pictures \
  --volume $DESKTOP_ENVIRONMENT_HOME/Videos:$DESKTOP_ENVIRONMENT_HOME/Videos \
  --volume DESKTOP_ENVIRONMENT_CACHE_CERTIFICATES:$DESKTOP_ENVIRONMENT_CACHE_CERTIFICATES \
  --volume DESKTOP_ENVIRONMENT_CACHE_CHROME:$DESKTOP_ENVIRONMENT_CACHE_CHROME \
  --volume DESKTOP_ENVIRONMENT_CACHE_CODE:$DESKTOP_ENVIRONMENT_CACHE_CODE \
  --volume DESKTOP_ENVIRONMENT_CACHE_JUMP:$DESKTOP_ENVIRONMENT_CACHE_JUMP \
  --volume DESKTOP_ENVIRONMENT_CACHE_SSH:$DESKTOP_ENVIRONMENT_CACHE_SSH \
  --volume DESKTOP_ENVIRONMENT_CACHE_YARN:$DESKTOP_ENVIRONMENT_CACHE_YARN \
  --volume DESKTOP_ENVIRONMENT_CACHE_ZOOM:$DESKTOP_ENVIRONMENT_CACHE_ZOOM \
  --volume DESKTOP_ENVIRONMENT_CACHE_ZSH:$DESKTOP_ENVIRONMENT_CACHE_ZSH \
  --volume DESKTOP_ENVIRONMENT_CONFIG_CHROME:$DESKTOP_ENVIRONMENT_CONFIG_CHROME \
  --volume DESKTOP_ENVIRONMENT_CONFIG_CODE:$DESKTOP_ENVIRONMENT_CONFIG_CODE \
  --volume DESKTOP_ENVIRONMENT_CONFIG_GITHUB:$DESKTOP_ENVIRONMENT_CONFIG_GITHUB \
  --volume DESKTOP_ENVIRONMENT_CONFIG_MUSIKCUBE:$DESKTOP_ENVIRONMENT_CONFIG_MUSIKCUBE \
  --volume DESKTOP_ENVIRONMENT_CONFIG_ZOOM:$DESKTOP_ENVIRONMENT_CONFIG_ZOOM \
  --volume DESKTOP_ENVIRONMENT_HOME:$DESKTOP_ENVIRONMENT_HOME \
  --volume DESKTOP_ENVIRONMENT_REPOSITORIES:$DESKTOP_ENVIRONMENT_REPOSITORIES \
  --workdir $DESKTOP_ENVIRONMENT_HOME \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER:latest

# Wait until the container is running before proceeding
until docker inspect $DESKTOP_ENVIRONMENT_CONTAINER | grep Status | grep -m 1 running >/dev/null; do sleep 1; done
