local wezterm = require 'wezterm';
local launch_menu = {
  {
    label = 'Nushell',
    args = {'nu', '-l'}
}
};

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    table.insert(launch_menu, {
        label = 'PowerShell 5',
        args = {'powershell', '-NoLogo'}
    })
    table.insert(launch_menu, {
        label = 'PowerShell 7',
        args = {'pwsh'}
    })
    table.insert(launch_menu, {
        label = 'Command Prompt',
        args = {'cmd', '/E:ON', '/F:ON'}
    })
    table.insert(launch_menu, {
        label = 'Git Bash',
        -- TODO: amigouos username
        args = {wezterm.home_dir .. '\\scoop\\shims\\bash.exe', '-l'}
    })
    
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' or wezterm.target_triple == 'x86_64-apple-darwin' then
    table.insert(launch_menu, {
        args = {'htop'}
    })
    table.insert(launch_menu, {{
        label = 'Bash',
        args = {'bash', '-l'}
    }, {
        label = 'Fish',
        args = {'fish', '-l'}
    }, {
        label = 'Zsh',
        args = {'zsh', '-l'}
    } 
    -- You can override environment variables just for this command
    -- by setting this here.  It has the same semantics as the main
    -- set_environment_variables configuration option described above
    -- set_environment_variables = { FOO = "bar" },
    })
end

return launch_menu
