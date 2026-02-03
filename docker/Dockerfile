FROM ubuntu:24.04

ARG DESKTOP_ENVIRONMENT_GITHUB_USER
ARG DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD
ARG DESKTOP_ENVIRONMENT_USER

ENV DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD=$DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD
ENV EDITOR=nano
ENV LC_ALL=en_US.UTF-8
ENV SHELL=/bin/zsh
ENV TERM=xterm-256color
ENV TZ=Australia/Sydney
ENV USER=$DESKTOP_ENVIRONMENT_USER

ENV HOME /home/$USER

ENV ARIA2C_ARGS="-q -x 5 -s 5 -k 1M"

# Install nala
RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y -qq nala

# Restore minimized distribution content e.g. man pages
RUN nala update && \
  nala install -y \
  unminimize && \
  yes | unminimize

# Install locales and timezone data
RUN nala update && \
  nala install -y \
  locales \
  tzdata

# Generate locales
RUN locale-gen $LC_ALL && \
  update-locale LC_ALL=$LC_ALL && \
  dpkg-reconfigure --frontend=noninteractive locales

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone

# Install desktop environment core utilities
RUN nala update && \
  DEBIAN_FRONTEND=noninteractive nala install -y \
  acpi \
  aria2 \
  alsa \
  alsa-utils \
  apt-file \
  apt-utils \
  arandr \
  asciinema \
  autoconf \
  autorandr \
  bat \
  bc \
  build-essential \
  cava \
  cmake \
  cmatrix \
  colorized-logs \
  curl \
  dbus-x11 \
  dnsmasq \
  dnsutils \
  docker-compose-v2 \
  docker.io \
  dput \
  feh \
  ffmpeg \
  figlet \
  fonts-font-awesome \
  fonts-noto-color-emoji \
  g++ \
  gcc \
  gimp \
  git \
  git-lfs \
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
  libgtk-3-0 \
  libnotify-bin \
  libnss3-tools \
  libssl-dev \
  libterm-readkey-perl \
  lsb-release \
  maim \
  make \
  man-db \
  mpc \
  mpd \
  mpv \
  nano \
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
  pcmanfm \
  perl \
  pipewire \
  pipewire-alsa \
  pipewire-jack \
  pipewire-pulse \
  pipx \
  pkg-config \
  pulseaudio-utils \
  python3 \
  python3-libtmux \
  python3-pip \
  qjackctl \
  ranger \
  redshift \
  ruby \
  slop \
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
  xauth \
  xautolock \
  xclip \
  xdotool \
  xinit \
  xinput \
  xorg \
  xsel \
  xserver-xorg \
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

# Install alacritty
RUN nala install -y libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 && \
  git clone --depth 1 --single-branch https://github.com/alacritty/alacritty /opt/alacritty && \
  cd /opt/alacritty && \
  cargo build --release --no-default-features --features=x11 && \
  install target/release/alacritty /usr/local/bin && \
  cargo clean

# Install arc
RUN aria2c $ARIA2C_ARGS -d /usr/local/bin -o arc https://github.com/mholt/archiver/releases/download/v3.5.0/arc_3.5.0_linux_amd64 && \
  chmod +x /usr/local/bin/arc

# Install ardour
RUN nala update && \
  nala install -y a2jmidid ardour

# Install asciic
RUN cargo install --git https://github.com/S0raWasTaken/bad_apple asciic && \
  git clone --depth 1 --single-branch https://github.com/S0raWasTaken/bapple_player /opt/bplay && \
  cargo install --path /opt/bplay

# Install btm
RUN aria2c $ARIA2C_ARGS -o btm.deb https://github.com/ClementTsang/bottom/releases/download/0.10.2/bottom_0.10.2-1_amd64.deb && \
  dpkg -i btm.deb && \
  rm btm.deb

