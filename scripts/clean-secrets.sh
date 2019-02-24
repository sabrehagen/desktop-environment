REPO_ROOT=$(dirname $(realpath $0))/..

# Stop the running environment so there are no containers using the volumes, ignoring errors if it does not exist
$REPO_ROOT/scripts/stop.sh 2>/dev/null

# Perform standard clean
$REPO_ROOT/scripts/clean.sh

# Remove volumes containing secrets
docker volume rm DESKTOP_ENVIRONMENT_CACHE_SECRETS
docker volume rm DESKTOP_ENVIRONMENT_CACHE_VCSH_PRIVATE
