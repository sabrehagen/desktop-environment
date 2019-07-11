REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Ensure the desktop-environment-shell session exists
$REPO_ROOT/docker/scripts/exec.sh tmux new-session -t desktop-environment-shell

# Start a new tmux client attached to the desktop environment shell
$REPO_ROOT/docker/scripts/exec.sh tmux new-session -s desktop-environment-shell-$(date +%s) -t desktop-environment-shell
