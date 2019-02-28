REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

docker rm -f $DESKTOP_ENVIRONMENT_CONTAINER_NAME
