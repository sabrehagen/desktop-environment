# ☁️ Desktop Environment

[![Build Status](https://travis-ci.org/sabrehagen/desktop-environment.svg?branch=master)](https://travis-ci.org/sabrehagen/desktop-environment)

My [daily driver](https://cloud.docker.com/repository/docker/sabrehagen/desktop-environment).

## Getting Started

As `root`:

```sh
# Clone desktop environment
git clone https://github.com/sabrehagen/desktop-environment

# Supply cloud provider credentials
export DESKTOP_ENVIRONMENT_CLOUDFLARE_TOKEN=
export DESKTOP_ENVIRONMENT_GOOGLE_CREDENTIALS=

# Start desktop environment
desktop-environment/host/bootstrap.sh
```

## Forking

Set your [user configuration](docker/scripts/environment.sh#L3) and go.
