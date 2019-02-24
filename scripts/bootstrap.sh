# Script is run as root to create the host user
if [ $USER != "root" ]; then
  echo "Host configuration script must be run as root!"
  exit 1
fi

REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $($REPO_ROOT/scripts/environment.sh)

# Fork setup to desktop environment global location immediately
if [ ! "$REPO_ROOT" -ef "$DESKTOP_ENVIRONMENT_REPOSITORY" ]; then

  # Clone the desktop environment to the global location on the host
  git clone https://github.com/$DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER $DESKTOP_ENVIRONMENT_REPOSITORY

  # Restart bootstrap from the global location
  $DESKTOP_ENVIRONMENT_REPOSITORY/scripts/bootstrap.sh
  exit 0
fi

# Install utilities
apt-get update -qq && \
  apt-get install -qq \
  curl \
  gosu \
  keychain \
  sudo \
  tilda \
  vcsh \
  wicd-curses \
  xclip \
  xserver-xephyr \
  zsh

# Enable password-less sudo for the sudo group
echo "%sudo ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

# Increase max open files on host
echo 'fs.file-max=1000000' >> /etc/sysctl.conf

# Increase max open file watchers on host
echo 'fs.inotify.max_user_watches=1000000' >> /etc/sysctl.conf

# Increase file descriptor limit
echo '* soft nofile 1000000' >> /etc/security/limits.conf
echo '* hard nofile 1000000' >> /etc/security/limits.conf

# Start the desktop environment as the host user on system start
echo "@reboot $HOST_USER $DESKTOP_ENVIRONMENT_REPOSITORY/scripts/start.sh" >> /etc/crontab

# Remove existing group with id 999 if it is not the docker group
getent group 999 | \
  grep -v docker | \
  cut -d: -f1 | \
  xargs groupdel

# Install docker
sh -c "$(curl -fsSL get.docker.com)" && \
  usermod -aG docker $DESKTOP_ENVIRONMENT_USER

# Install alacritty
wget -O alacritty.deb https://github.com/jwilm/alacritty/releases/download/v0.2.9/Alacritty-v0.2.9_amd64.deb && \
  dpkg -i alacritty.deb && \
  rm alacritty.deb

# Install bat
wget -O bat.deb -nv https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb && \
  dpkg -i bat.deb && \
  rm bat.deb

# Install jump directory navigator
wget -nv -O jump.deb https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb && \
  dpkg -i jump.deb && \
  rm jump.deb

# Install antigen
curl -L git.io/antigen > /usr/local/bin/antigen.zsh

# Allow docker containers to access the host's X server
xhost local:docker

# Host user configuration
HOST_USER=$DESKTOP_ENVIRONMENT_USER
HOST_USER_ID=1000
HOST_HOME=/$HOST_USER/home
HOST_REPOSITORY=/$DESKTOP_ENVIRONMENT_CONTAINER

# Make the host user directory
mkdir -p /$HOST_USER

# Create the host user group
groupadd \
  --gid $HOST_USER_ID \
  $HOST_USER

# Create the host user
useradd \
  --home-dir $HOST_HOME \
  --gid $HOST_USER_ID \
  --uid $HOST_USER_ID \
  $HOST_USER && \
  passwd $HOST_USER

# Add the host user to the docker group
usermod \
  --append \
  --groups docker,sudo \
  $HOST_USER

# Make desktop environment logs directory
mkdir $DESKTOP_ENVIRONMENT_REPOSITORY/logs

# Take ownership of all files under the user's directory
chown -R $HOST_USER:$HOST_USER /$HOST_USER

# Make gosu accessible to the host user for running desktop environment scripts
chown :$HOST_USER /usr/sbin/gosu && \
  chmod +s /usr/sbin/gosu

# Install dotfiles configuration for host user
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alacritty.git
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-autostart.git
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-git.git
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-kde.git
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-scripts.git
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-tilda.git
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-zsh.git

# Ensure the desktop environment container exists before starting
$REPO_ROOT/scripts/build.sh

# Ensure the container user has ownership of the volumes before starting
$REPO_ROOT/scripts/bootstrap-volumes.sh

# Recycle the desktop environment
$DESKTOP_ENVIRONMENT_REPOSITORY/scripts/recycle.sh
