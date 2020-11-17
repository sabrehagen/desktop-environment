REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Get host user password to apply to container user
DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD=$(sudo cat /etc/shadow | grep $DESKTOP_ENVIRONMENT_USER | cut -d: -f2)

docker build \
  --build-arg DESKTOP_CONTAINER_GIT_SHA=$(git --git-dir $REPO_ROOT/.git rev-parse HEAD | cut -b 1-7) \
  --build-arg DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME="$DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE" \
  --build-arg DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD="$DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD" \
  --build-arg DESKTOP_ENVIRONMENT_USER="$DESKTOP_ENVIRONMENT_USER" \
  --build-arg DESKTOP_ENVIRONMENT_GITHUB_USER="$DESKTOP_ENVIRONMENT_GITHUB_USER" \
  --build-arg DOTFILES_CACHEBUST=$(cat $REPO_ROOT/.dotfiles-cachebust 2>/dev/null) \
  --file $REPO_ROOT/docker/Dockerfile \
  --network host \
  --tag $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE:$DESKTOP_ENVIRONMENT_CONTAINER_TAG \
  --tag $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE:latest \
  $REPO_ROOT/docker
