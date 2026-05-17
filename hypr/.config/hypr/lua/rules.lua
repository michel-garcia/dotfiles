hl.workspace_rule({
    gaps_in = 4,
    gaps_out = 64,
    layout = "master",
    on_created_empty = "kitty",
    workspace = "special:magic",
})

hl.window_rule({
    name = "suppress-maximize-events",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "tweak-special-workspace-windows",
    match = {
        workspace = "special:magic",
    },
    no_anim = true,
})
