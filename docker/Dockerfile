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
ARG DESKTOP_ENVIRONMENT_SOURCE_SLACK_TUI
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
ENV DESKTOP_ENVIRONMENT_SOURCE_SLACK_TUI=$DESKTOP_ENVIRONMENT_SOURCE_SLACK_TUI
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
  libasound2-plugins \
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

# Install rust
RUN nala update && \
  curl -fsSL https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly --no-modify-path --profile minimal && \
  ln -s $HOME/.cargo/bin/cargo /usr/local/bin && \
  ln -s $HOME/.cargo/bin/rustup /usr/local/bin

# Install uv
RUN curl -fsSL https://astral.sh/uv/install.sh | UV_UNMANAGED_INSTALL=/usr/local/bin sh

# Install alacritty
RUN nala install libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 && \
  git clone --depth 1 --single-branch https://github.com/alacritty/alacritty $DESKTOP_ENVIRONMENT_SOURCE_ALACRITTY && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_ALACRITTY && \
  cargo build --release --no-default-features --features=x11 && \
  install target/release/alacritty /usr/local/bin && \
  cargo clean

# Install arc
RUN git clone --depth 1 --single-branch https://github.com/jm33-m0/arc && \
  go build -C arc/v2/cmd/arc -o /usr/local/bin/arc && \
  rm -rf arc

# Install ardour
RUN nala update && \
  nala install a2jmidid ardour

# Install asciic
RUN cargo install --git https://github.com/S0raWasTaken/bad_apple asciic && \
  git clone --depth 1 --single-branch https://github.com/S0raWasTaken/bapple_player $DESKTOP_ENVIRONMENT_SOURCE_BPLAY && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_BPLAY && \
  cargo install --path . && \
  cargo clean

# Install autorandr
RUN uv tool install autorandr

