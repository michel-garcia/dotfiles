local wibox = require("wibox")

return function ()
    return wibox.widget.textclock(" %a, %b %e %H:%M ")
end

