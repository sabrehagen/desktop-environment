# Desktop Environment

My [daily driver](https://cloud.docker.com/repository/docker/sabrehagen/desktop-environment).

## Getting Started

Use a new GitHub [Personal Access Token](https://github.com/settings/tokens/new) for [`DESKTOP_ENVIRONMENT_GITHUB_TOKEN`](scripts/credentials.sh#L2) on each device running the desktop environmment.

On a clean install of Ubuntu 18.10+ run as `root`:

```sh
# Clone desktop environment
git clone https://github.com/sabrehagen/desktop-environment

# Provide repository with github access
echo DESKTOP_ENVIRONMENT_GITHUB_TOKEN=... > desktop-environment/scripts/credentials.sh

# Start desktop environment
desktop-environment/scripts/bootstrap-host.sh
```

## Forking

Set your [user configuration](scripts/environment.sh#L5) and go.
