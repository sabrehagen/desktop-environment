REPO_ROOT=$(dirname $(realpath $0))/..

sh $REPO_ROOT/scripts/stop.sh
sh $REPO_ROOT/scripts/start.sh
