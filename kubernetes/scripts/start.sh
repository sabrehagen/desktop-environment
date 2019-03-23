REPO_ROOT=$(dirname $(readlink -f $0))/../..

kind create cluster --config=$REPO_ROOT/kubernetes/resources/cluster.yaml
