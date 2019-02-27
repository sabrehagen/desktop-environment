REPO_ROOT=$(dirname $(readlink -f $0))/..

# Extract credentials from environment
if [ ! -z "$DESKTOP_ENVIRONMENT_CREDENTIALS" ]; then
  echo "$DESKTOP_ENVIRONMENT_CREDENTIALS" > $REPO_ROOT/credentials/credentials.json
fi
