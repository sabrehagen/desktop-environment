# Script is run as root to create the host user
if [ $USER != "root" ]; then
  echo "Host configuration script must be run as root!"
  exit 1
fi

REPO_ROOT=$(dirname $(readlink -f $0))/..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

# Conventional docker group id
DOCKER_GID=999

# Remove existing group with docker group id
getent group $DOCKER_GID | sed 's;:.*;;' | xargs groupdel --force

# Install utilities
apt-get update -qq && \
  apt-get install -qq \
  curl \
  docker.io \
  gosu \
  keychain \
  sudo \
  tilda \
  vcsh \
  wicd-curses \
  xclip \
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

# Install alacritty
wget -nv -O alacritty.deb https://github.com/jwilm/alacritty/releases/download/v0.2.9/Alacritty-v0.2.9_amd64.deb && \
  dpkg -i alacritty.deb && \
  rm alacritty.deb

# Install bat
wget -nv -O bat.deb -nv https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb && \
  dpkg -i bat.deb && \
  rm bat.deb

# Install jump directory navigator
wget -nv -O jump.deb https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb && \
  dpkg -i jump.deb && \
  rm jump.deb

# Install antigen
curl -sSL git.io/antigen > /usr/local/bin/antigen.zsh

# Allow docker containers to access the host's X server
xhost local:docker

# Host user configuration
HOST_USER=$DESKTOP_ENVIRONMENT_USER
HOST_USER_ID=1000
HOST_REPOSITORY=/$DESKTOP_ENVIRONMENT_CONTAINER

# Remove existing user with host user id
userdel --force $(getent passwd $HOST_USER_ID | cut -d : -f 1)

# Create the host user
useradd \
  --gid $HOST_USER_ID \
  --uid $HOST_USER_ID \
  $HOST_USER

# Give the host user access to required tools
usermod \
  --append \
  --groups docker,sudo \
  $HOST_USER

# Install dotfiles configuration for host user
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-alacritty.git
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-autostart.git
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-git.git
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-kde.git
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-scripts.git
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-tilda.git
gosu $HOST_USER vcsh clone https://sabrehagen@github.com/sabrehagen/dotfiles-zsh.git

# Pre-cache development environment container
docker pull --quiet $DESKTOP_ENVIRONMENT_REPOSITORY/$DESKTOP_ENVIRONMENT_CONTAINER_NAME:$DESKTOP_ENVIRONMENT_BRANCH

# Pre-cache development environment support container
docker pull --quiet jare/x11-bridge:latest

# Clone the desktop environment into a local docker volume
$REPO_ROOT/docker/scripts/clone.sh

# Ensure the container user has ownership of docker volumes
$REPO_ROOT/docker/scripts/take-ownership.sh

# Start the environment on host startup
DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY_VOLUME_PATH=/var/lib/docker/volumes/$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY/_data$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY
if [ "$1" = "--xpra" ]; then
  echo "$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY_VOLUME_PATH/docker/scripts/recycle-xpra.sh; exit 0" > /etc/rc2.d/S01$DESKTOP_ENVIRONMENT_REPOSITORY-$DESKTOP_ENVIRONMENT_CONTAINER_NAME
else
  echo "$DESKTOP_ENVIRONMENT_DOCKER_REPOSITORY_VOLUME_PATH/docker/scripts/recycle.sh; exit 0" > /etc/rc2.d/S01$DESKTOP_ENVIRONMENT_REPOSITORY-$DESKTOP_ENVIRONMENT_CONTAINER_NAME
fi
