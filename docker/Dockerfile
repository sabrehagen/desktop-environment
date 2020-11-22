# Install desktop environment utilities
RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing \
  alsa-utils \
  apt-file \
  apt-utils \
  arandr \
  asciinema \
  autorandr \
  build-essential \
  cmake \
  curl \
  dnsutils \
  dnsmasq \
  docker.io \
  feh \
  figlet \
  fonts-font-awesome \
  g++ \
  gcc \
  git \
  gtk-theme-switch \
  gtk+3.0 \
  htop \
  httpie \
  iftop \
  iputils-ping \
  irssi \
  jq \
  keychain \
  libnotify-bin \
  libnss3-tools \
  libterm-readkey-perl \
  lsb-core \
  maim \
  make \
  man-db \
  mpd \
  nano \
  ncdu \
  ncmpcpp \
  neovim \
  net-tools \
  netcat-openbsd \
  numlockx \
  openssl \
  openvpn \
  pavucontrol-qt \
  pcmanfm \
  perl \
  pulseaudio \
  python \
  python-pip \
  python3 \
  python3-pip \
  ranger \
  ruby \
  rofi \
  software-properties-common \
  ssh \
  sudo \
  sxhkd \
  tigervnc-scraping-server \
  tigervnc-standalone-server \
  tmux \
  transmission-cli \
  transmission-common \
  transmission-daemon \
  tree \
  vcsh \
  vim \
  wmctrl \
  xauth \
  xautolock \
  xdotool \
  xinit \
  xinput \
  xclip \
  xorg \
  xsel \
  xserver-xorg \
  zsh \
  zathura && \
  apt-file update

# Install alacritty
RUN apt-get update -qq && \
  apt-get install -qq \
  pkg-config \
  libfreetype6-dev \
  libfontconfig1-dev \
  libxcb-xfixes0-dev && \
  curl https://sh.rustup.rs -sSf | sh -s -- -y && \
  export PATH=$PATH:$HOME/.cargo/bin && \
  rustup override set stable && \
  rustup update stable && \
  cargo install --git https://github.com/alacritty/alacritty --tag v0.5.0

# Install arc
RUN wget -O /usr/local/bin/arc -q https://github.com/mholt/archiver/releases/download/v3.5.0/arc_3.5.0_linux_amd64 && \
  chmod +x /usr/local/bin/arc

# Install bandwhich
RUN curl -fsSL https://github.com/imsnif/bandwhich/releases/download/0.20.0/bandwhich-v0.20.0-x86_64-unknown-linux-musl.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install bat
RUN wget -O bat.deb -q https://github.com/sharkdp/bat/releases/download/v0.16.0/bat_0.16.0_amd64.deb && \
  dpkg -i bat.deb && \
  rm bat.deb

# Install chrome
RUN apt-get update -qq && \
  apt-get install -qq \
  apt-transport-https \
  ca-certificates \
  gnupg \
  hicolor-icon-theme \
  libcanberra-gtk* \
  libgl1-mesa-dri \
  libgl1-mesa-glx \
  libpango1.0-0 \
  libpulse0 \
  libv4l-0 \
  fonts-symbola \
  --no-install-recommends && \
  curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update -qq && \
  apt-get install -qq google-chrome-stable --no-install-recommends && \
  rm /etc/apt/sources.list.d/google.list && \
  wget -O /etc/fonts/local.conf -nv https://raw.githubusercontent.com/jessfraz/dockerfiles/master/chrome/stable/local.conf && \
  groupadd --system chrome

# Install cloudstorage
RUN apt-get install -qq \
  autoconf \
  fuse3 \
  libcurl4-openssl-dev \
  libfuse3-dev \
  libjsoncpp-dev \
  libmicrohttpd-dev \
  libtinyxml2-dev \
  libtool \
  pkg-config && \
  git clone --depth 1 https://github.com/cloud-computer/libcloudstorage && \
  cd libcloudstorage && \
  ./bootstrap && \
  ./configure --with-curl --with-microhttpd --with-fuse && \
  make -j$(nproc) && \
  make install && \
  echo user_allow_other >> /etc/fuse.conf && \
  mkdir -p $HOME/.config/cloudstorage && \
  mkdir $HOME/cloudstorage

# Install cmatrix
RUN apt-get install -qq libncurses5-dev && \
  git clone --depth 1 https://github.com/abishekvashok/cmatrix && \
  mkdir -p cmatrix/build && \
  cd cmatrix/build && \
  cmake .. && \
  make && \
  make install

# Install cool retro term
RUN add-apt-repository ppa:vantuz/cool-retro-term && \
  apt-get update -qq && \
  apt-get install -qq cool-retro-term

# Install ctop
RUN wget -O /usr/local/bin/ctop https://github.com/bcicen/ctop/releases/download/v0.7.5/ctop-0.7.5-linux-amd64 && \
  chmod +x /usr/local/bin/ctop

# Install define
RUN wget -O /usr/local/bin/define -q https://github.com/Rican7/define/releases/download/v0.1.2/define_linux_amd64 && \
  chmod +x /usr/local/bin/define

# Install discord
RUN wget -q -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb" && \
  dpkg -i discord.deb || apt-get install -qq --fix-broken && \
  rm discord.deb

