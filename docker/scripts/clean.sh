REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Stop the running environment so there are no containers using the volumes, ignoring errors if it does not exist
$REPO_ROOT/docker/scripts/stop.sh 2>/dev/null

# Remove stateful volumes that are recreated directly from the container filesystem
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_CACHE_VCSH &
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_USER_HOME &

# Wait for cleans to complete in parallel
wait
