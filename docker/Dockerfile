FROM ubuntu:24.04

ARG DESKTOP_ENVIRONMENT_GITHUB_USER
ARG DESKTOP_ENVIRONMENT_SOURCE_HOME
ARG DESKTOP_ENVIRONMENT_SOURCE_ALACRITTY
ARG DESKTOP_ENVIRONMENT_SOURCE_BPLAY
ARG DESKTOP_ENVIRONMENT_SOURCE_CBONSAI
ARG DESKTOP_ENVIRONMENT_SOURCE_DESKTOP_ENVIRONMENT
ARG DESKTOP_ENVIRONMENT_SOURCE_DMENU
ARG DESKTOP_ENVIRONMENT_SOURCE_DNCLI
ARG DESKTOP_ENVIRONMENT_SOURCE_DUNST
ARG DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH
ARG DESKTOP_ENVIRONMENT_SOURCE_GIT
ARG DESKTOP_ENVIRONMENT_SOURCE_GOTOP
ARG DESKTOP_ENVIRONMENT_SOURCE_GPING
ARG DESKTOP_ENVIRONMENT_SOURCE_GSIMPLECAL
ARG DESKTOP_ENVIRONMENT_SOURCE_HERMES_AGENT
ARG DESKTOP_ENVIRONMENT_SOURCE_I3
ARG DESKTOP_ENVIRONMENT_SOURCE_I3BLOCKS
ARG DESKTOP_ENVIRONMENT_SOURCE_I3LOCK
ARG DESKTOP_ENVIRONMENT_SOURCE_JOBBER
ARG DESKTOP_ENVIRONMENT_SOURCE_JUMP
ARG DESKTOP_ENVIRONMENT_SOURCE_NCMPCPP
ARG DESKTOP_ENVIRONMENT_SOURCE_NICOTINE_PLUS
ARG DESKTOP_ENVIRONMENT_SOURCE_NOVNC
ARG DESKTOP_ENVIRONMENT_SOURCE_PCMANFM
ARG DESKTOP_ENVIRONMENT_SOURCE_PICOM
ARG DESKTOP_ENVIRONMENT_SOURCE_PYWAL
ARG DESKTOP_ENVIRONMENT_SOURCE_QJACKCTL
ARG DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH
ARG DESKTOP_ENVIRONMENT_SOURCE_QT5CT
ARG DESKTOP_ENVIRONMENT_SOURCE_SCREENPIPE
ARG DESKTOP_ENVIRONMENT_SOURCE_TMUX
ARG DESKTOP_ENVIRONMENT_SOURCE_VCSH
ARG DESKTOP_ENVIRONMENT_SOURCE_VSCODE_WAL
ARG DESKTOP_ENVIRONMENT_SOURCE_WAL_CHROME_EXTENSION
ARG DESKTOP_ENVIRONMENT_SOURCE_WALOGRAM
ARG DESKTOP_ENVIRONMENT_SOURCE_WARNAI
ARG DESKTOP_ENVIRONMENT_SOURCE_WHATFILES
ARG DESKTOP_ENVIRONMENT_SOURCE_XWINWRAP
ARG DESKTOP_ENVIRONMENT_SOURCE_ZSH
ARG DESKTOP_ENVIRONMENT_USER

