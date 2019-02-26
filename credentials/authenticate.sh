REPO_ROOT=$(dirname $(realpath $0))/..

# Extract credentials from environment
if [ ! -z "$DESKTOP_ENVIRONMENT_CREDENTIALS" ]; then
  echo "$DESKTOP_ENVIRONMENT_CREDENTIALS" > $REPO_ROOT/credentials/credentials.json
fi
