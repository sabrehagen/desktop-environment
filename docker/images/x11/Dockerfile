FROM sabrehagen/desktop-environment-base:latest

# Install X11
RUN sudo apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive sudo apt-get install -qq --fix-missing \
  xinit \
  xorg \
  xsel \
  xserver-xorg && \
  sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
  echo needs_root_rights=yes >> /etc/X11/Xwrapper.config && \
  chmod u+s /usr/bin/xinit
