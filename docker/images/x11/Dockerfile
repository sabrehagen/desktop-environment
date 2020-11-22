ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

# Install X11
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq --fix-missing \
  xinit \
  xorg \
  xsel \
  xserver-xorg

# Configure X11
RUN sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
  echo needs_root_rights=yes | sudo tee -a /etc/X11/Xwrapper.config && \
  chmod u+s /usr/bin/xinit && \
  echo sleep infinity > ~/.xinitrc

# Start X11
CMD xinit -- $DISPLAY vt03
