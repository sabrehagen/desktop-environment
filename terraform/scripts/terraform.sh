REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

# Authenticate with cloud service provider
$REPO_ROOT/credentials/authenticate.sh

# Capture command line arguments
TERRAFORM_ARGS=$@

# Execute the supplied terraform command
docker run \
  --entrypoint ash \
  --env GOOGLE_APPLICATION_CREDENTIALS=$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY/credentials/credentials.json \
  --env TF_CLI_ARGS_apply="-auto-approve -lock=false" \
  --env TF_CLI_ARGS_destroy="-auto-approve -lock=false" \
  --env TF_IN_AUTOMATION=true \
  --env TF_INPUT=0 \
  --env TF_VAR_DESKTOP_ENVIRONMENT_CONTAINER=$DESKTOP_ENVIRONMENT_CONTAINER \
  --env TF_VAR_DESKTOP_ENVIRONMENT_REGISTRY=$DESKTOP_ENVIRONMENT_REGISTRY \
  --rm \
  --tty \
  --volume DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY:$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY \
  --workdir $DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY/terraform \
  hashicorp/terraform:light -c "\
  terraform init;
  terraform $TERRAFORM_ARGS"
