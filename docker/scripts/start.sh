REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Ensure volumes that can be removed are owned before starting
$REPO_ROOT/docker/scripts/clean.sh

# Ensure the desktop environment network exists
docker network create $DESKTOP_ENVIRONMENT_DOCKER_NETWORK

# Start the desktop environment container
docker run \
  --cap-add SYS_PTRACE \
  --detach \
  --device /dev/snd \
  --env DESKTOP_ENVIRONMENT_USER \
  --env DISPLAY=:0 \
  --env GIT_COMMITTER_EMAIL="$DESKTOP_ENVIRONMENT_GIT_EMAIL" \
  --env GIT_COMMITTER_NAME="$DESKTOP_ENVIRONMENT_GIT_NAME" \
  --group-add audio \
  --group-add docker \
  --group-add video \
  --hostname $DESKTOP_ENVIRONMENT_REGISTRY-$DESKTOP_ENVIRONMENT_CONTAINER_NAME-$(hostname) \
  --interactive \
  --name $DESKTOP_ENVIRONMENT_CONTAINER_NAME \
  --rm \
  --security-opt seccomp:$REPO_ROOT/docker/config/chrome/chrome.json \
  --tty \
  --volume /dev/shm:/dev/shm \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --volume /var/lib/docker:/var/lib/docker \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume DESKTOP_ENVIRONMENT_CACHE_CERTIFICATES:$DESKTOP_ENVIRONMENT_CACHE_CERTIFICATES \
  --volume DESKTOP_ENVIRONMENT_CACHE_CHROME:$DESKTOP_ENVIRONMENT_CACHE_CHROME \
  --volume DESKTOP_ENVIRONMENT_CACHE_CODE:$DESKTOP_ENVIRONMENT_CACHE_CODE \
  --volume DESKTOP_ENVIRONMENT_CACHE_GDRIVE:$DESKTOP_ENVIRONMENT_CACHE_GDRIVE \
  --volume DESKTOP_ENVIRONMENT_CACHE_SECRETS:$DESKTOP_ENVIRONMENT_CACHE_SECRETS \
  --volume DESKTOP_ENVIRONMENT_CACHE_SSH:$DESKTOP_ENVIRONMENT_CACHE_SSH \
  --volume DESKTOP_ENVIRONMENT_CACHE_STEMN:$DESKTOP_ENVIRONMENT_CACHE_STEMN \
  --volume DESKTOP_ENVIRONMENT_CACHE_TMUX:$DESKTOP_ENVIRONMENT_CACHE_TMUX \
  --volume DESKTOP_ENVIRONMENT_CACHE_YARN:$DESKTOP_ENVIRONMENT_CACHE_YARN \
  --volume DESKTOP_ENVIRONMENT_CACHE_ZOOM:$DESKTOP_ENVIRONMENT_CACHE_ZOOM \
  --volume DESKTOP_ENVIRONMENT_CACHE_ZSH:$DESKTOP_ENVIRONMENT_CACHE_ZSH \
  --volume DESKTOP_ENVIRONMENT_STATE_CHROME:$DESKTOP_ENVIRONMENT_STATE_CHROME \
  --volume DESKTOP_ENVIRONMENT_STATE_CODE:$DESKTOP_ENVIRONMENT_STATE_CODE \
  --volume DESKTOP_ENVIRONMENT_STATE_GITHUB:$DESKTOP_ENVIRONMENT_STATE_GITHUB \
  --volume DESKTOP_ENVIRONMENT_STATE_JUMP:$DESKTOP_ENVIRONMENT_STATE_JUMP \
  --volume DESKTOP_ENVIRONMENT_STATE_MUSIKCUBE:$DESKTOP_ENVIRONMENT_STATE_MUSIKCUBE \
  --volume DESKTOP_ENVIRONMENT_STATE_SIGNAL:$DESKTOP_ENVIRONMENT_STATE_SIGNAL \
  --volume DESKTOP_ENVIRONMENT_STATE_SLACK:$DESKTOP_ENVIRONMENT_STATE_SLACK \
  --volume DESKTOP_ENVIRONMENT_STATE_ZOOM:$DESKTOP_ENVIRONMENT_STATE_ZOOM \
  --volume DESKTOP_ENVIRONMENT_USER_DOCUMENTS:$DESKTOP_ENVIRONMENT_USER_DOCUMENTS \
  --volume DESKTOP_ENVIRONMENT_USER_DOWNLOADS:$DESKTOP_ENVIRONMENT_USER_DOWNLOADS \
  --volume DESKTOP_ENVIRONMENT_USER_GO:$DESKTOP_ENVIRONMENT_USER_GO \
  --volume DESKTOP_ENVIRONMENT_USER_MUSIC:$DESKTOP_ENVIRONMENT_USER_MUSIC \
  --volume DESKTOP_ENVIRONMENT_USER_PICTURES:$DESKTOP_ENVIRONMENT_USER_PICTURES \
  --volume DESKTOP_ENVIRONMENT_USER_REPOSITORIES:$DESKTOP_ENVIRONMENT_USER_REPOSITORIES \
  --volume DESKTOP_ENVIRONMENT_USER_TORRENTS:$DESKTOP_ENVIRONMENT_USER_TORRENTS \
  --volume DESKTOP_ENVIRONMENT_USER_VIDEOS:$DESKTOP_ENVIRONMENT_USER_VIDEOS \
  --workdir $DESKTOP_ENVIRONMENT_USER_HOME \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_NAME:$DESKTOP_ENVIRONMENT_CONTAINER_TAG \
  sleep infinity

# Wait until the desktop environment container is running before proceeding
until docker inspect $DESKTOP_ENVIRONMENT_CONTAINER_NAME | grep Status | grep -m 1 running >/dev/null; do sleep 1; done

# Start the desktop environment inside the container
$REPO_ROOT/docker/scripts/exec.sh /home/$DESKTOP_ENVIRONMENT_USER/.config/scripts/startup.sh
