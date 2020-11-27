ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

ARG DESKTOP_ENVIRONMENT_HOST_TTY
ENV DESKTOP_ENVIRONMENT_HOST_TTY $DESKTOP_ENVIRONMENT_HOST_TTY

# Install novnc
RUN git clone --depth 1 https://github.com/cloud-computer/noVNC.git /opt/noVNC && \
  git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify

# Start novnc
CMD /opt/noVNC/utils/launch.sh \
  --listen 8080 \
  --vnc desktop-environment-vncserver:5900
