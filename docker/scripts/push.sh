REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

docker push $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER_NAME:$DESKTOP_ENVIRONMENT_CONTAINER_TAG
