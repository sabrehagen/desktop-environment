REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Start a desktop environment detached from this shell
nohup alacritty </dev/null >/dev/null 2>&1 &
