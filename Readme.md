# About

The main intention of this repo is to configure windows in a declarative mannaer as good as (not) possible. In this attempt I am using [chezmoi](https://www.chezmoi.io/) for managing dotfiles and the `winget configure` sub-command from [winget](https://github.com/microsoft/winget-cli) to install software and call [DSC resources](https://learn.microsoft.com/en-us/powershell/dsc/overview?view=dsc-2.0).

## Setup 

Note: not tested yet

```powershell
$GITHUB_USERNAME = seapat
iex "&{$(irm 'https://get.chezmoi.io/ps1')} init --apply $GITHUB_USERNAME" 
rm chezmoi
```

## TODO

- [ ] Nixos WSL
