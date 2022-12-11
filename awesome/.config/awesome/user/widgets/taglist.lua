local awful = require("awful")

return function (s)
    return awful.widget.taglist({
        filter = awful.widget.taglist.filter.all,
        screen = s
    })
end

