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

# Restore minimized distribution content e.g. man pages
RUN apt-get update -qq && \
  apt-get install -qq \
  unminimize && \
  yes | unminimize

# Install locales and timezone data
RUN apt-get update -qq && \
  apt-get install -qq \
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
RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing \
  acpi \
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
  feh \
  ffmpeg \
  figlet \
  fonts-font-awesome \
  fonts-noto-color-emoji \
  g++ \
  gcc \
  gimp \
  git \
  golang-go \
  grc \
  gtk-theme-switch \
  gtk+3.0 \
  htop \
  iftop \
  imv \
  initramfs-tools \
  iputils-ping \
  jq \
  keychain \
  ksnip \
  libappindicator3-dev \
  libnotify-bin \
  libnss3-tools \
  libssl-dev \
  libterm-readkey-perl \
  lsb-release \
  maim \
  make \
  man-db \
  mpd \
  mpv \
  nano \
  ncdu \
  ncmpcpp \
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
  pipx \
  pkg-config \
  pulseaudio \
  pulseaudio-module-zeroconf \
  pulsemixer \
  python3 \
  python3-pip \
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
  tmux \
  transmission-cli \
  transmission-common \
  transmission-daemon \
  tree \
  unclutter-xfixes \
  vcsh \
  vim \
  wdiff \
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
  zathura \
  zsh && \
  apt-file update

# If the CACHEBUST_APPS build arg is supplied, rebuild from apps onwards
ARG CACHEBUST_APPS
RUN echo 'Building from apps onwards...'

# Install rust
RUN apt-get update -qq && \
  curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly --no-modify-path --profile minimal && \
  ln -s $HOME/.cargo/bin/cargo /usr/local/bin && \
  ln -s $HOME/.cargo/bin/rustup /usr/local/bin && \
  rustup install 1.79.0

# Install aider
RUN pipx install aider-chat

# Install alacritty
RUN apt-get install -qq libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 && \
  git clone --depth 1 https://github.com/sabrehagen/alacritty /opt/alacritty && \
  cd /opt/alacritty && \
  cargo build --release --no-default-features --features=x11 && \
  install target/release/alacritty /usr/local/bin && \
  cargo clean

# Install arc
RUN curl -fsSL -o /usr/local/bin/arc https://github.com/mholt/archiver/releases/download/v3.5.0/arc_3.5.0_linux_amd64 && \
  chmod +x /usr/local/bin/arc

# Install aws cli
RUN curl -fsSL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip && \
  unzip awscliv2.zip && \
  ./aws/install && \
  rm -rf aws awscliv2.zip

# Install bandwhich
RUN curl -fsSL https://github.com/imsnif/bandwhich/releases/download/0.20.0/bandwhich-v0.20.0-x86_64-unknown-linux-musl.tar.gz | \
  tar -C /usr/local/bin -xzf - bandwhich

# Install beekeeper studio
RUN curl -fsSL -o beekeeper-studio.deb https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v3.7.10/beekeeper-studio_3.7.10_amd64.deb && \
  dpkg -i beekeeper-studio.deb && \
  rm beekeeper-studio.deb

# Install bottom
RUN curl -fsSL -o bottom.deb https://github.com/ClementTsang/bottom/releases/download/0.10.2/bottom_0.10.2-1_amd64.deb && \
  dpkg -i bottom.deb && \
  rm bottom.deb

# Install cbonsai
RUN apt-get update -qq && \
  apt-get install -qq libncurses-dev && \
  git clone --depth 1 https://gitlab.com/jallbrit/cbonsai /opt/cbonsai && \
  cd /opt/cbonsai && \
  make install

# Install cursor
RUN curl -fsSL -o cursor.appimage https://downloads.cursor.com/production/61e99179e4080fecf9d8b92c6e2e3e00fbfb53f4/linux/x64/Cursor-0.48.9-x86_64.AppImage && \
  chmod +x cursor.appimage && \
  ./cursor.appimage --appimage-extract && \
  mv squashfs-root /opt/cursor && \
  ln -s /opt/cursor/usr/bin/cursor /usr/local/bin && \
  ln -s /opt/cursor/cursor.desktop /usr/share/applications && \
  sed -iE 's;Exec=.*;Exec=/usr/local/bin/cursor;' /opt/cursor/cursor.desktop && \
  rm cursor.appimage

