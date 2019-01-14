# Jackson container volumes configuration
CONTAINER_USER=jackson
JACKSON_CONFIG_CHROME=/$CONTAINER_USER/home/.config/google-chrome
JACKSON_CONFIG_CODE=/$CONTAINER_USER/home/.config/Code
JACKSON_CONFIG_GITHUB=/$CONTAINER_USER/home/.config/hub

# Give the container user ownership of the JACKSON_CONFIG_CHROME volume
docker run \
  --rm \
  --user root \
  --volume JACKSON_CONFIG_CHROME:$JACKSON_CONFIG_CHROME \
  sabrehagen/desktop-environment:latest \
  chown -R $CONTAINER_USER:$CONTAINER_USER $JACKSON_CONFIG_CHROME

# Give the container user ownership of the JACKSON_CONFIG_CODE volume
docker run \
  --rm \
  --user root \
  --volume JACKSON_CONFIG_CODE:$JACKSON_CONFIG_CODE \
  sabrehagen/desktop-environment:latest \
  chown -R $CONTAINER_USER:$CONTAINER_USER $JACKSON_CONFIG_CODE

# Give the container user ownership of the JACKSON_CONFIG_GITHUB volume
docker run \
  --rm \
  --user root \
  --volume JACKSON_CONFIG_GITHUB:$JACKSON_CONFIG_GITHUB \
  sabrehagen/desktop-environment:latest \
  chown -R $CONTAINER_USER:$CONTAINER_USER $JACKSON_CONFIG_GITHUB
