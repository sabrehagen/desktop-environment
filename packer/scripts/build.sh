REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Clone the desktop environment into a local docker volume
$REPO_ROOT/docker/scripts/clone.sh

# Authenticate with cloud service provider
$REPO_ROOT/credentials/authenticate.sh

docker run \
  --env DESKTOP_ENVIRONMENT_CONTAINER_NAME \
  --env DESKTOP_ENVIRONMENT_REGISTRY \
  --env GOOGLE_APPLICATION_CREDENTIALS=$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY/credentials/google.json \
  --interactive \
  --rm \
  --tty \
  --volume DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY:$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY:ro \
  hashicorp/packer:light build \
  -force \
  $DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY/packer/desktop-environment.json
