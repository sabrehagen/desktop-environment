REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

docker build \
  --build-arg DESKTOP_CONTAINER_BUILD_DATE=$(date +%s) \
  --build-arg DESKTOP_CONTAINER_GIT_SHA=$(git --git-dir $REPO_ROOT/.git rev-parse HEAD | cut -b 1-7) \
  --build-arg DESKTOP_ENVIRONMENT_GIT_EMAIL=$DESKTOP_ENVIRONMENT_GIT_EMAIL \
  --build-arg DESKTOP_ENVIRONMENT_GIT_NAME=$DESKTOP_ENVIRONMENT_GIT_NAME \
  --cache-from $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_NAME:$DESKTOP_ENVIRONMENT_CONTAINER_TAG \
  --file docker/Dockerfile \
  --pull \
  --tag $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_NAME:$DESKTOP_ENVIRONMENT_CONTAINER_TAG \
  --tag $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_NAME:latest \
  $REPO_ROOT/docker
