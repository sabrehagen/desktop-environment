FROM stemn/development-environment:latest
USER root

# System environment configuration
ENV S6_LOGGING 1

# Container user home directories
ENV BASE_USER stemn
ENV USER jackson
ENV HOME /home/$USER

# User environment configuration
ARG DESKTOP_ENVIRONMENT_GIT_EMAIL
ARG DESKTOP_ENVIRONMENT_GIT_NAME
ENV STEMN_GIT_EMAIL "$DESKTOP_ENVIRONMENT_GIT_EMAIL"
ENV STEMN_GIT_NAME "$DESKTOP_ENVIRONMENT_GIT_NAME"

# Remove base user files
RUN rm -rf /$BASE_USER

# Make the new user's home directory
RUN mkdir -p $HOME

# Rename the first non-root group to jackson
RUN groupmod \
  --new-name \
  $USER $BASE_USER

# Rename the first non-root user to jackson
RUN usermod \
  --groups $USER,docker,sudo \
  --home $HOME \
  --login $USER \
  $BASE_USER

# Give the user ownership of their home folder
RUN chown -R $USER:$USER $HOME

# Install user utilities
RUN apt-get update -qq && \
  apt-get install -qq --fix-broken --fix-missing \
  alpine \
  alsa-utils \
  arandr \
  bitlbee \
  feh \
  numlockx \
  ruby-dev \
  software-properties-common \
  transmission-cli \
  transmission-common \
  transmission-daemon \
  vcsh \
  vlc \
  x11-xkb-utils \
  xinput \
  youtube-dl

# Install s6 init system
RUN curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz | \
  tar -C / -xzf -

# Install resucetime time tracker
RUN wget -O rescuetime.deb -nv https://www.rescuetime.com/installers/rescuetime_current_amd64.deb && \
  dpkg -i rescuetime.deb || apt-get install -qq --fix-broken && \
  rm rescuetime.deb

# Install zoom conferencing
RUN wget -O zoom.deb -nv https://zoom.us/client/latest/zoom_amd64.deb && \
  dpkg -i zoom.deb || apt-get install -qq --fix-broken && \
  rm zoom.deb

# Install musikcube
RUN wget -O musikcube.deb -nv https://github.com/clangen/musikcube/releases/download/0.62.0/musikcube_0.62.0_ubuntu_cosmic_amd64.deb && \
  dpkg -i musikcube.deb || apt-get install -qq --fix-broken && \
  rm musikcube.deb

# Install alacritty
RUN wget -O alacritty.deb -nv https://github.com/jwilm/alacritty/releases/download/v0.2.9/Alacritty-v0.2.9_amd64.deb && \
  dpkg -i alacritty.deb && \
  rm alacritty.deb

# Install traefik
RUN wget -O /usr/local/bin/traefik -nv https://github.com/containous/traefik/releases/download/v1.7.9/traefik_linux-amd64 && \
  chmod +x /usr/local/bin/traefik

# Install tormix
RUN git clone https://github.com/ckardaris/tormix.git && \
  cd tormix && \
  gosu $USER ./install && \
  rm -rf ../tormix

# Install onedrive client
RUN wget -O /usr/local/bin/onedrive -nv https://github.com/sabrehagen/onedrive/raw/master/onedrive && \
  chmod +x /usr/local/bin/onedrive

# Install signal messenger
RUN curl -s https://updates.signal.org/desktop/apt/keys.asc | apt-key add - && \
  echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | tee -a /etc/apt/sources.list.d/signal-xenial.list && \
  apt-get update -qq && \
  apt-get install -qq signal-desktop

# Install vs code, vs live share dependencies, and shfmt extension dependency
RUN wget -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt-get install -qq ./code.deb && \
  rm code.deb && \
  apt-get install -qq libicu[0-9][0-9] libkrb5-3 zlib1g libsecret-1-0 desktop-file-utils x11-utils && \
  wget -O /usr/local/bin/shfmt -nv https://github.com/mvdan/sh/releases/download/v2.6.3/shfmt_v2.6.3_linux_amd64 && \
  chmod +x /usr/local/bin/shfmt

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
  groupadd --system chrome && \
  usermod --append --groups audio,chrome,video $USER

# Install google drive client
RUN add-apt-repository ppa:alessandro-strada/ppa && \
  apt-get update -qq && \
  apt-get install -qq google-drive-ocamlfuse

# Install gem utilities
RUN gem install \
  travis

# Install yarn utilities
RUN yarn global add \
  http-server

# Clone dotfiles configuration
RUN gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alacritty.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alpine.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-bin.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-code.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-git.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-mime.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-musikcube.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-rpi.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-scripts.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-ssh.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-tmux.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-tmuxinator.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-vlc.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-weechat.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-x11.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-xdg.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-zsh.git & \
  wait

# Cache zsh plugins
RUN gosu $USER zsh -c "source $HOME/.zshrc"

# Cache tmux plugins
RUN gosu $USER zsh -c /opt/tpm/bin/install_plugins

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf

# Record container build information
ARG DESKTOP_CONTAINER_BUILD_DATE
ARG DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_BUILD_DATE $DESKTOP_CONTAINER_BUILD_DATE
ENV CONTAINER_GIT_SHA $DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_IMAGE_NAME sabrehagen/desktop-environment

# Add static container filesystem
COPY root /

# Use s6 init system
ENTRYPOINT ["/init"]
