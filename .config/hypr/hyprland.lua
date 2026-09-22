-- Monitors
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

hl.config({
    xwayland = {
        force_zero_scaling = true, -- unscale XWayland apps
    }
})

-- AutoStart
local autostart_always = function()
    -- Execute apps on each reload
    hl.exec_cmd("~/.bin/import-gsettings.sh gtk-theme:gtk-theme-name icon-theme:gtk-icon-theme-name cursor-theme:gtk-cursor-theme-name")
end

local autostart_once = function()
    -- Execute apps at launch
    hl.exec_cmd("kanshi")
    hl.exec_cmd("waybar --config ~/.config/waybar/config")
    hl.exec_cmd("waytrogen --restore")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("dropbox")
    hl.exec_cmd("udiskie --smart-tray")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("mako")
    hl.exec_cmd("avizo-service")
    hl.exec_cmd("xremap ~/.config/xremap/config.yml")
    hl.exec_cmd("bitwarden-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime")
    hl.exec_cmd("tailscale systray")
    hl.exec_cmd("hypridle")
end

hl.on("hyprland.start", function()
    autostart_always()
    autostart_once()
end)

hl.on("config.reloaded", function()
    autostart_always()
end)

-- Environment Variables
hl.env("XCURSOR_SIZE", "24")

-- Input
hl.config({
    input = {
        kb_layout = "jp",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,

        touchpad = {
            natural_scroll = true,
        },

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
    }
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.device({ -- per-device config
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- Look and Feel
hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 12,
        border_size = 2,

        col = {
            active_border = "rgba(2eb398ee)",
            inactive_border = "rgba(00000000)",
        },

        layout = "dwindle",
        resize_on_border = true,
    },

    decoration = {
        border_part_of_window = false,

        blur = {
            enabled = true,
            size = 2,
            passes = 5,
            new_optimizations = true,
        },

        shadow = {
            enabled = yes,
            color = "rgba(1a1a1a44)",
            range = 12,
            render_power = 3,
        }
    },

    animations = {
        enabled = true,
    }
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23,1},    {0.32,1}   } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65,0.05}, {0.36,1}   } })
hl.curve("linear",         { type = "bezier", points = { {0,0},       {1,1}      } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5,0.5},   {0.75,1.0} } })
hl.curve("quick",          { type = "bezier", points = { {0.15,0},    {0.1,1}    } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

hl.layer_rule({ match = { namespace = "waybar"        }, blur = true, xray = true })
hl.layer_rule({ match = { namespace = "wofi"          }, blur = true, ignore_alpha = 0, no_anim = true })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true, ignore_alpha = 0, xray = true })
hl.layer_rule({ match = { namespace = "avizo"         }, blur = true, ignore_alpha = 0 })

hl.config({
    dwindle = {
        preserve_split = true,
    }
})

hl.config({
    master = {
        new_status = "master",
    }
})

hl.config({
    misc = {
        background_color = 0x2d5580,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    }
})

-- Window rules
hl.window_rule({ match = { class = "Bitwarden" }, float = true })


-- Key Bindings
local mainMod = "SUPER"

-- Launch apps
hl.bind(mainMod .. " + SPACE",                  hl.dsp.exec_cmd("wofi --show drun"))
hl.bind(mainMod .. " + RETURN",                 hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + CTRL + ALT + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- Basic operation
hl.bind(mainMod .. " + Q",             hl.dsp.window.close())
hl.bind(mainMod .. " + F",             hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P",             hl.dsp.window.pseudo())
hl.bind(mainMod .. " + E",             hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + E",     hl.dsp.exit())

-- Move focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- left click

-- Resize windows
hl.bind(mainMod .. " + ALT + H",   hl.dsp.window.resize({ x = -32, y = 0   }))
hl.bind(mainMod .. " + ALT + J",   hl.dsp.window.resize({ x = 0,   y = -32 }))
hl.bind(mainMod .. " + ALT + K",   hl.dsp.window.resize({ x = 0,   y = -32 }))
hl.bind(mainMod .. " + ALT + L",   hl.dsp.window.resize({ x = 32,  y = 0   }))
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- right click

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,                   hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Switch to next/prev workspace
hl.bind(mainMod .. "+ CONTROL + L", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. "+ CONTROL + H", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .." + mouse_down",  hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .." + mouse_up",    hl.dsp.focus({ workspace = "e-1" }))

-- Move windows to  next/prev workspace
hl.bind(mainMod .. "+ CONTROL + SHIFT + L", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. "+ CONTROL + SHIFT + H", hl.dsp.window.move({ workspace = "e-1" }))

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("volumectl -d -u up"),          { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("volumectl -d -u down"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("volumectl -d toggle-mute"),    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("volumectl -d -m toggle-mute"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("lightctl -d up"),              { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("lightctl -d down"),            { locked = true, repeating = true })

-- Load host-specific config
hl.dsp.exec_cmd("hyprctl keyword source ~/.config/hypr/hyprland.conf.d/local/`hostname`.conf")
