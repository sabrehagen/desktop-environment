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
  --env GOOGLE_APPLICATION_CREDENTIALS=$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY/credentials/google.json \
  --env TF_CLI_ARGS_apply="-auto-approve -lock=false" \
  --env TF_CLI_ARGS_destroy="-auto-approve -lock=false" \
  --env TF_IN_AUTOMATION=true \
  --env TF_INPUT=false \
  --env TF_VAR_DESKTOP_ENVIRONMENT_CONTAINER_NAME=$DESKTOP_ENVIRONMENT_CONTAINER_NAME \
  --env TF_VAR_DESKTOP_ENVIRONMENT_REGISTRY=$DESKTOP_ENVIRONMENT_REGISTRY \
  --env TF_VAR_DESKTOP_ENVIRONMENT_CLOUDFLARE_DOMAIN=$DESKTOP_ENVIRONMENT_CLOUDFLARE_DOMAIN \
  --env TF_VAR_DESKTOP_ENVIRONMENT_CLOUDFLARE_EMAIL=$DESKTOP_ENVIRONMENT_CLOUDFLARE_EMAIL \
  --env TF_VAR_DESKTOP_ENVIRONMENT_CLOUDFLARE_TOKEN=$DESKTOP_ENVIRONMENT_CLOUDFLARE_TOKEN \
  --env TF_VAR_owner_host=$HOSTNAME \
  --env TF_VAR_owner_name=$USER \
  --rm \
  --tty \
  --volume DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY:$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY \
  --workdir $DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY/terraform \
  hashicorp/terraform:light -c "\
  terraform init;
  terraform $TERRAFORM_ARGS"
