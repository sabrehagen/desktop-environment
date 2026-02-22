REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Prepare docker host volumes
$REPO_ROOT/docker/scripts/take-ownership.sh

# Start desktop environment
$REPO_ROOT/docker/scripts/recycle.sh
