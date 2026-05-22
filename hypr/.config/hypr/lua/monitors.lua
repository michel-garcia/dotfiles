hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

local handle = io.popen("uname -n")
if handle then
    local hostname = handle:read("*a"):gsub("%s+", "")
    handle:close()
    if hostname == "desktop-home" then
        hl.monitor({
            output = "DP-2",
            mode = "preferred",
            position = "1920x0",
            scale = 1,
        })
        hl.monitor({
            output = "HDMI-A-1",
            mode = "preferred",
            position = "0x180",
            scale = 1,
        })
    elseif hostname == "laptop-work" then
        hl.monitor({
            output = "DP-7",
            mode = "preferred",
            position = "auto",
            scale = 1,
        })
        hl.monitor({
            output = "DP-8",
            mode = "preferred",
            position = "auto",
            scale = 1,
        })
    end
end

hl.bind("switch:on:Lid Switch", function()
    hl.monitor({
        output = "eDP-1",
        disabled = true,
    })
end)
hl.bind("switch:off:Lid Switch", function()
    hl.monitor({
        output = "eDP-1",
        mode = "preferred",
        position = "auto",
        scale = 1,
    })
end)