# Install cbonsai
RUN nala update && \
  nala install -y libncurses-dev && \
  git clone --depth 1 --single-branch https://gitlab.com/jallbrit/cbonsai /opt/cbonsai && \
  cd /opt/cbonsai && \
  make install

# Install cursor
RUN aria2c $ARIA2C_ARGS -o cursor.deb https://api2.cursor.sh/updates/download/golden/linux-x64-deb/cursor/2.3 && \
  dpkg -i cursor.deb && \
  rm cursor.deb

# Install cursor cli
RUN curl -fsSL https://cursor.com/install | bash

# Install discord
RUN aria2c $ARIA2C_ARGS --header='User-Agent: Mozilla/5.0' --header='Referer: https://discord.com/' -o discord.deb 'https://discord.com/api/download?platform=linux&format=deb' && \
  dpkg -i discord.deb && \
  rm discord.deb

# Install dive
RUN aria2c $ARIA2C_ARGS -o dive.deb https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb && \
  dpkg -i dive.deb && \
  rm dive.deb

# Install dncli
RUN nala update && \
  nala install -y qtbase5-dev && \
  git clone --depth 1 --single-branch https://github.com/Nohac/dncli /opt/dncli && \
  cd /opt/dncli && \
  qmake && \
  make -j$(nproc) && \
  install dncli /usr/local/bin/drag

# Install docker-compose
RUN aria2c $ARIA2C_ARGS -d /usr/local/bin -o docker-compose "https://github.com/docker/compose/releases/download/v2.27.1/docker-compose-$(uname -s)-$(uname -m)" && \
  chmod +x /usr/local/bin/docker-compose

# Install dra
RUN aria2c $ARIA2C_ARGS -o dra.deb https://github.com/devmatteini/dra/releases/download/0.6.2/dra_0.6.2-1_amd64.deb && \
  dpkg -i dra.deb && \
  rm dra.deb

# Install dunst
RUN nala update && \
  nala install -y libdbus-1-dev libnotify-dev libsdl-pango-dev libxinerama-dev libxrandr-dev libxss-dev && \
  git clone https://github.com/sabrehagen/dunst /opt/dunst && \
  cd /opt/dunst && \
  make WAYLAND=0 all && \
  make WAYLAND=0 install

# Install elecwhat
RUN aria2c $ARIA2C_ARGS -o elecwhat.deb https://github.com/piec/elecwhat/releases/download/v1.13.0/elecwhat_1.13.0_amd64.deb && \
  dpkg -i elecwhat.deb && \
  rm elecwhat.deb

# Install eza
RUN curl -fsSL https://github.com/eza-community/eza/releases/download/v0.23.4/eza_x86_64-unknown-linux-gnu.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install fastfetch
RUN git clone https://github.com/fastfetch-cli/fastfetch /opt/fastfetch && \
  cmake -S /opt/fastfetch -B /opt/fastfetch/build -DCMAKE_BUILD_TYPE=Release && \
  cmake --build /opt/fastfetch/build --parallel $(nproc) --target fastfetch && \
  install /opt/fastfetch/build/fastfetch /usr/local/bin

# Install fzf
RUN curl -fsSL https://github.com/junegunn/fzf/releases/download/v0.55.0/fzf-0.55.0-linux_amd64.tar.gz | \
  tar -C /usr/local/bin -xzf - fzf

# Install gh
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
  chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main' | tee /etc/apt/sources.list.d/github-cli.list && \
  nala update && \
  nala install -y gh

# Install git
RUN nala update && \
  nala install -y asciidoc docbook-xsl-ns gettext libauthen-sasl-perl libcgi-pm-perl libcurl4-openssl-dev libdbd-sqlite3-perl libemail-valid-perl liberror-perl libexpat-dev libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libpcre2-dev libsecret-1-dev libssl-dev tcl tk xmlto zlib1g-dev && \
  git clone --depth 20 --single-branch https://github.com/sabrehagen/git /opt/git && \
  cd /opt/git && \
  make configure && \
  ./configure --prefix=/usr --sysconfdir=/etc && \
  make -j$(nproc) && \
  make install && \
  install git /usr/local/bin && \
  touch /etc/gitconfig && \
  git config --system init.defaultBranch master

