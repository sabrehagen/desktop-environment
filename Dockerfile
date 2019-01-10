FROM stemn/development-environment:latest
USER root

ENV HOME /home/jackson
ENV USER jackson
ENV SSH_AUTH_SOCK=/ssh-auth.sock
ENV STEMN_GIT_EMAIL="jackson@stemn.com"
ENV STEMN_GIT_NAME="Jackson Delahunt"

WORKDIR $HOME

# Name the first non-root user jackson
RUN sed -i "s/stemn/$USER/g" /etc/passwd

# Enable password-less sudo for jackson
RUN echo 'jackson ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers

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
  rm -rf /var/lib/apt/lists/*

# Add jackson to groups required to run chrome
RUN groupadd --system chrome && \
  usermod --groups audio,chrome,video $USER

# Install vs code
RUN wget -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt install code.deb && \
  rm code.deb

# Clone dotfiles configuration
RUN git clone git@github.com:sabrehagen/dotfiles-alacritty.git
RUN git clone git@github.com:sabrehagen/dotfiles-git.git
RUN git clone git@github.com:sabrehagen/dotfiles-scripts.git
RUN git clone git@github.com:sabrehagen/dotfiles-tmux.git
RUN git clone git@github.com:sabrehagen/dotfiles-vcsh.git
RUN git clone git@github.com:sabrehagen/dotfiles-zsh.git

# Install operating system utilities
RUN apt install --yes \
  vcsh \
  wicd-curses

# Add zsh aliases
RUN echo 'tree="tree -a -I .git -I node_modules -L 4"' >> $HOME/.zshenv
RUN echo 'wifi=wicd-curses' >> $HOME/.zshenv

# Manage ssh keys using keychain
RUN echo 'keychain $HOME/.ssh/id_rsa >/dev/null 2>&1' >> $HOME/.zshenv
RUN echo 'source $HOME/.keychain/$(hostname)-sh' >> $HOME/.zshenv

USER $USER
