REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $($REPO_ROOT/scripts/environment.sh)

docker exec \
  --interactive \
  $DESKTOP_ENVIRONMENT_CONTAINER zsh -c "$*"
