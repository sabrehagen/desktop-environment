REPO_ROOT=$(dirname $(realpath $0))/..

docker build -t sabrehagen/desktop-environment:latest $REPO_ROOT
