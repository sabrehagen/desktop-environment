ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

ARG DESKTOP_ENVIRONMENT_HOST_TTY
ENV DESKTOP_ENVIRONMENT_HOST_TTY $DESKTOP_ENVIRONMENT_HOST_TTY

# Add the user to the input group
RUN sudo groupadd input && \
  sudo usermod -aG input $USER

# Ensure the x server session is blank
RUN mkdir $HOME/.vnc && \
  echo sleep infinity > $HOME/.vnc/xstartup && \
  chmod +x $HOME/.vnc/xstartup

# Start vncserver
CMD vncserver $DISPLAY \
  -fg \
  -geometry 1920x1080 \
  --I-KNOW-THIS-IS-INSECURE \
  -localhost no \
  -SecurityTypes none \
  -- \
  -noxstartup
