REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $($REPO_ROOT/scripts/environment.sh)

# Start a desktop environment detached from this shell
nohup gosu $DESKTOP_ENVIRONMENT_USER alacritty </dev/null >/dev/null 2>&1 &
