REPO_ROOT=$(dirname $(realpath $0))/..

# Stop the running environment so there are no containers using the volumes, ignoring errors if it does not exist
sh $REPO_ROOT/scripts/stop.sh 2>/dev/null

docker volume rm JACKSON_HOME
