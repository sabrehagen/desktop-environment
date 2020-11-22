REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

$REPO_ROOT/docker/scripts/run.sh tmux
$REPO_ROOT/docker/scripts/run.sh x11
$REPO_ROOT/docker/scripts/run.sh i3
