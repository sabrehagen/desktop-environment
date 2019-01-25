REPO_ROOT=$(dirname $(realpath $0))/..

# Rebuild the desktop environment
sh $REPO_ROOT/scripts/build.sh

# Reset the desktop environment state
sh $REPO_ROOT/scripts/stop.sh
sh $REPO_ROOT/scripts/clean.sh
sh $REPO_ROOT/scripts/start.sh

# Start the desktop environment detached from this shell
nohup alacritty </dev/null >/dev/null 2>&1 &
