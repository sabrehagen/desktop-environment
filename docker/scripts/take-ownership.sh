REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

DESKTOP_ENVIRONMENT_VOLUMES=$(cat $REPO_ROOT/docker/scripts/environment.sh | grep echo | grep -E 'CACHE|STATE|USER_' | grep -vE '_ID|X11' | cut -d' ' -f3 | cut -d= -f1)

for VOLUME_NAME in $DESKTOP_ENVIRONMENT_VOLUMES; do

  VOLUME_PATH=$(printenv $VOLUME_NAME)

  # Take ownership if the volume is owned by root
  docker run \
    --env DESKTOP_ENVIRONMENT_USER_ID=$DESKTOP_ENVIRONMENT_USER_ID \
    --env VOLUME_NAME=$VOLUME_NAME \
    --env VOLUME_PATH=$VOLUME_PATH \
    --quiet \
    --rm \
    --user root \
    --volume $VOLUME_NAME:$VOLUME_PATH \
    alpine:latest \
    sh -c '
      if [ "$(stat -c %U "$VOLUME_PATH")" = "root" ]; then
        echo Owning $VOLUME_NAME...
        chown -R $DESKTOP_ENVIRONMENT_USER_ID:$DESKTOP_ENVIRONMENT_USER_ID "$VOLUME_PATH"
      fi
    ' &

done

# Wait for ownership changes to complete in parallel
wait

# Ensure desktop environment network exists
docker network create $DESKTOP_ENVIRONMENT_DOCKER_NETWORK 2>/dev/null || true
