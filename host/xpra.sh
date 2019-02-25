REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

docker ps -a | grep xpra | cut -c 1-15 | xargs docker rm -f

# Start the xpra server
docker run \
  --detach \
  --env MODE=tcp \
  --env XPRA_HTML=yes \
  --env DISPLAY=:14 \
  --name $DESKTOP_ENVIRONMENT_CONTAINER-xpra-x11-bridge \
  --publish 10000:10000 \
  jare/x11-bridge:latest

ACME_DOMAINS=
ACME_EMAIL=
ACME_ENABLE=
DOCKER_DOMAIN=
TRAEFIK_DEFAULT_ENTRYPOINTS=
TRAEFIK_ENTRYPOINT_HTTP=
TRAEFIK_ENTRYPOINT_HTTPS=
TRAEFIK_HOST=

# Make the X server publicly accessible
# docker run \
#   --detach \
#   --name $DESKTOP_ENVIRONMENT_CONTAINER-xpra-nginx-proxy \
#   nginx:alpine

# Start a container attached to the xpra server
docker run \
  --detach \
  --env DISPLAY=:14 \
  --name $DESKTOP_ENVIRONMENT_CONTAINER-xpra-client \
  --volumes-from $DESKTOP_ENVIRONMENT_CONTAINER-xpra-x11-bridge \
  sabrehagen/desktop-environment:latest

docker exec -it --user jackson $DESKTOP_ENVIRONMENT_CONTAINER-xpra-client code
