ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

# Install novnc
RUN git clone --depth 1 https://github.com/cloud-computer/noVNC.git /opt/noVNC && \
  git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify

# Start novnc
CMD sudo /opt/noVNC/utils/launch.sh \
  --listen 80 \
  --vnc desktop-environment-tigervncserver:5900
