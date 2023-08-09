return {
    "michel-garcia/rsync.nvim",
    dev = true,
    config = function ()
        local rsync = require("rsync")
        rsync.setup({
            sync_up_on_write = true
        })
    end
}
