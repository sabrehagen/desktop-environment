# Enable password-less sudo for user
echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

USER=jackson
JACKSON_HOME=/$USER/home
JACKSON_CONFIG_CHROME=$JACKSON_HOME/.config/google-chrome

# Take ownership of the JACKSON_CONFIG_CHROME_VOLUME volume
docker run \
  --rm \
  --user root \
  --volume JACKSON_CONFIG_CHROME:$JACKSON_CONFIG_CHROME \
  sabrehagen/desktop-environment:latest \
  chown -R $USER:$USER $JACKSON_CONFIG_CHROME
