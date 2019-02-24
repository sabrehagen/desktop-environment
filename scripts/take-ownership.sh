REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $($REPO_ROOT/scripts/environment.sh)

DESKTOP_ENVIRONMENT_VOLUMES=$(cat scripts/environment.sh | grep -E "CACHE|STATE|USER_" | cut -b 6- | cut -f 1 -d =)

for VOLUME_NAME in $DESKTOP_ENVIRONMENT_VOLUMES; do

  VOLUME_PATH=$(printenv $VOLUME_NAME)

  # Give the desktop environment user ownership of the volume
  docker run \
    --rm \
    --user root \
    --volume $VOLUME_NAME:$VOLUME_PATH \
    $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER:$DESKTOP_ENVIRONMENT_BRANCH \
    chown -R $DESKTOP_ENVIRONMENT_USER:$DESKTOP_ENVIRONMENT_USER $VOLUME_PATH &

done

# Wait for ownership changes to complete in parallel
wait
