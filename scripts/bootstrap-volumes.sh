# Jackson container user configuration
CONTAINER_USER=jackson
CONTAINER_HOME=/$CONTAINER_USER/home

# Jackson container volume configuration
JACKSON_CONFIG_CHROME=$CONTAINER_HOME/.config/google-chrome
JACKSON_CONFIG_CODE=$CONTAINER_HOME/.config/Code

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
