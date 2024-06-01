# Nushell Environment Config File
#
# version = "0.93.0"

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'lib') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# VARS
# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
# use std "path add"
# $env.PATH = ($env.PATH | split row (char esep))
# path add /some/path
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')
$env.GITHUB_ACCESS_TOKEN = (gh auth token)


# TODO: replace Paths with something that is not hardcoded (perhaps setup xdg dirs on windows)
let cache_path = $"/Users/($env.USERNAME)/.cache/nushell"
mkdir ($cache_path)

print "finished loading libs"

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
carapace _carapace nushell | save --force $"($cache_path)/carapace.nu"

if ((which starship | length) > 0) {
    mkdir ~/.cache/starship
    starship init nu | save -f $"($cache_path)/starship.nu"
} else {
    source ($nu.default-config-dir | path join 'prompt.nu')
}

zoxide init nushell | save -f $"($cache_path)/zoxide.nu"
sfsu hook --shell nu | save -f $"($cache_path)/sfsu.nu"