# Install dive docker image explorer
RUN wget -q -O dive.deb https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb && \
  dpkg -i dive.deb && \
  rm dive.deb

# Install docker-compose
RUN curl -fsSL "https://github.com/docker/compose/releases/download/1.25.0-rc1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf && \
  $HOME/.fzf/install --bin

# Install gist
RUN gem install gist

# Install go
RUN add-apt-repository ppa:longsleep/golang-backports && \
  apt-get update -qq && \
  apt-get install -qq golang-go

# Install gotop
RUN wget -q -O gotop-deb https://github.com/cjbassi/gotop/releases/download/3.0.0/gotop_3.0.0_linux_amd64.deb && \
  dpkg -i gotop-deb

# Install gotty
RUN curl -fsSL https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install i3
RUN add-apt-repository ppa:kgilmer/speed-ricer && \
  apt-get update -qq && \
  apt-get install -qq i3blocks i3-gaps i3lock-fancy && \
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

# Install jobber
RUN wget -O jobber.deb -q https://github.com/dshearer/jobber/releases/download/v1.4.4/jobber_1.4.4-1_amd64.deb && \
  dpkg -i jobber.deb || apt-get install -qq --fix-broken && \
  rm jobber.deb

# Install jump directory navigator
RUN wget -q -O jump.deb https://github.com/gsamokovarov/jump/releases/download/v0.30.1/jump_0.30.1_amd64.deb && \
  dpkg -i jump.deb && \
  rm jump.deb

# Install musikcube
RUN wget -O musikcube.deb -nv https://github.com/clangen/musikcube/releases/download/0.95.0/musikcube_0.95.0_ubuntu_eoan_amd64.deb && \
  dpkg -i musikcube.deb || apt-get install -qq --fix-broken && \
  rm musikcube.deb

# Install nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_12.x | bash -

# Install novnc
RUN git clone --depth 1 https://github.com/cloud-computer/noVNC.git /opt/noVNC && \
  git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify

# Install picom
RUN apt-get install -qq \
  libconfig-dev \
  libdbus-1-dev \
  libev-dev \
  libevdev-dev \
  libgl1-mesa-dev \
  libpcre2-dev \
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
  meson --buildtype=release . build && \
  ninja -C build && \
  ninja -C build install

# Install pulseaudio mixer
RUN wget -O /usr/local/bin/pulsemixer -nv https://raw.githubusercontent.com/GeorgeFilipkin/pulsemixer/master/pulsemixer && \
  chmod +x /usr/local/bin/pulsemixer

# Install pywal
RUN pip3 install --user pywal

# Install resucetime time tracker
RUN wget -O rescuetime.deb -nv https://www.rescuetime.com/installers/rescuetime_current_amd64.deb && \
  dpkg -i rescuetime.deb || apt-get install -qq --fix-broken && \
  rm rescuetime.deb

# Install skype
RUN wget -O skype.deb -q https://go.skype.com/skypeforlinux-64.deb && \
  dpkg -i skype.deb && \
  rm skype.deb

# Install slack
RUN wget -O slack.deb -nv https://downloads.slack-edge.com/linux_releases/slack-desktop-4.9.1-amd64.deb && \
  dpkg -i slack.deb || apt-get install -qq --fix-broken && \
  rm slack.deb

# Install speedtest
RUN pip install --user speedtest-cli

# Install timeago
RUN wget -O /usr/local/bin/timeago -nv https://raw.githubusercontent.com/sabrehagen/timeago/master/timeago && \
  chmod +x /usr/local/bin/timeago

# Install tormix
RUN wget -O /usr/local/bin/tormix -nv https://raw.githubusercontent.com/ckardaris/tormix/master/tormix && \
  chmod +x /usr/local/bin/tormix

# Install warnai
RUN apt-get update -qq && \
  apt-get install -qq inkscape optipng xfconf && \
  git clone --depth 1 https://github.com/reorr/warnai /opt/warnai && \
  sed -i '/notify-send/d' /opt/warnai/warnai

# Install xava
RUN apt-get update -qq && \
  apt-get install -qq \
  libfftw3-dev \
  libasound2-dev \
  libpulse-dev \
  libx11-dev \
  libsdl2-dev && \
  git clone --depth 1 https://github.com/sabrehagen/xava && \
  git clone --depth 1 https://github.com/ndevilla/iniparser xava/lib/iniparser && \
  mkdir xava/build && \
  cd xava/build && \
  cmake .. -DCMAKE_BUILD_TYPE=Debug -DINCLUDE_DIRS=lib/iniparser/src && \
  make -j$(nproc) && \
  make install

# Install yarn
RUN curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && \
  apt-get install -qq yarn

# Install yarn based utilities
RUN yarn global add \
  clipboard-cli \
  github-email \
  http-server \
  imgur-uploader-cli \
  localtunnel \
  nodemon \
  rebase-editor \
  tldr && \
  tldr --update

# Configure openvpn
RUN mkdir -p $HOME/.config/openvpn && \
  mknod $HOME/.config/openvpn/tun c 10 200 && \
  chmod 600 $HOME/.config/openvpn/tun
