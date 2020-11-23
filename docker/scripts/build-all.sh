REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Build the base image
$REPO_ROOT/docker/scripts/build.sh

# Build all images in parallel
ls $REPO_ROOT/docker/images | \
  xargs -n 1 -P 0 $REPO_ROOT/docker/scripts/build.sh
