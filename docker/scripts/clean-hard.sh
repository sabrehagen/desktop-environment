REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Remove volumes that can be recreated from scratch, but require manual configuration in app
docker volume rm DESKTOP_ENVIRONMENT_STATE_CHROME &
docker volume rm DESKTOP_ENVIRONMENT_STATE_CODE &
docker volume rm DESKTOP_ENVIRONMENT_STATE_JUMP &
docker volume rm DESKTOP_ENVIRONMENT_STATE_MUSIKCUBE &
docker volume rm DESKTOP_ENVIRONMENT_STATE_TRAEFIK &

# Wait for cleans to complete in parallel
wait
