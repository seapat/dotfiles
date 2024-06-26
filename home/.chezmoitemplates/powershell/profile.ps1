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
# Invoke-Expression (&scoop-search --hook)

# extension of scoop commands, also better than scoop seasrch
Invoke-Expression (&sfsu hook)

# zoxide, replaces psmodules z or zlocation, provides `z` and `zi` commands
Invoke-Expression (& { (zoxide init powershell | Out-String) })
# TODO https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#third-party-integrations

### PROMPT ETC

# starship
# $ENV:STARSHIP_CONFIG = "$HOME\config\starship\config.toml"
if (Get-Command starship -errorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
  $ENV:STARSHIP_CACHE = "$HOME\AppData\Local\Temp"
}

# copy paste from wezterm docs https://wezfurlong.org/wezterm/shell-integration.html#osc-7-on-windows-with-powershell-with-starship
$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}

### MODULES
# Import-Module PSFzf -ArgumentList 'Ctrl+t', 'Ctrl+r'
# Import-Module Terminal-Icons # buggy in windows terminal, works in wezterm

# ~/.config/powershell/Microsoft.PowerShell_profile.ps1
$env:CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
carapace _carapace | Out-String | Invoke-Expression

Invoke-Expression (& { (zoxide init powershell | Out-String) })