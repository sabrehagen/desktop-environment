REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $(sh $REPO_ROOT/scripts/environment.sh)

docker build \
  --build-arg DESKTOP_CONTAINER_BUILD_DATE=$(date +%s) \
  --build-arg DESKTOP_CONTAINER_GIT_SHA=$(git --git-dir $REPO_ROOT/.git rev-parse HEAD | cut -b 1-7) \
  --build-arg DESKTOP_ENVIRONMENT_GITHUB_TOKEN \
  --tag $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER:latest \
  $REPO_ROOT
