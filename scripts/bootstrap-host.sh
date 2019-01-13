# Host machine user configuration
HOST_HOME=$HOME
HOST_USER=$(whoami)

# Allow connections from docker containers to the host machine's X server
xhost local:docker

# Enable password-less sudo for the user on the host machine
echo "$HOST_USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

# Install alacritty
wget -q -O alacritty.deb https://github.com/jwilm/alacritty/releases/download/v0.2.5/Alacritty-v0.2.5_amd64.deb && \
  dpkg -i alacritty.deb && \
  rm alacritty.deb

# Install the latest alacritty config on the host machine
wget -q -O $HOST_HOME/.config/alacritty/alacritty.yml https://raw.githubusercontent.com/sabrehagen/dotfiles-alacritty/master/.config/alacritty/alacritty.yml
