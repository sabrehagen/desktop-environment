REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Remove volumes that can be recreated from scratch, directly from the container filesystem
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_CACHE_VCSH
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_USER_HOME