# Install discord
RUN curl -fsSL -o discord.deb 'https://discordapp.com/api/download?platform=linux&format=deb' && \
  dpkg -i discord.deb || apt-get install -qq --fix-broken && \
  rm discord.deb

# Install dive docker image explorer
RUN curl -fsSL -o dive.deb https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb && \
  dpkg -i dive.deb && \
  rm dive.deb

# Install docker-compose
RUN curl -fsSL "https://github.com/docker/compose/releases/download/v2.27.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

# Install dra
RUN curl -fsSL -o dra.deb https://github.com/devmatteini/dra/releases/download/0.6.2/dra_0.6.2-1_amd64.deb && \
  dpkg -i dra.deb && \
  rm dra.deb

# Install dunst
RUN apt-get update -qq && \
  apt-get install -qq libdbus-1-dev libnotify-dev libsdl-pango-dev libxinerama-dev libxrandr-dev libxss-dev && \
  git clone https://github.com/sabrehagen/dunst /opt/dunst && \
  cd /opt/dunst && \
  make WAYLAND=0 all && \
  make WAYLAND=0 install

# Install eza
RUN curl -fsSL https://github.com/eza-community/eza/releases/download/v0.20.2/eza_x86_64-unknown-linux-gnu.tar.gz | \
  tar -C /usr/local/bin -xzf -

# Install fastfetch
RUN git clone https://github.com/fastfetch-cli/fastfetch /opt/fastfetch && \
  cd /opt/fastfetch && \
  mkdir build && \
  cd build && \
  cmake .. && \
  cmake --build . --target fastfetch --target flashfetch && \
  install fastfetch /usr/local/bin

# Install fzf
RUN curl -fsSL https://github.com/junegunn/fzf/releases/download/v0.55.0/fzf-0.55.0-linux_amd64.tar.gz | \
  tar -C /usr/local/bin -xzf - fzf

# Install gh
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
  chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main' | tee /etc/apt/sources.list.d/github-cli.list && \
  apt-get update -qq && \
  apt-get install -qq gh

# Install gotop
RUN git clone --depth 1 https://github.com/xxxserxxx/gotop /opt/gotop && \
  cd /opt/gotop && \
  VERSION="$(git tag -l --sort=-v:refname | sed 's/v\([^-].*\)/\1/g' | head -1 | tr -d '-' ).$(git describe --long --tags | sed 's/\([^-].*\)-\([0-9]*\)-\(g.*\)/r\2.\3/g' | tr -d '-')" && \
  DATE=$(date +%Y%m%dT%H%M%S) && \
  go build -o gotop -ldflags "-X main.Version=v$VERSION -X main.BuildDate=$DATE" ./cmd/gotop && \
  install gotop /usr/local/bin

# Install gping
RUN git clone --depth 1 https://github.com/orf/gping /opt/gping && \
  cd /opt/gping && \
  cargo install --locked --path ./gping && \
  install target/release/gping /usr/local/bin && \
  cargo clean

# Install i3
RUN apt-get update -qq && \
  apt-get install -qq dmenu libev-dev libpango1.0-dev libstartup-notification0-dev libxcb-cursor-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-randr0-dev libxcb-shape0-dev libxcb-util0-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-xrm0 libxcb1-dev libxkbcommon-dev libxkbcommon-x11-dev libyajl-dev meson ninja-build && \
  git clone --depth 1 https://github.com/i3/i3 /opt/i3 && \
  cd /opt/i3 && \
  mkdir build && \
  meson setup build && \
  meson compile -C build && \
  meson install -C build

# Install i3blocks
RUN git clone --depth 1 https://github.com/vivien/i3blocks /opt/i3blocks && \
  cd /opt/i3blocks && \
  ./autogen.sh && \
  ./configure && \
  make && \
  make install

# Install i3lock
RUN apt-get update -qq && \
  apt-get install -qq libcairo2-dev libfontconfig1-dev libgif-dev libjpeg-dev libpam0g-dev libx11-xcb-dev libxcb-composite0-dev && \
  git clone --depth 1 https://github.com/Raymo111/i3lock-color /opt/i3lock && \
  cd /opt/i3lock && \
  sed -i 's/Num Lock//' i3lock.c && \
  sed -i 's/wrong!/auth failed/' unlock_indicator.c && \
  ./build.sh && \
  ./install-i3lock-color.sh

