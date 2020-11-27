REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Remove all desktop environment containers
docker ps -a | \
  grep " $DESKTOP_ENVIRONMENT_CONTAINER_IMAGE-" | \
  grep -v "CONTAINER " | \
  cut -b 1-20 | \
  xargs docker rm -f
