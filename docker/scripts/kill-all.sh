REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $($REPO_ROOT/scripts/environment.sh)

# Remove all non desktop environment containers
docker ps -a | \
  grep -v " $DESKTOP_ENVIRONMENT_CONTAINER" | \
  cut -b 1-20 | \
  xargs docker rm -f