# Install gotop
RUN git clone --depth 1 --single-branch https://github.com/sabrehagen/gotop /opt/gotop && \
  cd /opt/gotop && \
  VERSION="$(git tag -l --sort=-v:refname | sed 's/v\([^-].*\)/\1/g' | head -1 | tr -d '-' ).$(git describe --long --tags | sed 's/\([^-].*\)-\([0-9]*\)-\(g.*\)/r\2.\3/g' | tr -d '-')" && \
  DATE=$(date +%Y%m%dT%H%M%S) && \
  go build -o gotop -ldflags "-X main.Version=v$VERSION -X main.BuildDate=$DATE" ./cmd/gotop && \
  install gotop /usr/local/bin

# Install gping
RUN git clone --depth 1 --single-branch https://github.com/orf/gping /opt/gping && \
  cd /opt/gping && \
  cargo install --locked --path ./gping && \
  install target/release/gping /usr/local/bin && \
  cargo clean

# Install hints
RUN nala update && \
  nala install -y gir1.2-gtk-4.0 libcairo2-dev libdbus-1-dev libgirepository1.0-dev gcc libwnck-3-dev && \
  pipx install git+https://github.com/AlfredoSequeida/hints.git && \
  echo 'ACCESSIBILITY_ENABLED=1\nGNOME_ACCESSIBILITY=1\nGTK_MODULES=gail:atk-bridge\nQT_ACCESSIBILITY=1\nQT_LINUX_ACCESSIBILITY_ALWAYS_ON=1' >> /etc/environment

# Install i3
RUN nala update && \
  nala install -y dmenu libanyevent-perl libev-dev libpango1.0-dev libstartup-notification0-dev libxcb-cursor-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-randr0-dev libxcb-shape0-dev libxcb-util0-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-xrm0 libxcb1-dev libxkbcommon-dev libxkbcommon-x11-dev libyajl-dev meson ninja-build && \
  git clone --depth 1 --single-branch --branch next https://github.com/sabrehagen/i3 /opt/i3 && \
  cd /opt/i3 && \
  mkdir build && \
  meson setup build && \
  meson compile -C build && \
  meson install -C build && \
  cd AnyEvent-I3 && \
  perl Makefile.PL && \
  make && \
  make install

# Install i3blocks
RUN git clone --depth 1 --single-branch https://github.com/vivien/i3blocks /opt/i3blocks && \
  cd /opt/i3blocks && \
  ./autogen.sh && \
  ./configure && \
  make && \
  make install

# Install i3lock
RUN nala update && \
  nala install -y libcairo2-dev libfontconfig1-dev libgif-dev libjpeg-dev libpam0g-dev libx11-xcb-dev libxcb-composite0-dev && \
  git clone --depth 1 --single-branch https://github.com/Raymo111/i3lock-color /opt/i3lock && \
  cd /opt/i3lock && \
  sed -i 's/Num Lock//' i3lock.c && \
  sed -i 's/wrong!/auth failed/' unlock_indicator.c && \
  ./build.sh && \
  ./install-i3lock-color.sh

# Install i3 extras
RUN nala update && \
  nala install -y libgtk2.0-dev libglib2.0-dev python3-dev python3-i3ipc && \
  pipx install i3-resurrect==1.4.2 && \
  pipx install i3altlayout==1.1.1 && \
  pipx install git+https://github.com/sabrehagen/i3-workspace-names-daemon && \
  git clone --depth 1 --single-branch https://github.com/s-urbaniak/i3-focus-last $HOME/.config/i3/i3-focus-last && \
  cd $HOME/.config/i3/i3-focus-last && \
  go install && \
  git clone --depth 1 --single-branch https://github.com/dmedvinsky/gsimplecal /opt/gsimplecal && \
  cd /opt/gsimplecal && \
  ./autogen.sh && \
  ./configure --enable-gtk2 && \
  make && \
  make install

