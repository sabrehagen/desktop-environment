FROM sabrehagen/desktop-environment-base:latest

# Install i3
RUN sudo apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive sudo apt-get install -y --fix-missing \
  software-properties-common \
  wget && \
  add-apt-repository ppa:kgilmer/speed-ricer && \
  sudo apt-get update -qq && \
  sudo apt-get install -qq i3blocks i3-gaps i3lock-fancy && \
  sed -i 's/TEXT=".*"/TEXT=""/' /usr/bin/i3lock-fancy && \
  sed -i 's/rm -f "$IMAGE"//' /usr/bin/i3lock-fancy && \
  sed -ie '79i~/.config/scripts/screensaver.sh' /usr/bin/i3lock-fancy && \
  wget -q -O /usr/share/i3lock-fancy/lock.png http://png-pixel.com/1x1-00000000.png && \
  pip3 install --user i3-resurrect==1.4.2 && \
  pip3 install --user autotiling && \
  pip3 install --force --user i3-workspace-names-daemon && \
  git clone https://github.com/s-urbaniak/i3-focus-last ~/.config/i3/i3-focus-last && \
  cd ~/.config/i3/i3-focus-last && \
  go install
