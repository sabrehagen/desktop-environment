FROM stemn/development-environment:latest
USER root

# Container user home directories
ENV BASE_USER stemn
ENV USER jackson
ENV HOME /home/$USER

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
  transmission-cli \
  transmission-common \
  transmission-daemon \
  youtube-dl

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
  groupadd --system chrome && \
  usermod --append --groups audio,chrome,video $USER

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

# Install tormix
RUN git clone https://github.com/ckardaris/tormix.git && \
  cd tormix && \
  gosu $USER ./install && \
  rm -rf ../tormix

# Install traefik
RUN wget -O /usr/local/bin/traefik -nv https://github.com/containous/traefik/releases/download/v1.7.9/traefik_linux-amd64 && \
  chmod +x /usr/local/bin/traefik

# Install vs code, vs live share dependencies, and shfmt extension dependency
RUN wget -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt-get install -qq ./code.deb && \
  rm code.deb && \
  apt-get install -qq libicu[0-9][0-9] libkrb5-3 zlib1g libsecret-1-0 desktop-file-utils x11-utils && \
  wget -O /usr/local/bin/shfmt -nv https://github.com/mvdan/sh/releases/download/v2.6.3/shfmt_v2.6.3_linux_amd64 && \
  chmod +x /usr/local/bin/shfmt

# Install yarn utilities
RUN yarn global add \
  http-server

# Install zoom conferencing
RUN wget -O zoom.deb -nv https://zoom.us/client/latest/zoom_amd64.deb && \
  dpkg -i zoom.deb || apt-get install -qq --fix-broken && \
  rm zoom.deb

# Clone dotfiles configuration
RUN gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alacritty.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alpine.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-bin.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-code.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-git.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-mime.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-musikcube.git & \
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
  wait && echo

# Cache zsh plugins
RUN gosu $USER zsh -c "source $HOME/.zshrc"

# Cache tmux plugins
RUN gosu $USER zsh -c /opt/tpm/bin/install_plugins

# Add static container filesystem
COPY root /

# Create the docker group with the host os group id
ENV DOCKER_GROUP 233
RUN groupmod --gid $DOCKER_GROUP docker

# Become desktop environment user
USER $USER
WORKDIR $HOME

# Record container build information
ARG DESKTOP_CONTAINER_BUILD_DATE
ARG DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_BUILD_DATE $DESKTOP_CONTAINER_BUILD_DATE
ENV CONTAINER_GIT_SHA $DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_IMAGE_NAME sabrehagen/desktop-environment
