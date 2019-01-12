# Enable password-less sudo for user
echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

JACKSON_HOME=/jackson/home
JACKSON_CONFIG_CHROME=$JACKSON_HOME/.config/google-chrome

docker run \
  --rm \
  --user root \
  --volume $JACKSON_CONFIG_CHROME:$JACKSON_CONFIG_CHROME \
  sabrehagen/desktop-environment:latest \
  chown -R stemn:stemn $JACKSON_CONFIG_CHROME
