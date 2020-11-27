REPO_ROOT=$(dirname $(readlink -f $0))/../../..
IMAGE=$(basename $(dirname $0))

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Start the desktop environment container
docker run \
  --detach \
  --env DESKTOP_ENVIRONMENT_HOST_HOSTNAME \
  --env DISPLAY \
  --interactive \
  --name $DESKTOP_ENVIRONMENT_CONTAINER_NAME-$IMAGE \
  --network $DESKTOP_ENVIRONMENT_DOCKER_NETWORK \
  --rm \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume DESKTOP_ENVIRONMENT_STATE_TMUX:$DESKTOP_ENVIRONMENT_STATE_TMUX \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE-$IMAGE:$DESKTOP_ENVIRONMENT_CONTAINER_TAG
