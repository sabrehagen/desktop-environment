REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Rebuild the desktop environment
$REPO_ROOT/docker/scripts/build-all.sh

# Restart the desktop environment state
$REPO_ROOT/docker/scripts/stop.sh
$REPO_ROOT/docker/scripts/clean-hard.sh
$REPO_ROOT/docker/scripts/start.sh
