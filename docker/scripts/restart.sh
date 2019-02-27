REPO_ROOT=$(dirname $(readlink -f $0))/../..

$REPO_ROOT/docker/scripts/stop.sh
$REPO_ROOT/docker/scripts/start.sh
$REPO_ROOT/docker/scripts/alacritty.sh
