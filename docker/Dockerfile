FROM ubuntu:20.04

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
  acpi \
  alsa-utils \
  apt-file \
  apt-utils \
  arandr \
  asciinema \
  autorandr \
  build-essential \
  cmake \
  curl \
  dnsmasq \
  dnsutils \
  docker.io \
  feh \
  ffmpeg \
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
  mpv \
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
  python3 \
  python3-pip \
  python3-venv \
  ranger \
  rofi \
  ruby \
  software-properties-common \
  ssh \
  sshpass \
  strace \
  stress \
  sudo \
  tigervnc-scraping-server \
  tigervnc-standalone-server \
  tmux \
  transmission-cli \
  transmission-common \
  transmission-daemon \
  tree \
  vcsh \
  vim \
  wdiff \
  wmctrl \
  xauth \
  xautolock \
  xclip \
  xdotool \
  xinit \
  xinput \
  xorg \
  xsel \
  xserver-xorg \
  xterm \
  zathura \
  zsh && \
  apt-file update

# Install alacritty
RUN apt-get update -qq && \
  apt-get install -qq \
  pkg-config \
  libfreetype6-dev \
  libfontconfig1-dev \
  libxcb-xfixes0-dev \
  libxkbcommon-dev && \
  curl https://sh.rustup.rs -sSf | sh -s -- -y && \
  export PATH=$PATH:$HOME/.cargo/bin && \
  rustup override set stable && \
  rustup update stable && \
  cargo install --git https://github.com/alacritty/alacritty --tag v0.8.0

# Install arc
RUN wget -O /usr/local/bin/arc -q https://github.com/mholt/archiver/releases/download/v3.5.0/arc_3.5.0_linux_amd64 && \
  chmod +x /usr/local/bin/arc

# Install aws cli
RUN pip3 install --user awscli

# Install bandwhich
RUN curl -fsSL https://github.com/imsnif/bandwhich/releases/download/0.20.0/bandwhich-v0.20.0-x86_64-unknown-linux-musl.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install bat
RUN wget -O bat.deb -q https://github.com/sharkdp/bat/releases/download/v0.16.0/bat_0.16.0_amd64.deb && \
  dpkg -i bat.deb && \
  rm bat.deb

# Install beekeeper studio
RUN wget -O beekeeper-studio.deb -q https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v3.7.10/beekeeper-studio_3.7.10_amd64.deb && \
  dpkg -i beekeeper-studio.deb && \
  rm beekeeper-studio.deb

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

# Install cmatrix
RUN apt-get install -qq libncurses5-dev && \
  git clone --depth 1 https://github.com/abishekvashok/cmatrix && \
  mkdir -p cmatrix/build && \
  cd cmatrix/build && \
  cmake .. && \
  make install && \
  rm -rf ../../cmatrix

# Install discord
RUN wget -O discord.deb -qnv 'https://discordapp.com/api/download?platform=linux&format=deb' && \
  dpkg -i discord.deb || apt-get install -qq --fix-broken && \
  rm discord.deb

# Install dive docker image explorer
RUN wget -q -O dive.deb https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb && \
  dpkg -i dive.deb && \
  rm dive.deb

# Install docker-compose
RUN curl -fsSL "https://github.com/docker/compose/releases/download/1.25.0-rc1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

# Install dunst
RUN apt-get update -qq && \
  apt-get install -qq libnotify-dev libxss-dev && \
  git clone https://github.com/sabrehagen/dunst /opt/dunst && \
  cd /opt/dunst && \
  make all && \
  make install

# Install flux
RUN curl -s https://fluxcd.io/install.sh | bash

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf && \
  $HOME/.fzf/install --bin

# Install github cli
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0 && \
  apt-add-repository https://cli.github.com/packages && \
  apt-get update -qq && \
  apt-get install -qq gh

# Install gist
RUN gem install gist

# Install glow
RUN wget -q -O glow.deb https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_amd64.deb && \
  dpkg -i glow.deb && \
  rm glow.deb

# Install go
RUN add-apt-repository ppa:longsleep/golang-backports && \
  apt-get update -qq && \
  apt-get install -qq golang-go