# Install i3-restore
RUN git clone --depth 1 --single-branch https://github.com/jdholtz/i3-restore.git /opt/i3-restore && \
  python3 -m pip install --break-system-packages -r /opt/i3-restore/requirements.txt

# Install jobber
RUN nala update && \
  nala install -y debhelper rsync && \
  mkdir /opt/jobber && \
  git clone --depth 1 --single-branch https://github.com/sabrehagen/jobber /opt/jobber/jobber-src && \
  cd /opt/jobber/jobber-src && \
  sed -i 's/dh-system[^,]*,//' packaging/debian/debian-pkg/control && \
  make -C packaging/debian pkg-local . && \
  make && \
  make install

# Install jump directory navigator
RUN git clone --depth 1 --single-branch https://github.com/gsamokovarov/jump /opt/jump && \
  cd /opt/jump && \
  go build -o jump && \
  install jump /usr/local/bin

# Install kdenlive
RUN nala update && \
  nala install -y frei0r-plugins kde-style-breeze kdenlive knewstuff-dialog mediainfo --no-install-recommends

# Install musikcube
RUN aria2c $ARIA2C_ARGS -o musikcube.deb https://github.com/clangen/musikcube/releases/download/3.0.5/musikcube_3.0.5_linux_x86_64.deb && \
  dpkg -i musikcube.deb && \
  rm musikcube.deb

# Install ncmpcpp
RUN nala update && \
  nala install -y libboost-all-dev libcurl4-openssl-dev libfftw3-dev libmpdclient-dev libncursesw5-dev libreadline-dev libtag1-dev && \
  git clone --depth 1 --single-branch https://github.com/ncmpcpp/ncmpcpp /opt/ncmpcpp && \
  cd /opt/ncmpcpp && \
  autoreconf -fiv && \
  ./configure --prefix=/usr --enable-outputs --enable-visualizer --enable-clock --with-fftw --with-taglib --with-lto && \
  make -j$(nproc) && \
  make install && \
  make clean

# Install nerd fonts
RUN aria2c $ARIA2C_ARGS -o DejaVuSansMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DejaVuSansMono.zip && \
  mkdir -p /usr/share/fonts/truetype/dejavu && \
  unzip -p DejaVuSansMono.zip DejaVuSansMNerdFont-Regular.ttf > /usr/share/fonts/truetype/dejavu/DejaVuSansMNerdFont-Regular.ttf && \
  rm DejaVuSansMono.zip

# Install ngrok
RUN curl -fsSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
  echo 'deb https://ngrok-agent.s3.amazonaws.com buster main' | tee /etc/apt/sources.list.d/ngrok.list && \
  nala update && \
  nala install -y ngrok

# Install tailscale
RUN curl -fsSL https://tailscale.com/install.sh | sh

# Install nicotine+
RUN nala update && \
  nala install -y devscripts equivs python3-build && \
  git clone --depth 1 --single-branch https://github.com/sabrehagen/nicotine-plus /opt/nicotine-plus/src && \
  cd /opt/nicotine-plus/src && \
  mk-build-deps --install --remove --tool 'nala install -y --no-install-recommends' debian/control && \
  python3 -m build --sdist && \
  mk-origtargz dist/nicotine*.tar.gz && \
  DEB_BUILD_OPTIONS=nocheck debuild -sa -us -uc && \
  dpkg -i ../nicotine*.deb && \
  nala purge -y devscripts equivs && \
  nala autoremove -y

# Install nodejs
RUN curl -fsSL https://nodejs.org/dist/v24.11.1/node-v24.11.1-linux-x64.tar.xz | \
  tar -C /usr/local -Jx --strip-components=1

