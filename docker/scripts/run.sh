REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Run image supplied as the first argument
IMAGE=${1-base}

$REPO_ROOT/docker/images/$IMAGE/run.sh $@
