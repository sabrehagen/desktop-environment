REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

# Authenticate with cloud service provider
$REPO_ROOT/credentials/authenticate.sh

docker run \
  --entrypoint ash \
  --env GOOGLE_APPLICATION_CREDENTIALS=$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY/credentials/credentials.json \
  --interactive \
  --rm \
  --tty \
  --volume DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY:$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY \
  hashicorp/terraform:light -c "\
  cd $DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY/terraform && \
  terraform init && \
  terraform apply \
  -auto-approve \
  -var DESKTOP_ENVIRONMENT_CONTAINER=$DESKTOP_ENVIRONMENT_CONTAINER \
  -var DESKTOP_ENVIRONMENT_REGISTRY=$DESKTOP_ENVIRONMENT_REGISTRY \
  -var owner_host=$(hostname) \
  -var owner_name=$(whoami)"
