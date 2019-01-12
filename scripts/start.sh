REPO_ROOT=$(dirname $(realpath $0))/..

docker run \
  --detach \
  --device /dev/snd \
  --device /dev/dri \
  --device /dev/video0 \
  --device /dev/usb \
  --device /dev/bus/usb \
  --env DISPLAY \
  --env SSH_AUTH_SOCK \
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
  --volume $HOME/.ssh:$STEMN_HOME/.ssh \
  --volume $HOME:/home \
  --volume $SSH_AUTH_SOCK:$SSH_AUTH_SOCK \
  --volume JACKSON_HOME:/jackson/home \
  --workdir /home \
  sabrehagen/development-environment:latest
