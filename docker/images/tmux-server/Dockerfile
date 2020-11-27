ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

# Start tmux server and wait until exit
ENTRYPOINT ["zsh", "-c", "~/.config/scripts/startup.sh; tail --follow --pid=$(pgrep tmux)"]
