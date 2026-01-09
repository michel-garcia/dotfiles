return {
    "folke/snacks.nvim",
    opts = {
        bigfile = {
            line_length = 1000,
        },
        notifier = {
            margin = {
                bottom = 1,
            },
            style = function(buf, notification, context)
                context.opts.border = "solid"
                context.opts.wo.winhighlight = table.concat({
                    "Normal:NormalFloat",
                    "NormalNC:NormalFloat",
                    "FloatBorder:NormalFloat",
                }, ",")
                local message = vim.split(notification.msg, "\n")
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, message)
                vim.api.nvim_buf_set_extmark(buf, context.ns, 0, 0, {
                    virt_text = {
                        {
                            notification.icon,
                            context.hl.icon,
                        },
                    },
                    virt_text_pos = "right_align",
                })
            end,
            top_down = false,
        },
    },
}
