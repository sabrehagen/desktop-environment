REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Start a desktop environment detached from this shell
docker exec $DESKTOP_ENVIRONMENT_CONTAINER_NAME alacritty >/dev/null 2>&1 &
