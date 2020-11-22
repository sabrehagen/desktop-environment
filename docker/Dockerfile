FROM ubuntu:19.04

ARG DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD
ARG DESKTOP_ENVIRONMENT_USER
ARG DESKTOP_ENVIRONMENT_GITHUB_USER

ENV DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD ${DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD:-'$6$7De0aW9hUvGDKZmc$qrylcFmwKAL9iGNG9dvQ/GXCM4gLY.hES/P2d/3ZzRxkVMjD77WeTVSxV1P9XtmE9iAUmDwDTCHiVK.p5Ct1y1:18193:0:99999:7:::'}
ENV EDITOR nano
ENV LANG en_US.UTF-8
ENV LANGUAGE $LANG
ENV LC_ALL $LANG
ENV LC_CTYPE $LANG
ENV SHELL /bin/zsh
ENV TERM xterm-256color
ENV USER $DESKTOP_ENVIRONMENT_USER
ENV TZ Australia/Sydney

ENV HOME /home/$USER

# Ensure container image sources are always available by using 'old' repositories
RUN sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

# Restore minimized distribution content e.g. man pages
RUN yes | unminimize

# Install locales and timezone data
RUN apt-get update -qq && \
  apt-get install -qq \
  locales \
  tzdata

# Generate locales
RUN locale-gen $LANG && \
  update-locale LC_ALL=$LC_ALL LANG=$LANG && \
  dpkg-reconfigure --frontend=noninteractive locales

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone

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

# Install tmuxinator
RUN gem install tmuxinator -v 1.1.5

# Install vs code, vs live share dependencies, shfmt extension dependency, and vs-wal
RUN wget -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt-get install -qq ./code.deb && \
  rm code.deb && \
  apt-get install -qq libicu[0-9][0-9] libkrb5-3 zlib1g libsecret-1-0 desktop-file-utils x11-utils && \
  wget -O /usr/local/bin/shfmt -nv https://github.com/mvdan/sh/releases/download/v3.2.0/shfmt_v3.2.0_linux_amd64 && \
  chmod +x /usr/local/bin/shfmt

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

# Configure password-less sudo for the sudo group
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# Configure X11 permissions
RUN sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
  echo needs_root_rights=yes >> /etc/X11/Xwrapper.config && \
  chmod u+s /usr/bin/xinit

# Create a non-root user for safe operation
RUN useradd \
  --create-home \
  --groups audio,chrome,docker,input,netdev,shadow,sudo,tty,video \
  --shell /bin/zsh \
  $USER

# Set non-root user password
RUN sed -i "s;^$USER:[^:]*;$USER:$DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD;" /etc/shadow

# Take ownership of user's home directory and applications
RUN chown -R $USER:$USER $HOME /opt

# Become desktop environment user
USER $USER
WORKDIR $HOME

# If the DOTFILES_CACHEBUST build arg is supplied, rebuild from static dotfiles onwards
ARG DOTFILES_CACHEBUST
RUN DOTFILES_CACHEBUST=$DOTFILES_CACHEBUST echo "Building from dotfiles..."

# Clone user dotfiles or fallback to sabrehagen dotfiles
RUN vcsh clone git://github.com/$DESKTOP_ENVIRONMENT_GITHUB_USER/dotfiles.git || \
  vcsh clone https://github.com/sabrehagen/dotfiles.git

# Bootstrap dotfiles
RUN $HOME/.dotfiles-bootstrap.sh

# Record container build information
ARG DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_GIT_SHA $DESKTOP_CONTAINER_GIT_SHA
ARG DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME
ENV DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME $DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME
