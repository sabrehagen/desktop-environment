REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Ensure the desktop environment network exists
docker network create $DESKTOP_ENVIRONMENT_DOCKER_NETWORK

# Start the desktop environment container
docker run \
  --detach \
  --env DESKTOP_ENVIRONMENT_USER \
  --name $DESKTOP_ENVIRONMENT_CONTAINER_NAME \
  --rm \
  --user $DESKTOP_ENVIRONMENT_USER \
  --workdir $DESKTOP_ENVIRONMENT_USER_HOME \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_NAME:$DESKTOP_ENVIRONMENT_CONTAINER_TAG \
  sleep infinity

# Wait until the desktop environment container is running before proceeding
until docker inspect $DESKTOP_ENVIRONMENT_CONTAINER_NAME | grep Status | grep -m 1 running >/dev/null; do sleep 1; done

# Start the desktop environment inside the container
$REPO_ROOT/docker/scripts/exec.sh /home/$DESKTOP_ENVIRONMENT_USER/.config/scripts/vnc.sh

# Check desktop environment started successfully
curl --silent localhost | grep -iq vnc
