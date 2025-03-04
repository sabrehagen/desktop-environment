REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Set the cachebust file to rebuild from apps onwards
CACHEBUST_APPS=$(date +%s > $REPO_ROOT/.cachebust-apps)

# Rebuild the desktop environment
$REPO_ROOT/docker/scripts/build.sh
