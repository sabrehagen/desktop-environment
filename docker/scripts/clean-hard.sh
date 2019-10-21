REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Remove volumes that can be recreated from scratch, but require manual configuration in app
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_STATE_CHROME &
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_STATE_CODE &
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_STATE_JUMP &
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_STATE_MUSIKCUBE &
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_STATE_TRAEFIK &
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_STATE_ZOOM &

# Wait for cleans to complete in parallel
wait
