REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Build the desktop environment without cache
$REPO_ROOT/docker/scripts/build.sh --no-cache