# Install i3 extras
RUN apt-get update -qq && \
  apt-get install -qq libgtk2.0-dev libglib2.0-dev python3-dev python3-i3ipc && \
  pipx install i3-resurrect==1.4.2 && \
  pipx install i3altlayout==1.1.1 && \
  pipx install i3-workspace-names-daemon && \
  sed -i s/'?'/''/ $(find "$(pipx environment --value PIPX_LOCAL_VENVS)/i3-workspace-names-daemon" -name i3_workspace_names_daemon.py) && \
  git clone --depth 1 https://github.com/s-urbaniak/i3-focus-last $HOME/.config/i3/i3-focus-last && \
  cd $HOME/.config/i3/i3-focus-last && \
  go install && \
  git clone --depth 1 https://github.com/dmedvinsky/gsimplecal /opt/gsimplecal && \
  cd /opt/gsimplecal && \
  ./autogen.sh && \
  ./configure --enable-gtk2 && \
  make && \
  make install

# Install jobber
RUN apt-get update -qq && \
  apt-get install -qq debhelper rsync && \
  mkdir /opt/jobber && \
  git clone --depth 1 https://github.com/dshearer/jobber /opt/jobber/jobber-src && \
  cd /opt/jobber/jobber-src && \
  sed -i 's/dh-system[^,]*,//' packaging/debian/debian-pkg/control && \
  make -C packaging/debian pkg-local . && \
  make && \
  make install

# Install jump directory navigator
RUN git clone --depth 10 https://github.com/gsamokovarov/jump /opt/jump && \
  cd /opt/jump && \
  git checkout fe4f4be && \
  go build -o jump && \
  install jump /usr/local/bin

# Install kdenlive
RUN apt-get update -qq && \
  apt-get install -qq frei0r-plugins kde-style-breeze kdenlive knewstuff-dialog mediainfo --no-install-recommends

# Install lazyvim
RUN git clone --depth 1 https://github.com/LazyVim/starter $HOME/.config/nvim && \
  rm -rf $HOME/.config/nvim/.git && \
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')_Linux_x86_64.tar.gz" && \
  tar xf lazygit.tar.gz lazygit && \
  install lazygit /usr/local/bin && \
  rm lazygit lazygit.tar.gz

# Install musikcube
RUN wget -O musikcube.deb -nv https://github.com/clangen/musikcube/releases/download/3.0.4/musikcube_3.0.4_linux_x86_64.deb && \
  dpkg -i musikcube.deb || apt-get install -qq --fix-broken && \
  rm musikcube.deb

# Install nerd fonts
RUN curl -fsSL -o DejaVuSansMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DejaVuSansMono.zip && \
  unzip -p DejaVuSansMono.zip DejaVuSansMNerdFont-Regular.ttf > /usr/share/fonts/truetype/dejavu/DejaVuSansMNerdFont-Regular.ttf && \
  rm DejaVuSansMono.zip

# Install ngrok
RUN curl -fsSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
  echo 'deb https://ngrok-agent.s3.amazonaws.com buster main' | tee /etc/apt/sources.list.d/ngrok.list && \
  apt-get update -qq && \
  apt-get install -qq ngrok

# Install nodejs
RUN curl -fsSL https://nodejs.org/dist/v23.11.0/node-v23.11.0-linux-x64.tar.xz | \
  tar -C /usr/local -Jx --strip-components=1

# Install novnc
RUN git clone --depth 1 https://github.com/cloud-computer/noVNC.git /opt/noVNC && \
  git clone --depth 1 https://github.com/novnc/websockify /opt/noVNC/utils/websockify

# Install nvidia driver
# RUN apt-get update -qq && \
#   apt-get install linux-headers-$(uname -r) && \
#   curl -fsSL -o nvidia-driver.run https://us.download.nvidia.com/XFree86/Linux-x86_64/565.77/NVIDIA-Linux-x86_64-565.77.run && \
#   chmod +x nvidia-driver.run && \
#   ./nvidia-driver.run --allow-installation-with-running-driver --silent && \
#   rm nviia-driver.run

# Install nvidia driver
# RUN apt-get update -qq && \
#   apt-get install -qq \
#   nvidia-cuda-toolkit

# Install nvm
RUN mkdir /opt/nvm && \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | \
  NVM_DIR=/opt/nvm bash && \
  . /opt/nvm/nvm.sh && \
  nvm install 20

