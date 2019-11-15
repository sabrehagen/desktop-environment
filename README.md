# ☁️ Cloud Desktop Environment

[![Build Status](https://travis-ci.org/sabrehagen/desktop-environment.svg?branch=master)](https://travis-ci.org/sabrehagen/desktop-environment)

My [daily driver](https://cloud.docker.com/repository/docker/sabrehagen/desktop-environment) on the cloud and on desktop.

## Getting Started

The only dependency required for this environment is [Docker](https://docs.docker.com/install).

```sh
# Clone desktop environment
git clone https://github.com/sabrehagen/desktop-environment

# Start desktop environment
./desktop-environment/docker/scripts/recycle.sh
```

## Forking

Set your [user configuration](docker/scripts/environment.sh#L3) and go.

## Project Goals

- [x] A computer wholly defined in code.
- [x] Only one command required to start.
- [x] Accessible from anywhere.
