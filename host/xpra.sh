REPO_ROOT=$(dirname $(realpath $0))/..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

# Kill all existing xpra services
docker ps -a | grep xpra | cut -c 1-15 | xargs docker rm -f

# Xpra client configuration
XPRA_DESKTOP_ENVIRONMENT_CONTAINER=$DESKTOP_ENVIRONMENT_CONTAINER-xpra-client

# Xpra server configuration
XPRA_CONTAINER=$DESKTOP_ENVIRONMENT_CONTAINER-xpra-server
XPRA_DISPLAY=:14
XPRA_WEB_PORT=10000

# Traefik configuration
ACME_DOMAINS=*.stemn.com
ACME_EMAIL=security@stemn.com
ACME_ENABLE=true
TRAEFIK_DEFAULT_ENTRYPOINTS=http,https
TRAEFIK_ENTRYPOINT_HTTP=
TRAEFIK_ENTRYPOINT_HTTPS=
TRAEFIK_HOST=cloud.jacksondelahunt.com

# Start the xpra server
docker run \
  --detach \
  --env DISPLAY=$XPRA_DISPLAY \
  --env MODE=tcp \
  --env XPRA_HTML=yes \
  --label traefik.backend=$XPRA_CONTAINER \
  --label traefik.enable=true \
  --label traefik.frontend.entryPoints=https  \
  --label traefik.frontend.rule=Host:$TRAEFIK_HOST \
  --label traefik.port=$XPRA_WEB_PORT \
  --name $XPRA_CONTAINER \
  --publish $XPRA_WEB_PORT:$XPRA_WEB_PORT \
  jare/x11-bridge:latest

# Start a desktop environment attached to the xpra server
docker run \
  --detach \
  --env DISPLAY=$XPRA_DISPLAY \
  --name $XPRA_DESKTOP_ENVIRONMENT_CONTAINER \
  --publish 80:80 \
  --publish 443:443 \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume DESKTOP_ENVIRONMENT_TRAEFIK_CERTIFICATES=/etc/traefik \
  --volumes-from $XPRA_CONTAINER \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER:$DESKTOP_ENVIRONMENT_BRANCH

# Start traefik to expose the xpra web client publicly
docker exec \
  --tty \
  --user $DESKTOP_ENVIRONMENT_USER \
  $XPRA_DESKTOP_ENVIRONMENT_CONTAINER \
  traefik \
  --acme.domains=$ACME_DOMAINS \
  --acme.email=$ACME_EMAIL \
  --acme.entrypoint=https \
  --acme.httpchallenge \
  --acme.httpchallenge.entrypoint=http \
  --acme.storage=/etc/traefik/acme.json \
  --acme=$ACME_ENABLE \
  --defaultentrypoints=$TRAEFIK_DEFAULT_ENTRYPOINTS \
  --docker \
  --docker.endpoint=unix:///var/run/docker.sock \
  --docker.exposedbydefault=false \
  --docker.watch=true \
  --entryPoints='Name:http Address::80 Redirect.EntryPoint:https' \
  --entryPoints='Name:https Address::443 TLS' \
  --logLevel=info \
  --web
  # $TRAEFIK_ENTRYPOINT_HTTP $TRAEFIK_ENTRYPOINT_HTTPS