# Install obsidian
RUN curl -fsSL -o obsidian.deb https://github.com/obsidianmd/obsidian-releases/releases/download/v1.7.7/obsidian_1.7.7_amd64.deb && \
  dpkg -i obsidian.deb && \
  rm obsidian.deb

# Install op
RUN curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg && \
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | tee /etc/apt/sources.list.d/1password.list && \
  mkdir -p /etc/debsig/policies/AC2D62742012EA22 /usr/share/debsig/keyrings/AC2D62742012EA22 && \
  curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | tee /etc/debsig/policies/AC2D62742012EA22/1password.pol && \
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg && \
  apt-get update -qq && \
  apt-get install -qq 1password-cli

# Install oxker
RUN cargo install oxker

# Install picom
RUN apt-get update -qq && \
  apt-get install -qq libconfig-dev libdbus-1-dev libegl-dev libepoxy-dev libev-dev libgl-dev libpcre3-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev && \
  git clone --depth 1 https://github.com/yshui/picom /opt/picom && \
  cd /opt/picom && \
  meson setup --buildtype=release build && \
  ninja -C build && \
  install build/src/picom /usr/local/bin

# Install posting
RUN pipx install posting

# Install pywal
RUN pipx install pywal

# Install screenpipe
# RUN apt-get update -qq && \
#   apt-get install -qq libasound2-dev libavdevice-dev libavfilter-dev libavformat-dev libclang-16-dev libtesseract-dev tesseract-ocr libxdo-dev libxtst-dev && \
#   git clone --depth 1 https://github.com/mediar-ai/screenpipe /opt/screenpipe && \
#   cd /opt/screenpipe && \
#   cargo build --release && \
#   install target/release/screenpipe /usr/local/bin

# Install screenpipe ui
# RUN apt-get update -qq && \
#   apt-get install -qq libappindicator3-dev && \
#   cd /opt/screenpipe/screenpipe-app-tauri && \
#   npm install bun && \
#   npx bun install && \
#   npx bun scripts/pre_build.js >/dev/null && \
#   PATH=$HOME/.cargo/bin:$PATH npx bun tauri build || true

# Install shell chatgpt
RUN pipx install shell-gpt

# Install slack
RUN curl -fsSL -o slack.deb https://downloads.slack-edge.com/desktop-releases/linux/x64/4.38.125/slack-desktop-4.38.125-amd64.deb && \
  dpkg -i slack.deb && \
  rm slack.deb

# Install speedtest
RUN pipx install speedtest-cli

# Install telegram
RUN add-apt-repository ppa:atareao/telegram && \
  apt-get update -qq && \
  apt-get install -qq telegram

# Install terraform
RUN curl -fsSL -o terraform.zip https://releases.hashicorp.com/terraform/1.1.0/terraform_1.1.0_linux_amd64.zip && \
  unzip terraform.zip && \
  install terraform /usr/local/bin && \
  rm terraform terraform.zip

# Install thorium
RUN echo 'deb [trusted=yes arch=amd64] https://dl.thorium.rocks/debian/ stable main' | tee /etc/apt/sources.list.d/thorium.list && \
  apt-get update -qq && \
  apt-get install -qq thorium-browser

# Install timeago
RUN curl -fsSL -o /usr/local/bin/timeago https://raw.githubusercontent.com/sabrehagen/timeago/master/timeago && \
  chmod +x /usr/local/bin/timeago

# Install tldr
RUN pipx install tldr && \
  pipx run tldr --update

# Install tmpmail
RUN curl -fsSL -o /usr/local/bin/tmpmail https://raw.githubusercontent.com/sdushantha/tmpmail/master/tmpmail && \
  chmod +x /usr/local/bin/tmpmail

# Install tormix
RUN curl -fsSL -o /usr/local/bin/tormix https://raw.githubusercontent.com/ckardaris/tormix/master/tormix && \
  chmod +x /usr/local/bin/tormix

# Install tracexec
RUN curl -fsSL https://github.com/kxxt/tracexec/releases/download/v0.5.2/tracexec-x86_64-unknown-linux-gnu.tar.gz | \
  tar -C /usr/local/bin -xzf - tracexec

# Install trippy
RUN cargo install trippy --locked

