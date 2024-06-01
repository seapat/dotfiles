local wezterm = require('wezterm')
local nf = wezterm.nerdfonts

-- NOTIFICATIONS
wezterm.on('bell', function(window, pane)
    if window:is_focused() and window:active_pane():pane_id() == pane:pane_id() then
        return
    end

    local pane_title = pane:get_title()
    local user_title = pane:get_user_vars().panetitle

    if user_title ~= nil and #user_title > 0 then
        pane_title = user_title
    end

    window:toast_notification('wezterm', 'Bell rung in ' .. pane_title)
end)

-- wezterm.on('window-config-reloaded', function(window, pane)
--     window:toast_notification('wezterm', 'configuration reloaded!', nil, 4000)
-- end)

-- TAB BAR
wezterm.on('new-tab-button-click', function(window, pane, button, default_action)
    wezterm.log_info('new-tab', window, pane, button, default_action)
    if default_action and button == 'Left' then
        window:perform_action(default_action, pane)
    end

    if default_action and button == 'Right' then
        window:perform_action(wezterm.action.ShowLauncherArgs({
            title = wezterm.nerdfonts.fa_rocket .. '  Select/Search:',
            flags = 'FUZZY|LAUNCH_MENU_ITEMS|DOMAINS|WORKSPACES|TABS'
        }), pane)
    end
    return false
end)

wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, hover, max_width)
    local GLYPH_CIRCLE = nf.fa_circle
    local GLYPH_ADMIN = ""

    local is_admin = false
    if tab.active_pane.title:match('^Administrator: ') then
        local GLYPH_ADMIN = nf.md_shield_half_full .. "  "
    end

    -- TODO improve https://www.lua.org/manual/5.4/manual.html#6.4.1
    -- TODO pane:get_title()
    -- tab.active_pane.foreground_process_name
    -- :gsub('%.exe$', ''):gsub('%.com$', ''):gsub('%.cmd$', '') -- :gsub('%.bat$', '')

    local tab_title = {
        {Text = GLYPH_ADMIN .. " "}
    }

    local has_unseen_output = false
    for idx, pane in ipairs(tab.panes) do

        local sep = "|"
        if idx == #tab.panes then
            sep = " "
        end

        local title = string.format('%s', pane.title:gsub('(.*[/\\])(.*)', '%2'):gsub('%.%a%a%a', ''))

        if pane.is_zoomed then
            table.insert(tab_title, {
                Text = "[z] "
            })
        end

        if pane.has_unseen_output then
            has_unseen_output = true
            -- TODO: Fixme, this seems to be the causing problems on `tree` (the other pane's title is reverting to nu.exe)
            -- table.insert(tab_title, {
            --     {Attribute={Underline="Dotted"}},
            --     "ResetAttributes"
            -- }) 
        end
        table.insert(tab_title, {
            Text = title
        })
        table.insert(tab_title, {
            Text = sep
        })
    end
    if has_unseen_output then
        table.insert(tab_title,  {
            Text = string.format('%s ', GLYPH_CIRCLE)
        })
    end

    return tab_title
end)

wezterm.on('update-status', function(window, pane)
    local user_vars = pane:get_user_vars()

    local compose = window:composition_status()
    if compose then
        compose = 'COMPOSING: ' .. compose
    end
    window:set_left_status(wezterm.format {
        { Text = compose or '' },
    })

    -- Figure out the cwd and host of the current pane.
    -- This will pick up the hostname for the remote host if your
    -- shell is using OSC 7 on the remote host.
    local cwd = ''
    local hostname = ''
    local cwd_uri = pane:get_current_working_dir()
    if cwd_uri then

        if type(cwd_uri) == 'userdata' then
            -- Running on a newer version of wezterm and we have
            -- a URL object here, making this simple!

            cwd = cwd_uri.file_path
            hostname = cwd_uri.host or wezterm.hostname()
        else
            -- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
            -- which doesn't have the Url object
            cwd_uri = cwd_uri:sub(8)
            local slash = cwd_uri:find '/'
            if slash then
                hostname = cwd_uri:sub(1, slash - 1)
                -- and extract the cwd from the uri, decoding %-encoding
                cwd = cwd_uri:sub(slash):gsub('%%(%x%x)', function(hex)
                    return string.char(tonumber(hex, 16))
                end)
            end
        end

        -- Remove the domain name portion of the hostname
        local dot = hostname:find '[.]'
        if dot then
            hostname = hostname:sub(1, dot - 1)
        end
        if hostname == '' then
            hostname = wezterm.hostname()
        end

    end

    local title = pane:get_title()
    local date = wezterm.strftime('%H:%M %d-%m-%Y') .. ' '

    -- figure out a way to center it
    window:set_right_status(wezterm.format {{
        Text = title .. '@'
    }, {
        Text = hostname .. ' '
    }, {
        Text = cwd .. ' '
    } -- ,{
    --     Text = date .. ' '
    -- }
    })
end)

return {}
