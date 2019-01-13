REPO_ROOT=$(dirname $(realpath $0))/..
JACKSON_HOME=/jackson/home

# Ensure the container user has ownership of the volumes before starting
sh $REPO_ROOT/scripts/bootstrap-volumes.sh

docker run \
  --detach \
  --device /dev/snd \
  --device /dev/dri \
  --device /dev/video0 \
  --device /dev/usb \
  --device /dev/bus/usb \
  --env DISPLAY \
  --env SSH_AUTH_SOCK=$JACKSON_HOME/.ssh/auth.sock \
  --env STEMN_GIT_EMAIL="$(git config --get user.email)" \
  --env STEMN_GIT_NAME="$(git config --get user.name)" \
  --group-add audio \
  --group-add video \
  --interactive \
  --name desktop-environment \
  --net host \
  --rm \
  --security-opt seccomp:$REPO_ROOT/config/chrome/chrome.json \
  --tty \
  --volume /dev/shm:/dev/shm \
  --volume /etc/localtime:/etc/localtime:ro \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume $HOME/.ssh:$JACKSON_HOME/.ssh \
  --volume $HOME/notes:$JACKSON_HOME/notes \
  --volume $HOME/repositories:$JACKSON_HOME/repositories \
  --volume $HOME/Downloads:$JACKSON_HOME/Downloads \
  --volume $HOME/Pictures:$JACKSON_HOME/Pictures \
  --volume $HOME/Videos:$JACKSON_HOME/Videos \
  --volume ${SSH_AUTH_SOCK-$HOME/.ssh/auth.sock}:$JACKSON_HOME/.ssh/auth.sock \
  --volume JACKSON_CONFIG_CHROME:$JACKSON_HOME/.config/google-chrome \
  --volume JACKSON_CONFIG_CODE:$JACKSON_HOME/.config/Code \
  --volume JACKSON_HOME:$JACKSON_HOME \
  --workdir $JACKSON_HOME \
  sabrehagen/desktop-environment:latest

# Wait until the container is running before proceeding
until docker inspect desktop-environment | grep Status | grep -m 1 "running" >/dev/null; do sleep 1 ; done
