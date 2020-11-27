REPO_ROOT=$(dirname $(readlink -f $0))/../../..
IMAGE=$(basename $(dirname $0))

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

docker run \
  --detach \
  --env DISPLAY=${DISPLAY-:1} \
  --interactive \
  --name $DESKTOP_ENVIRONMENT_CONTAINER_NAME-$IMAGE \
  --network $DESKTOP_ENVIRONMENT_DOCKER_NETWORK \
  --rm \
  --volume DESKTOP_ENVIRONMENT_STATE_TMUX:$DESKTOP_ENVIRONMENT_STATE_TMUX \
  --volume DESKTOP_ENVIRONMENT_STATE_X11:$DESKTOP_ENVIRONMENT_STATE_X11 \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE-$IMAGE:$DESKTOP_ENVIRONMENT_CONTAINER_TAG
