# Configure tmux to always use utf8 mode and a fixed socket path
export CONTAINER_TMUX_SOCKET=$HOME/.tmux.sock
touch $CONTAINER_TMUX_SOCKET
alias tmux="tmux -u -S $CONTAINER_TMUX_SOCKET"

# Change to the most frequently used directory
STARTUP_DIR=$HOME/repositories/stemn/stemn-backend
if [ -d $STARTUP_DIR ]; then
  cd $STARTUP_DIR
fi
