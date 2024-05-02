# About

The main intention of this repo is to configure windows in a declarative manager as good as (not) possible. In this attempt I am using [chezmoi](https://www.chezmoi.io/) for managing dotfiles and the `winget configure` sub-command from [winget](https://github.com/microsoft/winget-cli) to install software and call [DSC resources](https://learn.microsoft.com/en-us/powershell/dsc/overview?view=dsc-2.0).

## Setup 

Note: not tested yet

```powershell
winget install chezmoi
chezmoi init --apply seapat
```

## How Packages are managed

### Powershell commands

The powershell profile contains a function that precedes `winget` (not `winget.exe`). When relevant commands (`winget install`, `winget uninstall`, `winget update`, ...) are run, the `winget export` command is invoked and `winget.json` in `%AppData%` get's updated. `Chezmoi` symlinks this file, hence it is directly edited in the chezmoi directory.
`scoop` ( -> `scoop.json`) is treated in the same manner. 


## TODO

- [ ] Nixos WSL
- [ ] Spicetify command setup, together with respective package updates (winget)
- [ ] Finish MPV setup
- [ ] Windows Optional Features (dependencies, hyper-v, wsl)
- [ ] Windows Group policies
    - [ ] Brave / Chromium extensions
- [ ] us altgr-intl keyboard layout
- [ ] set XDG spec variables to windows equivalents ([ref1](https://github.com/adrg/xdg/blob/master/README.md), [ref2](https://stackoverflow.com/questions/43853548/xdg-basedir-directories-for-windows))