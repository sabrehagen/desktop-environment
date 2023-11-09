# ☁️ Cloud Desktop Environment

My [daily driver](https://github.com/users/sabrehagen/packages/container/package/desktop-environment) on the desktop and in the cloud.

![desktop](https://i.imgur.com/yv34lxO.png)
![desktop](https://i.imgur.com/Mi40odG.png)
![desktop](https://i.imgur.com/LZvxAnW.jpg)
![desktop](https://i.imgur.com/jm4RrKw.jpg)
![desktop](https://i.imgur.com/C1eBDKX.jpg)
![desktop](https://i.imgur.com/n3YUPD9.png)

## Running on the Desktop

The only dependency required is [Docker](https://docs.docker.com/install).

To run on Linux, clone the repository and start the environment.

```sh
# Clone desktop environment
git clone https://github.com/sabrehagen/desktop-environment

# Start desktop environment
./desktop-environment/docker/scripts/recycle.sh
```

## Running in the Cloud

- Fork this repository.
- Add your [ngrok auth token](https://dashboard.ngrok.com/login) to the [repository secrets](../../settings/secrets/actions/new) as `NGROK_AUTH_TOKEN` to enable web access.
- Enable [read and write permissions](../../settings/actions) on your fork to allow GitHub Actions to push to your repository's container registry.
- Run the [Deploy Desktop Environment](../../actions/workflows/deploy.yml) GitHub Actions workflow to deploy the desktop environment to GitHub's Actions infrastructure.
- Click the Cloud Desktop Environment URL printed in the output of the `Get URL` workflow step.

Fork the [cloud-computer/cloud-computer](https://github.com/cloud-computer/cloud-computer) repository to deploy the desktop environment to Google Cloud.

## Project Goals

- [x] A computer wholly defined in code.
- [x] From zero to production in one command.
- [x] Consistent experience across cloud and desktop.

## Keybindings

Inexhaustive list of keybindings. Check `~/.config/i3/config` for all available bindings.

### System Management

- Restart the desktop environment: `$mod+Shift+q`
- Lock screen: `$mod+slash`

### Window Focus and Movement

Vim-style bindings for focusing and moving windows.

- Focus left: `$mod+h`
- Focus down: `$mod+j`
- Focus up: `$mod+k`
- Focus right: `$mod+l`
- Move focused window left: `$mod+Shift+h`
- Move focused window down: `$mod+Shift+j`
- Move focused window up: `$mod+Shift+k`
- Move focused window right: `$mod+Shift+l`
- Resize gaps: `$mod+equal` and `$mod+Shift+equal`

### Workspace Management

- Create a new workspace: `$mod+n`
- Move the focused window to a new workspace: `$mod+Shift+n`
- Switch to adjacent workspace: `$mod+Control+h` or `$mod+Control+l`
- Switch to workspace n: `$mod+1` to `$mod+0`
- Switch to previous workspace: `$mod+minus`

### Application Launching

- Launch alacritty terminal: `$mod+return`
- Launch google chrome: `$mod+b`
- Launch vs code: `$mod+c`
- Launch discord: `$mod+d`
- Launch pcmanfm file manager: `$mod+e`
- Launch telegram: `$mod+t`
- Launch screenshot: `$mod+x`

### Monitor Management

- Move the focused window to the left monitor: `$mod+less`
- Move the focused window to the right monitor: `$mod+greater`

### Scratchpad

- Show gotop: `$mod+escape`
- Show terminal: `$mod+grave`
- Show volume: `$mod+v`
- Show wifi: `$mod+i`
