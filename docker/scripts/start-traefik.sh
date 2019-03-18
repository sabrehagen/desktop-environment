REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Start traefik to expose the xpra web client publicly
docker exec \
  --detach \
  --tty \
  $DESKTOP_ENVIRONMENT_CONTAINER_NAME \
  traefik \
  --accessLog.filePath=/var/log/traefik-http.log \
  --accessLog.format=json \
  --acme.domains=*.$DESKTOP_ENVIRONMENT_CLOUDFLARE_DOMAIN \
  --acme.email=$DESKTOP_ENVIRONMENT_CLOUDFLARE_EMAIL \
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
  --traefikLog.filePath=/var/log/traefik-system.log \
  --traefikLog.format=json \
  --web
