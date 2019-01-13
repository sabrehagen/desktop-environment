# Host user configuration
HOST_USER=$(whoami)
HOST_HOME=$HOME

# Container user configuration
CONTAINER_USER=jackson
CONTAINER_HOME=/$CONTAINER_USER/home

# Install docker on the host
apt update && apt install --yes \
  docker.io

# Add the container user to the docker group on the host
usermod -aG docker $CONTAINER_USER

# Allow connections from docker containers to the host's X server
xhost local:docker

# Enable password-less sudo for the container user on the host
echo "$HOST_USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

# Install alacritty on the host
wget -q -O alacritty.deb https://github.com/jwilm/alacritty/releases/download/v0.2.5/Alacritty-v0.2.5_amd64.deb && \
  dpkg -i alacritty.deb && \
  rm alacritty.deb

# Install the latest alacritty config on the host
wget -q -O $HOST_HOME/.config/alacritty/alacritty.yml https://raw.githubusercontent.com/sabrehagen/dotfiles-alacritty/master/.config/alacritty/alacritty.yml
