# Print container build info
CURRENT_DATE=$(date +%s)
TIME_SINCE_CONTAINER_BUILD=$(echo $((CURRENT_DATE-CONTAINER_BUILD_DATE)) | awk '{print int($1/(60 * 60 * 24))" days "int($1/(60 * 60))" hrs "int($1/60)" mins "int($1%60)" secs ago"}')
echo "\nContainer built $TIME_SINCE_CONTAINER_BUILD | sha $CONTAINER_GIT_SHA"
