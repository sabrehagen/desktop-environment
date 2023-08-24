REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Wait until the desktop environment test container is running before proceeding
timeout 10 sh -c "until docker inspect $DESKTOP_ENVIRONMENT_CONTAINER_NAME | grep Status | grep -m 1 running >/dev/null; do sleep 1; done"

# Remove desktop environment test container
docker rm -f $DESKTOP_ENVIRONMENT_CONTAINER_NAME

# Check desktop environment container started successfully
TEST_RESULT=$?

# Exit with test result exit code
exit $TEST_RESULT
