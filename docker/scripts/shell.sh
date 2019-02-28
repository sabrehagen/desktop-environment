REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

docker exec \
  --interactive \
  --tty \
  --user $DESKTOP_ENVIRONMENT_USER \
  $DESKTOP_ENVIRONMENT_CONTAINER_NAME zsh --login
