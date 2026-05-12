hl.curve("easeOutQuint", {
    type = "bezier",
    points = {
        { 0.23, 1 },
        { 0.32, 1 },
    },
})

hl.curve("easeInOutCubic", {
    type = "bezier",
    points = {
        { 0.65, 0.05 },
        { 0.36, 1 },
    },
})

hl.curve("linear", {
    type = "bezier",
    points = {
        { 0, 0 },
        { 1, 1 },
    },
})

hl.curve("almostLinear", {
    type = "bezier",
    points = {
        { 0.5, 0.5 },
        { 0.75, 1 },
    },
})

hl.curve("quick", {
    type = "bezier",
    points = {
        { 0.15, 0 },
        { 0.1, 1 },
    },
})

hl.curve("easy", {
    type = "spring",
    mass = 1,
    stiffness = 71.2633,
    dampening = 15.8273644,
})

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 1,
    bezier = "default",
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 1,
    spring = "easy",
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 1,
    spring = "easy",
    style = "popin 90%",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1,
    bezier = "linear",
    style = "popin 90%",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 2,
    bezier = "quick",
    style = "slidevert",
})
