REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

SECRETS_VOLUMES=$(cat $REPO_ROOT/docker/scripts/clean*.sh | grep DESKTOP_ | grep -v SECRETS_ | cut -f 2 -d ' ' | sort | uniq)

for VOLUME_NAME in $SECRETS_VOLUMES; do

  VOLUME_PATH=$(printenv $VOLUME_NAME)

  echo Owning $VOLUME_NAME...

  # Give the desktop environment user ownership of the volume
  docker run \
    --rm \
    --user root \
    --volume $VOLUME_NAME:$VOLUME_PATH \
    alpine:latest \
    chown -R $DESKTOP_ENVIRONMENT_USER_ID:$DESKTOP_ENVIRONMENT_USER_ID $VOLUME_PATH &

done

# Wait for ownership changes to complete in parallel
wait
