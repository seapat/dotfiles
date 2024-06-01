local wezterm = require 'wezterm'
local module ={}
-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux

function module.dynamic_theme(config)
  local appearance = wezterm.gui and wezterm.gui.get_appearance() or "Light"
  if appearance:find("Dark") then
    config.set_environment_variables.DELTA_FEATURES = "dark-mode"
    config.color_scheme = 'Catppuccin Macchiato'
  else 
    config.set_environment_variables.DELTA_FEATURES = "light-mode"
    config.color_scheme =  'Catppuccin Latte'
  end
  wezterm.log_warn("Changed Environment Vars for Theming. Only works in new Program / new Tab.")

  return config
end

return module
