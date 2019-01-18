REPO_ROOT=$(dirname $(realpath $0))/..

# Export development environment shell configuration
export $(sh $REPO_ROOT/scripts/environment.sh)

docker build \
  --build-arg CONTAINER_BUILD_DATE=$(date +%s) \
  --build-arg CONTAINER_GIT_SHA=$(git rev-parse HEAD | cut -b 1-7) \
  --tag $DESKTOP_ENVIRONMENT_USER/desktop-environment:latest \
  $REPO_ROOT
