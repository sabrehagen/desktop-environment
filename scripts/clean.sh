REPO_ROOT=$(dirname $(realpath $0))/..

# Stop the running environment so there are no containers using the volumes, ignoring errors if it does not exist
$REPO_ROOT/scripts/stop.sh 2>/dev/null

# Remove volumes that can be recreated from scratch, directly from the container filesystem
docker volume rm DESKTOP_ENVIRONMENT_CACHE_SECRETS
docker volume rm DESKTOP_ENVIRONMENT_CACHE_SSH
docker volume rm DESKTOP_ENVIRONMENT_CACHE_VCSH
docker volume rm DESKTOP_ENVIRONMENT_USER_HOME
