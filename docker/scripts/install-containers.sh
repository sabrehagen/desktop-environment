REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Link all desktop environment containers into the user binary path
ls $REPO_ROOT/docker/images | \
  xargs -n1 -I@ \
  sudo ln -s $REPO_ROOT/docker/images/@/run.sh /usr/local/bin/@
