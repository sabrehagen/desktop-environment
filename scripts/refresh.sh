REPO_ROOT=$(dirname $(realpath $0))/..

# Rebuild the desktop environment
sh $REPO_ROOT/scripts/build.sh

# Reset the desktop environment state
sh $REPO_ROOT/scripts/stop.sh
sh $REPO_ROOT/scripts/clean.sh
sh $REPO_ROOT/scripts/start.sh
sh $REPO_ROOT/scripts/alacritty.sh
