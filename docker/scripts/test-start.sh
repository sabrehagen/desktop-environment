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
  --expose 8080 \
  --name $DESKTOP_ENVIRONMENT_CONTAINER_NAME \
  --rm \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE \
  sleep infinity
