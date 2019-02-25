REPO_ROOT=$(dirname $(realpath $0))/../..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

docker run \
  --interactive \
  --rm \
  --tty \
  --volume $PWD:$PWD \
  --workdir $PWD \
  hashicorp/terraform:light apply \
  -auto-approve \
  -var owner_host=$(hostname) \
  -var owner_name=$(whoami) \
  -lock=false
