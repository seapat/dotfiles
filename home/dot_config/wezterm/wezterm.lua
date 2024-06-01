local color_scheme_switch = require 'color_scheme_switch'

local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end
config:set_strict_mode(true)

-- TODO: https://github.com/sravioli/wezterm?tab=readme-ov-file#flexible-status-bar https://github.com/sravioli/wezterm/blob/main/events/update-status.lua

-- APPEARANCE
-- Tab bar
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.hide_tab_bar_if_only_one_tab = false
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_max_width = 25
config.show_tab_index_in_tab_bar = false

local nf = wezterm.nerdfonts
-- local window_min = string.format(' %s  ', nf.md_window_minimize)  
-- local window_max = string.format(' %s  ', nf.md_window_maximize) 
-- local window_close = string.format(' %s  ', nf.md_window_close) 
-- md_window_restore
local window_min = string.format(' %s  ', nf.cod_chrome_minimize)
local window_max = string.format(' %s  ', nf.cod_chrome_maximize)
local window_close = string.format(' %s  ', nf.cod_chrome_close)
-- cod_chrome_restore
config.tab_bar_style = {
    window_hide = window_min,
    window_hide_hover = window_min,
    window_maximize = window_max,
    window_maximize_hover = window_max,
    window_close = window_close,
    window_close_hover = window_close
}

-- scroll bar
config.enable_scroll_bar = true
config.min_scroll_bar_height = "1cell"

-- general
config.window_padding = {
    top = "0.5cell",
    right = "1cell",
    bottom = "0.5cell",
    left = "1cell"
}
config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.7
}
config.window_background_opacity = 1.0
config.text_background_opacity = 1.0
config.cell_width = 0.9
config.default_cursor_style = "BlinkingBar"

-- BEHAVIOUR
config.audible_bell = "Disabled"
config.check_for_updates = false

-- enable_wayland = false
-- closing stuff
config.exit_behavior = 'Hold'
config.exit_behavior_messaging = "Brief"
config.window_close_confirmation = "NeverPrompt" -- we multiplex by default
config.notification_handling = "SuppressFromFocusedTab" -- SuppressFromFocusedWindow 
-- startup
config.default_prog = {'nu', '-l'}
config.default_cwd = wezterm.home_dir

-- PERFORMANCE
config.animation_fps = 10
config.scrollback_lines = 5000

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"


-- WINDOWS
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.set_environment_variables = {
        prompt = '$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m '
    }
end


-- IMPORTS
require("keys").setup(config)

config = require("color_scheme_switch").dynamic_theme(config)
config.launch_menu = require("launch_menu")
-- require("set_environment_variables").env_vars(config)
require("callbacks")

return config
