ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

# Install x11
RUN sudo apt-get update -qq && \
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq \
  xorg

# Configure x11
RUN sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
  echo needs_root_rights=yes | sudo tee -a /etc/X11/Xwrapper.config && \
  sudo chmod u+s /usr/bin/xinit && \
  echo sleep infinity > ~/.xinitrc

# Start xinit
ENTRYPOINT ["/usr/bin/xinit", "--"]
