docker run \
  --env DISPLAY=$DISPLAY \
  --env SSH_AUTH_SOCK=/ssh-auth.sock \
  --env STEMN_GIT_EMAIL="$(git config --get user.email)" \
  --env STEMN_GIT_NAME="$(git config --get user.name)" \
  --interactive \
  --name desktop-shell-$(date +%s) \
  --rm \
  --tty \
  --volume /etc/hosts:/etc/hosts \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume $HOME/.ssh:$STEMN_HOME/.ssh \
  --volume $HOME:/home \
  --volume $SSH_AUTH_SOCK:/ssh-auth.sock \
  --workdir /home \
  stemn/development-environment:latest "$@"
