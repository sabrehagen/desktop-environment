REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Ensure the desktop environment shell session exists
docker exec \
  --detach \
  $DESKTOP_ENVIRONMENT_CONTAINER_NAME \
  tmux new-session \
  -s desktop-environment-shell \
  -d

# Start a new tmux client attached to the desktop environment shell
docker exec \
  --detach \
  $DESKTOP_ENVIRONMENT_CONTAINER_NAME \
  tmux new-session \
  -s desktop-environment-shell-$(date +%s) \
  -t desktop-environment-shell
