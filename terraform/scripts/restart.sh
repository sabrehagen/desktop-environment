REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Authenticate with cloud service provider
$REPO_ROOT/terraform/scripts/stop.sh
$REPO_ROOT/terraform/scripts/start.sh
