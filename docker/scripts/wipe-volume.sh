REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

VOLUME_NAME=$1
VOLUME_PATH=$(printenv $VOLUME_NAME)

# Remove all files in the volume rather than removing the volume so that ownership permissions are preserved
docker run \
  --rm \
  --user root \
  --volume $VOLUME_NAME:$VOLUME_PATH \
  --workdir $VOLUME_PATH \
  alpine:latest \
  rm -rf ..?* .[!.]* *
