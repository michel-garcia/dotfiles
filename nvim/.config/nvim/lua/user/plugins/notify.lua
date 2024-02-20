return {
    "rcarriga/nvim-notify",
    config = function ()
        local notify = require("notify")
        notify.setup({
            on_open = function (win)
                if vim.api.nvim_win_is_valid(win) then
                    vim.api.nvim_win_set_config(win, {
                        border = vim.g.borders.frame
                    })
                end
            end,
            render = "minimal",
            stages = "static"
        })
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function ()
                local levels = { "ERROR", "WARN", "INFO", "DEBUG", "TRACE" }
                for _, level in ipairs(levels) do
                    local border = string.format("Notify%sBorder", level)
                    vim.api.nvim_set_hl(0, border, {
                        bg = vim.api.nvim_get_hl(0, {
                            link = true,
                            name = "NormalFloat"
                        }).bg,
                        fg = vim.api.nvim_get_hl(0, {
                            link = true,
                            name = border
                        }).fg
                    })
                    local background = string.format("Notify%sBody", level)
                    vim.api.nvim_set_hl(0, background, {
                        link = "NormalFloat"
                    })
                end
            end,
            group = vim.api.nvim_create_augroup("NotifyHighlights", {
                clear = true
            })
        })
        vim.notify = notify
    end
}

