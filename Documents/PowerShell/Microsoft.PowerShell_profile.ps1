Import-Module posh-git
Import-Module PSFzf -ArgumentList 'Ctrl+t', 'Ctrl+r'
Import-Module z
Import-Module Terminal-Icons

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

$env:POSH_GIT_ENABLED=$true

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

# starship
$ENV:STARSHIP_CONFIG = "$HOME\config\starship\config.toml"
if (Get-Command starship -errorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}

# TODO: put Start-job inside block of If chneck
function winget {
    Invoke-Command -ScriptBlock { winget.exe $args } -ArgumentList $args

    # not excluding export, so that the auto export is equivalent to the one that was generated manually
    If (-Not ($args -match "install|add|uninstall|remove|rm|update|upgrade")) {Return}
    Start-Job -ScriptBlock { winget.exe export -o $env:APPDATA\winget.json --include-versions --disable-interactivity } | Out-Null
}

function scoop {
    Invoke-Command -ScriptBlock { scoop.cmd $args } -ArgumentList $args

    # not excluding export, so that the auto export is equivalent to the one that was generated manually
    If (-Not ($args -match "install|uninstall|update")) {Return}
    Start-Job -ScriptBlock { scoop.cmd export -c > $env:APPDATA\scoop.json } | Out-Null
}

function choco {
    Invoke-Command -ScriptBlock { choco.exe $args } -ArgumentList $args

    # not excluding export, so that the auto export is equivalent to the one that was generated manually
    If (-Not ($args -match "install|uninstall|upgrade")) {Return}
    Start-Job -ScriptBlock { choco.exe export -o $env:APPDATA\choco.xml --include-version-numbers } | Out-Null
}