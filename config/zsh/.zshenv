# Print container build info
CURRENT_DATE=$(date +%s)
TIME_SINCE_CONTAINER_BUILD=$(echo $((CURRENT_DATE-CONTAINER_BUILD_DATE)) | awk '{print int($1/60)":"int($1%60)}')
echo "Container built: $CONTAINER_BUILD_DATE ($TIME_SINCE_CONTAINER_BUILD ago) | sha $CONTAINER_GIT_SHA"

# Change to most used directory
cd $HOME/repositories/stemn/stemn-backend

# Always connect to the desktop-environment session
export $STEMN_TMUX_SESSION=desktop-environment

# Start the desktop-environment session if it isn't already started
tmux new-session -d -s $STEMN_TMUX_SESSION tmuxinator desktop
