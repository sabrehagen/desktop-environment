REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

docker run \
  --rm \
  --volume DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY:$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY \
  --workdir $DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY \
  alpine/git:latest clone https://github.com/$DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER --branch $DESKTOP_ENVIRONMENT_BRANCH $DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY
