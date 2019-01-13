# Host machine user configuration
HOST_HOME=$HOME
HOST_USER=$(whoami)

# Jackson container user configuration
CONTAINER_USER=jackson
CONTAINER_HOME=/$CONTAINER_USER/home
JACKSON_CONFIG_CHROME=$CONTAINER_HOME/.config/google-chrome
JACKSON_CONFIG_CODE=$CONTAINER_HOME/.config/Code

# Allow connections from docker containers to the host's X server
xhost local:docker

# Enable password-less sudo for the host user
echo "$HOST_USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

# Install the latest alacritty config on the host
wget -q -O $HOST_HOME/.config/alacritty/alacritty.yml https://raw.githubusercontent.com/sabrehagen/dotfiles-alacritty/master/.config/alacritty/alacritty.yml

# Take ownership of the JACKSON_CONFIG_CHROME volume
docker run \
  --rm \
  --user root \
  --volume JACKSON_CONFIG_CHROME:$JACKSON_CONFIG_CHROME \
  sabrehagen/desktop-environment:latest \
  chown -R $CONTAINER_USER:$CONTAINER_USER $JACKSON_CONFIG_CHROME

# Take ownership of the JACKSON_CONFIG_CODE volume
docker run \
  --rm \
  --user root \
  --volume JACKSON_CONFIG_CODE:$JACKSON_CONFIG_CODE \
  sabrehagen/desktop-environment:latest \
  chown -R $CONTAINER_USER:$CONTAINER_USER $JACKSON_CONFIG_CODE