# Install gotop
RUN wget -q -O gotop.deb https://github.com/cjbassi/gotop/releases/download/3.0.0/gotop_3.0.0_linux_amd64.deb && \
  dpkg -i gotop.deb && \
  rm gotop.deb

# Install gotty
RUN curl -fsSL https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install i3
RUN add-apt-repository ppa:kgilmer/speed-ricer && \
  apt-get update -qq && \
  apt-get install -qq i3-gaps dunst-

# Install i3blocks
RUN git clone https://github.com/vivien/i3blocks /opt/i3blocks --depth 1 && \
  cd /opt/i3blocks && \
  ./autogen.sh && \
  ./configure && \
  make install

# Install i3lock
RUN apt-get update -qq && \
  apt-get install -qq \
  libev-dev \
  libpam0g-dev \
  libxcb-dpms0-dev \
  libxcb-image0-dev \
  libxcb-xinerama0-dev \
  libxcb-xkb-dev \
  libxcb-xrm-dev \
  libxkbcommon-x11-dev && \
  git clone --depth 1 https://github.com/meskarune/i3lock-color /opt/i3lock && \
  cd /opt/i3lock && \
  sed -i 's/Num Lock//' i3lock.c && \
  sed -i 's/wrong!/auth failed/' unlock_indicator.c && \
  make install

# Install i3 extras
RUN pip3 install --user i3-resurrect==1.4.2 && \
  pip3 install --user i3altlayout && \
  pip3 install --force --user i3-workspace-names-daemon && \
  git clone https://github.com/s-urbaniak/i3-focus-last ~/.config/i3/i3-focus-last && \
  cd ~/.config/i3/i3-focus-last && \
  go install && \
  apt-get update -qq && \
  apt-get install -qq gsimplecal

# Install jobber
RUN wget -O jobber.deb -q https://github.com/dshearer/jobber/releases/download/v1.4.4/jobber_1.4.4-1_amd64.deb && \
  dpkg -i jobber.deb || apt-get install -qq --fix-broken && \
  rm jobber.deb

# Install jump directory navigator
RUN wget -q -O jump.deb https://github.com/gsamokovarov/jump/releases/download/v0.30.1/jump_0.30.1_amd64.deb && \
  dpkg -i jump.deb && \
  rm jump.deb

# Install kubectl
RUN curl -fsSL "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && \
  chmod +x /usr/local/bin/kubectl

# Install kubectx
RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx && \
  ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx && \
  ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# Install musikcube
RUN wget -O musikcube.deb -nv https://github.com/clangen/musikcube/releases/download/0.95.0/musikcube_0.95.0_ubuntu_eoan_amd64.deb && \
  dpkg -i musikcube.deb || apt-get install -qq --fix-broken && \
  rm musikcube.deb

# Install nmail
RUN apt-get update -qq && \
  apt-get install -qq \
  libetpan-dev \
  libssl-dev \
  libncurses-dev \
  libxapian-dev \
  libsqlite3-dev \
  libsasl2-modules && \
  git clone --depth 1 https://github.com/d99kris/nmail /opt/nmail && \
  cd /opt/nmail && \
  ./make.sh all

# Install nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -

# Install novnc
RUN git clone --depth 1 https://github.com/cloud-computer/noVNC.git /opt/noVNC && \
  git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify

# Install picom
RUN apt-get update -qq && \
  apt-get install -qq \
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

# Install qutebrowser
RUN apt-get update -qq && \
  apt-get install -qq asciidoc libnotify-dev libxss-dev && \
  git clone --depth 1 https://github.com/qutebrowser/qutebrowser /opt/qutebrowser && \
  cd /opt/qutebrowser && \
  python3 scripts/mkvenv.py --skip-smoke-test && \
  echo '/opt/qutebrowser/.venv/bin/python3 -m qutebrowser "$@"' > /usr/local/bin/qutebrowser

# Install resucetime time tracker
RUN wget -O rescuetime.deb -nv https://www.rescuetime.com/installers/rescuetime_current_amd64.deb && \
  dpkg -i rescuetime.deb || apt-get install -qq --fix-broken && \
  rm rescuetime.deb

