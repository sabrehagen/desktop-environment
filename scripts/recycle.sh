REPO_ROOT=$(dirname $(realpath $0))/..

# Rebuild the desktop environment
$REPO_ROOT/scripts/build.sh

# Check for data loss before recycling
$REPO_ROOT/scripts/pre-clean.sh

# Reset the desktop environment state
$REPO_ROOT/scripts/clean.sh
$REPO_ROOT/scripts/start.sh
$REPO_ROOT/scripts/alacritty.sh
