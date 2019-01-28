FROM stemn/development-environment:latest
USER root

ENV BASE_USER stemn
ENV USER jackson
ENV HOME /$USER/home
ENV SSH_AUTH_SOCK /ssh-auth.sock
ENV STEMN_GIT_EMAIL "jackson@stemn.com"
ENV STEMN_GIT_NAME "Jackson Delahunt"
ENV STEMN_TMUX_SESSION desktop-environment

# Make the user's workspace directory
RUN mkdir -p $HOME

# Rename the first non-root group to jackson
RUN groupmod \
  --new-name \
  $USER $BASE_USER

# Rename the first non-root user to jackson
RUN usermod \
  --home $HOME \
  --groups $USER,docker \
  --login $USER \
  $BASE_USER

# Install user utilities
RUN apt-get install -qq \
  software-properties-common \
  strace \
  vcsh \
  vlc \
  xinput \
  youtube-dl

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
  apt-get update -qq && apt-get install -qq \
  google-chrome-stable \
  --no-install-recommends && \
  rm /etc/apt/sources.list.d/google.list && \
  wget -O /etc/fonts/local.conf -nv https://raw.githubusercontent.com/jessfraz/dockerfiles/master/chrome/stable/local.conf

# Add user to groups required to run chrome
RUN groupadd --system chrome && \
  usermod --append --groups audio,chrome,video $USER

# Install vs code
RUN echo 'deb http://au.archive.ubuntu.com/ubuntu/ xenial main restricted universe' > /etc/apt/sources.list && \
  apt-get update -qq && \
  wget -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt-get install -qq ./code.deb && \
  rm code.deb && \
  apt-get install -qq libicu[0-9][0-9] libkrb5-3 zlib1g libsecret-1-0 desktop-file-utils x11-utils # vs live share dependencies

# Install musikcube
RUN wget -O musikcube.deb -nv https://github.com/clangen/musikcube/releases/download/0.62.0/musikcube_0.62.0_ubuntu_cosmic_amd64.deb && \
  dpkg -i musikcube.deb || apt-get install -qq --fix-broken && \
  rm musikcube.deb

# Install peek screen recorder
RUN add-apt-repository ppa:peek-developers/daily && \
  apt-get update -qq && \
  apt-get install -qq peek

# Install resucetime time tracker
RUN wget -O rescuetime.deb -nv https://www.rescuetime.com/installers/rescuetime_current_amd64.deb && \
  dpkg -i rescuetime.deb || apt-get install -qq --fix-broken && \
  rm rescuetime.deb

# Enable password-less sudo for user
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Add custom binaries
COPY bin /usr/local/bin

# Remove root ownership of all files under non-root user directory
RUN chown -R $USER:$USER /$USER

# Record container build information
ARG CONTAINER_BUILD_DATE
ARG CONTAINER_GIT_SHA
ENV CONTAINER_BUILD_DATE $CONTAINER_BUILD_DATE
ENV CONTAINER_GIT_SHA $CONTAINER_GIT_SHA
ENV CONTAINER_IMAGE_NAME sabrehagen/desktop-environment

# Become the desktop user
USER $USER
WORKDIR $HOME

# Keep existing user configuration files
RUN zsh -c "cp -r /$BASE_USER/home/{.gitconfig,.motd,.tmux.conf,.zshenv,.zshrc} $HOME"

# Clone dotfiles configuration
RUN alias https-to-git="sed 's;https://github.com/\(.*\);git@github.com:\1.git;'"
RUN vcsh clone https://github.com/sabrehagen/dotfiles-alacritty && \
  vcsh clone https://github.com/sabrehagen/dotfiles-code && \
  vcsh clone https://github.com/sabrehagen/dotfiles-scripts && \
  vcsh clone https://github.com/sabrehagen/dotfiles-vlc

# Add program configurations
COPY config/tmuxinator $HOME/.config/tmuxinator
COPY config/zsh/.zshenv $HOME/.zshenv.desktop
RUN sed -i '1s;^;source $HOME/.zshenv.desktop\n\n;' $HOME/.zshenv

# Cache zsh plugins
RUN zsh -c "source $HOME/.zshrc"

# Start a shell on entry
CMD zsh
