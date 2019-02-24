REPO_ROOT=$(dirname $(realpath $0))/..

# Clean secrets and home
$REPO_ROOT/scripts/clean-secrets.sh

# Remove volumes that can be recreated from scratch, but require manual configuration in app
docker volume rm DESKTOP_ENVIRONMENT_STATE_CHROME
docker volume rm DESKTOP_ENVIRONMENT_STATE_CODE
docker volume rm DESKTOP_ENVIRONMENT_STATE_GITHUB
docker volume rm DESKTOP_ENVIRONMENT_STATE_JUMP
docker volume rm DESKTOP_ENVIRONMENT_STATE_MUSIKCUBE
docker volume rm DESKTOP_ENVIRONMENT_STATE_ZOOM
