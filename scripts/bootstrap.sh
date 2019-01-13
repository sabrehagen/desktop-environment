REPO_ROOT=$(dirname $(realpath $0))/..

# Bootstrap the local host
sh $REPO_ROOT/scripts/bootstrap-host.sh

# Bootstrap the docker volumes
sh $REPO_ROOT/scripts/bootstrap-volumes.sh