ENV DESKTOP_ENVIRONMENT_SOURCE_HOME=$DESKTOP_ENVIRONMENT_SOURCE_HOME
ENV DESKTOP_ENVIRONMENT_SOURCE_ALACRITTY=$DESKTOP_ENVIRONMENT_SOURCE_ALACRITTY
ENV DESKTOP_ENVIRONMENT_SOURCE_BPLAY=$DESKTOP_ENVIRONMENT_SOURCE_BPLAY
ENV DESKTOP_ENVIRONMENT_SOURCE_CBONSAI=$DESKTOP_ENVIRONMENT_SOURCE_CBONSAI
ENV DESKTOP_ENVIRONMENT_SOURCE_DESKTOP_ENVIRONMENT=$DESKTOP_ENVIRONMENT_SOURCE_DESKTOP_ENVIRONMENT
ENV DESKTOP_ENVIRONMENT_SOURCE_DMENU=$DESKTOP_ENVIRONMENT_SOURCE_DMENU
ENV DESKTOP_ENVIRONMENT_SOURCE_DNCLI=$DESKTOP_ENVIRONMENT_SOURCE_DNCLI
ENV DESKTOP_ENVIRONMENT_SOURCE_DUNST=$DESKTOP_ENVIRONMENT_SOURCE_DUNST
ENV DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH=$DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH
ENV DESKTOP_ENVIRONMENT_SOURCE_GIT=$DESKTOP_ENVIRONMENT_SOURCE_GIT
ENV DESKTOP_ENVIRONMENT_SOURCE_GOTOP=$DESKTOP_ENVIRONMENT_SOURCE_GOTOP
ENV DESKTOP_ENVIRONMENT_SOURCE_GPING=$DESKTOP_ENVIRONMENT_SOURCE_GPING
ENV DESKTOP_ENVIRONMENT_SOURCE_GSIMPLECAL=$DESKTOP_ENVIRONMENT_SOURCE_GSIMPLECAL
ENV DESKTOP_ENVIRONMENT_SOURCE_HERMES_AGENT=$DESKTOP_ENVIRONMENT_SOURCE_HERMES_AGENT
ENV DESKTOP_ENVIRONMENT_SOURCE_I3=$DESKTOP_ENVIRONMENT_SOURCE_I3
ENV DESKTOP_ENVIRONMENT_SOURCE_I3BLOCKS=$DESKTOP_ENVIRONMENT_SOURCE_I3BLOCKS
ENV DESKTOP_ENVIRONMENT_SOURCE_I3LOCK=$DESKTOP_ENVIRONMENT_SOURCE_I3LOCK
ENV DESKTOP_ENVIRONMENT_SOURCE_JOBBER=$DESKTOP_ENVIRONMENT_SOURCE_JOBBER
ENV DESKTOP_ENVIRONMENT_SOURCE_JUMP=$DESKTOP_ENVIRONMENT_SOURCE_JUMP
ENV DESKTOP_ENVIRONMENT_SOURCE_NCMPCPP=$DESKTOP_ENVIRONMENT_SOURCE_NCMPCPP
ENV DESKTOP_ENVIRONMENT_SOURCE_NICOTINE_PLUS=$DESKTOP_ENVIRONMENT_SOURCE_NICOTINE_PLUS
ENV DESKTOP_ENVIRONMENT_SOURCE_NOVNC=$DESKTOP_ENVIRONMENT_SOURCE_NOVNC
ENV DESKTOP_ENVIRONMENT_SOURCE_PCMANFM=$DESKTOP_ENVIRONMENT_SOURCE_PCMANFM
ENV DESKTOP_ENVIRONMENT_SOURCE_PICOM=$DESKTOP_ENVIRONMENT_SOURCE_PICOM
ENV DESKTOP_ENVIRONMENT_SOURCE_PYWAL=$DESKTOP_ENVIRONMENT_SOURCE_PYWAL
ENV DESKTOP_ENVIRONMENT_SOURCE_QJACKCTL=$DESKTOP_ENVIRONMENT_SOURCE_QJACKCTL
ENV DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH=$DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH
ENV DESKTOP_ENVIRONMENT_SOURCE_QT5CT=$DESKTOP_ENVIRONMENT_SOURCE_QT5CT
ENV DESKTOP_ENVIRONMENT_SOURCE_SCREENPIPE=$DESKTOP_ENVIRONMENT_SOURCE_SCREENPIPE
ENV DESKTOP_ENVIRONMENT_SOURCE_TMUX=$DESKTOP_ENVIRONMENT_SOURCE_TMUX
ENV DESKTOP_ENVIRONMENT_SOURCE_VCSH=$DESKTOP_ENVIRONMENT_SOURCE_VCSH
ENV DESKTOP_ENVIRONMENT_SOURCE_VSCODE_WAL=$DESKTOP_ENVIRONMENT_SOURCE_VSCODE_WAL
ENV DESKTOP_ENVIRONMENT_SOURCE_WAL_CHROME_EXTENSION=$DESKTOP_ENVIRONMENT_SOURCE_WAL_CHROME_EXTENSION
ENV DESKTOP_ENVIRONMENT_SOURCE_WALOGRAM=$DESKTOP_ENVIRONMENT_SOURCE_WALOGRAM
ENV DESKTOP_ENVIRONMENT_SOURCE_WARNAI=$DESKTOP_ENVIRONMENT_SOURCE_WARNAI
ENV DESKTOP_ENVIRONMENT_SOURCE_WHATFILES=$DESKTOP_ENVIRONMENT_SOURCE_WHATFILES
ENV DESKTOP_ENVIRONMENT_SOURCE_XWINWRAP=$DESKTOP_ENVIRONMENT_SOURCE_XWINWRAP
ENV DESKTOP_ENVIRONMENT_SOURCE_ZSH=$DESKTOP_ENVIRONMENT_SOURCE_ZSH
ENV DESKTOP_ENVIRONMENT_USER=$DESKTOP_ENVIRONMENT_USER

