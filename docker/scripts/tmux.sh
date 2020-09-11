REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Start a new tmux client attached to the desktop environment shell
docker exec \
  --interactive \
  --tty \
  $DESKTOP_ENVIRONMENT_CONTAINER_IMAGE \
  tmux new-session \
  -s desktop-environment-shell-$(date +%s) \
  -t desktop-environment-shell
