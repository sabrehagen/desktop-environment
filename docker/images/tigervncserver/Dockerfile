ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

ARG DESKTOP_ENVIRONMENT_HOST_TTY
ENV DESKTOP_ENVIRONMENT_HOST_TTY $DESKTOP_ENVIRONMENT_HOST_TTY

# Ensure the x server session is blank
RUN mkdir $HOME/.vnc && \
  echo sleep infinity > $HOME/.vnc/xstartup && \
  chmod +x $HOME/.vnc/xstartup

# Start vncserver
ENTRYPOINT vncserver
