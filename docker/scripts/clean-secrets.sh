REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Perform standard clean
$REPO_ROOT/docker/scripts/clean.sh

# Clean volumes containing secrets
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_CACHE_SECRETS &
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_CACHE_SIGNAL &
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_CACHE_SSH &
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_CACHE_VCSH_PRIVATE &

# Wait for cleans to complete in parallel
wait
