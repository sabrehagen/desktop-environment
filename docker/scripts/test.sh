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
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE:$DESKTOP_ENVIRONMENT_CONTAINER_TAG \
  sleep infinity

# Wait until the desktop environment test container is running before proceeding
until docker inspect $DESKTOP_ENVIRONMENT_CONTAINER_NAME | grep Status | grep -m 1 running >/dev/null; do sleep 1; done

# Start the vnc server inside the desktop environment container
$REPO_ROOT/docker/scripts/exec.sh /home/$DESKTOP_ENVIRONMENT_USER/.config/scripts/startup.sh

# Check desktop environment vnc server started successfully
$REPO_ROOT/docker/scripts/exec.sh "curl --silent localhost | grep -iq vnc"
TEST_RESULT=$?

# Remove desktop environment test container
docker rm -f $DESKTOP_ENVIRONMENT_CONTAINER_NAME

# Exit with test result exit code
exit $TEST_RESULT