# Install btm
RUN LATEST=$(curl -s https://api.github.com/repos/ClementTsang/bottom/releases/latest | jq -r '.tag_name') && \
  aria2c -o btm.deb https://github.com/ClementTsang/bottom/releases/download/${LATEST}/bottom_${LATEST}-1_amd64.deb && \
  dpkg -i btm.deb && \
  rm btm.deb

# Install btop
RUN nala update && \
  nala install g++-14 && \
  git clone --depth 1 --single-branch https://github.com/aristocratos/btop.git /opt/btop && \
  cd /opt/btop && \
  make CXX=g++-14 -j$(nproc) && \
  make install

# Install bun
RUN curl -fsSL https://bun.sh/install | BUN_INSTALL=/usr/local bash

# Install cbonsai
RUN nala update && \
  nala install libncurses-dev && \
  git clone --depth 1 --single-branch https://gitlab.com/jallbrit/cbonsai $DESKTOP_ENVIRONMENT_SOURCE_CBONSAI && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_CBONSAI && \
  make install

# Install claude code
RUN curl -fsSL https://claude.ai/install.sh | bash

# Install claude-history
RUN curl -fsSL https://raw.githubusercontent.com/raine/claude-history/main/scripts/install.sh | bash

# Install cloudflare
RUN aria2c -o cloudflare.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
  dpkg -i cloudflare.deb && \
  rm cloudflare.deb

# Install cursor
RUN aria2c -o cursor.deb https://api2.cursor.sh/updates/download/golden/linux-x64-deb/cursor/2.6 && \
  dpkg -i cursor.deb && \
  rm cursor.deb

# Install wal chrome extension
RUN git clone --depth 1 --single-branch https://github.com/sabrehagen/wal-chrome-extension $DESKTOP_ENVIRONMENT_SOURCE_WAL_CHROME_EXTENSION

# Install discord
RUN aria2c --header='User-Agent: Mozilla/5.0' --header='Referer: https://discord.com/' -o discord.deb 'https://discord.com/api/download?platform=linux&format=deb' && \
  dpkg -i discord.deb && \
  rm discord.deb

# Install dive
RUN LATEST=$(curl -s https://api.github.com/repos/wagoodman/dive/releases/latest | jq -r '.tag_name | ltrimstr("v")') && \
  aria2c -o dive.deb https://github.com/wagoodman/dive/releases/download/v${LATEST}/dive_${LATEST}_linux_amd64.deb && \
  dpkg -i dive.deb && \
  rm dive.deb

# Install docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
  echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu noble stable' > /etc/apt/sources.list.d/docker.list && \
  nala update && \
  nala install docker-buildx-plugin docker-ce-cli docker-compose-plugin && \
  groupadd --system docker

# Install dmenu
RUN nala update && \
  nala install libfontconfig1-dev libfreetype-dev libx11-dev libxft-dev libxinerama-dev && \
  git clone --depth 1 --single-branch https://github.com/sabrehagen/dmenu $DESKTOP_ENVIRONMENT_SOURCE_DMENU && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_DMENU && \
  make install

# Install dncli
RUN nala update && \
  nala install qtbase5-dev && \
  git clone --depth 1 --single-branch https://github.com/Nohac/dncli $DESKTOP_ENVIRONMENT_SOURCE_DNCLI && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_DNCLI && \
  qmake && \
  make -j$(nproc) && \
  install dncli /usr/local/bin/drag


# Install dra
RUN LATEST=$(curl -s https://api.github.com/repos/devmatteini/dra/releases/latest | jq -r '.tag_name') && \
  aria2c -o dra.deb https://github.com/devmatteini/dra/releases/download/${LATEST}/dra_${LATEST}-1_amd64.deb && \
  dpkg -i dra.deb && \
  rm dra.deb

# Install dunst
RUN nala update && \
  nala install libdbus-1-dev libnotify-dev libsdl-pango-dev libxinerama-dev libxrandr-dev libxss-dev && \
  git clone https://github.com/sabrehagen/dunst $DESKTOP_ENVIRONMENT_SOURCE_DUNST && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_DUNST && \
  make WAYLAND=0 all && \
  make WAYLAND=0 install

# Install elecwhat
RUN LATEST=$(curl -s https://api.github.com/repos/piec/elecwhat/releases/latest | jq -r '.tag_name | ltrimstr("v")') && \
  aria2c -o elecwhat.deb https://github.com/piec/elecwhat/releases/download/v${LATEST}/elecwhat_${LATEST}_amd64.deb && \
  dpkg -i elecwhat.deb && \
  rm elecwhat.deb

# Install eza
RUN curl -fsSL https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install fastfetch
RUN git clone https://github.com/fastfetch-cli/fastfetch $DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH && \
  cmake -S $DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH -B $DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH/build -DCMAKE_BUILD_TYPE=Release && \
  cmake --build $DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH/build --parallel $(nproc) --target fastfetch && \
  install $DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH/build/fastfetch /usr/local/bin

# Install fzf
RUN LATEST=$(curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | jq -r '.tag_name | ltrimstr("v")') && \
  curl -L https://github.com/junegunn/fzf/releases/download/v${LATEST}/fzf-${LATEST}-linux_amd64.tar.gz | tar -xz -C /usr/local/bin

# Install gcsf
RUN nala update && \
  nala install fuse3 libfuse-dev libssl-dev pkg-config && \
  cargo install gcsf && \
  echo 'user_allow_other' >> /etc/fuse.conf && \
  chmod 644 /etc/fuse.conf && \
  chown root:root /etc/fuse.conf && \
  mkdir $HOME/gdrive

# Install gh
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
  chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main' | tee /etc/apt/sources.list.d/github-cli.list && \
  nala update && \
  nala install gh

# Install git
RUN nala update && \
  nala install asciidoc docbook-xsl-ns gettext libauthen-sasl-perl libcgi-pm-perl libcurl4-openssl-dev libdbd-sqlite3-perl libemail-valid-perl liberror-perl libexpat-dev libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libpcre2-dev libsecret-1-dev libssl-dev tcl tk xmlto zlib1g-dev && \
  git clone --depth 20 --single-branch https://github.com/sabrehagen/git $DESKTOP_ENVIRONMENT_SOURCE_GIT && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_GIT && \
  make configure && \
  ./configure --prefix=/usr --sysconfdir=/etc && \
  make -j$(nproc) && \
  make install && \
  install git /usr/local/bin && \
  touch /etc/gitconfig && \
  git config --system init.defaultBranch master

# Install github actions runner
RUN LATEST=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | jq -r '.tag_name | ltrimstr("v")') && \
  mkdir $DESKTOP_ENVIRONMENT_SOURCE_HOME/github-actions-runner && \
  aria2c -o actions-runner.tar.gz https://github.com/actions/runner/releases/download/v${LATEST}/actions-runner-linux-x64-${LATEST}.tar.gz && \
  tar -C $DESKTOP_ENVIRONMENT_SOURCE_HOME/github-actions-runner -xzf actions-runner.tar.gz && \
  rm actions-runner.tar.gz

# Install gotop
RUN git clone --depth 1 --single-branch https://github.com/sabrehagen/gotop $DESKTOP_ENVIRONMENT_SOURCE_GOTOP && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_GOTOP && \
  VERSION="$(git tag -l --sort=-v:refname | sed 's/v\([^-].*\)/\1/g' | head -1 | tr -d '-' ).$(git describe --long --tags | sed 's/\([^-].*\)-\([0-9]*\)-\(g.*\)/r\2.\3/g' | tr -d '-')" && \
  DATE=$(date +%Y%m%dT%H%M%S) && \
  go build -o gotop -ldflags "-X main.Version=v$VERSION -X main.BuildDate=$DATE" ./cmd/gotop && \
  install gotop /usr/local/bin

# Install gping
RUN git clone --depth 1 --single-branch https://github.com/orf/gping $DESKTOP_ENVIRONMENT_SOURCE_GPING && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_GPING && \
  cargo install --locked --path gping && \
  install target/release/gping /usr/local/bin && \
  cargo clean

# Install gsimplecal
RUN nala update && \
  nala install libgtk2.0-dev libglib2.0-dev && \
  git clone --depth 1 --single-branch https://github.com/dmedvinsky/gsimplecal $DESKTOP_ENVIRONMENT_SOURCE_GSIMPLECAL && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_GSIMPLECAL && \
  ./autogen.sh && \
  ./configure --enable-gtk2 && \
  make && \
  make install

# Install hermes-agent
RUN git clone --depth 1 --single-branch https://github.com/nousresearch/hermes-agent $DESKTOP_ENVIRONMENT_SOURCE_HERMES_AGENT && \
  PATH=$HOME/.local/bin:$PATH HERMES_INSTALL_DIR=$DESKTOP_ENVIRONMENT_SOURCE_HERMES_AGENT $DESKTOP_ENVIRONMENT_SOURCE_HERMES_AGENT/scripts/install.sh --skip-setup

# Install hints
RUN nala update && \
  nala install gir1.2-gtk-4.0 libcairo2-dev libdbus-1-dev libgirepository1.0-dev gcc libwnck-3-dev && \
  HINTS_EXPECTED_BIN_DIR=$HOME/.local/bin uv tool install git+https://github.com/AlfredoSequeida/hints.git && \
  echo 'ACCESSIBILITY_ENABLED=1\nGNOME_ACCESSIBILITY=1\nGTK_MODULES=gail:atk-bridge\nQT_ACCESSIBILITY=1\nQT_LINUX_ACCESSIBILITY_ALWAYS_ON=1' >> /etc/environment

# Install i3
RUN nala update && \
  nala install libanyevent-perl libev-dev libpango1.0-dev libstartup-notification0-dev libxcb-cursor-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-randr0-dev libxcb-shape0-dev libxcb-util0-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-xrm0 libxcb1-dev libxkbcommon-dev libxkbcommon-x11-dev libyajl-dev meson ninja-build && \
  git clone --depth 1 --single-branch --branch next https://github.com/sabrehagen/i3 $DESKTOP_ENVIRONMENT_SOURCE_I3 && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_I3 && \
  mkdir build && \
  meson setup build && \
  meson compile -C build && \
  meson install -C build && \
  cd AnyEvent-I3 && \
  perl Makefile.PL && \
  make && \
  make install

# Install i3blocks
RUN git clone --depth 1 --single-branch https://github.com/vivien/i3blocks $DESKTOP_ENVIRONMENT_SOURCE_I3BLOCKS && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_I3BLOCKS && \
  ./autogen.sh && \
  ./configure && \
  make && \
  make install

# Install i3lock
RUN nala update && \
  nala install libcairo2-dev libfontconfig1-dev libgif-dev libjpeg-dev libpam0g-dev libx11-xcb-dev libxcb-composite0-dev && \
  git clone --depth 1 --single-branch https://github.com/sabrehagen/i3lock-color $DESKTOP_ENVIRONMENT_SOURCE_I3LOCK && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_I3LOCK && \
  ./build.sh && \
  ./install-i3lock-color.sh

# Install i3-focus-last
RUN git clone --depth 1 --single-branch https://github.com/s-urbaniak/i3-focus-last $HOME/.config/i3/i3-focus-last && \
  cd $HOME/.config/i3/i3-focus-last && \
  go install

# Install i3 extras
RUN nala update && \
  nala install python3-dev python3-i3ipc && \
  uv tool install i3-resurrect==1.4.2 && \
  uv tool install i3altlayout==1.1.1 && \
  uv tool install git+https://github.com/sabrehagen/i3-workspace-names-daemon

# Install jobber
RUN git clone --depth 1 --single-branch https://github.com/sabrehagen/jobber $DESKTOP_ENVIRONMENT_SOURCE_JOBBER && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_JOBBER && \
  make && \
  make install

# Install jump directory navigator
RUN git clone --depth 1 --single-branch https://github.com/gsamokovarov/jump $DESKTOP_ENVIRONMENT_SOURCE_JUMP && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_JUMP && \
  go build -o jump && \
  install jump /usr/local/bin

# Install kdenlive
RUN nala update && \
  nala install frei0r-plugins kde-style-breeze kdenlive knewstuff-dialog mediainfo --no-install-recommends

# Install mise
RUN curl https://mise.run | sh

# Install musikcube
RUN aria2c -o musikcube.deb https://github.com/clangen/musikcube/releases/download/3.0.5/musikcube_3.0.5_linux_x86_64.deb && \
  dpkg -i musikcube.deb && \
  rm musikcube.deb

# Install ncmpcpp
RUN nala update && \
  nala install libboost-all-dev libcurl4-openssl-dev libfftw3-dev libmpdclient-dev libncursesw5-dev libreadline-dev libtag1-dev && \
  git clone --depth 1 --single-branch https://github.com/ncmpcpp/ncmpcpp $DESKTOP_ENVIRONMENT_SOURCE_NCMPCPP && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_NCMPCPP && \
  autoreconf -fiv && \
  ./configure --prefix=/usr --enable-outputs --enable-visualizer --enable-clock --with-fftw --with-taglib --with-lto && \
  make -j$(nproc) && \
  make install && \
  make clean

# Install nerd fonts
RUN aria2c -o DejaVuSansMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DejaVuSansMono.zip && \
  mkdir -p /usr/share/fonts/truetype/dejavu && \
  unzip -p DejaVuSansMono.zip DejaVuSansMNerdFont-Regular.ttf > /usr/share/fonts/truetype/dejavu/DejaVuSansMNerdFont-Regular.ttf && \
  unzip -p DejaVuSansMono.zip DejaVuSansMNerdFont-Bold.ttf > /usr/share/fonts/truetype/dejavu/DejaVuSansMNerdFont-Bold.ttf && \
  unzip -p DejaVuSansMono.zip DejaVuSansMNerdFont-Oblique.ttf > /usr/share/fonts/truetype/dejavu/DejaVuSansMNerdFont-Oblique.ttf && \
  unzip -p DejaVuSansMono.zip DejaVuSansMNerdFont-BoldOblique.ttf > /usr/share/fonts/truetype/dejavu/DejaVuSansMNerdFont-BoldOblique.ttf && \
  rm DejaVuSansMono.zip && \
  nala install fonts-noto-core

# Install ngrok
RUN curl -fsSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
  echo 'deb https://ngrok-agent.s3.amazonaws.com buster main' | tee /etc/apt/sources.list.d/ngrok.list && \
  nala update && \
  nala install ngrok

# Install tailscale
RUN curl -fsSL https://tailscale.com/install.sh | sh && \
  nala remove resolvconf

# Install nicotine+
RUN nala update && \
  nala install devscripts equivs python3-build && \
  git clone --depth 1 --single-branch https://github.com/sabrehagen/nicotine-plus $DESKTOP_ENVIRONMENT_SOURCE_NICOTINE_PLUS/src && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_NICOTINE_PLUS/src && \
  mk-build-deps --install --remove --tool 'nala install --no-install-recommends' debian/control && \
  python3 -m build --sdist && \
  mk-origtargz dist/nicotine*.tar.gz && \
  DEB_BUILD_OPTIONS=nocheck debuild -sa -us -uc && \
  dpkg -i ../nicotine*.deb && \
  nala purge devscripts equivs && \
  nala autoremove

# Install nodejs
RUN LATEST=$(curl -s https://nodejs.org/dist/index.json | jq -r '[.[] | select(.lts != false)] | first | .version') && \
  curl -fsSL https://nodejs.org/dist/${LATEST}/node-${LATEST}-linux-x64.tar.xz | \
  tar -C /usr/local -Jx --strip-components=1

# Install novnc
RUN git clone --depth 1 --single-branch https://github.com/cloud-computer/noVNC.git $DESKTOP_ENVIRONMENT_SOURCE_NOVNC && \
  git clone --depth 1 --single-branch https://github.com/novnc/websockify $DESKTOP_ENVIRONMENT_SOURCE_NOVNC/utils/websockify

# Install nvidia driver
RUN aria2c -o nvidia.run https://download.nvidia.com/XFree86/Linux-x86_64/595.58.03/NVIDIA-Linux-x86_64-595.58.03.run && \
  chmod +x nvidia.run && \
  ./nvidia.run --no-kernel-modules --silent && \
  rm nvidia.run

# Install nviwatch
RUN cargo install nviwatch

# Install nvm
RUN mkdir $DESKTOP_ENVIRONMENT_SOURCE_HOME/nvm && \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name')/install.sh | \
  NVM_DIR=$DESKTOP_ENVIRONMENT_SOURCE_HOME/nvm PROFILE=/dev/null bash && \
  . $DESKTOP_ENVIRONMENT_SOURCE_HOME/nvm/nvm.sh && \
  nvm install 20

# Install ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Install op
RUN curl -fsSL https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg && \
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | tee /etc/apt/sources.list.d/1password.list && \
  mkdir -p /etc/debsig/policies/AC2D62742012EA22 /usr/share/debsig/keyrings/AC2D62742012EA22 && \
  curl -fsSL https://downloads.1password.com/linux/debian/debsig/1password.pol | tee /etc/debsig/policies/AC2D62742012EA22/1password.pol && \
  curl -fsSL https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg && \
  nala update && \
  nala install 1password-cli

# Install open-webui
# RUN uv tool install open-webui

# Install openclaw
RUN curl -fsSL https://openclaw.ai/install.sh | bash -s -- --no-onboard

# Install oxker
RUN cargo install --git https://github.com/sabrehagen/oxker --branch fix/bollard-secret-to-models

# Install pcmanfm
RUN nala update && \
  nala install intltool libfm-gtk3-dev libgtk-3-dev && \
  git clone --depth 1 --single-branch https://github.com/lxde/pcmanfm $DESKTOP_ENVIRONMENT_SOURCE_PCMANFM && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_PCMANFM && \
  ./autogen.sh && \
  ./configure --disable-nls --prefix=/usr --sysconfdir=/etc --with-gtk=3 && \
  make -j$(nproc) && \
  make install

# Install picom
RUN nala update && \
  nala install libconfig-dev libdbus-1-dev libegl-dev libepoxy-dev libev-dev libgl-dev libpcre3-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev && \
  git clone --depth 1 --single-branch https://github.com/yshui/picom $DESKTOP_ENVIRONMENT_SOURCE_PICOM && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_PICOM && \
  meson setup --buildtype=release build && \
  ninja -C build && \
  install build/src/picom /usr/local/bin

# Install pipewire
RUN nala install pipewire pipewire-alsa pipewire-jack pipewire-pulse && \
  echo /usr/lib/x86_64-linux-gnu/pipewire-0.3/jack > /etc/ld.so.conf.d/pipewire-jack.conf && \
  ldconfig

# Install postgres
RUN nala update && \
  nala install postgresql && \
  pg_ctlcluster 16 main start && \
  runuser --user postgres -- createuser --superuser $DESKTOP_ENVIRONMENT_USER && \
  runuser --user postgres -- createdb --owner $DESKTOP_ENVIRONMENT_USER $DESKTOP_ENVIRONMENT_USER && \
  pg_ctlcluster 16 main stop

# Install posting
RUN uv tool install posting

# Install pywal
RUN git clone --depth 1 --single-branch https://github.com/sabrehagen/pywal $DESKTOP_ENVIRONMENT_SOURCE_PYWAL && \
  uv tool install $DESKTOP_ENVIRONMENT_SOURCE_PYWAL

# Install qjackctl
RUN nala update && \
  nala install libasound2-dev libjack-jackd2-dev libqt5svg5-dev portaudio19-dev qtbase5-dev qttools5-dev && \
  git clone --depth 1 --single-branch https://github.com/rncbc/qjackctl $DESKTOP_ENVIRONMENT_SOURCE_QJACKCTL && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_QJACKCTL && \
  cmake -DCMAKE_BUILD_TYPE=Release -B build && \
  cmake --build build --parallel $(nproc) && \
  cmake --install build

# Install qt5ct
RUN nala update && \
  nala install g++ libqt5svg5-dev qt5-qmake qtbase5-dev qtbase5-dev-tools qtbase5-private-dev qttools5-dev qttools5-dev-tools && \
  git clone --depth 1 --single-branch https://github.com/sabrehagen/qt5ct $DESKTOP_ENVIRONMENT_SOURCE_QT5CT && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_QT5CT && \
  qmake && \
  make -j$(nproc) && \
  make install

# Install qpwgraph
RUN nala update && \
  nala install libasound2-dev libpipewire-0.3-dev libqt6svg6-dev libspa-0.2-dev qt6-base-dev qt6-base-dev-tools qt6-tools-dev qt6-wayland && \
  git clone --depth 1 --single-branch https://github.com/rncbc/qpwgraph $DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH && \
  cmake -S $DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH -B $DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH/build -DCMAKE_BUILD_TYPE=Release && \
  cmake --build $DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH/build --parallel $(nproc) && \
  cmake --install $DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH/build

# Install screenpipe
# RUN curl -fsSL get.screenpi.pe/cli | sh && \
#   rm -f $HOME/.zshrc

# Install shell chatgpt
RUN uv tool install shell-gpt

# Install shfmt
RUN LATEST=$(curl -s https://api.github.com/repos/mvdan/sh/releases/latest | jq -r '.tag_name') && \
  aria2c -d /usr/local/bin -o shfmt https://github.com/mvdan/sh/releases/download/${LATEST}/shfmt_${LATEST}_linux_amd64 && \
  chmod +x /usr/local/bin/shfmt

# Install slack
RUN aria2c -o slack.deb https://downloads.slack-edge.com/desktop-releases/linux/x64/4.46.101/slack-desktop-4.46.101-amd64.deb && \
  dpkg -i slack.deb && \
  rm slack.deb

# Install slack-tui
RUN git clone --depth 1 --single-branch https://github.com/jonnonz1/slack-tui $DESKTOP_ENVIRONMENT_SOURCE_SLACK_TUI && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_SLACK_TUI && \
  go build -o /usr/local/bin/slack-tui .

# Install speedtest
RUN uv tool install speedtest-cli

# Install telegram
RUN add-apt-repository ppa:atareao/telegram && \
  nala update && \
  nala install telegram

# Install thorium
RUN LATEST=$(curl -s https://api.github.com/repos/Alex313031/thorium/releases/latest | jq -r '.tag_name | ltrimstr("M")') && \
  aria2c -o thorium.deb https://github.com/Alex313031/thorium/releases/download/M${LATEST}/thorium-browser_${LATEST}_AVX2.deb && \
  dpkg -i thorium.deb && \
  rm thorium.deb

# Install thunderbird
RUN aria2c -o thunderbird.tar.xz https://download-installer.cdn.mozilla.net/pub/thunderbird/releases/148.0b3/linux-x86_64/en-US/thunderbird-148.0b3.tar.xz && \
  tar -C $DESKTOP_ENVIRONMENT_SOURCE_HOME -xJf thunderbird.tar.xz && \
  rm thunderbird.tar.xz && \
  ln -s $DESKTOP_ENVIRONMENT_SOURCE_HOME/thunderbird/thunderbird /usr/local/bin/thunderbird

# Install timeago
RUN aria2c -d /usr/local/bin -o timeago https://raw.githubusercontent.com/sabrehagen/timeago/master/timeago && \
  chmod +x /usr/local/bin/timeago

# Install tldr
RUN uv tool install tldr && \
  uv tool run tldr --update

# Install tmpmail
RUN aria2c -d /usr/local/bin -o tmpmail https://raw.githubusercontent.com/sdushantha/tmpmail/master/tmpmail && \
  chmod +x /usr/local/bin/tmpmail

# Install tmux
RUN nala update && \
  nala install libevent-dev libncurses-dev bison && \
  git clone --depth 20 --single-branch https://github.com/sabrehagen/tmux $DESKTOP_ENVIRONMENT_SOURCE_TMUX && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_TMUX && \
  sh autogen.sh && \
  ./configure --prefix=/usr --sysconfdir=/etc && \
  make -j$(nproc) && \
  make install && \
  make clean

# Install tormix
RUN aria2c -d /usr/local/bin -o tormix https://raw.githubusercontent.com/ckardaris/tormix/master/tormix && \
  chmod +x /usr/local/bin/tormix

# Install tracexec
RUN curl -fsSL https://github.com/kxxt/tracexec/releases/latest/download/tracexec-x86_64-unknown-linux-gnu.tar.gz | \
  tar -C /usr/local/bin -xzf - tracexec

# Install walogram
RUN git clone --depth 1 --single-branch https://github.com/sabrehagen/walogram $DESKTOP_ENVIRONMENT_SOURCE_WALOGRAM && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_WALOGRAM && \
  make install

# Install vcsh
RUN nala update && \
  nala install automake ronn && \
  git clone --depth 1 --single-branch https://github.com/sabrehagen/vcsh $DESKTOP_ENVIRONMENT_SOURCE_VCSH && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_VCSH && \
  ./bootstrap.sh && \
  ./configure \
  --prefix=/usr \
  --sysconfdir=/etc \
  --disable-tests \
  --with-man-page=yes \
  --with-zsh-completion-dir=/usr/share/zsh/vendor-completions && \
  make -j$(nproc) && \
  make install && \
  make clean

# Install warnai
RUN nala update && \
  nala install inkscape optipng xfconf libegl-dev libwayland-dev && \
  git clone --depth 1 --single-branch https://github.com/sabrehagen/warnai $DESKTOP_ENVIRONMENT_SOURCE_WARNAI && \
  ln -s $DESKTOP_ENVIRONMENT_SOURCE_WARNAI/warnai /usr/local/bin

# Install whatfiles
RUN git clone --depth 1 --single-branch https://github.com/spieglt/whatfiles $DESKTOP_ENVIRONMENT_SOURCE_WHATFILES && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_WHATFILES && \
  make && \
  make install

# Install workmux
RUN curl -fsSL https://raw.githubusercontent.com/raine/workmux/main/scripts/install.sh | bash

# Install xava
RUN LATEST=$(curl -s https://api.github.com/repos/nikp123/xava/releases | jq -r '[.[] | select(any(.assets[]; .name == "xava-x86_64.AppImage"))][0].tag_name') && \
  aria2c -o xava.appimage https://github.com/nikp123/xava/releases/download/${LATEST}/xava-x86_64.AppImage && \
  chmod +x xava.appimage && \
  ./xava.appimage --appimage-extract && \
  rm xava.appimage && \
  mv squashfs-root $DESKTOP_ENVIRONMENT_SOURCE_HOME/xava && \
  ln -sf $DESKTOP_ENVIRONMENT_SOURCE_HOME/xava/usr/bin/xava /usr/local/bin/xava && \
  ln -sf $DESKTOP_ENVIRONMENT_SOURCE_HOME/xava/usr/share/xava /usr/share/xava && \
  ln -sf $DESKTOP_ENVIRONMENT_SOURCE_HOME/xava/usr/lib/xava /usr/lib/xava && \
  mkdir -p /etc/skel/.config/xava && \
  cp -a $DESKTOP_ENVIRONMENT_SOURCE_HOME/xava/usr/share/xava/. /etc/skel/.config/xava/

# Install xcolor
RUN cargo install xcolor

# Install xwinwrap
RUN nala update && \
  nala install libx11-dev libxext-dev libxrender-dev x11proto-xext-dev xorg-dev && \
  git clone --depth 1 --single-branch https://github.com/sabrehagen/xwinwrap.git $DESKTOP_ENVIRONMENT_SOURCE_XWINWRAP && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_XWINWRAP && \
  make && \
  make install

# Install yarn
RUN curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo 'deb https://dl.yarnpkg.com/debian stable main' | tee /etc/apt/sources.list.d/yarn.list && \
  nala update && \
  nala install yarn

# Install yarn based utilities
RUN yarn global add \
  @google/gemini-cli \
  @openai/codex \
  @mariozechner/pi-coding-agent \
  @sourcegraph/amp \
  aicommit2 \
  clipboard-cli \
  diff-so-fancy \
  github-email \
  grok-dev \
  http-server \
  imgur-uploader-cli \
  nodemon \
  rebase-editor \
  vercel && \
  yarn cache clean

# Install zsh
RUN nala update && \
  nala install libncursesw5-dev libpcre2-dev yodl && \
  git clone --depth 1 --single-branch https://github.com/zsh-users/zsh $DESKTOP_ENVIRONMENT_SOURCE_ZSH && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_ZSH && \
  ./Util/preconfig && \
  ./configure --prefix=/usr --sysconfdir=/etc && \
  make -j$(nproc) && \
  make install && \
  make clean

# Install zvm and zig
RUN curl -fsSL https://raw.githubusercontent.com/tristanisham/zvm/master/install.sh | bash -s - -- --no-env && \
  yes | $HOME/.zvm/self/zvm use 0.15.2

# Install vs code wal theme
RUN git clone --depth 1 --single-branch https://github.com/sabrehagen/vscode-wal $DESKTOP_ENVIRONMENT_SOURCE_VSCODE_WAL && \
  yarn --cwd $DESKTOP_ENVIRONMENT_SOURCE_VSCODE_WAL

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
