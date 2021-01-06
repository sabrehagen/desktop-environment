REPO_ROOT=$(dirname $(readlink -f $0))/../..
IMAGE=${1-base}

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

docker push $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE-$IMAGE:$DESKTOP_ENVIRONMENT_CONTAINER_TAG
