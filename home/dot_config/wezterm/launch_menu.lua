
local wezterm = require 'wezterm';
local launch_menu = {};

-- Windoof
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  table.insert(launch_menu, {
    label = 'PowerShell 5',
    args = { 'powershell.exe', '-NoLogo' },
  })
  table.insert(launch_menu, {
    label = 'PowerShell 7',
    args = { 'pwsh.exe'},
  })
  table.insert(launch_menu, {
    label = 'Nushell',
    args = { 'nu', '-i' },
  })

-- lincool
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' or wezterm.target_triple == 'x86_64-apple-darwin' then
  table.insert(launch_menu,  {args = { 'htop' }})
  table.insert(launch_menu,  {
      -- Optional label to show in the launcher. If omitted, a label
      -- is derived from the `args`
      label = 'Bash',
      -- The argument array to spawn.  If omitted the default program
      -- will be used as described in the documentation above
      args = { 'bash', '-l' },

      -- You can specify an alternative current working directory;
      -- if you don't specify one then a default based on the OSC 7
      -- escape sequence will be used (see the Shell Integration
      -- docs), falling back to the home directory.
      -- cwd = "/some/path"

      -- You can override environment variables just for this command
      -- by setting this here.  It has the same semantics as the main
      -- set_environment_variables configuration option described above
      -- set_environment_variables = { FOO = "bar" },
  })
end

return launch_menu