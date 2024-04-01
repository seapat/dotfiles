# About

The main intention of this repo is to configure windows in a declarative manager as good as (not) possible. In this attempt I am using [chezmoi](https://www.chezmoi.io/) for managing dotfiles and the `winget configure` sub-command from [winget](https://github.com/microsoft/winget-cli) to install software and call [DSC resources](https://learn.microsoft.com/en-us/powershell/dsc/overview?view=dsc-2.0).

## Setup 

Note: not tested yet

```powershell
winget install chezmoi
chezmoi init --apply seapat
```

## TODO

- [ ] Nixos WSL
- [ ] Finish MPV setup
- [ ] Spicetify
- [ ] scoop
- [ ] Windows Optional Features (dependencies, hyper-v, wsl)
- [ ] Windows Group policies
    - [ ] Brave / Chromium extensions
- [ ] us altgr-intl keyboard layout