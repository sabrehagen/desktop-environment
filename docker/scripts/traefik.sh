REPO_ROOT=$(dirname $(realpath $0))/../..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

# Start traefik to expose the xpra web client publicly
docker exec \
  --detach \
  --tty \
  $DESKTOP_ENVIRONMENT_CONTAINER \
  traefik \
  --acme.domains=*.stemn.com \
  --acme.email=security@stemn.com \
  --acme.entrypoint=https \
  --acme.httpchallenge \
  --acme.httpchallenge.entrypoint=http \
  --acme.storage=/etc/traefik/acme.json \
  --acme=true \
  --defaultentrypoints=http,https \
  --docker \
  --docker.endpoint=unix:///var/run/docker.sock \
  --docker.exposedbydefault=false \
  --docker.watch=true \
  --entryPoints='Name:http Address::80 Redirect.EntryPoint:https' \
  --entryPoints='Name:https Address::443 TLS' \
  --logLevel=info \
  --web
