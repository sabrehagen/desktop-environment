REPO_ROOT=$(dirname $(readlink -f $0))/../..
IMAGE=${1-base}

# Remove the image name before passing the arguments
shift

$REPO_ROOT/docker/images/$IMAGE/run.sh $@
