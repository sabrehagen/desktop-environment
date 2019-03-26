# run boostrap here
REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

EXISTING_CLUSTER=$(curl https://kubernetes.$DESKTOP_ENVIRONMENT_CLOUDFLARE_DOMAIN)

# check if existing cluster is responding
if [ ! -z "$EXISTING_CLUSTER"]; then
  # join cluster
else
  # bootstrap new cluster
fi
