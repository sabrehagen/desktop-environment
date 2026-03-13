# AGENTS.md

## Cursor Cloud specific instructions

This is a Docker-based "Cloud Desktop Environment" project. The entire product is a single Docker image that packages a full Linux desktop (i3 window manager, 100+ apps) into a container. There is no traditional application code, package manager, or linter — everything is defined in a large `docker/Dockerfile` and shell scripts in `docker/scripts/`.

### Environment variables

All scripts source `docker/scripts/environment.sh`, which derives both `DESKTOP_ENVIRONMENT_GITHUB_USER` and `DESKTOP_ENVIRONMENT_USER` from the git remote URL. `DESKTOP_ENVIRONMENT_REGISTRY` defaults to `ghcr.io/<owner>`. Everything adapts automatically when the repo is forked — no hardcoded usernames or manual overrides needed.

### Key commands

| Action | Command |
|---|---|
| Build image | `./docker/scripts/build.sh` (Docker build cache is pre-populated in the VM snapshot) |
| Pull pre-built image | `docker pull ghcr.io/$DESKTOP_ENVIRONMENT_GITHUB_USER/desktop-environment:latest` (after sourcing `environment.sh`) |
| Run tests | `./docker/scripts/test.sh` |
| Start headless | `./docker/scripts/headless.sh` |
| All scripts | See `docker/scripts/` — `environment.sh` exports env vars used by all others |

### Running headless

Run `./docker/scripts/headless.sh` to start the desktop environment in headless mode. It creates a container with port 8080 published, starts a VNC server on display `:1`, and launches noVNC for browser access.

noVNC is then accessible at `http://localhost:8080/vnc.html?autoconnect=true`.

### Testing

The only automated test is `docker/scripts/test.sh`, which starts a container, waits for it to reach "running" status within 10 seconds, then removes it.

### Gotchas

- A full Docker build from a cold cache takes hours. The VM snapshot includes a pre-populated build cache, so incremental rebuilds after Dockerfile edits are fast.
- There are no linters, type checkers, or package managers in this repo. "Lint" and "build" correspond to shell script syntax and Docker image builds, respectively.
- The `start.sh` script requires physical devices (`/dev/tty3`, `/dev/dri`, `/dev/snd`, etc.) and host Docker socket access — it is intended for bare-metal Linux, not cloud VMs. Use `headless.sh` for cloud/VM environments.
