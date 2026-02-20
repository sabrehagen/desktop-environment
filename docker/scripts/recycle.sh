REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Rebuild the desktop environment
$REPO_ROOT/docker/scripts/build.sh

# Reset the desktop environment state
$REPO_ROOT/docker/scripts/restart.sh
