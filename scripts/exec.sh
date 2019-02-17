REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $($REPO_ROOT/scripts/environment.sh)

docker exec \
  --interactive \
  --tty \
  --user $DESKTOP_ENVIRONMENT_USER \
  $DESKTOP_ENVIRONMENT_CONTAINER zsh --login -c "$*"
