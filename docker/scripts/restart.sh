REPO_ROOT=$(dirname $(realpath $0))/../..

$REPO_ROOT/docker/scripts/stop.sh
$REPO_ROOT/docker/scripts/start.sh
$REPO_ROOT/docker/scripts/alacritty.sh