# Install rofi
RUN git clone --depth 1 --recursive https://github.com/DaveDavenport/rofi /opt/rofi && cd /opt/rofi && \
  git pull && \
  git submodule update --init && \
  apt-get install -qq bison flex libstartup-notification0-dev libxcb-cursor-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-util-dev libxcb-xkb-dev libxkbcommon-x11-dev && \
  autoreconf -i && \
  mkdir build && cd build && \
  ../configure --disable-check --prefix=/usr/local && \
  make install

# Install speedtest
RUN pip3 install --user speedtest-cli

# install taskwarrior
RUN apt-get update -qq && \
  apt-get install -qq taskwarrior

# Install taskwarrior-tui
RUN wget -O taskwarrior.deb -q https://github.com/kdheepak/taskwarrior-tui/releases/download/v0.9.5/taskwarrior-tui.deb && \
  dpkg -i taskwarrior.deb && \
  rm taskwarrior.deb

# Install telegram
RUN curl -fsSL https://telegram.org/dl/desktop/linux | \
  tar -C /opt -xJf -

# Install terraform
RUN wget -O terraform.zip -q https://releases.hashicorp.com/terraform/1.0.3/terraform_1.0.3_linux_amd64.zip && \
  unzip terraform.zip -d terraform && \
  mv terraform/terraform /usr/local/bin && \
  rm -rf terraform terraform.zip

# Install exa
RUN wget -O exa.zip -q https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip && \
  unzip exa.zip -d exa && \
  mv exa/bin/exa /usr/local/bin && \
  rm -rf exa exa.zip

# Install timeago
RUN wget -O /usr/local/bin/timeago -nv https://raw.githubusercontent.com/sabrehagen/timeago/master/timeago && \
  chmod +x /usr/local/bin/timeago

# Install tmux
RUN apt-get update -qq && \
  apt-get install -qq libevent-dev && \
  curl -fsSL https://github.com/tmux/tmux/releases/download/3.2a/tmux-3.2a.tar.gz | \
  tar -C /opt -xzf - && \
  cd /opt/tmux-* && \
  ./configure && \
  make install

# Install tldr
RUN pip3 install --user tldr

# Install tmuxinator
RUN gem install tmuxinator -v 1.1.5

# Install tormix
RUN wget -O /usr/local/bin/tormix -nv https://raw.githubusercontent.com/ckardaris/tormix/master/tormix && \
  chmod +x /usr/local/bin/tormix

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

# Install werf
RUN curl -L https://raw.githubusercontent.com/werf/multiwerf/master/get.sh | bash && \
  mv multiwerf /usr/local/bin && \
  sh $(multiwerf use 1.2 ea --as-file)

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
  make install && \
  rm -rf ../../xava

# Install yarn
RUN curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && \
  apt-get install -qq yarn

# Install yarn based utilities
RUN yarn global add \
  clipboard-cli \
  diff-so-fancy \
  github-email \
  http-server \
  imgur-uploader-cli \
  localtunnel \
  nativefier \
  nodemon \
  rebase-editor

# Configure openvpn
RUN mkdir -p $HOME/.config/openvpn && \
  mknod $HOME/.config/openvpn/tun c 10 200 && \
  chmod 600 $HOME/.config/openvpn/tun

# Configure password-less sudo for the sudo group
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# Configure X11 permissions and touchpad tap to click
RUN sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
  echo needs_root_rights=yes >> /etc/X11/Xwrapper.config && \
  chmod u+s /usr/bin/xinit && \
  mkdir -p /etc/X11/xorg.conf.d && \
  echo 'Section "InputClass"\n Identifier "touchpad"\n MatchIsTouchpad "on"\n Driver "libinput"\n Option "Tapping" "on"\nEndSection' > /etc/X11/xorg.conf.d/90-touchpad.conf

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
RUN vcsh clone https://github.com/sabrehagen/dotfiles

# Bootstrap dotfiles
RUN $HOME/.dotfiles-bootstrap.sh

# Record container build information
ARG DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_GIT_SHA $DESKTOP_CONTAINER_GIT_SHA
ARG DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME
ENV DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME $DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME
