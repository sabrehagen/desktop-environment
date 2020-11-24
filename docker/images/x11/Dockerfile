ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

ARG DESKTOP_ENVIRONMENT_HOST_TTY
ENV DESKTOP_ENVIRONMENT_HOST_TTY $DESKTOP_ENVIRONMENT_HOST_TTY

# Install x11
RUN sudo apt-get update -qq && \
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing \
  xinit \
  xorg \
  xsel \
  xserver-xorg

# Install x11 pywal utility
RUN pip3 install --user pywal

# Install x11 warnai utility
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq \
  inkscape \
  optipng \
  xfconf && \
  git clone --depth 1 https://github.com/reorr/warnai /opt/warnai && \
  sed -i '/notify-send/d' /opt/warnai/warnai

# Configure x11
RUN sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
  echo needs_root_rights=yes | sudo tee -a /etc/X11/Xwrapper.config && \
  sudo chmod u+s /usr/bin/xinit && \
  echo sleep infinity > ~/.xinitrc

# Start x11
CMD xinit -- $DISPLAY vt0$DESKTOP_ENVIRONMENT_HOST_TTY
