REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $($REPO_ROOT/scripts/environment.sh)

docker rm -f $DESKTOP_ENVIRONMENT_CONTAINER