# Install novnc
RUN git clone --depth 1 --single-branch https://github.com/cloud-computer/noVNC.git /opt/noVNC && \
  git clone --depth 1 --single-branch https://github.com/novnc/websockify /opt/noVNC/utils/websockify

# Install nvm
RUN mkdir /opt/nvm && \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | \
  NVM_DIR=/opt/nvm bash && \
  . /opt/nvm/nvm.sh && \
  nvm install 20

# Install op
RUN curl -fsSL https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg && \
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | tee /etc/apt/sources.list.d/1password.list && \
  mkdir -p /etc/debsig/policies/AC2D62742012EA22 /usr/share/debsig/keyrings/AC2D62742012EA22 && \
  curl -fsSL https://downloads.1password.com/linux/debian/debsig/1password.pol | tee /etc/debsig/policies/AC2D62742012EA22/1password.pol && \
  curl -fsSL https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg && \
  nala update && \
  nala install -y 1password-cli

# Install oxker
RUN cargo install oxker

# Install picom
RUN nala update && \
  nala install -y libconfig-dev libdbus-1-dev libegl-dev libepoxy-dev libev-dev libgl-dev libpcre3-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev && \
  git clone --depth 1 --single-branch https://github.com/yshui/picom /opt/picom && \
  cd /opt/picom && \
  meson setup --buildtype=release build && \
  ninja -C build && \
  install build/src/picom /usr/local/bin

# Install posting
RUN pipx install posting

# Install pywal
RUN pipx install pywal

# Install qjackctl
RUN nala update && \
  nala install -y libasound2-dev libjack-jackd2-dev libqt5svg5-dev portaudio19-dev qtbase5-dev qttools5-dev && \
  git clone --depth 1 --single-branch https://github.com/rncbc/qjackctl /opt/qjackctl && \
  cd /opt/qjackctl && \
  cmake -DCMAKE_BUILD_TYPE=Release -B build && \
  cmake --build build --parallel $(nproc) && \
  cmake --install build

# Install qt5ct
RUN nala update && \
  nala install -y g++ libqt5svg5-dev qt5-qmake qtbase5-dev qtbase5-dev-tools qtbase5-private-dev qttools5-dev qttools5-dev-tools && \
  git clone --depth 1 --single-branch https://github.com/sabrehagen/qt5ct /opt/qt5ct && \
  cd /opt/qt5ct && \
  cp src/qt5ct-common/qt5ct.h src/qt5ct/qt5ct.h && \
  qmake && \
  make -j$(nproc) && \
  make install

# Install qpwgraph
RUN nala update && \
  nala install -y libasound2-dev libpipewire-0.3-dev libqt6svg6-dev libspa-0.2-dev qt6-base-dev qt6-base-dev-tools qt6-tools-dev qt6-wayland && \
  git clone --depth 1 --single-branch https://github.com/rncbc/qpwgraph /opt/qpwgraph && \
  cmake -S /opt/qpwgraph -B /opt/qpwgraph/build -DCMAKE_BUILD_TYPE=Release && \
  cmake --build /opt/qpwgraph/build --parallel $(nproc) && \
  cmake --install /opt/qpwgraph/build

# Install screenpipe
RUN curl -fsSL get.screenpi.pe/cli | sh

# Install shell chatgpt
RUN pipx install shell-gpt

# Install shfmt
RUN aria2c $ARIA2C_ARGS -d /usr/local/bin -o shfmt https://github.com/mvdan/sh/releases/download/v3.12.0/shfmt_v3.12.0_linux_amd64 && \
  chmod +x /usr/local/bin/shfmt

# Install slack
RUN aria2c $ARIA2C_ARGS -o slack.deb https://downloads.slack-edge.com/desktop-releases/linux/x64/4.46.101/slack-desktop-4.46.101-amd64.deb && \
  dpkg -i slack.deb && \
  rm slack.deb

