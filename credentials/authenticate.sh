# Extract credentials from environment
if [ ! -z "$DESKTOP_ENVIRONMENT_CREDENTIALS" ]; then
  echo $DESKTOP_ENVIRONMENT_CREDENTIALS > credentials.json
fi
