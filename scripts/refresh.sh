REPO_ROOT=$(dirname $(realpath $0))/..

# Rebuild the desktop environment
sh $REPO_ROOT/scripts/build.sh

# Reset the desktop environment state
sh $REPO_ROOT/scripts/stop.sh
sh $REPO_ROOT/scripts/clean.sh
sh $REPO_ROOT/scripts/start.sh

# Race condition causes new shell to fail if started too soon after container restart above
sleep 1

# Enter the desktop environment
sh $REPO_ROOT/scripts/shell.sh
