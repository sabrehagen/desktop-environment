REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

DESKTOP_ENVIRONMENT_VOLUMES=$(cat $REPO_ROOT/docker/scripts/environment.sh | grep echo | grep -v _ID | grep -E "CACHE|STATE|USER_" | cut -b 13- | cut -f 1 -d =)

for VOLUME_NAME in $DESKTOP_ENVIRONMENT_VOLUMES; do

  VOLUME_PATH=$(printenv $VOLUME_NAME)

  echo Owning $VOLUME_NAME...

  # Give the desktop environment user ownership of the volume
  docker run \
    --quiet \
    --rm \
    --user root \
    --volume $VOLUME_NAME:$VOLUME_PATH \
    alpine:latest \
    chown -R $DESKTOP_ENVIRONMENT_USER_ID:$DESKTOP_ENVIRONMENT_USER_ID $VOLUME_PATH &

done

# Wait for ownership changes to complete in parallel
wait

# Ensure desktop environment network exists
docker network create $DESKTOP_ENVIRONMENT_DOCKER_NETWORK 2>/dev/null
