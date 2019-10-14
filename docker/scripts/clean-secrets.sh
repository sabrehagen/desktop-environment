REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Clean volumes containing private data
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_CACHE_GDRIVE &
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_STATE_SIGNAL &
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_CACHE_SSH &

# Wait for cleans to complete in parallel
wait
