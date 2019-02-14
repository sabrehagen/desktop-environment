# Desktop Environment

My [daily driver](https://cloud.docker.com/repository/docker/sabrehagen/desktop-environment).

## Getting Started

Use a new GitHub [Personal Access Token](https://github.com/settings/tokens/new) for [`DESKTOP_ENVIRONMENT_GITHUB_TOKEN`](scripts/credentials.sh#L2) on each device running the desktop environmment.

```sh
# Clone docker environment.
git clone https://github.com/sabrehagen/desktop-environment && cd desktop-environment

# Bootstrap docker host.
./scripts/bootstrap-host.sh

# Become non-root user.
su jackson

# Start the environment.
./scripts/refresh.sh
```

## Forking

Set your [user configuration](scripts/environment.sh#L5) and go.
