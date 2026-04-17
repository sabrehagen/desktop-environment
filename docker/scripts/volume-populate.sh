REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

VOLUME_NAME=$1
VOLUME_PATH=$(printenv $VOLUME_NAME)

echo Populating $VOLUME_NAME from $DESKTOP_ENVIRONMENT_CONTAINER_NAME:$VOLUME_PATH...

# Copy local state to desktop environment state volume
docker cp $DESKTOP_ENVIRONMENT_CONTAINER_NAME:$VOLUME_PATH - | docker run \
  --interactive \
  --rm \
  --volume $VOLUME_NAME:$VOLUME_PATH \
  alpine tar \
  --extract \
  --file - \
  --directory $(dirname $VOLUME_PATH) \
  --overwrite
