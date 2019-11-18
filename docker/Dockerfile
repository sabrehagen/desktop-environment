FROM ubuntu:19.04

ARG DESKTOP_ENVIRONMENT_USER

ENV USER $DESKTOP_ENVIRONMENT_USER
ENV DISPLAY :1
ENV EDITOR nano
ENV HOME /home/$USER
ENV LANG en_US.UTF-8
ENV LANGUAGE $LANG
ENV LC_ALL $LANG
ENV LC_CTYPE $LANG
ENV SHELL /bin/zsh
ENV TERM xterm-256color
ENV TZ Australia/Sydney

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

# Install cloud computer utilities
RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing \
  alsa-utils \
  apt-utils \
  arandr \
  asciinema \
  autorandr \
  build-essential \
  cmake \
  cmatrix \
  compton \
  curl \
  dnsutils \
  dnsmasq \
  docker.io \
  evince \
  feh \
  figlet \
  fonts-font-awesome \
  g++ \
  gcc \
  git \
  gtk+3.0 \
  gosu \
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
  pcmanfm \
  perl \
  python \
  python-pip \
  python3 \
  python3-pip \
  ranger \
  ruby \
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
  zsh

# Install antigen
RUN curl -fsSL git.io/antigen > /usr/local/bin/antigen.zsh

# Install arc
RUN wget -O /usr/local/bin/arc -qnv https://github.com/mholt/archiver/releases/download/v3.1.1/arc_linux_amd64 && \
  chmod +x /usr/local/bin/arc

# Install bat
RUN wget -O bat.deb -qnv https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb && \
  dpkg -i bat.deb && \
  rm bat.deb

# Install alacritty
RUN wget -O alacritty.deb -nv https://github.com/jwilm/alacritty/releases/download/v0.3.3/Alacritty-v0.3.3-ubuntu_18_04_amd64.deb && \
  dpkg -i alacritty.deb && \
  rm alacritty.deb

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
  curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
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

# Install cool retro term
RUN add-apt-repository ppa:vantuz/cool-retro-term && \
  apt-get update -qq && \
  apt-get install -qq cool-retro-term

# Install ctop
RUN wget https://github.com/bcicen/ctop/releases/download/v0.7.2/ctop-0.7.2-linux-amd64 -O /usr/local/bin/ctop && \
  chmod +x /usr/local/bin/ctop

# Install define
RUN wget -O /usr/local/bin/define -qnv https://github.com/Rican7/define/releases/download/v0.1.2/define_linux_amd64 && \
  chmod +x /usr/local/bin/define

# Install desktop environment
RUN git clone --depth 1 https://github.com/sabrehagen/desktop-environment.git /opt/desktop-environment

# Install dive docker image explorer
RUN wget -qnv -O dive.deb https://github.com/wagoodman/dive/releases/download/v0.7.2/dive_0.7.2_linux_amd64.deb && \
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
RUN wget -qnv -O gotop-deb https://github.com/cjbassi/gotop/releases/download/3.0.0/gotop_3.0.0_linux_amd64.deb && \
  dpkg -i gotop-deb

# Install gotty
RUN curl -fsSL https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install gotty-client
RUN go get github.com/moul/gotty-client/cmd/gotty-client

# Install i3
RUN add-apt-repository ppa:kgilmer/speed-ricer && \
  apt-get update -qq && \
  apt-get install -qq i3blocks i3-gaps i3lock-fancy && \
  sed -i 's/TEXT=".*"/TEXT=""/' /usr/bin/i3lock-fancy && \
  wget -qnv -O /usr/share/i3lock-fancy/lock.png http://png-pixel.com/1x1-00000000.png && \
  pip3 install --user i3-resurrect==1.3.2 && \
  pip3 install --force --user i3-workspace-names-daemon

# Install jobber
RUN wget -O jobber.deb -qnv https://github.com/dshearer/jobber/releases/download/v1.4.0/jobber_1.4.0-1_amd64.deb && \
  dpkg -i jobber.deb || apt-get install -qq --fix-broken && \
  rm jobber.deb

# Install jump directory navigator
RUN wget -qnv -O jump.deb https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb && \
  dpkg -i jump.deb && \
  rm jump.deb

# Install lazydocker
RUN curl -fsSL https://github.com/jesseduffield/lazydocker/releases/download/v0.2.4/lazydocker_0.2.4_Linux_x86_64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install lazygit
RUN curl -fsSL https://github.com/jesseduffield/lazygit/releases/download/v0.8.1/lazygit_0.8.1_Linux_x86_64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install musikcube
RUN wget -O musikcube.deb -nv https://github.com/clangen/musikcube/releases/download/0.65.0/musikcube_0.65.0_ubuntu_disco_amd64.deb && \
  dpkg -i musikcube.deb || apt-get install -qq --fix-broken && \
  rm musikcube.deb

# Install netdata
RUN bash -c "$(curl -Ss https://my-netdata.io/kickstart.sh)" --dont-wait --dont-start-it

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Install novnc
RUN git clone --depth 1 https://github.com/cloud-computer/noVNC.git /opt/noVNC

# Install onedrive client
RUN wget -O /usr/local/bin/onedrive -nv https://github.com/sabrehagen/onedrive/raw/master/onedrive && \
  chmod +x /usr/local/bin/onedrive

# Install pywal
RUN pip3 install --user pywal