# Install vs code, vs live share dependencies, shfmt extension dependency, and vs-wal
RUN curl -fsSL -o code.deb https://go.microsoft.com/fwlink/?LinkID=760868 && \
  apt-get install -qq ./code.deb && \
  rm code.deb && \
  apt-get install -qq libicu[0-9][0-9] libkrb5-3 zlib1g libsecret-1-0 desktop-file-utils x11-utils && \
  curl -fsSL -o /usr/local/bin/shfmt https://github.com/mvdan/sh/releases/download/v3.2.0/shfmt_v3.2.0_linux_amd64 && \
  chmod +x /usr/local/bin/shfmt

# Install warnai
RUN apt-get update -qq && \
  apt-get install -qq inkscape optipng xfconf libegl-dev libwayland-dev && \
  git clone --depth 1 https://github.com/reorr/warnai /opt/warnai && \
  sed -i '/notify-send/d' /opt/warnai/warnai

# Install whatfiles
RUN git clone --depth 1 https://github.com/spieglt/whatfiles /opt/whatfiles && \
  cd /opt/whatfiles && \
  make && \
  make install

# Install windsurf
RUN curl -fsSL https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg | gpg --dearmor -o /usr/share/keyrings/windsurf-stable-archive-keyring.gpg && \
  echo 'deb [signed-by=/usr/share/keyrings/windsurf-stable-archive-keyring.gpg arch=amd64] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main' | tee /etc/apt/sources.list.d/windsurf.list > /dev/null && \
  apt-get update -qq && \
  apt-get install -qq windsurf

# Install xava
# RUN apt-get update -qq && \
#   apt-get install -qq libasound2-dev libcairo2-dev libfftw3-dev libglew-dev libiniparser1 libpipewire-0.3-dev libpulse-dev librsvg2-bin libsdl2-dev portaudio19-dev && \
#   wget -qnv -O imagemagick.appimage https://download.imagemagick.org/ImageMagick/download/binaries/magick && \
#   chmod +x imagemagick.appimage && \
#   ./imagemagick.appimage --appimage-extract && \
#   cp -r squashfs-root/usr/* /usr/local && \
#   git clone --depth 1 https://github.com/nikp123/xava && \
#   mkdir xava/build && \
#   cd xava/build && \
#   cmake .. -DCMAKE_BUILD_TYPE=Debug -DINCLUDE_DIRS=lib/iniparser/src -DCMAKE_INSTALL_PREFIX=/usr -DWAYLAND=OFF && \
#   make -j$(nproc) && \
#   make install && \
#   cp /usr/lib/xava/out_x11_cairo.so /usr/lib/xava/out_x11_opengl.so

# Install xcolor
RUN cargo install xcolor

# Install yarn
RUN curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo 'deb https://dl.yarnpkg.com/debian stable main' | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && \
  apt-get install -qq yarn

# Install yarn based utilities
RUN yarn global add \
  @anthropic-ai/claude-code \
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
  vercel

# Install vs code wal theme
RUN git clone --depth 1 https://github.com/sabrehagen/vscode-wal /opt/vscode-wal && \
  yarn --cwd /opt/vscode-wal

# Configure openvpn
RUN mkdir -p $HOME/.config/openvpn && \
  mknod $HOME/.config/openvpn/tun c 10 200 && \
  chmod 600 $HOME/.config/openvpn/tun

# Configure password-less sudo for the sudo group
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers

# Configure X11 permissions and touchpad tap to click
RUN sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
  echo needs_root_rights=yes >> /etc/X11/Xwrapper.config && \
  chmod u+s /usr/bin/xinit && \
  mkdir -p /etc/X11/xorg.conf.d && \
  echo 'Section "InputClass"\n Identifier "touchpad"\n MatchIsTouchpad "on"\n Driver "libinput"\n Option "Tapping" "on"\n Option "libinput Accel Speed" "0.5"\nEndSection' > /etc/X11/xorg.conf.d/90-touchpad.conf

# Create a non-root user for safe operation
RUN userdel -r ubuntu && \
  useradd \
  --create-home \
  --groups audio,docker,input,pulse-access,shadow,sudo,tty,video \
  --shell /bin/zsh \
  $USER

# Set non-root user password
RUN sed -i "s;^$USER:[^:]*;$USER:$DESKTOP_ENVIRONMENT_HOST_USER_PASSWORD;" /etc/shadow

# Take ownership of user's home directory and applications
RUN chown -R $USER:$USER $HOME /opt

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
