SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -ec

STAMPS := /tmp/.stamps
APT_LOCK := /tmp/apt.lock

$(shell mkdir -p $(STAMPS))

define apt-install
flock $(APT_LOCK) bash -c 'nala update && nala install $(1)'
endef

define dpkg-install
flock $(APT_LOCK) bash -c 'dpkg -i $(1)'
endef

APPS := \
  alacritty \
  arc \
  ardour \
  asciic \
  autorandr \
  btm \
  btop \
  cbonsai \
  claude-code \
  cloudflare \
  cursor \
  discord \
  dive \
  dmenu \
  dncli \
  docker \
  dra \
  dunst \
  elecwhat \
  eza \
  fastfetch \
  fzf \
  gcsf \
  gh \
  git \
  github-actions-runner \
  gotop \
  gping \
  gsimplecal \
  hermes-agent \
  hints \
  i3 \
  i3-extras \
  i3-focus-last \
  i3blocks \
  i3lock \
  jobber \
  jump \
  kdenlive \
  musikcube \
  ncmpcpp \
  nerd-fonts \
  ngrok \
  nicotine-plus \
  nodejs \
  novnc \
  nvidia-driver \
  nviwatch \
  nvm \
  ollama \
  op \
  openclaw \
  oxker \
  pcmanfm \
  picom \
  pipewire \
  posting \
  pywal \
  qjackctl \
  qpwgraph \
  rust \
  shell-gpt \
  shfmt \
  slack \
  speedtest \
  tailscale \
  telegram \
  thorium \
  thunderbird \
  timeago \
  tldr \
  tmpmail \
  tmux \
  tormix \
  tracexec \
  uv \
  vcsh \
  vscode-wal \
  wal-chrome-extension \
  walogram \
  warnai \
  whatfiles \
  xava \
  xcolor \
  xwinwrap \
  yarn \
  yarn-utils \
  zsh \
  zvm

.PHONY: all $(APPS)
$(APPS): %: $(STAMPS)/%
all: $(APPS)

# Install alacritty
$(STAMPS)/alacritty: $(STAMPS)/rust
	$(call apt-install,libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3)
	git clone --depth 1 --single-branch https://github.com/alacritty/alacritty $$DESKTOP_ENVIRONMENT_SOURCE_ALACRITTY
	cd $$DESKTOP_ENVIRONMENT_SOURCE_ALACRITTY
	cargo build --release --no-default-features --features=x11
	install target/release/alacritty /usr/local/bin
	cargo clean
	touch $@

# Install arc
$(STAMPS)/arc:
	aria2c -d /usr/local/bin -o arc https://github.com/mholt/archiver/releases/download/v3.5.0/arc_3.5.0_linux_amd64
	chmod +x /usr/local/bin/arc
	touch $@

# Install ardour
$(STAMPS)/ardour:
	$(call apt-install,a2jmidid ardour)
	touch $@

# Install asciic
$(STAMPS)/asciic: $(STAMPS)/rust
	cargo install --git https://github.com/S0raWasTaken/bad_apple asciic
	git clone --depth 1 --single-branch https://github.com/S0raWasTaken/bapple_player $$DESKTOP_ENVIRONMENT_SOURCE_BPLAY
	cd $$DESKTOP_ENVIRONMENT_SOURCE_BPLAY
	cargo install --path .
	cargo clean
	touch $@

# Install autorandr
$(STAMPS)/autorandr: $(STAMPS)/uv
	uv tool install autorandr
	touch $@

