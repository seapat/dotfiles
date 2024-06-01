local wezterm = require("wezterm")
local wa = wezterm.action

local module = {}
function module.setup(config)
	
	local main_mod = "CTRL"
	local mod_combi = main_mod .. "|SHIFT"

	-- TODO: Overwrite following default hotkeys (avoid using super, does not work on windows)
	-- Tabs (Hotkey: Super-T, next/prev: Super-Shift-[ and Super-Shift-], go-to: Super-[1-9]) 
	-- By default, SHIFT-PageUp and SHIFT-PageDown will adjust the viewport scrollback position by one full screen for each press. 
	-- https://wezfurlong.org/wezterm/config/lua/keyassignment/ScrollByPage.html
	-- 		Search mode keytable
	-- return {
		-- 	key_tables = {
		-- 	  search_mode = {
		-- 		{ key = 'Enter', mods = 'NONE', action = wa.CopyMode 'PriorMatch' },
		-- 		{ key = 'Escape', mods = 'NONE', action = wa.CopyMode 'Close' },
		-- 		{ key = 'n', mods = 'CTRL', action = wa.CopyMode 'NextMatch' },
		-- 		{ key = 'p', mods = 'CTRL', action = wa.CopyMode 'PriorMatch' },
		-- 		{ key = 'r', mods = 'CTRL', action = wa.CopyMode 'CycleMatchType' },
		-- 		{ key = 'u', mods = 'CTRL', action = wa.CopyMode 'ClearPattern' },
		-- 		{
		-- 		  key = 'PageUp',
		-- 		  mods = 'NONE',
		-- 		  action = wa.CopyMode 'PriorMatchPage',
		-- 		},
		-- 		{
		-- 		  key = 'PageDown',
		-- 		  mods = 'NONE',
		-- 		  action = wa.CopyMode 'NextMatchPage',
		-- 		},
		-- 		{ key = 'UpArrow', mods = 'NONE', action = wa.CopyMode 'PriorMatch' },
		-- 		{ key = 'DownArrow', mods = 'NONE', action = wa.CopyMode 'NextMatch' },
		-- 	  },
		-- 	},
		--   }
		-- (Those assignments reference CopyMode because search mode is a facet of Copy Mode).

	config.disable_default_key_bindings = false
	config.keys = {
		{ key = 'l', mods = main_mod, action = wa.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS|DOMAINS|WORKSPACES|TABS' } },
		{ key = 't', mods = main_mod, action = wa.ShowTabNavigator },

		{ key = 'w', mods = main_mod, action = wa.CloseCurrentPane { confirm = true } },
		{ key = 'w', mods = mod_combi, action = wa.CloseCurrentTab { confirm = true } },

		{ key = 'h', mods = main_mod, action = wa.ActivatePaneDirection('Left') },
		{ key = 'l', mods = main_mod, action = wa.ActivatePaneDirection('Right') },
		{ key = 'j', mods = main_mod, action = wa.ActivatePaneDirection('Down') },
		{ key = 'k', mods = main_mod, action = wa.ActivatePaneDirection('Up') },
		{ key = 's', mods = mod_combi, action = wa.PaneSelect },
		-- { key = 's', mods = mod_combi, action = wa.PaneSelect({ mode = 'SwapWithActive' }) },

		{ key = 'e', mods = mod_combi, action = wa.CharSelect },

		{ key = 'b', mods = mod_combi, action = wa.SplitVertical({ domain = 'CurrentPaneDomain' }) },
		{ key = 'r', mods = mod_combi, action = wa.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },

		{ key = '1', mods = main_mod, action = wa.ActivateTab(0) },
		{ key = '2', mods = main_mod, action = wa.ActivateTab(1) },
		{ key = '3', mods = main_mod, action = wa.ActivateTab(2) },
		{ key = '4', mods = main_mod, action = wa.ActivateTab(3) },
		{ key = '5', mods = main_mod, action = wa.ActivateTab(4) },
		{ key = '6', mods = main_mod, action = wa.ActivateTab(5) },
		{ key = '7', mods = main_mod, action = wa.ActivateTab(6) },
		{ key = '8', mods = main_mod, action = wa.ActivateTab(7) },
		{ key = '9', mods = main_mod, action = wa.ActivateTab(8) },
		{ key = '[', mods = main_mod, action = wa.ActivateTabRelative(-1) },
		{ key = ']', mods = main_mod, action = wa.ActivateTabRelative(1) },
		{ key = ',', mods = main_mod, action = wa.MoveTabRelative(-1) },
		{ key = '.', mods = main_mod, action = wa.MoveTabRelative(1) },
	}
	config.mouse_bindings = {{
		event = {
			Down = {
				streak = 1,
				button = "Right"
			}
		},
		mods = "NONE",
		action = wezterm.action {
			PasteFrom = "Clipboard"
		}
	}, -- Change the default click behavior so that it only selects
	-- text and doesn't open hyperlinks
	{
		event = {
			Up = {
				streak = 1,
				button = "Left"
			}
		},
		mods = "NONE",
		action = wezterm.action {
			CompleteSelection = "PrimarySelection"
		}
	}, -- and make CTRL-Click open hyperlinks
	{
		event = {
			Up = {
				streak = 1,
				button = "Left"
			}
		},
		mods = "CTRL",
		action = "OpenLinkAtMouseCursor"
	}}

end

return module