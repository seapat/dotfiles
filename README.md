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

The powershell profile contains a function that precedes `winget` (not `winget.exe`). When `winget install`, `winget uninstall` or `winget update` is run, the `winget export` command inst invoked and `winget.json` in the users Home directory is updated. `Chezmoi` symlinks this file, hence it is directly edited in the chezmoi directory.
`scoop` ( -> `.scoop.json`) and `chocolatey` () are treated in the same manner.

## TODO

- [ ] Nixos WSL
- [ ] Finish MPV setup
- [ ] scoop
- [ ] Windows Optional Features (dependencies, hyper-v, wsl)
- [ ] Windows Group policies
    - [ ] Brave / Chromium extensions
- [ ] us altgr-intl keyboard layout