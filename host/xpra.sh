REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

# Kill existing xpra server
docker ps -a | grep xpra | cut -c 1-15 | xargs docker rm -f

# Xpra server configuration
XPRA_DISPLAY=:14
XPRA_SERVER_CONTAINER=$DESKTOP_ENVIRONMENT_CONTAINER-xpra-server
XPRA_WEB_PORT=10000

# Start the xpra server
docker run \
  --detach \
  --env DISPLAY=$XPRA_DISPLAY \
  --env MODE=tcp \
  --env XPRA_HTML=yes \
  --label traefik.backend=$XPRA_SERVER_CONTAINER \
  --label traefik.enable=true \
  --label traefik.frontend.entryPoints=https  \
  --label traefik.frontend.rule=Host:$DESKTOP_ENVIRONMENT_DOMAIN_NAME \
  --label traefik.port=$XPRA_WEB_PORT \
  --name $XPRA_SERVER_CONTAINER \
  --network $DESKTOP_ENVIRONMENT_DOCKER_NETWORK \
  --rm \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  jare/x11-bridge:latest

# Start a desktop environment attached to the xpra server display
DISPLAY=$XPRA_DISPLAY $REPO_ROOT/docker/scripts/start.sh