# Install speedtest
RUN pipx install speedtest-cli

# Install telegram
RUN add-apt-repository ppa:atareao/telegram && \
  nala update && \
  nala install -y telegram

# Install thorium
RUN aria2c $ARIA2C_ARGS -o thorium.deb https://github.com/Alex313031/thorium/releases/download/M138.0.7204.300/thorium-browser_138.0.7204.300_AVX2.deb && \
  dpkg -i thorium.deb && \
  rm thorium.deb

# Install thunderbird
RUN aria2c $ARIA2C_ARGS -o thunderbird.tar.xz https://download-installer.cdn.mozilla.net/pub/thunderbird/releases/148.0b3/linux-x86_64/en-US/thunderbird-148.0b3.tar.xz && \
  tar -C /opt -xJf thunderbird.tar.xz && \
  rm thunderbird.tar.xz && \
  ln -s /opt/thunderbird/thunderbird /usr/local/bin/thunderbird

# Install timeago
RUN aria2c $ARIA2C_ARGS -d /usr/local/bin -o timeago https://raw.githubusercontent.com/sabrehagen/timeago/master/timeago && \
  chmod +x /usr/local/bin/timeago

# Install tldr
RUN pipx install tldr && \
  pipx run tldr --update

# Install tmpmail
RUN aria2c $ARIA2C_ARGS -d /usr/local/bin -o tmpmail https://raw.githubusercontent.com/sdushantha/tmpmail/master/tmpmail && \
  chmod +x /usr/local/bin/tmpmail

# Install tmux
RUN nala update && \
  nala install -y libevent-dev libncurses-dev bison && \
  git clone --depth 20 --single-branch https://github.com/tmux/tmux /opt/tmux && \
  cd /opt/tmux && \
  sh autogen.sh && \
  ./configure --prefix=/usr --sysconfdir=/etc && \
  make -j$(nproc) && \
  make install && \
  make clean

# Install tormix
RUN aria2c $ARIA2C_ARGS -d /usr/local/bin -o tormix https://raw.githubusercontent.com/ckardaris/tormix/master/tormix && \
  chmod +x /usr/local/bin/tormix

# Install tracexec
RUN curl -fsSL https://github.com/kxxt/tracexec/releases/download/v0.5.2/tracexec-x86_64-unknown-linux-gnu.tar.gz | \
  tar -C /usr/local/bin -xzf - tracexec

# Install vcsh
RUN nala update && \
  nala install -y automake bash-completion && \
  git clone --depth 1 --single-branch https://github.com/sabrehagen/vcsh /opt/vcsh && \
  cd /opt/vcsh && \
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
  nala install -y inkscape optipng xfconf libegl-dev libwayland-dev && \
  git clone --depth 1 --single-branch https://github.com/reorr/warnai /opt/warnai && \
  sed -i '/notify-send/d' /opt/warnai/warnai

# Install whatfiles
RUN git clone --depth 1 --single-branch https://github.com/spieglt/whatfiles /opt/whatfiles && \
  cd /opt/whatfiles && \
  make && \
  make install

# Install xava
RUN aria2c $ARIA2C_ARGS -o xava.appimage https://github.com/nikp123/xava/releases/download/0.7.1.1/xava-x86_64.AppImage && \
  chmod +x xava.appimage && \
  ./xava.appimage --appimage-extract && \
  rm xava.appimage && \
  mv squashfs-root /opt/xava && \
  ln -sf /opt/xava/usr/bin/xava /usr/local/bin/xava && \
  ln -sf /opt/xava/usr/share/xava /usr/share/xava && \
  ln -sf /opt/xava/usr/lib/xava /usr/lib/xava && \
  mkdir -p /etc/skel/.config/xava && \
  cp -a /opt/xava/usr/share/xava/. /etc/skel/.config/xava/

# Install xcolor
RUN cargo install xcolor

