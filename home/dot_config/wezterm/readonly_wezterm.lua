local color_scheme_switch = require 'color_scheme_switch'

return {
    window_decorations = "RESIZE",

    -- config.default_prog = { 'nushell', '-l' }

    -- enable_wayland = false,
    -- color_schemes = {
    --     ["Gnome Light"] = require("gnome"),
    --     ["Charmful Dark"] = require("charmful"),
    -- },
    -- font = require("wezterm").font("CaskaydiaCove NF"),
    cell_width = 0.9,
    default_cursor_style = "BlinkingBar",

    window_close_confirmation = "NeverPrompt",
    hide_tab_bar_if_only_one_tab = false,

    window_padding = {
        top = "0.5cell",
        right = "1cell",
        bottom = "0.5cell",
        left = "1cell",
    },

    inactive_pane_hsb = {
        saturation = 0.8,
        brightness = 0.7,
    },

    window_background_opacity = 1.0,
    text_background_opacity = 1.0,

    keys = require("keys"),
    color_scheme = require("color_scheme_switch"),
    launch_menu = require("launch_menu"),
      
}