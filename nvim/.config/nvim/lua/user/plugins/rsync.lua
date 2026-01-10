return {
    "michel-garcia/rsync.nvim",
    config = function()
        local rsync = require("rsync")
        rsync.setup({
            on_update = function(event)
                local frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
                local message = event.job:status()
                local icon = nil
                if not event.job.completed then
                    local delta = vim.uv.hrtime() / (1e6 * 80)
                    local index = math.floor(delta % #frames + 1)
                    icon = frames[index]
                end
                vim.notify(message, event.level, {
                    id = "rsync",
                    icon = icon,
                    title = "Rsync",
                })
            end,
            sync_up_on_write = true,
        })
    end,
}
