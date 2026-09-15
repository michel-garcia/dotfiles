return {
    "https://github.com/michel-garcia/notify.nvim",
    config = function()
        local notify = require("notify")
        notify.setup()
    end,
}
