local color_scheme_switch = require 'color_scheme_switch'

local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_decorations = "RESIZE"
config.animation_fps = 1

-- scroll bar
config.enable_scroll_bar = true
config.min_scroll_bar_height = "1cell"

-- startup
config.default_prog = { 'nu', '-i'}
config.default_cwd = "~"

-- enable_wayland = false
-- color_schemes = {
--     ["Gnome Light"] = require("gnome")
--     ["Charmful Dark"] = require("charmful")
-- },
-- font = require("wezterm").font("CaskaydiaCove NF")
config.cell_width = 0.9
config.default_cursor_style = "BlinkingBar"

config.window_close_confirmation = "NeverPrompt"
config.hide_tab_bar_if_only_one_tab = false

config.window_padding = {
    top = "0.5cell",
    right = "1cell",
    bottom = "0.5cell",
    left = "1cell",
}

config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.7,
}

config.window_background_opacity = 1.0
config.text_background_opacity = 1.0

config.notification_handling = "SuppressFromFocusedTab" -- SuppressFromFocusedWindow 

config.keys = require("keys")
config.color_scheme = require("color_scheme_switch")
config.launch_menu = require("launch_menu")




return config