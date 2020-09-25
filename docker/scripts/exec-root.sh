REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

docker exec \
  --interactive \
  --user root \
  $DESKTOP_ENVIRONMENT_CONTAINER_IMAGE zsh -c "$*"
