# AGENTS.md

## Cursor Cloud specific instructions

This is a Docker-based "Cloud Desktop Environment" project. The entire product is a single Docker image that packages a full Linux desktop (i3 window manager, 100+ apps) into a container. There is no traditional application code, package manager, or linter — everything is defined in a large `docker/Dockerfile` and shell scripts in `docker/scripts/`.

### Registry and environment variables

All scripts source `docker/scripts/environment.sh`, which derives `DESKTOP_ENVIRONMENT_GITHUB_USER` from the git remote URL and sets `DESKTOP_ENVIRONMENT_REGISTRY` to `ghcr.io/<owner>` by default. This means the registry adapts automatically when the repo is forked — no hardcoded usernames.

If the git remote uses an access token URL (e.g. `x-access-token:...@github.com/owner/repo`), the sed extraction in `environment.sh` still correctly parses the owner. You generally do not need to override `DESKTOP_ENVIRONMENT_REGISTRY` manually.

### Key commands

| Action | Command |
|---|---|
| Build image | `./docker/scripts/build.sh` (takes hours; prefer pulling pre-built image) |
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

- Building the Docker image from source takes hours and downloads from dozens of external URLs. Always prefer pulling the pre-built image.
- There are no linters, type checkers, or package managers in this repo. "Lint" and "build" correspond to shell script syntax and Docker image builds, respectively.
- The `start.sh` script requires physical devices (`/dev/tty3`, `/dev/dri`, `/dev/snd`, etc.) and host Docker socket access — it is intended for bare-metal Linux, not cloud VMs. Use `headless.sh` for cloud/VM environments.
