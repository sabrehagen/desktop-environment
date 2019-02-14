REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $(sh $REPO_ROOT/scripts/environment.sh)

# Start a desktop environment detached from this shell
gosu $DESKTOP_ENVIRONMENT_USER nohup alacritty </dev/null >/dev/null 2>&1 &
