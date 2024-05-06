### PROMPT ETC

# starship
# $ENV:STARSHIP_CONFIG = "$HOME\config\starship\config.toml"
if (Get-Command starship -errorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
  $ENV:STARSHIP_CACHE = "$HOME\AppData\Local\Temp"
}

### MODULES
Import-Module PSFzf -ArgumentList 'Ctrl+t', 'Ctrl+r'
# Import-Module Terminal-Icons # buggy in windows terminal, works in wezterm

Import-Module posh-git
$GitPromptSettings.EnablePromptStatus = $false



### COMPLETIONS

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Winget completion
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

# pixi: python dev environments
if (Get-Command pixi -errorAction SilentlyContinue) {
  (& pixi completion --shell powershell) | Out-String | Invoke-Expression
}

### FUNCTIONS

function winget {
    Invoke-Command -ArgumentList $args -ScriptBlock { winget.exe $args }

    # not excluding export, so that the auto export is equivalent to the one that was generated manually
    If ($args -match "install|add|uninstall|remove|rm|update|upgrade") {
      Start-Job -ScriptBlock { winget.exe export -o $env:APPDATA\winget.json --include-versions --disable-interactivity --accept-source-agreements } | Out-Null
    }
}


function scoop {
    Invoke-Command -ArgumentList $args -ScriptBlock { scoop.cmd $args }

    # not excluding export, so that the auto export is equivalent to the one that was generated manually
    If ($args -match "install|uninstall|update") {
      Start-Job -ScriptBlock { 
        scoop.cmd export -c > $env:APPDATA\scoop.json
        # $json = $env:APPDATA\scoop.json
        # $obj = ConvertFrom-Json $json
        # $obj | Sort-Object {$_.name} | ConvertTo-Json
        } | Out-Null
    }
}

### ALIASES

Set-Alias open Invoke-Item


### INVOKES

# fast `scoop-search` replaces slow `scoop search` (needs to be installed)
Invoke-Expression (&scoop-search --hook)

# zoxide, replaces psmodules z or zlocation, provides `z` and `zi` commands
Invoke-Expression (& { (zoxide init powershell | Out-String) })
# TODO https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#third-party-integrations