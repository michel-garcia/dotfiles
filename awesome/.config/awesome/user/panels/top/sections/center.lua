local wibox = require("wibox")
local taglist = require("user.widgets.taglist")

local function CenterSection(args)
    local container = wibox.container.place(taglist(args.screen))
    container.halign = "center"
    return container
end

return CenterSection

