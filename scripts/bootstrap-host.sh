# Script is run as root to create the host user
if [ $USER != "root" ]; then
  echo "Host configuration script must be run as root!"
  exit 1
fi

REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $(sh $REPO_ROOT/scripts/environment.sh)

# Install utilities
apt-get update -qq && apt-get install -qq \
  curl \
  sudo \
  vcsh \
  xclip

# Install Docker
sh -c "$(curl -fsSL get.docker.com)" && \
  usermod -aG docker $DESKTOP_ENVIRONMENT_USER

# Enable password-less sudo for the sudo group
echo "%sudo ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

# Increase max open files on host
echo 'fs.file-max=1000000' >> /etc/sysctl.conf

# Increase max open file watchers on host
echo 'fs.inotify.max_user_watches=1000000' >> /etc/sysctl.conf

# Increase file descriptor limit
echo '* soft nofile 1000000' >> /etc/security/limits.conf
echo '* hard nofile 1000000' >> /etc/security/limits.conf

# Install alacritty on the host
wget -O alacritty.deb https://github.com/jwilm/alacritty/releases/download/v0.2.8/Alacritty-v0.2.8_amd64.deb && \
  dpkg -i alacritty.deb && \
  rm alacritty.deb

# Start the desktop environment as the host user on system start
echo "@reboot $HOST_USER $REPO_ROOT/scripts/start.sh" >> /etc/crontab

# Allow connections from docker containers to the host's X server
xhost local:docker

# Host user configuration
HOST_USER=$DESKTOP_ENVIRONMENT_USER
HOST_USER_ID=1000
HOST_HOME=/$HOST_USER/home
HOST_REPOSITORY=/$DESKTOP_ENVIRONMENT_CONTAINER

# Make the host user directory
mkdir /$HOST_USER

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

# Avoid committing user credentials to the repository
git update-index --assume-unchanged $REPO_ROOT/scripts/credentials.sh

# Clone the desktop environment to the host
git clone https://github.com/$DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER $HOST_REPOSITORY

# Copy the existing credentials to the host desktop environment
cp $REPO_ROOT/scripts/credentials.sh $HOST_REGISTRY/scripts/credentials.sh

# Take ownership of all files under the user's directory
chown -R $HOST_USER:$HOST_USER /$HOST_USER $HOST_REPOSITORY

# Install dotfiles configuration for host user
gosu $HOST_USER vcsh clone https://github.com/sabrehagen/dotfiles-alacritty.git
gosu $HOST_USER vcsh clone https://github.com/sabrehagen/dotfiles-autostart.git
gosu $HOST_USER vcsh clone https://github.com/sabrehagen/dotfiles-kwin.git
gosu $HOST_USER vcsh clone https://${DESKTOP_ENVIRONMENT_GITHUB_TOKEN}@github.com/sabrehagen/dotfiles-ssh.git
gosu $HOST_USER vcsh clone https://github.com/sabrehagen/dotfiles-scripts.git

# Manually execute startup script to simulate host startup
$HOST_HOME/.config/scripts/startup.sh

# Recycle the desktop environment
$HOST_REPOSITORY/scripts/recycle.sh
