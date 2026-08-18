package.path = package.path .. ";./?.lua;./?/init.lua"

local smw = require("plugins.split-monitor-workspaces")
smw.setup()
