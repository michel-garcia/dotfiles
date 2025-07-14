return {
    "michel-garcia/rsync.nvim",
    dev = true,
    opts = {
        on_update = function(event)
            local frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
            local message = event.job:status()
            vim.notify(message, event.level, {
                id = "rsync",
                opts = function(notification)
                    if not event.job.completed then
                        local delta = vim.uv.hrtime() / (1e6 * 80)
                        local index = math.floor(delta % #frames + 1)
                        local icon = frames[index]
                        notification.icon = icon
                    end
                end,
                title = "Rsync",
            })
        end,
        sync_up_on_write = true,
    },
}
