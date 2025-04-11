return {
    "rcarriga/nvim-notify",
    config = function()
        local notify = require("notify")
        notify.setup({
            on_open = function(win)
                if vim.api.nvim_win_is_valid(win) then
                    vim.api.nvim_win_set_config(win, {
                        border = "solid",
                    })
                end
            end,
            max_width = math.min(vim.o.columns, 64),
            render = "wrapped-compact",
            stages = "static",
        })
        local levels = { "ERROR", "WARN", "INFO", "DEBUG", "TRACE" }
        local bgcolor = vim.api.nvim_get_hl(0, {
            link = true,
            name = "NormalFloat",
        }).bg
        for _, level in ipairs(levels) do
            local border = string.format("Notify%sBorder", level)
            vim.api.nvim_set_hl(0, border, {
                bg = bgcolor,
            })
            local background = string.format("Notify%sBody", level)
            vim.api.nvim_set_hl(0, background, {
                link = "NormalFloat",
            })
        end
        vim.notify = notify
    end,
}
