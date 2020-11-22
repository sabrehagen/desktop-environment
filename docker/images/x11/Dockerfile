ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

# Install x11
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq --fix-missing \
  xinit \
  xorg \
  xsel \
  xserver-xorg

# Install x11 pywal utility
RUN pip3 install --user pywal

# Install x11 warnai utility
RUN apt-get update -qq && \
  apt-get install -qq inkscape optipng xfconf && \
  git clone --depth 1 https://github.com/reorr/warnai /opt/warnai && \
  sed -i '/notify-send/d' /opt/warnai/warnai

# Configure x11
RUN sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
  echo needs_root_rights=yes | sudo tee -a /etc/X11/Xwrapper.config && \
  chmod u+s /usr/bin/xinit && \
  echo sleep infinity > ~/.xinitrc

# Start x11
CMD xinit -- :1 vt04
