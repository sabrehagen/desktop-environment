REPO_ROOT=$(dirname $(realpath $0))/..

# Export development environment shell configuration
export $(sh $REPO_ROOT/scripts/environment.sh)

docker push $DESKTOP_ENVIRONMENT_REGISTRY/desktop-environment:latest