# Install resucetime time tracker
RUN wget -O rescuetime.deb -nv https://www.rescuetime.com/installers/rescuetime_current_amd64.deb && \
  dpkg -i rescuetime.deb || apt-get install -qq --fix-broken && \
  rm rescuetime.deb

# Install signal messenger
RUN curl -s https://updates.signal.org/desktop/apt/keys.asc | apt-key add - && \
  echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | tee -a /etc/apt/sources.list.d/signal-xenial.list && \
  apt-get update -qq && \
  apt-get install -qq signal-desktop

# Install skype
RUN wget -O skype.deb -qnv https://go.skype.com/skypeforlinux-64.deb && \
  dpkg -i skype.deb && \
  rm skype.deb

# Install slack
RUN wget -O slack.deb -nv https://downloads.slack-edge.com/linux_releases/slack-desktop-4.1.1-amd64.deb && \
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

# Install tmux plugin manager
RUN git clone --depth 1 https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Install tmuxinator
RUN gem install tmuxinator

# Install vs code, vs live share dependencies, and shfmt extension dependency
RUN wget -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt-get install -qq ./code.deb && \
  rm code.deb && \
  apt-get install -qq libicu[0-9][0-9] libkrb5-3 zlib1g libsecret-1-0 desktop-file-utils x11-utils && \
  wget -O /usr/local/bin/shfmt -nv https://github.com/mvdan/sh/releases/download/v2.6.3/shfmt_v2.6.3_linux_amd64 && \
  chmod +x /usr/local/bin/shfmt

# Install warnai
RUN apt-get update -qq && \
  apt-get install -qq inkscape optipng xfconf && \
  git clone --depth 1 https://github.com/reorr/warnai /opt/warnai

# Install xava
RUN apt-get update -qq && \
  apt-get install -qq \
  libfftw3-dev \
  libasound2-dev \
  libpulse-dev \
  libx11-dev \
  libsdl2-dev && \
  git clone --depth 1 https://github.com/nikp123/xava && \
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
  rebase-editor \
  tldr

# Install zoom conferencing
RUN wget -O zoom.deb -nv https://zoom.us/client/latest/zoom_amd64.deb && \
  dpkg -i zoom.deb || apt-get install -qq --fix-broken && \
  rm zoom.deb

# Configure openvpn
RUN mkdir -p $HOME/.config/openvpn && \
  mknod $HOME/.config/openvpn/tun c 10 200 && \
  chmod 600 $HOME/.config/openvpn/tun && \
  wget -O $HOME/.config/openvpn/america.ovpn -nv https://downloads.nordcdn.com/configs/files/ovpn_legacy/servers/us4349.nordvpn.com.tcp443.ovpn && \
  wget -O $HOME/.config/openvpn/sydney.ovpn -nv https://downloads.nordcdn.com/configs/files/ovpn_legacy/servers/au296.nordvpn.com.tcp443.ovpn && \
  wget -O $HOME/.config/openvpn/india.ovpn -nv https://downloads.nordcdn.com/configs/files/ovpn_legacy/servers/in33.nordvpn.com.tcp443.ovpn

# Configure password-less sudo for the sudo group
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# Configure X11 permissions
RUN sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
  echo needs_root_rights=yes >> /etc/X11/Xwrapper.config && \
  chmod u+s /usr/bin/xinit

# Create the docker group with the host os group id, backing up any existing group with docker group id
ENV DOCKER_GROUP 999
RUN getent group $DOCKER_GROUP | \
  grep -v docker | \
  cut -d: -f1 | \
  xargs groupmod --gid 9999 2>/dev/null || true
RUN groupmod --gid $DOCKER_GROUP docker

# Create a non-root user for safe operation
RUN useradd \
  --create-home \
  --groups $DOCKER_GROUP,audio,chrome,input,netdev,sudo,tty,video \
  --shell /bin/zsh \
  $USER

# Set non-root user password
RUN sed -i 's;^jackson.*$;jackson:$6$7De0aW9hUvGDKZmc$qrylcFmwKAL9iGNG9dvQ/GXCM4gLY.hES/P2d/3ZzRxkVMjD77WeTVSxV1P9XtmE9iAUmDwDTCHiVK.p5Ct1y1:18193:0:99999:7:::;' /etc/shadow

# Take ownership of user's home directory and applications
RUN chown -R $USER:$USER $HOME /opt

# Become desktop environment user
USER $USER
WORKDIR $HOME

# Clone large dotfiles and those that require post install
RUN vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-gtk.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-tmux.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-x11.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-zsh.git & \
  wait

# Cache zsh plugins
RUN zsh -c "source $HOME/.zshrc"

# Cache tmux plugins
RUN zsh -c $HOME/.tmux/plugins/tpm/bin/install_plugins

# If the DOTFILES_CACHEBUST build arg is supplied, rebuild from static dotfiles onwards
ARG DOTFILES_CACHEBUST
RUN DOTFILES_CACHEBUST=$DOTFILES_CACHEBUST echo "Building from dotfiles..."

# Clone static dotfiles
RUN vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alacritty.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alsa.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-autorandr.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-code.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-compton.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-crt.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-dnsmasq.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-dunst.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-git.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-i3.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-jobber.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-mime.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-mpd.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-musikcube.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-ncmpcpp.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-pcmanfm.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-ranger.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-scripts.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-ssh.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-tmux.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-xdg.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-zsh.git & \
  wait

# Record container build information
ARG DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_GIT_SHA $DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_IMAGE_NAME sabrehagen/desktop-environment