# Install yarn
RUN curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo 'deb https://dl.yarnpkg.com/debian stable main' | tee /etc/apt/sources.list.d/yarn.list && \
  nala update && \
  nala install -y yarn

# Install yarn based utilities
RUN yarn global add \
  @anthropic-ai/claude-code \
  @google/gemini-cli \
  @openai/codex \
  @sourcegraph/amp \
  aicommit2 \
  clipboard-cli \
  diff-so-fancy \
  github-email \
  http-server \
  imgur-uploader-cli \
  nodemon \
  rebase-editor \
  vercel && \
  yarn cache clean

# Install zsh
RUN nala update && \
  nala install -y libncursesw5-dev libpcre2-dev yodl && \
  git clone --depth 1 --single-branch https://github.com/zsh-users/zsh /opt/zsh && \
  cd /opt/zsh && \
  ./Util/preconfig && \
  ./configure --prefix=/usr --sysconfdir=/etc && \
  make -j$(nproc) && \
  make install && \
  make clean

# Install zvm and zig
RUN curl -fsSL https://raw.githubusercontent.com/tristanisham/zvm/master/install.sh | bash -s - -- --no-env && \
  yes | $HOME/.zvm/self/zvm use 0.15.2

# Install vs code wal theme
RUN git clone --depth 1 --single-branch https://github.com/sabrehagen/vscode-wal /opt/vscode-wal && \
  yarn --cwd /opt/vscode-wal

# Configure openvpn
RUN mkdir -p $HOME/.config/openvpn && \
  mknod -m u=rw,go= $HOME/.config/openvpn/tun c 10 200

# Configure password-less sudo for the sudo group
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers

# Configure X11 permissions and touchpad tap to click
RUN sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
  echo needs_root_rights=yes >> /etc/X11/Xwrapper.config && \
  chmod u+s /usr/bin/xinit && \
  mkdir -p /etc/X11/xorg.conf.d && \
  echo 'Section "InputClass"\n Identifier "touchpad"\n MatchIsTouchpad "on"\n Driver "libinput"\n Option "Tapping" "on"\n Option "libinput Accel Speed" "0.5"\n Option "Natural Scrolling" "true"\nEndSection' > /etc/X11/xorg.conf.d/90-touchpad.conf

# Allow input group access to uinput
RUN echo 'KERNEL=="uinput", GROUP="input", MODE:="0660"' > /etc/udev/rules.d/80-hints.rules

# Create a non-root user for safe operation
RUN userdel -r ubuntu && \
  useradd \
  --create-home \
  --groups audio,docker,input,shadow,sudo,tty,video \
  --shell /usr/bin/zsh \
  $USER && \
  cp --preserve=all --recursive --update=none /etc/skel/. $HOME/

# Set non-root user password
RUN sed -i "s;^$USER:[^:]*;$USER:$DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD;" /etc/shadow

# Take ownership of user's home directory and applications
RUN chown -R $USER:$USER $HOME /opt

# Restore file ownership and file mode required for chrome-sandbox binaries
RUN find /opt -type f -name chrome-sandbox \
  -exec chown root:root {} \; \
  -exec chmod u=srwx,go=rx {} \;

# Become desktop environment user
USER $USER
WORKDIR $HOME

# Clone the desktop environment
RUN git clone https://github.com/sabrehagen/desktop-environment /opt/desktop-environment

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
ENV DESKTOP_ENVIRONMENT_CONTAINER_BUILD_DATE $DESKTOP_ENVIRONMENT_CONTAINER_BUILD_DATE
ARG DESKTOP_ENVIRONMENT_CONTAINER_GIT_SHA
ENV DESKTOP_ENVIRONMENT_CONTAINER_GIT_SHA $DESKTOP_ENVIRONMENT_CONTAINER_GIT_SHA
ARG DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME
ENV DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME $DESKTOP_ENVIRONMENT_CONTAINER_IMAGE_NAME
