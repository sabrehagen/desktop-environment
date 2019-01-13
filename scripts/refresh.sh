REPO_ROOT=$(dirname $(realpath $0))/..

sh $REPO_ROOT/scripts/build.sh
sh $REPO_ROOT/scripts/restart.sh
sh $REPO_ROOT/scripts/shell.sh
