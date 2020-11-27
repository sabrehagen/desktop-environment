ARG DESKTOP_ENVIRONMENT_BASE
FROM sabrehagen/desktop-environment-base:latest

# Install i3
RUN sudo add-apt-repository ppa:kgilmer/speed-ricer && \
  sudo apt-get update -qq && \
  sudo apt-get install -qq \
  i3blocks \
  i3-gaps \
  i3lock-fancy && \
  sudo sed -i 's/TEXT=".*"/TEXT=""/' /usr/bin/i3lock-fancy && \
  sudo sed -i 's/rm -f "$IMAGE"//' /usr/bin/i3lock-fancy && \
  sudo sed -ie '79i~/.config/scripts/screensaver.sh' /usr/bin/i3lock-fancy && \
  sudo wget -q -O /usr/share/i3lock-fancy/lock.png http://png-pixel.com/1x1-00000000.png

# Install i3 utilities
RUN sudo apt-get install -qq \
  feh \
  golang-go \
  pango1.0-tools \
  xautolock && \
  pip3 install --user i3-resurrect==1.4.2 && \
  pip3 install --user autotiling && \
  pip3 install --force --user i3-workspace-names-daemon && \
  git clone https://github.com/s-urbaniak/i3-focus-last ~/.config/i3/i3-focus-last && \
  cd ~/.config/i3/i3-focus-last && \
  go install

# Install picom
RUN sudo apt-get install -qq \
  libconfig-dev \
  libdbus-1-dev \
  libev-dev \
  libevdev-dev \
  libgl1-mesa-dev \
  libpcre3-dev \
  libpixman-1-dev \
  libx11-xcb-dev \
  libxcb-composite0-dev \
  libxcb-damage0-dev \
  libxcb-glx0-dev \
  libxcb-image0-dev \
  libxcb-present-dev \
  libxcb-randr0-dev \
  libxcb-render-util0-dev \
  libxcb-render0-dev \
  libxcb-shape0-dev \
  libxcb-xfixes0-dev \
  libxcb-xinerama0-dev \
  libxcb1-dev \
  libxext-dev \
  meson \
  uthash-dev && \
  git clone --depth 1 https://github.com/yshui/picom /opt/picom && cd /opt/picom \
  git submodule update --init --recursive && \
  sudo meson --buildtype=release . build && \
  sudo ninja -C build && \
  sudo ninja -C build install

# Install warnai utility
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq \
  inkscape \
  optipng \
  python2 \
  xfconf && \
  git clone --depth 1 https://github.com/reorr/warnai /opt/warnai && \
  sed -i '/notify-send/d' /opt/warnai/warnai

# Generate wal cache
RUN echo sleep infinity >> /tmp/xstartup && \
  chmod +x /tmp/xstartup && \
  export DISPLAY=:2 && \
  vncserver $DISPLAY \
  -autokill \
  -SecurityTypes none \
  -xstartup /tmp/xstartup && \
  ~/.config/scripts/wal.sh && \
  kill -HUP $(pgrep Xtigervnc)

# Start i3
ENTRYPOINT ["zsh", "-c", "/usr/bin/i3"]
