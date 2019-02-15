REPO_ROOT=$(dirname $(realpath $0))/..

# Perform a basic clean
$REPO_ROOT/scripts/clean.sh

# Remove volumes that can be recreated from scratch, but require manual configuration in app
docker volume rm DESKTOP_ENVIRONMENT_CONFIG_CHROME
docker volume rm DESKTOP_ENVIRONMENT_CONFIG_CODE
docker volume rm DESKTOP_ENVIRONMENT_CONFIG_GITHUB
