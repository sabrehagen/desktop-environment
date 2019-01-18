# Script is run as root to create the host user
if [ $USER != "root" ]; then
  echo "Host configuration script must be run as root!"
  exit 1
fi

REPO_ROOT=$(dirname $(realpath $0))/..

# Export development environment shell configuration
export $(sh $REPO_ROOT/scripts/environment.sh)

# Host user configuration
HOST_USER=$DESKTOP_ENVIRONMENT_USER
HOST_USER_ID=1000
HOST_HOME=/$HOST_USER/home

# Make the host user home directory
mkdir -p $HOST_HOME

# Create the host user group
groupadd \
  --gid $HOST_USER_ID \
  $HOST_USER

# Create the host user
useradd \
  --gid $HOST_USER_ID \
  --uid $HOST_USER_ID \
  $HOST_USER

# Add the host user to the docker group
usermod -aG docker $HOST_USER

# Allow connections from docker containers to the host's X server
xhost local:docker

# Install utilities
apt update && apt install --yes && \
  docker.io && \
  vcsh

# Enable password-less sudo for the host user
echo "$HOST_USER ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

# Install alacritty on the host
wget -O alacritty.deb https://github.com/jwilm/alacritty/releases/download/v0.2.5/Alacritty-v0.2.5_amd64.deb && \
  dpkg -i alacritty.deb && \
  rm alacritty.deb

# Start the desktop environment on system start
echo "@reboot $HOST_HOME/repositories/$DESKTOP_ENVIRONMENT_REGISTRY/desktop-environment/scripts/start.sh" >> /etc/crontab

# Take ownership of all files under the user's directory
chown $HOST_USER:$HOST_USER /$HOST_USER

# Install dotfiles configuration for host user
su $HOST_USER
vcsh clone https://github.com/sabrehagen/dotfiles-alacritty.git
vcsh clone https://github.com/sabrehagen/dotfiles-scripts.git
