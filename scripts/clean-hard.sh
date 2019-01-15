REPO_ROOT=$(dirname $(realpath $0))/..

# Perform a basic clean
sh $REPO_ROOT/scripts/clean.sh

# Remove volumes that can be recreated from scratch, but require manual configuration in app
docker volume rm JACKSON_CONFIG_CODE
docker volume rm JACKSON_CONFIG_CHROME
docker volume rm JACKSON_CONFIG_GITHUB
