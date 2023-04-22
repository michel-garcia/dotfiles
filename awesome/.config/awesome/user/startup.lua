local awful = require("awful")

local config = require("user.config")

for _, app in ipairs(config.startup) do
    awful.spawn(app, false)
end
