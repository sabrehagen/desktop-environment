REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$(cat $REPO_ROOT/docker/scripts/environment.sh)"

VOLUME_NAME=$1

echo Removing $VOLUME_NAME...

docker volume rm $VOLUME_NAME
