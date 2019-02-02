REPO_ROOT=$(dirname $(realpath $0))/..

# Export development environment shell configuration
export $(sh $REPO_ROOT/scripts/environment.sh)

# Give the container user ownership of the DESKTOP_ENVIRONMENT_CACHE_CHROME volume
docker run \
  --rm \
  --user root \
  --volume DESKTOP_ENVIRONMENT_CACHE_CHROME:$DESKTOP_ENVIRONMENT_CACHE_CHROME \
  $DESKTOP_ENVIRONMENT_USER/desktop-environment:latest \
  chown -R $DESKTOP_ENVIRONMENT_USER:$DESKTOP_ENVIRONMENT_USER $DESKTOP_ENVIRONMENT_CACHE_CHROME

# Give the container user ownership of the DESKTOP_ENVIRONMENT_CACHE_CODE volume
docker run \
  --rm \
  --user root \
  --volume DESKTOP_ENVIRONMENT_CACHE_CODE:$DESKTOP_ENVIRONMENT_CACHE_CODE \
  $DESKTOP_ENVIRONMENT_USER/desktop-environment:latest \
  chown -R $DESKTOP_ENVIRONMENT_USER:$DESKTOP_ENVIRONMENT_USER $DESKTOP_ENVIRONMENT_CACHE_CODE

# Give the container user ownership of the DESKTOP_ENVIRONMENT_CACHE_JUMP volume
docker run \
  --rm \
  --user root \
  --volume DESKTOP_ENVIRONMENT_CACHE_JUMP:$DESKTOP_ENVIRONMENT_CACHE_JUMP \
  $DESKTOP_ENVIRONMENT_USER/desktop-environment:latest \
  chown -R $DESKTOP_ENVIRONMENT_USER:$DESKTOP_ENVIRONMENT_USER $DESKTOP_ENVIRONMENT_CACHE_JUMP

# Give the container user ownership of the DESKTOP_ENVIRONMENT_CACHE_YARN volume
docker run \
  --rm \
  --user root \
  --volume DESKTOP_ENVIRONMENT_CACHE_YARN:$DESKTOP_ENVIRONMENT_CACHE_YARN \
  $DESKTOP_ENVIRONMENT_USER/desktop-environment:latest \
  chown -R $DESKTOP_ENVIRONMENT_USER:$DESKTOP_ENVIRONMENT_USER $DESKTOP_ENVIRONMENT_CACHE_YARN

# Give the container user ownership of the DESKTOP_ENVIRONMENT_CACHE_ZSH volume
docker run \
  --rm \
  --user root \
  --volume DESKTOP_ENVIRONMENT_CACHE_ZSH:$DESKTOP_ENVIRONMENT_CACHE_ZSH \
  $DESKTOP_ENVIRONMENT_USER/desktop-environment:latest \
  chown -R $DESKTOP_ENVIRONMENT_USER:$DESKTOP_ENVIRONMENT_USER $DESKTOP_ENVIRONMENT_CACHE_ZSH

# Give the container user ownership of the DESKTOP_ENVIRONMENT_CONFIG_CHROME volume
docker run \
  --rm \
  --user root \
  --volume DESKTOP_ENVIRONMENT_CONFIG_CHROME:$DESKTOP_ENVIRONMENT_CONFIG_CHROME \
  $DESKTOP_ENVIRONMENT_USER/desktop-environment:latest \
  chown -R $DESKTOP_ENVIRONMENT_USER:$DESKTOP_ENVIRONMENT_USER $DESKTOP_ENVIRONMENT_CONFIG_CHROME

# Give the container user ownership of the DESKTOP_ENVIRONMENT_CONFIG_CODE volume
docker run \
  --rm \
  --user root \
  --volume DESKTOP_ENVIRONMENT_CONFIG_CODE:$DESKTOP_ENVIRONMENT_CONFIG_CODE \
  $DESKTOP_ENVIRONMENT_USER/desktop-environment:latest \
  chown -R $DESKTOP_ENVIRONMENT_USER:$DESKTOP_ENVIRONMENT_USER $DESKTOP_ENVIRONMENT_CONFIG_CODE

# Give the container user ownership of the DESKTOP_ENVIRONMENT_CONFIG_GITHUB volume
docker run \
  --rm \
  --user root \
  --volume DESKTOP_ENVIRONMENT_CONFIG_GITHUB:$DESKTOP_ENVIRONMENT_CONFIG_GITHUB \
  $DESKTOP_ENVIRONMENT_USER/desktop-environment:latest \
  chown -R $DESKTOP_ENVIRONMENT_USER:$DESKTOP_ENVIRONMENT_USER $DESKTOP_ENVIRONMENT_CONFIG_GITHUB
