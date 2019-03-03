REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Remove stateful volumes that are recreated directly from the container filesystem
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_CACHE_VCSH
$REPO_ROOT/docker/scripts/wipe-volume.sh DESKTOP_ENVIRONMENT_USER_HOME
