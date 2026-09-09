-------------------
--- kitu's rice ---
-------------------

-- variaveis

local mainMod  = "SUPER"
local launcher = "rofi -show drun"
local terminal = "kitty"
local files    = "thunar"

-- autostart

hl.on("hyprland.start", function() hl.exec_cmd("hyprpaper") end)

-- monitores

hl.monitor({ output = "HDMI-A-1", mode = "1600x900@75", position = "auto" })
hl.monitor({ output = "eDP-1", disabled = true })

-- config geral

hl.config({ input = { kb_layout  = "us", kb_variant = "intl" }})
hl.config({ general = { layout = "dwindle" } })
    
-- variaveis do ambiente (???)

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")

-- binds + comportamentos do compositor

hl.bind("SUPER + left",  hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up",    hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down",  hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + V",     hl.dsp.window.float({ action = "toggle"}))
hl.bind("SUPER + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + C",  hl.dsp.window.close({ direction = "toggle" }))
hl.bind("SUPER + E",     hl.dsp.exec_cmd(files))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(launcher))
hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -z"))
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("hyprshot -m output -z"))
hl.bind("SUPER + H", hl.dsp.exec_cmd("hyprpicker --autocopy"))


-- animações

animations = { enabled = true },

hl.curve("bounce", { type = "spring", mass = 1, stiffness = 16, dampening = 8 })
hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })

hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windows", enabled = true, speed = 1, spring = "bounce", style = "popin2" })

hl.layer_rule({
	name = "rofi", 
	match = { namespace = "rofi" },
	blur = true,
	animation = easeOutQuint, 0.5, popin,
})
hl.layer_rule({
	name = "mako",
	match = { namespace = "notifications" },
}) 
-- decorações deliciosas 


hl.config({
    decoration = {
    	rounding = 0,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
        },
        blur = {
            enabled = true,
            passes = 3,
            new_optimizations = true,
            size = 8,
            noise = 0.1,
       },

    },
})

hl.config({
    group = {
        groupbar = {
            enabled = true,
            gaps_in = 2,
            gaps_out = 2,
        },

    },

    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 1,

        col = {
            active_border   = { colors = {"rgba(9d7cd8ff)", "rgba(bb9af7ff)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
	    }, },
})
