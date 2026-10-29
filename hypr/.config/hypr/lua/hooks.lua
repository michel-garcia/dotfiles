hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpm reload")
    hl.exec_cmd("ignis init")
    hl.exec_cmd("waypaper --restore")
end)

hl.on("workspace.created", function(workspace)
    if workspace.name == "special:magic" and workspace.windows == 0 then
        hl.exec_cmd("kitty")
    end
end)
