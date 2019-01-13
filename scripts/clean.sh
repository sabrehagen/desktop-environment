REPO_ROOT=$(dirname $(realpath $0))/..

# Stop the running environment so there are no containers using the volumes
sh $REPO_ROOT/scripts/stop.sh

docker volume rm JACKSON_HOME
