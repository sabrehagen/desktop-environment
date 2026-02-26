# AGENTS.md

## Cursor Cloud specific instructions

This is a Docker-based "Cloud Desktop Environment" project. The entire product is a single Docker image (`ghcr.io/sabrehagen/desktop-environment`) that packages a full Linux desktop (i3 window manager, 100+ apps) into a container. There is no traditional application code, package manager, or linter — everything is defined in a large `docker/Dockerfile` and shell scripts in `docker/scripts/`.

### Key commands

| Action | Command |
|---|---|
| Build image | `./docker/scripts/build.sh` (takes hours; prefer pulling pre-built image) |
| Pull pre-built image | `docker pull ghcr.io/sabrehagen/desktop-environment:latest` |
| Run tests | `DESKTOP_ENVIRONMENT_REGISTRY=ghcr.io/sabrehagen ./docker/scripts/test.sh` |
| Start headless | See "Running headless" below |
| All scripts | See `docker/scripts/` — `environment.sh` exports env vars used by all others |

### Running headless in the cloud VM

The built-in `docker/scripts/headless.sh` uses `--network host`, which conflicts with the host's existing VNC server on `:1`. Use this manual approach instead:

```sh
docker run --detach --name desktop-environment --publish 8080:8080 --rm \
  ghcr.io/sabrehagen/desktop-environment sleep infinity

docker exec desktop-environment bash -c \
  'export DISPLAY=:1 && vncserver :1 -geometry 1920x1080 -localhost true -SecurityTypes none -xstartup /usr/local/bin/i3'

docker exec -d desktop-environment bash -c \
  '/opt/noVNC/utils/launch.sh --listen 8080 --vnc localhost:5901'
```

noVNC is then accessible at `http://localhost:8080/vnc.html?autoconnect=true`.

### Testing

The only automated test is `docker/scripts/test.sh`, which starts a container, waits for it to reach "running" status within 10 seconds, then removes it. You must set `DESKTOP_ENVIRONMENT_REGISTRY=ghcr.io/sabrehagen` because the scripts derive the registry from the git remote owner by default.

### Gotchas

- Building the Docker image from source takes hours and downloads from dozens of external URLs. Always prefer pulling the pre-built image from `ghcr.io/sabrehagen/desktop-environment:latest`.
- The `environment.sh` script derives `DESKTOP_ENVIRONMENT_GITHUB_USER` from the git remote URL. If the remote uses an access token (e.g. `x-access-token:...@github.com/owner/repo`), the extracted username will include the token prefix. Set `DESKTOP_ENVIRONMENT_REGISTRY=ghcr.io/sabrehagen` explicitly.
- There are no linters, type checkers, or package managers in this repo. "Lint" and "build" correspond to shell script syntax and Docker image builds, respectively.
- The `start.sh` script requires physical devices (`/dev/tty3`, `/dev/dri`, `/dev/snd`, etc.) and host Docker socket access — it is intended for bare-metal Linux, not cloud VMs.
