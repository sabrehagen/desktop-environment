# ☁️ Cloud Desktop Environment

My [daily driver](https://github.com/users/sabrehagen/packages/container/package/desktop-environment) on the cloud and on desktop.

![desktop](https://i.imgur.com/cEBbzyu.png)

## Getting Started

The only dependency required is [Docker](https://docs.docker.com/install).

```sh
# Clone desktop environment
git clone https://github.com/sabrehagen/desktop-environment

# Start desktop environment
./desktop-environment/docker/scripts/recycle.sh
```

## Running in the Cloud

Fork the [github-computer/github-computer](https://github.com/github-computer/github-computer) repository and this desktop environment will be deployed to GitHub's cloud.

## Keybindings

```sh
# Launch terminal
Mod + Return

# Launch chrome
Mod + b

# Launch vs code
Mod + c

# Launch dmenu
Mod + d

# Launch pcmanfm
Mod + e

# Launch slack
Mod + m

# Launch signal
Mod + y

# Launch maim
Mod + x

# Launch i3lock
Mod + slash

```

## Project Goals

- [x] A computer wholly defined in code.
- [x] Only one command required to start from scratch.
