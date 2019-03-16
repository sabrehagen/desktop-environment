REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval $($REPO_ROOT/docker/scripts/environment.sh)

# Start a desktop environment detached from this shell
nohup gosu $DESKTOP_ENVIRONMENT_USER alacritty </dev/null >/dev/null 2>&1 &
