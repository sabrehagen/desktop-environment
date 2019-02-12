FROM stemn/development-environment:latest
USER root

# Install user utilities
RUN apt-get update -qq && apt-get install -qq --fix-missing \
  feh \
  software-properties-common \
  vcsh \
  vlc \
  xinput \
  youtube-dl

# Install musikcube
RUN wget -O musikcube.deb -nv https://github.com/clangen/musikcube/releases/download/0.62.0/musikcube_0.62.0_ubuntu_cosmic_amd64.deb && \
  dpkg -i musikcube.deb || apt-get install -qq --fix-broken && \
  rm musikcube.deb

# Install bluetooth utility
RUN wget -O blueberry.deb -nv http://packages.linuxmint.com//pool/main/b/blueberry/blueberry_1.1.5_all.deb && \
  dpkg -i blueberry.deb || apt-get install -qq --fix-broken && \
  rm blueberry.deb

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

# Install vs code
RUN echo 'deb http://au.archive.ubuntu.com/ubuntu/ xenial main restricted universe' > /etc/apt/sources.list && \
  apt-get update -qq && \
  wget -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt-get install -qq ./code.deb && \
  rm code.deb && \
  apt-get install -qq libicu[0-9][0-9] libkrb5-3 zlib1g libsecret-1-0 desktop-file-utils x11-utils # vs live share dependencies

# Install resucetime time tracker
RUN wget -O rescuetime.deb -nv https://www.rescuetime.com/installers/rescuetime_current_amd64.deb && \
  dpkg -i rescuetime.deb || apt-get install -qq --fix-broken && \
  rm rescuetime.deb

# Install peek screen recorder
RUN add-apt-repository ppa:peek-developers/daily && \
  apt-get update -qq && \
  apt-get install -qq peek

# Install yarn utilities
RUN yarn global add \
  http-server

# Record container build information
ARG DESKTOP_CONTAINER_BUILD_DATE
ARG DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_BUILD_DATE $DESKTOP_CONTAINER_BUILD_DATE
ENV CONTAINER_GIT_SHA $DESKTOP_CONTAINER_GIT_SHA
ENV CONTAINER_IMAGE_NAME sabrehagen/desktop-environment

# Container user home directories
ENV BASE_USER stemn
ENV USER jackson
ENV HOME /$USER/home

# User specific configuration
ENV STEMN_GIT_EMAIL "jackson@stemn.com"
ENV STEMN_GIT_NAME "Jackson Delahunt"

# Make the user's workspace directory
RUN mkdir -p $HOME && \
  chown -R stemn:stemn $HOME

# Rename the first non-root group to jackson
RUN groupmod \
  --new-name \
  $USER $BASE_USER

# Rename the first non-root user to jackson
RUN usermod \
  --home $HOME \
  --groups $USER,docker,sudo \
  --login $USER \
  $BASE_USER

# Add the user to the groups required to run chrome
RUN usermod \
  --append \
  --groups audio,chrome,video \
  $USER

# Become the desktop user
USER $USER
WORKDIR $HOME

# Keep desired base user configuration files
RUN cp /$BASE_USER/home/.gitconfig $HOME
RUN cp /$BASE_USER/home/.motd $HOME
RUN cp /$BASE_USER/home/.tmux.conf $HOME
RUN cp /$BASE_USER/home/.zlogin $HOME
RUN cp /$BASE_USER/home/.zshenv $HOME/.zshenv.base
RUN cp /$BASE_USER/home/.zshrc $HOME

# Remove base user files
RUN rm -rf $BASE_USER

# Clone dotfiles configuration
RUN alias https-to-git="sed 's;https://github.com/\(.*\);git@github.com:\1.git;'"
RUN vcsh clone https://github.com/sabrehagen/dotfiles-alacritty && \
  vcsh clone https://github.com/sabrehagen/dotfiles-code && \
  vcsh clone https://github.com/sabrehagen/dotfiles-musikcube && \
  vcsh clone https://github.com/sabrehagen/dotfiles-scripts && \
  vcsh clone https://github.com/sabrehagen/dotfiles-vlc && \
  vcsh clone https://github.com/sabrehagen/dotfiles-zsh

# Cache zsh plugins
RUN zsh -c "source $HOME/.zshrc"

# Cache tmux plugins
RUN zsh -c "/opt/tpm/bin/install_plugins"

# Start the global tmux sesssion on entry
CMD zsh -c 'tmux new-session -d -s desktop-environment zsh --login && sleep infinity'
