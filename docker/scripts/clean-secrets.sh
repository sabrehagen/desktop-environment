REPO_ROOT=$(dirname $(realpath $0))/..

# Perform standard clean
$REPO_ROOT/scripts/clean.sh

# Remove volumes containing secrets
docker volume rm DESKTOP_ENVIRONMENT_CACHE_SECRETS
docker volume rm DESKTOP_ENVIRONMENT_CACHE_VCSH_PRIVATE
