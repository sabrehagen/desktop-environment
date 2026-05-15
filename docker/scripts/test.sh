REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Ensure the desktop environment test network exists
docker network create $DESKTOP_ENVIRONMENT_DOCKER_NETWORK

# Set the desktop environment test container name
DESKTOP_ENVIRONMENT_CONTAINER_NAME=${DESKTOP_ENVIRONMENT_CONTAINER_IMAGE}-test-$(date +%s)

# Start the desktop environment test container
docker run \
  --detach \
  --group-add $DESKTOP_ENVIRONMENT_HOST_DOCKER_GROUP_ID \
  --name $DESKTOP_ENVIRONMENT_CONTAINER_NAME \
  --rm \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE \
  sleep infinity

# Wait until the desktop environment test container is running before proceeding
timeout 10 sh -c "until docker inspect $DESKTOP_ENVIRONMENT_CONTAINER_NAME | grep Status | grep -m 1 running >/dev/null; do sleep 1; done"

# Check docker ps works in the container to verify docker group access
docker exec $DESKTOP_ENVIRONMENT_CONTAINER_NAME docker ps >/dev/null

# Check desktop environment container started and docker ps succeeded
TEST_RESULT=$?

# Remove desktop environment test container
docker rm -f $DESKTOP_ENVIRONMENT_CONTAINER_NAME

# Exit with test result exit code
exit $TEST_RESULT
