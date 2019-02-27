REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Perform standard clean
$REPO_ROOT/docker/scripts/clean.sh

# Remove volumes containing secrets
docker volume rm DESKTOP_ENVIRONMENT_CACHE_SECRETS
docker volume rm DESKTOP_ENVIRONMENT_CACHE_SSH
docker volume rm DESKTOP_ENVIRONMENT_CACHE_VCSH_PRIVATE
