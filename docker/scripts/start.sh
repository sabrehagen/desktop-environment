REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Start the desktop environment container
$REPO_ROOT/docker/scripts/run.sh tmux

# Wait until the desktop environment container is running before proceeding
until docker inspect $(docker ps | grep desktop-environment | grep tmux | cut -f1 -d' ') | grep Status | grep -m 1 running >/dev/null; do sleep 1; done

# Start the desktop environment inside the container
$REPO_ROOT/docker/scripts/exec.sh /home/$DESKTOP_ENVIRONMENT_USER/.config/scripts/startup.sh
