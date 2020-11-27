FROM ubuntu:20.04

ARG DESKTOP_ENVIRONMENT_HOST_DOCKER_GID
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

# Install essential utilities
RUN apt-get update -qq && \
  apt-get install -y \
  alsa-utils \
  apt-file \
  apt-utils \
  build-essential \
  cmake \
  curl \
  dnsutils \
  dnsmasq \
  docker.io \
  figlet \
  fonts-font-awesome \
  g++ \
  gcc \
  git \
  gtk-theme-switch \
  htop \
  iputils-ping \
  jq \
  keychain \
  libnss3-tools \
  libterm-readkey-perl \
  lsb-core \
  maim \
  make \
  man-db \
  nano \
  ncdu \
  net-tools \
  numlockx \
  openssl \
  openvpn \
  perl \
  python-is-python3 \
  python3 \
  python3-pip \
  software-properties-common \
  ssh \
  sudo \
  tigervnc-scraping-server \
  tigervnc-standalone-server \
  tmux \
  tree \
  unzip \
  vcsh \
  wmctrl \
  x11-xkb-utils \
  x11-xserver-utils \
  xauth \
  xclip \
  xdg-utils \
  xdotool \
  xinput \
  xsel \
  zsh

# Install arc
RUN wget -q -O /usr/local/bin/arc https://github.com/mholt/archiver/releases/download/v3.5.0/arc_3.5.0_linux_amd64 && \
  chmod +x /usr/local/bin/arc

# Install bandwhich
RUN curl -fsSL https://github.com/imsnif/bandwhich/releases/download/0.20.0/bandwhich-v0.20.0-x86_64-unknown-linux-musl.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install bat
RUN wget -q -O bat.deb https://github.com/sharkdp/bat/releases/download/v0.16.0/bat_0.16.0_amd64.deb && \
  dpkg -i bat.deb && \
  rm bat.deb

# Install ctop
RUN wget -q -O /usr/local/bin/ctop https://github.com/bcicen/ctop/releases/download/v0.7.5/ctop-0.7.5-linux-amd64 && \
  chmod +x /usr/local/bin/ctop

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
  ~/.fzf/install --bin

# Install gotop
RUN wget -q -O gotop.deb https://github.com/cjbassi/gotop/releases/download/3.0.0/gotop_3.0.0_linux_amd64.deb && \
  dpkg -i gotop.deb && \
  rm gotop.deb

# Install jump directory navigator
RUN wget -q -O jump.deb https://github.com/gsamokovarov/jump/releases/download/v0.30.1/jump_0.30.1_amd64.deb && \
  dpkg -i jump.deb && \
  rm jump.deb

# Install nerd fonts
RUN curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip --create-dirs -o ~/.local/share/fonts/DroidSansMono.zip && \
  unzip ~/.local/share/fonts/DroidSansMono.zip -d ~/.local/share/fonts && \
  rm ~/.local/share/fonts/DroidSansMono.zip && \
  fc-cache -fv

# Install pywal
RUN apt-get update -qq && \
  apt-get install -qq imagemagick && \
  pip3 install --user pywal

# Install timeago
RUN wget -q -O /usr/local/bin/timeago -nv https://raw.githubusercontent.com/sabrehagen/timeago/master/timeago && \
  chmod +x /usr/local/bin/timeago

# Install yarn
RUN curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo deb https://dl.yarnpkg.com/debian stable main | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && \
  apt-get install -qq yarn

# Install yarn applications
RUN yarn global add \
  clipboard-cli \
  github-email \
  http-server \
  imgur-uploader-cli \
  localtunnel \
  nodemon \
  rebase-editor

# Create a non-root user for safe operation
RUN groupadd --system input && \
  useradd \
  --create-home \
  --groups audio,docker,input,shadow,sudo,tty,video \
  --shell /bin/zsh \
  $USER

# Configure container docker group id to be the same as the host docker group id so the mounted docker socket permissions match
RUN groupmod -g $DESKTOP_ENVIRONMENT_HOST_DOCKER_GID docker

# Configure non-root user password
RUN sed -i "s;^$USER:[^:]*;$USER:$DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD;" /etc/shadow

# Configure openvpn
RUN mknod /dev/tun c 10 200 && \
  chmod 600 /dev/tun

# Configure password-less sudo for the sudo group
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# Take ownership of user's home directory and applications
RUN chown -R $USER:$USER $HOME /opt

# Become desktop environment user
USER $USER
WORKDIR $HOME

# If the DOTFILES_CACHEBUST build arg is supplied, rebuild from static dotfiles onwards
ARG DOTFILES_CACHEBUST
RUN DOTFILES_CACHEBUST=$DOTFILES_CACHEBUST echo Building from dotfiles...

# Clone desktop environment repository
RUN git clone git://github.com/$DESKTOP_ENVIRONMENT_GITHUB_USER/desktop-environment.git /opt/desktop-environment || \
  git clone https://github.com/sabrehagen/desktop-environment.git /opt/desktop-environment && \
  /opt/desktop-environment/docker/scripts/install-containers.sh

# Clone user dotfiles or fallback to sabrehagen dotfiles
RUN wget https://github.com/$DESKTOP_ENVIRONMENT_GITHUB_USER/dotfiles.git --no-check-certificate -o /dev/null && \
  vcsh clone git://github.com/$DESKTOP_ENVIRONMENT_GITHUB_USER/dotfiles.git || \
  vcsh clone https://github.com/sabrehagen/dotfiles.git

# Bootstrap dotfiles
RUN ~/.dotfiles-bootstrap.sh
