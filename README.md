# ☁️ Cloud Desktop Environment

My [daily driver](https://cloud.docker.com/repository/docker/sabrehagen/desktop-environment) on the cloud and on desktop.

![desktop](https://i.imgur.com/cEBbzyu.png)

## Getting Started

The only dependency required is [Docker](https://docs.docker.com/install).

```sh
# Clone desktop environment
git clone https://github.com/sabrehagen/desktop-environment

# Start desktop environment
./desktop-environment/docker/scripts/recycle.sh
```

## Forking

Set your [user configuration](docker/scripts/environment.sh#L3) and go.

## Keybindings

```sh
# Launch alacritty
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
