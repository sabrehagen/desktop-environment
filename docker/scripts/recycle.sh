REPO_ROOT=$(dirname $(realpath $0))/../..

# Rebuild the desktop environment
$REPO_ROOT/docker/scripts/build.sh

# Check for data loss before recycling
$REPO_ROOT/docker/scripts/pre-clean.sh

# Reset the desktop environment state
$REPO_ROOT/docker/scripts/clean.sh
$REPO_ROOT/docker/scripts/start.sh
$REPO_ROOT/docker/scripts/alacritty.sh
