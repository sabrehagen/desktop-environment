FROM ubuntu:19.04

ENV USER jackson
ENV DISPLAY :0
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
  alttab \
  arandr \
  asciinema \
  autojump \
  build-essential \
  cmake \
  cmatrix \
  curl \
  dnsutils \
  docker.io \
  evince \
  feh \
  figlet \
  g++ \
  gcc \
  git \
  gtk+3.0 \
  gosu \
  htop \
  httpie \
  i3 \
  iftop \
  iputils-ping \
  irssi \
  jq \
  keychain \
  libnss3-tools \
  lsb-core \
  maim \
  make \
  man-db \
  nano \
  ncdu \
  net-tools \
  netcat-openbsd \
  nnn \
  numlockx \
  openssl \
  openvpn \
  pcmanfm \
  perl \
  python \
  python-pip \
  ruby \
  software-properties-common \
  ssh \
  sudo \
  sxhkd \
  tmux \
  transmission-cli \
  transmission-common \
  transmission-daemon \
  tree \
  vcsh \
  vim \
  weechat \
  wmctrl \
  xauth \
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
RUN wget -O alacritty.deb -nv https://github.com/jwilm/alacritty/releases/download/v0.2.9/Alacritty-v0.2.9_amd64.deb && \
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
  git clone https://github.com/cloud-computer/libcloudstorage && \
  cd libcloudstorage && \
  ./bootstrap && \
  ./configure --with-curl --with-microhttpd --with-fuse && \
  make -j$(nproc) && \
  make install && \
  echo user_allow_other >> /etc/fuse.conf

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

# Install helm
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash

# Install kind
RUN wget -qnv -O kind https://github.com/kubernetes-sigs/kind/releases/download/v0.3.0/kind-linux-amd64 && \
  chmod +x kind && \
  mv kind /usr/local/bin

# Install lazydocker
RUN curl -fsSL https://github.com/jesseduffield/lazydocker/releases/download/v0.2.4/lazydocker_0.2.4_Linux_x86_64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install lazygit
RUN curl -fsSL https://github.com/jesseduffield/lazygit/releases/download/v0.8.1/lazygit_0.8.1_Linux_x86_64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install musikcube
RUN wget -O musikcube.deb -nv https://github.com/clangen/musikcube/releases/download/0.62.0/musikcube_0.62.0_ubuntu_cosmic_amd64.deb && \
  dpkg -i musikcube.deb || apt-get install -qq --fix-broken && \
  rm musikcube.deb

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Install onedrive client
RUN wget -O /usr/local/bin/onedrive -nv https://github.com/sabrehagen/onedrive/raw/master/onedrive && \
  chmod +x /usr/local/bin/onedrive

# Install resucetime time tracker
RUN wget -O rescuetime.deb -nv https://www.rescuetime.com/installers/rescuetime_current_amd64.deb && \
  dpkg -i rescuetime.deb || apt-get install -qq --fix-broken && \
  rm rescuetime.deb

# Install signal messenger
RUN curl -s https://updates.signal.org/desktop/apt/keys.asc | apt-key add - && \
  echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | tee -a /etc/apt/sources.list.d/signal-xenial.list && \
  apt-get update -qq && \
  apt-get install -qq signal-desktop

# Install slack
RUN wget -O slack.deb -nv https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.1-amd64.deb && \
  dpkg -i slack.deb || apt-get install -qq --fix-broken && \
  rm slack.deb

# Install tormix
RUN wget -O /usr/local/bin/tormix -nv https://raw.githubusercontent.com/ckardaris/tormix/master/tormix && \
  chmod +x /usr/local/bin/tormix

# Install tmux plugin manager
RUN git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Install tmuxinator
RUN gem install tmuxinator

# Install vs code, vs live share dependencies, and shfmt extension dependency
RUN wget -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt-get install -qq ./code.deb && \
  rm code.deb && \
  apt-get install -qq libicu[0-9][0-9] libkrb5-3 zlib1g libsecret-1-0 desktop-file-utils x11-utils && \
  wget -O /usr/local/bin/shfmt -nv https://github.com/mvdan/sh/releases/download/v2.6.3/shfmt_v2.6.3_linux_amd64 && \
  chmod +x /usr/local/bin/shfmt

# Install weechat slack plugin
RUN mkdir -p $HOME/.weechat/python/autoload && \
  curl -fsSL "https://raw.githubusercontent.com/rawdigits/wee-slack/master/wee_slack.py" -o $HOME/.weechat/python/wee_slack.py && \
  ln -s $HOME/.weechat/python/wee_slack.py $HOME/.weechat/python/autoload && \
  pip install websocket-client

# Install yarn
RUN curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -qq yarn

# Install yarn based utilities
RUN yarn global add \
  clipboard-cli \
  github-email \
  http-server \
  imgur-uploader-cli \
  rebase-editor \
  speed-test \
  tldr

# Install zoom conferencing
RUN wget -O zoom.deb -nv https://zoom.us/client/latest/zoom_amd64.deb && \
  dpkg -i zoom.deb || apt-get install -qq --fix-broken && \
  rm zoom.deb

# Configure dns to use cloudflare
RUN echo "prepend domain-name-servers 1.1.1.1" >> /etc/dhcp/dhclient.conf

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
  --password $USER \
  --shell /bin/zsh \
  $USER

# Take ownership of user's home directory
RUN chown -R $USER:$USER $HOME

# Become desktop environment user
USER $USER
WORKDIR $HOME

# If the DOTFILES_CACHEBUST build arg is supplied, rebuild from dotfiles onwards
ARG DOTFILES_CACHEBUST
RUN DOTFILES_CACHEBUST=$DOTFILES_CACHEBUST echo "Building from dotfiles..."

# Clone dotfiles configuration
RUN vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alacritty.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alsa.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-code.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-git.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-i3.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-mime.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-musikcube.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-scripts.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-ssh.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-sxhkd.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-tmux.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-weechat.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-x11.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-xdg.git & \
  vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-zsh.git & \
  wait

# Cache zsh plugins
RUN zsh -c "source $HOME/.zshrc"

# Cache tmux plugins
RUN zsh -c $HOME/.tmux/plugins/tpm/bin/install_plugins

# Configure lazygit
RUN mkdir -p $HOME/.config/jesseduffield/lazygit && \
  echo 'reporting: "off"' > $HOME/.config/jesseduffield/lazygit/config.yml

# Record container build information
ARG DESKTOP_CONTAINER_BUILD_DATE
ARG DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_BUILD_DATE $DESKTOP_CONTAINER_BUILD_DATE
ENV CONTAINER_GIT_SHA $DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_IMAGE_NAME sabrehagen/desktop-environment
