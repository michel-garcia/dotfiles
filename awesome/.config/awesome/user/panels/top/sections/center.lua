local wibox = require("wibox")
local taglist = require("user.widgets.taglist")

local M = {}

function M:new(args)
    local container = wibox.container.place(taglist(args.screen))
    container.halign = "center"
    return container
end

return setmetatable(M, {
    __call = function(_, ...)
        return M:new(...)
    end
})

