REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval $($REPO_ROOT/docker/scripts/environment.sh)

# Remove existing cloned repository
docker run \
  --rm \
  --volume DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY:$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY \
  alpine:latest rm -rf $DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY

# Clone desktop environment repository
docker run \
  --rm \
  --volume DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY:$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY \
  alpine/git:latest clone https://github.com/$DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_NAME $DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY

# Ensure the container user has ownership of docker volumes
$REPO_ROOT/docker/scripts/take-ownership.sh
