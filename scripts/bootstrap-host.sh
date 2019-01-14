# Script is run as root to create the host user
if [ $USER != "root" ]; then
  echo "Host configuration script must be run as root!"
  exit 1
fi

# Host user configuration
HOST_USER=jackson
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

# Enable password-less sudo for the host user
echo "$HOST_USER ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

# Install alacritty on the host
wget -O alacritty.deb https://github.com/jwilm/alacritty/releases/download/v0.2.5/Alacritty-v0.2.5_amd64.deb && \
  dpkg -i alacritty.deb && \
  rm alacritty.deb

# Install latest alacritty configuration for host user
ALACRITTY_CONFIG=$HOST_HOME/.config/alacritty/alacritty.yml
mkdir -p $(dirname $ALACRITTY_CONFIG) && \
  wget -q -O $ALACRITTY_CONFIG https://raw.githubusercontent.com/sabrehagen/dotfiles-alacritty/master/.config/alacritty/alacritty.yml && \
  chown $HOST_USER:$HOST_USER $ALACRITTY_CONFIG

# Swap escape and capslock keys
setxkbmap -option caps:swapescape
