ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

# Ensure the x server session is blank
RUN mkdir ~/.vnc && \
  echo sleep infinity > ~/.vnc/xstartup && \
  chmod +x ~/.vnc/xstartup

# Start vncserver
ENTRYPOINT ["/usr/bin/vncserver"]
