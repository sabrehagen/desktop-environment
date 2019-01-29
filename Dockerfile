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
RUN apt install --yes \
  software-properties-common \
  vcsh \
  vlc \
  xinput

# Install chrome
RUN apt update && apt install --yes \
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
  apt update && apt install --yes \
  google-chrome-stable \
  --no-install-recommends && \
  rm /etc/apt/sources.list.d/google.list && \
  wget -O /etc/fonts/local.conf -nv https://raw.githubusercontent.com/jessfraz/dockerfiles/master/chrome/stable/local.conf

# Add user to groups required to run chrome
RUN groupadd --system chrome && \
  usermod --append --groups audio,chrome,video $USER

# Install vs code
RUN echo 'deb http://au.archive.ubuntu.com/ubuntu/ xenial main restricted universe' > /etc/apt/sources.list && \
  apt update && \
  wget -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt install --yes ./code.deb && \
  rm code.deb && \
  apt install --yes libicu[0-9][0-9] libkrb5-3 zlib1g libsecret-1-0 desktop-file-utils x11-utils # vs live share dependencies

# Install resucetime time tracker
RUN wget -O rescuetime.deb -nv https://www.rescuetime.com/installers/rescuetime_current_amd64.deb && \
  dpkg -i rescuetime.deb || apt --fix-broken --yes install && \
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

# Cache zsh plugins
RUN zsh -c "source $HOME/.zshrc"

# Start a shell on entry
CMD zsh
