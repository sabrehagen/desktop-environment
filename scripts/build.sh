REPO_ROOT=$(dirname $(realpath $0))/..

docker build \
  --build-arg CONTAINER_BUILD_DATE=$(date +%s) \
  --build-arg CONTAINER_GIT_SHA=$(git rev-parse HEAD | cut -b 1-7) \
  --tag sabrehagen/desktop-environment:latest \
  $REPO_ROOT