ENV EDITOR=nano
ENV LC_ALL=en_US.UTF-8
ENV SHELL=/bin/zsh
ENV TERM=xterm-256color
ENV TZ=Australia/Sydney
ENV USER=$DESKTOP_ENVIRONMENT_USER

ENV HOME=/home/$USER

# Install nala
RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get install -qq nala && \
  sed -i 's/^assume_yes =.*/assume_yes = true/' /etc/nala/nala.conf && \
  printf '\n\n%s' 'parallel_downloads = 16' >> /etc/nala/nala.conf

# Install aria2
RUN nala update && \
  nala install aria2 && \
  mkdir -p $HOME/.config/aria2 && \
  printf '%s\n' \
    'quiet=true' \
    'max-connection-per-server=10' \
    'min-split-size=1M' \
    > $HOME/.config/aria2/aria2.conf

# Restore minimized distribution content e.g. man pages
RUN nala update && \
  nala install unminimize && \
  yes | unminimize

# Install locales and timezone data
RUN nala update && \
  nala install \
  locales \
  tzdata

# Generate locales
RUN locale-gen $LC_ALL && \
  update-locale LC_ALL=$LC_ALL && \
  dpkg-reconfigure --frontend=noninteractive locales

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone

# Upgrade base system
RUN nala upgrade -y

# Install desktop environment core utilities
RUN nala update && \
  DEBIAN_FRONTEND=noninteractive nala install \
  acpi \
  alsa-base \
  alsa-utils \
  apt-file \
  apt-utils \
  arandr \
  asciinema \
  autoconf \
  bat \
  bc \
  build-essential \
  cava \
  cmake \
  cmatrix \
  colorized-logs \
  curl \
  dbus-x11 \
  ddcutil \
  dialog \
  dnsmasq \
  dnsutils \
  dput \
  ethtool \
  feh \
  ffmpeg \
  figlet \
  fonts-font-awesome \
  fonts-noto-color-emoji \
  g++ \
  gcc \
  gdb \
  gimp \
  git \
  git-lfs \
  gnupg2 \
  gnuplot \
  golang-go \
  grc \
  gtk-theme-switch \
  htop \
  id3v2 \
  iftop \
  imv \
  initramfs-tools \
  iputils-ping \
  jackd2 \
  jq \
  keychain \
  ksnip \
  libappindicator3-dev \
  libasound2-dev \
  libgtk-3-0t64 \
  libnotify-bin \
  libnss3-tools \
  libsecret-1-0 \
  libssl-dev \
  libterm-readkey-perl \
  lsb-release \
  lsof \
  maim \
  make \
  man-db \
  mpc \
  mpd \
  mpv \
  nano \
  ncat \
  ncdu \
  neovim \
  net-tools \
  netcat-openbsd \
  nmap \
  numlockx \
  nvtop \
  openssl \
  openvpn \
  pavucontrol-qt \
  pciutils \
  perl \
  pipx \
  pkg-config \
  pulseaudio-utils \
  pulsemixer \
  python3 \
  python3-libtmux \
  python3-pip \
  qjackctl \
  ranger \
  redshift \
  ripgrep \
  ruby \
  scrot \
  slop \
  socat \
  software-properties-common \
  ssh \
  sshpass \
  strace \
  stress \
  sudo \
  sxiv \
  tig \
  tigervnc-scraping-server \
  tigervnc-standalone-server \
  tini \
  transmission-cli \
  transmission-common \
  transmission-daemon \
  tree \
  unclutter-xfixes \
  unrar \
  usbutils \
  vim \
  wdiff \
  wireplumber \
  wmctrl \
  x2x \
  xauth \
  xautolock \
  xclip \
  xdotool \
  xinit \
  xinput \
  xorg \
  xsel \
  xserver-xorg \
  xsettingsd \
  xterm \
  yq \
  yt-dlp \
  zathura && \
  apt-file update

