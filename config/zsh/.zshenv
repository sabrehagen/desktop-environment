# Configure tmux to always use utf8 mode and a fixed socket path
export CONTAINER_TMUX_SOCKET=$HOME/.tmux/tmux.sock
touch $CONTAINER_TMUX_SOCKET
alias tmux="tmux -u -S $CONTAINER_TMUX_SOCKET"

# Change to the most frequently used directory
cd $HOME/repositories/stemn/stemn-backend
