REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Ensure the desktop environment test network exists
docker network create $DESKTOP_ENVIRONMENT_DOCKER_NETWORK

# Start the desktop environment test container
docker run \
  --detach \
  --name $DESKTOP_ENVIRONMENT_CONTAINER_IMAGE \
  --rm \
  --tty \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE \
  sleep infinity

# Wait until the desktop environment test container is running before proceeding
timeout 10 sh -c "until docker inspect $DESKTOP_ENVIRONMENT_CONTAINER_IMAGE | grep Status | grep -m 1 running >/dev/null; do sleep 1; done"

# Start the desktop environment inside the container
$REPO_ROOT/docker/scripts/exec.sh /home/$DESKTOP_ENVIRONMENT_USER/.config/scripts/startup.sh