# If the CACHEBUST_APPS build arg is supplied, rebuild from apps onwards
ARG CACHEBUST_APPS
RUN echo 'Building from apps onwards...'

# Install all applications via Makefile
COPY Makefile /tmp/Makefile
RUN make --directory /tmp --jobs $(nproc)

# Configure openvpn
RUN mkdir -p $HOME/.config/openvpn && \
  mknod -m u=rw,go= $HOME/.config/openvpn/tun c 10 200

# Configure password-less sudo for the sudo group
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers

# Configure x11 permissions and touchpad tap to click
RUN sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
  echo needs_root_rights=yes >> /etc/X11/Xwrapper.config && \
  chmod u+s /usr/bin/xinit && \
  mkdir -p /etc/X11/xorg.conf.d && \
  echo 'Section "InputClass"\n Identifier "touchpad"\n MatchIsTouchpad "on"\n Driver "libinput"\n Option "Tapping" "on"\n Option "libinput Accel Speed" "0.5"\n Option "Natural Scrolling" "true"\nEndSection' > /etc/X11/xorg.conf.d/90-touchpad.conf

# Configure nvidia fan control and allow headless operation
RUN echo 'Section "Device"\n Identifier "nvidia"\n Driver "nvidia"\n Option "Coolbits" "4"\n Option "AllowEmptyInitialConfiguration" "true"\nEndSection' > /etc/X11/xorg.conf.d/20-nvidia.conf

# Allow input group access to uinput
RUN echo 'KERNEL=="uinput", GROUP="input", MODE:="0660"' > /etc/udev/rules.d/80-hints.rules

# Create a non-root user for safe operation
RUN userdel -r ubuntu && \
  useradd \
  --create-home \
  --groups audio,docker,i2c,input,shadow,sudo,tty,video \
  --shell /usr/bin/zsh \
  $USER && \
  cp --preserve=all --recursive --update=none /etc/skel/. $HOME/ && \
  touch $HOME/.hushlogin

# Set non-root user password
RUN --mount=type=secret,id=user_password \
  sed -i "s;^$USER:[^:]*;$USER:$(cat /run/secrets/user_password);" /etc/shadow

# Take ownership of user's home directory and applications
RUN chown -R $USER:$USER $HOME $DESKTOP_ENVIRONMENT_SOURCE_HOME

# Restore file ownership and file mode required for chrome-sandbox binaries
RUN find $DESKTOP_ENVIRONMENT_SOURCE_HOME -type f -name chrome-sandbox \
  -exec chown root:root {} \; \
  -exec chmod u=srwx,go=rx {} \;

# Become desktop environment user
USER $USER
WORKDIR $HOME

# Clone the desktop environment
RUN git clone https://github.com/$DESKTOP_ENVIRONMENT_GITHUB_USER/desktop-environment $DESKTOP_ENVIRONMENT_SOURCE_DESKTOP_ENVIRONMENT || \
  git clone https://github.com/sabrehagen/desktop-environment $DESKTOP_ENVIRONMENT_SOURCE_DESKTOP_ENVIRONMENT

# If the CACHEBUST_DOTFILES build arg is supplied, rebuild from static dotfiles onwards
ARG CACHEBUST_DOTFILES
RUN echo 'Building from dotfiles...'

# Clone user dotfiles or fallback to sabrehagen dotfiles
RUN vcsh clone https://github.com/sabrehagen/dotfiles

# Bootstrap dotfiles
RUN $HOME/.dotfiles-bootstrap.sh

# Use tini to manage child processes
ENTRYPOINT ["tini", "--"]

# Run startup script and keep the container running
CMD ["zsh", "-c", "$HOME/.config/scripts/startup.sh & sleep infinity"]

# Record container build information
ARG DESKTOP_ENVIRONMENT_CONTAINER_BUILD_DATE
ENV DESKTOP_ENVIRONMENT_CONTAINER_BUILD_DATE=$DESKTOP_ENVIRONMENT_CONTAINER_BUILD_DATE
ARG DESKTOP_ENVIRONMENT_CONTAINER_GIT_SHA
ENV DESKTOP_ENVIRONMENT_CONTAINER_GIT_SHA=$DESKTOP_ENVIRONMENT_CONTAINER_GIT_SHA
ARG DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME
ENV DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME=$DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME
