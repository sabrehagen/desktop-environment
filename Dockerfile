FROM stemn/development-environment:latest
USER root

ENV BASE_USER stemn
ENV USER jackson
ENV HOME /$USER/home
ENV SSH_AUTH_SOCK=/ssh-auth.sock
ENV STEMN_GIT_EMAIL="jackson@stemn.com"
ENV STEMN_GIT_NAME="Jackson Delahunt"

# Keep the existing home directory
RUN mkdir /$USER && \
  mv /$BASE_USER/home $HOME

# Rename the first non-root user jackson
RUN sed -i "s/$BASE_USER/$USER/g" /etc/passwd
RUN sed -i "s/$BASE_USER/$USER/g" /etc/group

# Install chrome
RUN apt update && apt install --yes \
  apt-transport-https \
  ca-certificates \
  curl \
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
  apt purge --auto-remove -y curl && \
  rm -rf /var/lib/apt/lists/* && \
  rm /etc/apt/sources.list.d/google.list 
ADD config/chrome/local.conf /etc/fonts/local.conf

# Add user to groups required to run chrome
RUN groupadd --system chrome && \
  usermod --groups audio,chrome,video $USER

# Install vs code
RUN echo 'deb http://au.archive.ubuntu.com/ubuntu/ bionic main restricted universe' > /etc/apt/sources.list && \
  apt update && \
  wget -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt install --yes ./code.deb && \
  rm code.deb

# Remove mock sudo
RUN rm /usr/local/bin/sudo

# Install operating system utilities
RUN apt install --yes \
  sudo \
  vcsh

# Enable password-less sudo for user
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# Clone dotfiles configuration
RUN alias https-to-git="sed 's;https://github.com/\(.*\);git@github.com:\1.git;'"
RUN git clone https://github.com/sabrehagen/dotfiles-alacritty
RUN git clone https://github.com/sabrehagen/dotfiles-git
RUN git clone https://github.com/sabrehagen/dotfiles-scripts
RUN git clone https://github.com/sabrehagen/dotfiles-tmux
RUN git clone https://github.com/sabrehagen/dotfiles-vcsh
RUN git clone https://github.com/sabrehagen/dotfiles-zsh

# Add program configurations
COPY config/tmuxinator/.desktop.yaml $HOME/.tmuxinator/desktop.yaml

# Add custom binaries
COPY bin /usr/local/bin

# Extend existing shell configuration
RUN echo 'cd $HOME/repositories/stemn/stemn-backend' >> $HOME/.zshenv
RUN echo 'export $STEMN_TMUX_SESSION=desktop-environment' >> $HOME/.zshenv
RUN echo 'tmux new-session -d -s $STEMN_TMUX_SESSION tmuxinator desktop' >> $HOME/.zshenv

# Remove root ownership of all files under non-root user directory
RUN chown -R $USER:$USER $HOME

USER $USER
WORKDIR $HOME
