REPO_ROOT=$(dirname $(readlink -f $0))/../..
IMAGE=${1-base}

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Get host user password to apply to container user
DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD=$(sudo cat /etc/shadow | grep $DESKTOP_ENVIRONMENT_USER | cut -d: -f2)

docker build \
  --build-arg DESKTOP_ENVIRONMENT_BASE="$DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE-base" \
  --build-arg DESKTOP_ENVIRONMENT_HOST_DOCKER_GID="$(grep docker /etc/group | cut -f3 -d:)" \
  --build-arg DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD="$DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD" \
  --build-arg DESKTOP_ENVIRONMENT_USER="$DESKTOP_ENVIRONMENT_USER" \
  --build-arg DESKTOP_ENVIRONMENT_GITHUB_USER="$DESKTOP_ENVIRONMENT_GITHUB_USER" \
  --build-arg DOTFILES_CACHEBUST=$(cat $REPO_ROOT/.dotfiles-cachebust 2>/dev/null) \
  --file $REPO_ROOT/docker/images/$IMAGE/Dockerfile \
  --network $DESKTOP_ENVIRONMENT_DOCKER_NETWORK \
  --tag $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE-$IMAGE:$DESKTOP_ENVIRONMENT_CONTAINER_TAG \
  --tag $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE-$IMAGE:latest \
  $REPO_ROOT/docker/images/$IMAGE