# Install btm
$(STAMPS)/btm:
	LATEST=$$(curl -s https://api.github.com/repos/ClementTsang/bottom/releases/latest | jq -r '.tag_name')
	aria2c -o btm.deb https://github.com/ClementTsang/bottom/releases/download/$${LATEST}/bottom_$${LATEST}-1_amd64.deb
	$(call dpkg-install,btm.deb)
	rm btm.deb
	touch $@

# Install btop
$(STAMPS)/btop:
	$(call apt-install,g++-14)
	git clone --depth 1 --single-branch https://github.com/aristocratos/btop.git /opt/btop
	cd /opt/btop
	make CXX=g++-14 -j$$(nproc)
	make install
	touch $@

# Install cbonsai
$(STAMPS)/cbonsai:
	$(call apt-install,libncurses-dev)
	git clone --depth 1 --single-branch https://gitlab.com/jallbrit/cbonsai $$DESKTOP_ENVIRONMENT_SOURCE_CBONSAI
	cd $$DESKTOP_ENVIRONMENT_SOURCE_CBONSAI
	make install
	touch $@

# Install claude code
$(STAMPS)/claude-code:
	curl -fsSL https://claude.ai/install.sh | bash
	touch $@

# Install cloudflare
$(STAMPS)/cloudflare:
	aria2c -o cloudflare.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
	$(call dpkg-install,cloudflare.deb)
	rm cloudflare.deb
	touch $@

# Install cursor
$(STAMPS)/cursor:
	aria2c -o cursor.deb https://api2.cursor.sh/updates/download/golden/linux-x64-deb/cursor/2.6
	$(call dpkg-install,cursor.deb)
	rm cursor.deb
	touch $@

# Install discord
$(STAMPS)/discord:
	aria2c --header='User-Agent: Mozilla/5.0' --header='Referer: https://discord.com/' -o discord.deb 'https://discord.com/api/download?platform=linux&format=deb'
	$(call dpkg-install,discord.deb)
	rm discord.deb
	touch $@

# Install dive
$(STAMPS)/dive:
	LATEST=$$(curl -s https://api.github.com/repos/wagoodman/dive/releases/latest | jq -r '.tag_name | ltrimstr("v")')
	aria2c -o dive.deb https://github.com/wagoodman/dive/releases/download/v$${LATEST}/dive_$${LATEST}_linux_amd64.deb
	$(call dpkg-install,dive.deb)
	rm dive.deb
	touch $@

# Install dmenu
$(STAMPS)/dmenu:
	$(call apt-install,libfontconfig1-dev libfreetype-dev libx11-dev libxft-dev libxinerama-dev)
	git clone --depth 1 --single-branch https://github.com/sabrehagen/dmenu $$DESKTOP_ENVIRONMENT_SOURCE_DMENU
	cd $$DESKTOP_ENVIRONMENT_SOURCE_DMENU
	make install
	touch $@

# Install dncli
$(STAMPS)/dncli:
	$(call apt-install,qtbase5-dev)
	git clone --depth 1 --single-branch https://github.com/Nohac/dncli $$DESKTOP_ENVIRONMENT_SOURCE_DNCLI
	cd $$DESKTOP_ENVIRONMENT_SOURCE_DNCLI
	qmake
	make -j$$(nproc)
	install dncli /usr/local/bin/drag
	touch $@

# Install docker
$(STAMPS)/docker:
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu noble stable' > /etc/apt/sources.list.d/docker.list
	$(call apt-install,docker-buildx-plugin docker-ce-cli docker-compose-plugin)
	groupadd --system docker
	touch $@

# Install dra
$(STAMPS)/dra:
	LATEST=$$(curl -s https://api.github.com/repos/devmatteini/dra/releases/latest | jq -r '.tag_name')
	aria2c -o dra.deb https://github.com/devmatteini/dra/releases/download/$${LATEST}/dra_$${LATEST}-1_amd64.deb
	$(call dpkg-install,dra.deb)
	rm dra.deb
	touch $@

# Install dunst
$(STAMPS)/dunst:
	$(call apt-install,libdbus-1-dev libnotify-dev libsdl-pango-dev libxinerama-dev libxrandr-dev libxss-dev)
	git clone https://github.com/sabrehagen/dunst $$DESKTOP_ENVIRONMENT_SOURCE_DUNST
	cd $$DESKTOP_ENVIRONMENT_SOURCE_DUNST
	make WAYLAND=0 all
	make WAYLAND=0 install
	touch $@

# Install elecwhat
$(STAMPS)/elecwhat:
	LATEST=$$(curl -s https://api.github.com/repos/piec/elecwhat/releases/latest | jq -r '.tag_name | ltrimstr("v")')
	aria2c -o elecwhat.deb https://github.com/piec/elecwhat/releases/download/v$${LATEST}/elecwhat_$${LATEST}_amd64.deb
	$(call dpkg-install,elecwhat.deb)
	rm elecwhat.deb
	touch $@

# Install eza
$(STAMPS)/eza:
	curl -fsSL https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz | tar -C /usr/local/bin -xzf -
	touch $@

# Install fastfetch
$(STAMPS)/fastfetch:
	git clone https://github.com/fastfetch-cli/fastfetch $$DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH
	cmake -S $$DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH -B $$DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH/build -DCMAKE_BUILD_TYPE=Release
	cmake --build $$DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH/build --parallel $$(nproc) --target fastfetch
	install $$DESKTOP_ENVIRONMENT_SOURCE_FASTFETCH/build/fastfetch /usr/local/bin
	touch $@

# Install fzf
$(STAMPS)/fzf:
	LATEST=$$(curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | jq -r '.tag_name | ltrimstr("v")')
	curl -L https://github.com/junegunn/fzf/releases/download/v$${LATEST}/fzf-$${LATEST}-linux_amd64.tar.gz | tar -xz -C /usr/local/bin
	touch $@

# Install gcsf
$(STAMPS)/gcsf: $(STAMPS)/rust
	$(call apt-install,fuse3 libfuse-dev libssl-dev pkg-config)
	cargo install gcsf
	echo 'user_allow_other' >> /etc/fuse.conf
	chmod 644 /etc/fuse.conf
	chown root:root /etc/fuse.conf
	mkdir $$HOME/gdrive
	touch $@

# Install gh
$(STAMPS)/gh:
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
	chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
	echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main' | tee /etc/apt/sources.list.d/github-cli.list
	$(call apt-install,gh)
	touch $@

# Install git
$(STAMPS)/git:
	$(call apt-install,asciidoc docbook-xsl-ns gettext libauthen-sasl-perl libcgi-pm-perl libcurl4-openssl-dev libdbd-sqlite3-perl libemail-valid-perl liberror-perl libexpat-dev libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libpcre2-dev libsecret-1-dev libssl-dev tcl tk xmlto zlib1g-dev)
	git clone --depth 20 --single-branch https://github.com/sabrehagen/git $$DESKTOP_ENVIRONMENT_SOURCE_GIT
	cd $$DESKTOP_ENVIRONMENT_SOURCE_GIT
	make configure
	./configure --prefix=/usr --sysconfdir=/etc
	make -j$$(nproc)
	make install
	install git /usr/local/bin
	touch /etc/gitconfig
	git config --system init.defaultBranch master
	touch $@

# Install github actions runner
$(STAMPS)/github-actions-runner:
	LATEST=$$(curl -s https://api.github.com/repos/actions/runner/releases/latest | jq -r '.tag_name | ltrimstr("v")')
	mkdir $$DESKTOP_ENVIRONMENT_SOURCE_HOME/github-actions-runner
	aria2c -o actions-runner.tar.gz https://github.com/actions/runner/releases/download/v$${LATEST}/actions-runner-linux-x64-$${LATEST}.tar.gz
	tar -C $$DESKTOP_ENVIRONMENT_SOURCE_HOME/github-actions-runner -xzf actions-runner.tar.gz
	rm actions-runner.tar.gz
	touch $@

# Install gotop
$(STAMPS)/gotop:
	git clone --depth 1 --single-branch https://github.com/sabrehagen/gotop $$DESKTOP_ENVIRONMENT_SOURCE_GOTOP
	cd $$DESKTOP_ENVIRONMENT_SOURCE_GOTOP
	VERSION="$$(git tag -l --sort=-v:refname | sed 's/v\([^-].*\)/\1/g' | head -1 | tr -d '-').$$(git describe --long --tags | sed 's/\([^-].*\)-\([0-9]*\)-\(g.*\)/r\2.\3/g' | tr -d '-')"
	DATE=$$(date +%Y%m%dT%H%M%S)
	go build -o gotop -ldflags "-X main.Version=v$$VERSION -X main.BuildDate=$$DATE" ./cmd/gotop
	install gotop /usr/local/bin
	touch $@

# Install gping
$(STAMPS)/gping: $(STAMPS)/rust
	git clone --depth 1 --single-branch https://github.com/orf/gping $$DESKTOP_ENVIRONMENT_SOURCE_GPING
	cd $$DESKTOP_ENVIRONMENT_SOURCE_GPING
	cargo install --locked --path gping
	install target/release/gping /usr/local/bin
	cargo clean
	touch $@

# Install gsimplecal
$(STAMPS)/gsimplecal:
	$(call apt-install,libgtk2.0-dev libglib2.0-dev)
	git clone --depth 1 --single-branch https://github.com/dmedvinsky/gsimplecal $$DESKTOP_ENVIRONMENT_SOURCE_GSIMPLECAL
	cd $$DESKTOP_ENVIRONMENT_SOURCE_GSIMPLECAL
	./autogen.sh
	./configure --enable-gtk2
	make
	make install
	touch $@

# Install hermes-agent
$(STAMPS)/hermes-agent:
	git clone --depth 1 --single-branch https://github.com/nousresearch/hermes-agent $$DESKTOP_ENVIRONMENT_SOURCE_HERMES_AGENT
	HERMES_INSTALL_DIR=$$DESKTOP_ENVIRONMENT_SOURCE_HERMES_AGENT $$DESKTOP_ENVIRONMENT_SOURCE_HERMES_AGENT/scripts/install.sh --skip-setup
	touch $@

# Install hints
$(STAMPS)/hints: $(STAMPS)/uv
	$(call apt-install,gir1.2-gtk-4.0 libcairo2-dev libdbus-1-dev libgirepository1.0-dev gcc libwnck-3-dev)
	HINTS_EXPECTED_BIN_DIR=$$HOME/.local/bin uv tool install git+https://github.com/AlfredoSequeida/hints.git
	echo 'ACCESSIBILITY_ENABLED=1\nGNOME_ACCESSIBILITY=1\nGTK_MODULES=gail:atk-bridge\nQT_ACCESSIBILITY=1\nQT_LINUX_ACCESSIBILITY_ALWAYS_ON=1' >> /etc/environment
	touch $@

# Install i3
$(STAMPS)/i3:
	$(call apt-install,libanyevent-perl libev-dev libpango1.0-dev libstartup-notification0-dev libxcb-cursor-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-randr0-dev libxcb-shape0-dev libxcb-util0-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-xrm0 libxcb1-dev libxkbcommon-dev libxkbcommon-x11-dev libyajl-dev meson ninja-build)
	git clone --depth 1 --single-branch --branch next https://github.com/sabrehagen/i3 $$DESKTOP_ENVIRONMENT_SOURCE_I3
	cd $$DESKTOP_ENVIRONMENT_SOURCE_I3
	mkdir build
	meson setup build
	meson compile -C build
	meson install -C build
	cd AnyEvent-I3
	perl Makefile.PL
	make
	make install
	touch $@

# Install i3-extras
$(STAMPS)/i3-extras: $(STAMPS)/uv
	$(call apt-install,python3-dev python3-i3ipc)
	uv tool install i3-resurrect==1.4.2
	uv tool install i3altlayout==1.1.1
	uv tool install git+https://github.com/sabrehagen/i3-workspace-names-daemon
	touch $@

# Install i3-focus-last
$(STAMPS)/i3-focus-last:
	git clone --depth 1 --single-branch https://github.com/s-urbaniak/i3-focus-last $$HOME/.config/i3/i3-focus-last
	cd $$HOME/.config/i3/i3-focus-last
	go install
	touch $@

# Install i3blocks
$(STAMPS)/i3blocks:
	git clone --depth 1 --single-branch https://github.com/vivien/i3blocks $$DESKTOP_ENVIRONMENT_SOURCE_I3BLOCKS
	cd $$DESKTOP_ENVIRONMENT_SOURCE_I3BLOCKS
	./autogen.sh
	./configure
	make
	make install
	touch $@

# Install i3lock
$(STAMPS)/i3lock:
	$(call apt-install,libcairo2-dev libfontconfig1-dev libgif-dev libjpeg-dev libpam0g-dev libx11-xcb-dev libxcb-composite0-dev)
	git clone --depth 1 --single-branch https://github.com/sabrehagen/i3lock-color $$DESKTOP_ENVIRONMENT_SOURCE_I3LOCK
	cd $$DESKTOP_ENVIRONMENT_SOURCE_I3LOCK
	./build.sh
	./install-i3lock-color.sh
	touch $@

# Install jobber
$(STAMPS)/jobber:
	$(call apt-install,debhelper rsync)
	mkdir $$DESKTOP_ENVIRONMENT_SOURCE_JOBBER
	git clone --depth 1 --single-branch https://github.com/sabrehagen/jobber $$DESKTOP_ENVIRONMENT_SOURCE_JOBBER/jobber-src
	cd $$DESKTOP_ENVIRONMENT_SOURCE_JOBBER/jobber-src
	sed -i 's/dh-system[^,]*,//' packaging/debian/debian-pkg/control
	make -C packaging/debian pkg-local .
	make
	make install
	touch $@

# Install jump
$(STAMPS)/jump:
	git clone --depth 1 --single-branch https://github.com/gsamokovarov/jump $$DESKTOP_ENVIRONMENT_SOURCE_JUMP
	cd $$DESKTOP_ENVIRONMENT_SOURCE_JUMP
	go build -o jump
	install jump /usr/local/bin
	touch $@

# Install kdenlive
$(STAMPS)/kdenlive:
	$(call apt-install,frei0r-plugins kde-style-breeze kdenlive knewstuff-dialog mediainfo --no-install-recommends)
	touch $@

# Install musikcube
$(STAMPS)/musikcube:
	aria2c -o musikcube.deb https://github.com/clangen/musikcube/releases/download/3.0.5/musikcube_3.0.5_linux_x86_64.deb
	$(call dpkg-install,musikcube.deb)
	rm musikcube.deb
	touch $@

# Install ncmpcpp
$(STAMPS)/ncmpcpp:
	$(call apt-install,libboost-all-dev libcurl4-openssl-dev libfftw3-dev libmpdclient-dev libncursesw5-dev libreadline-dev libtag1-dev)
	git clone --depth 1 --single-branch https://github.com/ncmpcpp/ncmpcpp $$DESKTOP_ENVIRONMENT_SOURCE_NCMPCPP
	cd $$DESKTOP_ENVIRONMENT_SOURCE_NCMPCPP
	autoreconf -fiv
	./configure --prefix=/usr --enable-outputs --enable-visualizer --enable-clock --with-fftw --with-taglib --with-lto
	make -j$$(nproc)
	make install
	make clean
	touch $@

# Install nerd fonts
$(STAMPS)/nerd-fonts:
	aria2c -o DejaVuSansMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DejaVuSansMono.zip
	mkdir -p /usr/share/fonts/truetype/dejavu
	unzip -p DejaVuSansMono.zip DejaVuSansMNerdFont-Regular.ttf > /usr/share/fonts/truetype/dejavu/DejaVuSansMNerdFont-Regular.ttf
	unzip -p DejaVuSansMono.zip DejaVuSansMNerdFont-Bold.ttf > /usr/share/fonts/truetype/dejavu/DejaVuSansMNerdFont-Bold.ttf
	unzip -p DejaVuSansMono.zip DejaVuSansMNerdFont-Oblique.ttf > /usr/share/fonts/truetype/dejavu/DejaVuSansMNerdFont-Oblique.ttf
	unzip -p DejaVuSansMono.zip DejaVuSansMNerdFont-BoldOblique.ttf > /usr/share/fonts/truetype/dejavu/DejaVuSansMNerdFont-BoldOblique.ttf
	rm DejaVuSansMono.zip
	$(call apt-install,fonts-noto-core)
	touch $@

# Install ngrok
$(STAMPS)/ngrok:
	curl -fsSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
	echo 'deb https://ngrok-agent.s3.amazonaws.com buster main' | tee /etc/apt/sources.list.d/ngrok.list
	$(call apt-install,ngrok)
	touch $@

# Install nicotine+
$(STAMPS)/nicotine-plus: $(STAMPS)/uv
	$(call apt-install,devscripts equivs python3-build)
	git clone --depth 1 --single-branch https://github.com/sabrehagen/nicotine-plus $$DESKTOP_ENVIRONMENT_SOURCE_NICOTINE_PLUS/src
	cd $$DESKTOP_ENVIRONMENT_SOURCE_NICOTINE_PLUS/src
	flock $(APT_LOCK) bash -c 'mk-build-deps --install --remove --tool "nala install --no-install-recommends" debian/control'
	python3 -m build --sdist
	mk-origtargz dist/nicotine*.tar.gz
	DEB_BUILD_OPTIONS=nocheck debuild -sa -us -uc
	$(call dpkg-install,../nicotine*.deb)
	flock $(APT_LOCK) bash -c 'nala purge devscripts equivs && nala autoremove'
	touch $@

# Install nodejs
$(STAMPS)/nodejs:
	LATEST=$$(curl -s https://nodejs.org/dist/index.json | jq -r '[.[] | select(.lts != false)] | first | .version')
	curl -fsSL https://nodejs.org/dist/$${LATEST}/node-$${LATEST}-linux-x64.tar.xz | tar -C /usr/local -Jx --strip-components=1
	touch $@

# Install novnc
$(STAMPS)/novnc:
	git clone --depth 1 --single-branch https://github.com/cloud-computer/noVNC.git $$DESKTOP_ENVIRONMENT_SOURCE_NOVNC
	git clone --depth 1 --single-branch https://github.com/novnc/websockify $$DESKTOP_ENVIRONMENT_SOURCE_NOVNC/utils/websockify
	touch $@

# Install nvidia driver
$(STAMPS)/nvidia-driver:
	$(call apt-install,nvidia-driver-590)
	touch $@

# Install nviwatch
$(STAMPS)/nviwatch: $(STAMPS)/rust
	cargo install nviwatch
	touch $@

# Install nvm
$(STAMPS)/nvm:
	mkdir $$DESKTOP_ENVIRONMENT_SOURCE_HOME/nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name')/install.sh | NVM_DIR=$$DESKTOP_ENVIRONMENT_SOURCE_HOME/nvm bash
	. $$DESKTOP_ENVIRONMENT_SOURCE_HOME/nvm/nvm.sh
	nvm install 20
	touch $@

# Install ollama
$(STAMPS)/ollama:
	curl -fsSL https://ollama.com/install.sh | sh
	touch $@

# Install op
$(STAMPS)/op:
	curl -fsSL https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
	echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | tee /etc/apt/sources.list.d/1password.list
	mkdir -p /etc/debsig/policies/AC2D62742012EA22 /usr/share/debsig/keyrings/AC2D62742012EA22
	curl -fsSL https://downloads.1password.com/linux/debian/debsig/1password.pol | tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
	curl -fsSL https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
	$(call apt-install,1password-cli)
	touch $@

# Install openclaw
$(STAMPS)/openclaw:
	curl -fsSL https://openclaw.ai/install.sh | bash -s -- --no-onboard
	touch $@

# Install oxker
$(STAMPS)/oxker: $(STAMPS)/rust
	cargo install --git https://github.com/sabrehagen/oxker --branch fix/bollard-secret-to-models
	touch $@

# Install pcmanfm
$(STAMPS)/pcmanfm:
	$(call apt-install,intltool libfm-gtk3-dev libgtk-3-dev)
	git clone --depth 1 --single-branch https://github.com/lxde/pcmanfm $$DESKTOP_ENVIRONMENT_SOURCE_PCMANFM
	cd $$DESKTOP_ENVIRONMENT_SOURCE_PCMANFM
	./autogen.sh
	./configure --disable-nls --prefix=/usr --sysconfdir=/etc --with-gtk=3
	make -j$$(nproc)
	make install
	touch $@

# Install picom
$(STAMPS)/picom:
	$(call apt-install,libconfig-dev libdbus-1-dev libegl-dev libepoxy-dev libev-dev libgl-dev libpcre3-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev)
	git clone --depth 1 --single-branch https://github.com/yshui/picom $$DESKTOP_ENVIRONMENT_SOURCE_PICOM
	cd $$DESKTOP_ENVIRONMENT_SOURCE_PICOM
	meson setup --buildtype=release build
	ninja -C build
	install build/src/picom /usr/local/bin
	touch $@

# Install pipewire
$(STAMPS)/pipewire:
	$(call apt-install,pipewire pipewire-alsa pipewire-jack pipewire-pulse)
	echo /usr/lib/x86_64-linux-gnu/pipewire-0.3/jack > /etc/ld.so.conf.d/pipewire-jack.conf
	ldconfig
	touch $@

# Install posting
$(STAMPS)/posting: $(STAMPS)/uv
	uv tool install posting
	touch $@

# Install pywal
$(STAMPS)/pywal: $(STAMPS)/uv
	git clone --depth 1 --single-branch https://github.com/sabrehagen/pywal $$DESKTOP_ENVIRONMENT_SOURCE_PYWAL
	uv tool install $$DESKTOP_ENVIRONMENT_SOURCE_PYWAL
	touch $@

# Install qjackctl
$(STAMPS)/qjackctl:
	$(call apt-install,libasound2-dev libjack-jackd2-dev libqt5svg5-dev portaudio19-dev qtbase5-dev qttools5-dev)
	git clone --depth 1 --single-branch https://github.com/rncbc/qjackctl $$DESKTOP_ENVIRONMENT_SOURCE_QJACKCTL
	cd $$DESKTOP_ENVIRONMENT_SOURCE_QJACKCTL
	cmake -DCMAKE_BUILD_TYPE=Release -B build
	cmake --build build --parallel $$(nproc)
	cmake --install build
	touch $@

# Install qpwgraph
$(STAMPS)/qpwgraph:
	$(call apt-install,libasound2-dev libpipewire-0.3-dev libqt6svg6-dev libspa-0.2-dev qt6-base-dev qt6-base-dev-tools qt6-tools-dev qt6-wayland)
	git clone --depth 1 --single-branch https://github.com/rncbc/qpwgraph $$DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH
	cmake -S $$DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH -B $$DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH/build -DCMAKE_BUILD_TYPE=Release
	cmake --build $$DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH/build --parallel $$(nproc)
	cmake --install $$DESKTOP_ENVIRONMENT_SOURCE_QPWGRAPH/build
	touch $@

# Install rust
$(STAMPS)/rust:
	curl -fsSL https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly --no-modify-path --profile minimal
	ln -s $$HOME/.cargo/bin/cargo /usr/local/bin
	ln -s $$HOME/.cargo/bin/rustup /usr/local/bin
	touch $@

# Install shell-gpt
$(STAMPS)/shell-gpt: $(STAMPS)/uv
	uv tool install shell-gpt
	touch $@

# Install shfmt
$(STAMPS)/shfmt:
	LATEST=$$(curl -s https://api.github.com/repos/mvdan/sh/releases/latest | jq -r '.tag_name')
	aria2c -d /usr/local/bin -o shfmt https://github.com/mvdan/sh/releases/download/$${LATEST}/shfmt_$${LATEST}_linux_amd64
	chmod +x /usr/local/bin/shfmt
	touch $@

# Install slack
$(STAMPS)/slack:
	aria2c -o slack.deb https://downloads.slack-edge.com/desktop-releases/linux/x64/4.46.101/slack-desktop-4.46.101-amd64.deb
	$(call dpkg-install,slack.deb)
	rm slack.deb
	touch $@

# Install speedtest
$(STAMPS)/speedtest: $(STAMPS)/uv
	uv tool install speedtest-cli
	touch $@

# Install tailscale
$(STAMPS)/tailscale:
	curl -fsSL https://tailscale.com/install.sh | sh
	$(call apt-install,--purge resolvconf)
	touch $@

# Install telegram
$(STAMPS)/telegram:
	flock $(APT_LOCK) bash -c 'add-apt-repository ppa:atareao/telegram && nala update && nala install telegram'
	touch $@

# Install thorium
$(STAMPS)/thorium:
	LATEST=$$(curl -s https://api.github.com/repos/Alex313031/thorium/releases/latest | jq -r '.tag_name | ltrimstr("M")')
	aria2c -o thorium.deb https://github.com/Alex313031/thorium/releases/download/M$${LATEST}/thorium-browser_$${LATEST}_AVX2.deb
	$(call dpkg-install,thorium.deb)
	rm thorium.deb
	touch $@

# Install thunderbird
$(STAMPS)/thunderbird:
	aria2c -o thunderbird.tar.xz https://download-installer.cdn.mozilla.net/pub/thunderbird/releases/148.0b3/linux-x86_64/en-US/thunderbird-148.0b3.tar.xz
	tar -C $$DESKTOP_ENVIRONMENT_SOURCE_HOME -xJf thunderbird.tar.xz
	rm thunderbird.tar.xz
	ln -s $$DESKTOP_ENVIRONMENT_SOURCE_HOME/thunderbird/thunderbird /usr/local/bin/thunderbird
	touch $@

# Install timeago
$(STAMPS)/timeago:
	aria2c -d /usr/local/bin -o timeago https://raw.githubusercontent.com/sabrehagen/timeago/master/timeago
	chmod +x /usr/local/bin/timeago
	touch $@

# Install tldr
$(STAMPS)/tldr: $(STAMPS)/uv
	uv tool install tldr
	uv tool run tldr --update
	touch $@

# Install tmpmail
$(STAMPS)/tmpmail:
	aria2c -d /usr/local/bin -o tmpmail https://raw.githubusercontent.com/sdushantha/tmpmail/master/tmpmail
	chmod +x /usr/local/bin/tmpmail
	touch $@

# Install tmux
$(STAMPS)/tmux:
	$(call apt-install,libevent-dev libncurses-dev bison)
	git clone --depth 20 --single-branch https://github.com/sabrehagen/tmux $$DESKTOP_ENVIRONMENT_SOURCE_TMUX
	cd $$DESKTOP_ENVIRONMENT_SOURCE_TMUX
	sh autogen.sh
	./configure --prefix=/usr --sysconfdir=/etc
	make -j$$(nproc)
	make install
	make clean
	touch $@

# Install tormix
$(STAMPS)/tormix:
	aria2c -d /usr/local/bin -o tormix https://raw.githubusercontent.com/ckardaris/tormix/master/tormix
	chmod +x /usr/local/bin/tormix
	touch $@

# Install tracexec
$(STAMPS)/tracexec:
	curl -fsSL https://github.com/kxxt/tracexec/releases/latest/download/tracexec-x86_64-unknown-linux-gnu.tar.gz | tar -C /usr/local/bin -xzf - tracexec
	touch $@

# Install uv
$(STAMPS)/uv:
	curl -LsSf https://astral.sh/uv/install.sh | sh
	touch $@

# Install vcsh
$(STAMPS)/vcsh:
	$(call apt-install,automake ronn)
	git clone --depth 1 --single-branch https://github.com/sabrehagen/vcsh $$DESKTOP_ENVIRONMENT_SOURCE_VCSH
	cd $$DESKTOP_ENVIRONMENT_SOURCE_VCSH
	./bootstrap.sh
	./configure \
	  --prefix=/usr \
	  --sysconfdir=/etc \
	  --disable-tests \
	  --with-man-page=yes \
	  --with-zsh-completion-dir=/usr/share/zsh/vendor-completions
	make -j$$(nproc)
	make install
	make clean
	touch $@

# Install vscode-wal
$(STAMPS)/vscode-wal: $(STAMPS)/yarn
	git clone --depth 1 --single-branch https://github.com/sabrehagen/vscode-wal $$DESKTOP_ENVIRONMENT_SOURCE_VSCODE_WAL
	yarn --cwd $$DESKTOP_ENVIRONMENT_SOURCE_VSCODE_WAL
	touch $@

# Install wal chrome extension
$(STAMPS)/wal-chrome-extension:
	git clone --depth 1 --single-branch https://github.com/sabrehagen/wal-chrome-extension $$DESKTOP_ENVIRONMENT_SOURCE_WAL_CHROME_EXTENSION
	touch $@

# Install walogram
$(STAMPS)/walogram:
	git clone --depth 1 --single-branch https://github.com/sabrehagen/walogram $$DESKTOP_ENVIRONMENT_SOURCE_WALOGRAM
	cd $$DESKTOP_ENVIRONMENT_SOURCE_WALOGRAM
	make install
	touch $@

# Install warnai
$(STAMPS)/warnai:
	$(call apt-install,inkscape optipng xfconf libegl-dev libwayland-dev)
	git clone --depth 1 --single-branch https://github.com/sabrehagen/warnai $$DESKTOP_ENVIRONMENT_SOURCE_WARNAI
	ln -s $$DESKTOP_ENVIRONMENT_SOURCE_WARNAI/warnai /usr/local/bin
	touch $@

# Install whatfiles
$(STAMPS)/whatfiles:
	git clone --depth 1 --single-branch https://github.com/spieglt/whatfiles $$DESKTOP_ENVIRONMENT_SOURCE_WHATFILES
	cd $$DESKTOP_ENVIRONMENT_SOURCE_WHATFILES
	make
	make install
	touch $@

# Install xava
$(STAMPS)/xava:
	LATEST=$$(curl -s https://api.github.com/repos/nikp123/xava/releases | jq -r '[.[] | select(any(.assets[]; .name == "xava-x86_64.AppImage"))][0].tag_name')
	aria2c -o xava.appimage https://github.com/nikp123/xava/releases/download/$${LATEST}/xava-x86_64.AppImage
	chmod +x xava.appimage
	./xava.appimage --appimage-extract
	rm xava.appimage
	mv squashfs-root $$DESKTOP_ENVIRONMENT_SOURCE_HOME/xava
	ln -sf $$DESKTOP_ENVIRONMENT_SOURCE_HOME/xava/usr/bin/xava /usr/local/bin/xava
	ln -sf $$DESKTOP_ENVIRONMENT_SOURCE_HOME/xava/usr/share/xava /usr/share/xava
	ln -sf $$DESKTOP_ENVIRONMENT_SOURCE_HOME/xava/usr/lib/xava /usr/lib/xava
	mkdir -p /etc/skel/.config/xava
	cp -a $$DESKTOP_ENVIRONMENT_SOURCE_HOME/xava/usr/share/xava/. /etc/skel/.config/xava/
	touch $@

# Install xcolor
$(STAMPS)/xcolor: $(STAMPS)/rust
	cargo install xcolor
	touch $@

# Install xwinwrap
$(STAMPS)/xwinwrap:
	$(call apt-install,libx11-dev libxext-dev libxrender-dev x11proto-xext-dev xorg-dev)
	git clone --depth 1 --single-branch https://github.com/sabrehagen/xwinwrap.git $$DESKTOP_ENVIRONMENT_SOURCE_XWINWRAP
	cd $$DESKTOP_ENVIRONMENT_SOURCE_XWINWRAP
	make
	make install
	touch $@

# Install yarn
$(STAMPS)/yarn: $(STAMPS)/nodejs
	curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
	echo 'deb https://dl.yarnpkg.com/debian stable main' | tee /etc/apt/sources.list.d/yarn.list
	$(call apt-install,yarn)
	touch $@

# Install yarn utilities
$(STAMPS)/yarn-utils: $(STAMPS)/yarn
	yarn global add \
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
	  vercel
	yarn cache clean
	touch $@

# Install zsh
$(STAMPS)/zsh:
	$(call apt-install,libncursesw5-dev libpcre2-dev yodl)
	git clone --depth 1 --single-branch https://github.com/zsh-users/zsh $$DESKTOP_ENVIRONMENT_SOURCE_ZSH
	cd $$DESKTOP_ENVIRONMENT_SOURCE_ZSH
	./Util/preconfig
	./configure --prefix=/usr --sysconfdir=/etc
	make -j$$(nproc)
	make install
	make clean
	touch $@

# Install zvm and zig
$(STAMPS)/zvm:
	curl -fsSL https://raw.githubusercontent.com/tristanisham/zvm/master/install.sh | bash -s - -- --no-env
	yes | $$HOME/.zvm/self/zvm use 0.15.2
	touch $@
