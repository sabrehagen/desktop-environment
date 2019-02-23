FROM stemn/development-environment:latest
USER root

# Install user utilities
RUN apt-get update -qq && \
  apt-get install -qq --fix-broken --fix-missing \
  alpine \
  alsa-utils \
  arandr \
  feh \
  numlockx \
  software-properties-common \
  vcsh \
  vlc \
  x11-xkb-utils \
  xinput \
  youtube-dl

# Install s6 init system
RUN curl -L https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz | \
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

# Install vs code, vs live share dependencies, and shfmt extension dependency
RUN wget -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt-get install -qq ./code.deb && \
  rm code.deb && \
  apt-get install -qq libicu[0-9][0-9] libkrb5-3 zlib1g libsecret-1-0 desktop-file-utils x11-utils && \
  wget -O /usr/local/bin/shfmt -nv https://github.com/mvdan/sh/releases/download/v2.6.3/shfmt_v2.6.3_linux_amd64 && \
  chmod +x /usr/local/bin/shfmt

# Install chrome
RUN apt-get update -qq && apt-get install -qq \
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

# Install yarn utilities
RUN yarn global add \
  http-server

# System environment configuration
ENV S6_LOGGING 1

# Container user home directories
ENV BASE_USER stemn
ENV USER jackson
ENV HOME /$USER/home

# Remove base user files
RUN rm -rf /$BASE_USER

# Make the user's workspace directory
RUN mkdir -p $HOME

# User environment configuration
ENV STEMN_GIT_EMAIL "jackson@stemn.com"
ENV STEMN_GIT_NAME "Jackson Delahunt"
ENV TMUX $HOME/.tmux.sock
RUN touch $TMUX

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

# Add the user to the groups required to run chrome
RUN usermod \
  --append \
  --groups audio,chrome,video \
  $USER

# Add user configuration files
COPY .motd $HOME

# Take ownership of the desktop user's folder
RUN chown -R $USER:$USER /$USER

# Clone dotfiles configuration
RUN gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alacritty.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alpine.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-code.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-git.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-mime.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-musikcube.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-scripts.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-ssh.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-tmux.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-vlc.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-x11.git & \
  gosu $USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-zsh.git & \
  wait

# Cache zsh plugins
RUN gosu $USER zsh -c "source $HOME/.zshrc"

# Cache tmux plugins
RUN gosu $USER zsh -c /opt/tpm/bin/install_plugins

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
