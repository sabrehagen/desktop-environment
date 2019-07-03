FROM ubuntu:19.04

ENV USER jackson
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
  arandr \
  asciinema \
  build-essential \
  cmake \
  cmatrix \
  curl \
  dnsutils \
  docker.io \
  figlet \
  g++ \
  gcc \
  git \
  gtk+3.0 \
  gosu \
  htop \
  iftop \
  iputils-ping \
  jq \
  keychain \
  libnss3-tools \
  lsb-core \
  make \
  man-db \
  nano \
  ncdu \
  net-tools \
  netcat-openbsd \
  nnn \
  numlockx \
  openssl \
  perl \
  python \
  ruby \
  software-properties-common \
  ssh \
  sudo \
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
  xinput \
  xsel \
  zsh

# Install antigen
RUN curl -fsSL git.io/antigen > /usr/local/bin/antigen.zsh

# Install bat
RUN wget -O bat.deb -qnv https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb && \
  dpkg -i bat.deb && \
  rm bat.deb

# Install code
RUN curl -fsSL https://github.com/cdr/code-server/releases/download/1.1119-vsc1.33.1/code-server1.1119-vsc1.33.1-linux-x64.tar.gz | \
  tar -C /tmp -xzf - && \
  mv /tmp/code-server*/code-server /usr/local/bin && \
  rm -rf /tmp/code-server*

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

# Install compose-on-kubernetes
RUN wget -O compose-on-kubernetes -qnv https://github.com/docker/compose-on-kubernetes/releases/download/v0.4.23/installer-linux && \
  chmod +x compose-on-kubernetes && \
  mv compose-on-kubernetes /usr/local/bin

# Install docker-compose
RUN curl -fsSL "https://github.com/docker/compose/releases/download/1.25.0-rc1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /opt/fzf && \
  /opt/fzf/install --bin

# Install helm
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash

# Install jump directory navigator
RUN wget -qnv -O jump.deb https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb && \
  dpkg -i jump.deb && \
  rm jump.deb

# Install kind
RUN wget -qnv -O kind https://github.com/kubernetes-sigs/kind/releases/download/v0.3.0/kind-linux-amd64 && \
  chmod +x kind && \
  mv kind /usr/local/bin

# Install lazydocker
RUN curl -fsSL https://github.com/jesseduffield/lazydocker/releases/download/v0.2.4/lazydocker_0.2.4_Linux_x86_64.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install musikcube
RUN wget -O musikcube.deb -nv https://github.com/clangen/musikcube/releases/download/0.62.0/musikcube_0.62.0_ubuntu_cosmic_amd64.deb && \
  dpkg -i musikcube.deb || apt-get install -qq --fix-broken && \
  rm musikcube.deb

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
RUN wget -O slack.deb -nv https://downloads.slack-edge.com/linux_releases/slack-desktop-3.4.2-amd64.deb && \
  dpkg -i slack.deb || apt-get install -qq --fix-broken && \
  rm slack.deb

# Install tormix
RUN wget -O /usr/local/bin/tormix -nv https://raw.githubusercontent.com/ckardaris/tormix/master/tormix && \
  chmod +x /usr/local/bin/tormix

# Install tmux plugin manager
RUN git clone https://github.com/tmux-plugins/tpm /opt/tpm --depth 1 && \
  ln -s /opt/tpm/tpm /usr/local/bin

# Install tmuxinator
RUN gem install tmuxinator

# Install vs code, vs live share dependencies, and shfmt extension dependency
RUN wget -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt-get install -qq ./code.deb && \
  rm code.deb && \
  apt-get install -qq libicu[0-9][0-9] libkrb5-3 zlib1g libsecret-1-0 desktop-file-utils x11-utils && \
  wget -O /usr/local/bin/shfmt -nv https://github.com/mvdan/sh/releases/download/v2.6.3/shfmt_v2.6.3_linux_amd64 && \
  chmod +x /usr/local/bin/shfmt

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
  tldr

# Install zoom conferencing
RUN wget -O zoom.deb -nv https://zoom.us/client/latest/zoom_amd64.deb && \
  dpkg -i zoom.deb || apt-get install -qq --fix-broken && \
  rm zoom.deb

# Enable password-less sudo for the sudo group
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

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
  --groups $DOCKER_GROUP,audio,chrome,sudo,video \
  --password $USER \
  --shell /bin/zsh \
  $USER

# Clone dotfiles configuration
RUN gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alacritty.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alpine.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-bin.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-code.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-git.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-mime.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-musikcube.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-openbox.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-rofi.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-rpi.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-scripts.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-ssh.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-sxhkd.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-tmux.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-tmuxinator.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-weechat.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-x11.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-xdg.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-zsh.git & \
  wait

# Take ownership of user's home and applications directory
RUN chown -R $USER:$USER $HOME /opt

# Cache zsh plugins
RUN gosu $USER zsh -c "source $HOME/.zshrc"

# Cache tmux plugins
RUN gosu $USER zsh -c /opt/tpm/bin/install_plugins

# Add static container filesystem
COPY root /

# Become desktop environment user
USER $USER
WORKDIR $HOME

# Record container build information
ARG DESKTOP_CONTAINER_BUILD_DATE
ARG DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_BUILD_DATE $DESKTOP_CONTAINER_BUILD_DATE
ENV CONTAINER_GIT_SHA $DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_IMAGE_NAME sabrehagen/desktop-environment
