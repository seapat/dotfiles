local wezterm = require 'wezterm';
local set_environment_variables = {};

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    table.insert(set_environment_variables, {
        -- This changes the default prompt for cmd.exe to report the
        -- current directory using OSC 7, show the current time and
        -- the current directory colored in the prompt.
        prompt = '$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m ',
    })
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' or wezterm.target_triple == 'x86_64-apple-darwin' then
end

return set_environment_variables
