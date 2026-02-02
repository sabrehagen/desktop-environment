REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Get host user password to apply to container user
DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD=$(sudo cat /etc/shadow | grep $DESKTOP_ENVIRONMENT_USER | cut -d: -f2)

# Capture build start time
BUILD_START_TIME=$(date +%s)

docker build \
  --build-arg CACHEBUST_APPS=$(cat $REPO_ROOT/.cachebust-apps 2>/dev/null) \
  --build-arg CACHEBUST_DOTFILES=$(cat $REPO_ROOT/.cachebust-dotfiles 2>/dev/null) \
  --build-arg DESKTOP_ENVIRONMENT_CONTAINER_GIT_SHA=$(git --git-dir $REPO_ROOT/.git rev-parse HEAD | cut -b 1-7) \
  --build-arg DESKTOP_ENVIRONMENT_CONTAINER_BUILD_DATE=$(date +%s) \
  --build-arg DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME="$DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE" \
  --build-arg DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD="$DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD" \
  --build-arg DESKTOP_ENVIRONMENT_USER="$DESKTOP_ENVIRONMENT_USER" \
  --build-arg DESKTOP_ENVIRONMENT_GITHUB_USER="$DESKTOP_ENVIRONMENT_GITHUB_USER" \
  --file $REPO_ROOT/docker/Dockerfile \
  --tag $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE:$DESKTOP_ENVIRONMENT_CONTAINER_TAG \
  --tag $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE:latest \
  $REPO_ROOT/docker \
  $@

# Capture build exit code
BUILD_EXIT_CODE=$?

# Store build exit code
echo $BUILD_EXIT_CODE > $REPO_ROOT/.build-exit-code

# Store build end time
echo $(date +%s) > $REPO_ROOT/.build-exit-time

# Report build time
echo "Build time: $(($(date +%s) - BUILD_START_TIME))s."

# Exit with build exit code
exit $BUILD_EXIT_CODE
