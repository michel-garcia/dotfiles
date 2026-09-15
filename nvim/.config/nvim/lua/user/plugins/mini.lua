return {
    {
        "https://github.com/nvim-mini/mini.ai",
        config = function()
            local ai = require("mini.ai")
            ai.setup()
        end,
    },
    {
        "https://github.com/nvim-mini/mini.cmdline",
        config = function()
            local cmdline = require("mini.cmdline")
            cmdline.setup({
                autopeek = {
                    enable = false,
                },
            })
        end,
    },
    {
        "https://github.com/nvim-mini/mini.completion",
        config = function()
            local completion = require("mini.completion")
            completion.setup({
                delay = {
                    completion = 0,
                    info = 0,
                    signature = 0,
                },
                window = {
                    signature = {
                        border = "solid",
                    },
                },
            })
            vim.api.nvim_create_autocmd("User", {
                callback = function(args)
                    local config = vim.api.nvim_win_get_config(args.data.win_id)
                    config.title = ""
                    vim.api.nvim_win_set_config(args.data.win_id, config)
                end,
                pattern = "MiniCompletionWindowOpen",
                group = vim.api.nvim_create_augroup("MiniCompletionCustomization", {
                    clear = true,
                }),
            })
        end,
    },
    {
        "https://github.com/nvim-mini/mini.cursorword",
        config = function()
            local cursorword = require("mini.cursorword")
            cursorword.setup({
                delay = 0,
            })
        end,
    },
    {
        "https://github.com/nvim-mini/mini.icons",
        config = function()
            local icons = require("mini.icons")
            icons.setup()
            icons.tweak_lsp_kind()
        end,
    },
    {
        "https://github.com/nvim-mini/mini.jump",
        config = function()
            local jump = require("mini.jump")
            jump.setup()
        end,
    },
    {
        "https://github.com/nvim-mini/mini.splitjoin",
        config = function()
            local splitjoin = require("mini.splitjoin")
            splitjoin.setup()
        end,
    },
    {
        "https://github.com/nvim-mini/mini.statusline",
        config = function()
            local statusline = require("mini.statusline")
            statusline.setup({
                content = {
                    active = function()
                        return statusline.combine_groups({
                            function()
                                local name, hl = statusline.section_mode({
                                    trunc_width = 64,
                                })
                                return {
                                    hl = hl,
                                    strings = {
                                        string.upper(name),
                                    },
                                }
                            end,
                            "%<",
                            function()
                                local buftype = vim.api.nvim_get_option_value("buftype", {
                                    buf = 0,
                                })
                                local filename = buftype ~= "terminal" and "%f%m %r" or "%t"
                                return {
                                    hl = "MiniStatuslineFilename",
                                    strings = {
                                        filename,
                                    },
                                }
                            end,
                            "%=",
                            function()
                                local buftype = vim.api.nvim_get_option_value("buftype", {
                                    buf = 0,
                                })
                                if buftype == "terminal" then
                                    return {}
                                end
                                local filetype = vim.api.nvim_get_option_value("filetype", {
                                    buf = 0,
                                })
                                if filetype == "" then
                                    return {}
                                end
                                local _, icons = pcall(require, "mini.icons")
                                if icons then
                                    local icon = icons.get("filetype", filetype)
                                    filetype = table.concat({
                                        icon,
                                        filetype,
                                    }, "  ")
                                end
                                return {
                                    hl = "MiniStatuslineFiletype",
                                    strings = {
                                        filetype,
                                    },
                                }
                            end,
                            function()
                                local buftype = vim.api.nvim_get_option_value("buftype", {
                                    buf = 0,
                                })
                                if buftype == "terminal" then
                                    return {}
                                end
                                local location = table.concat({
                                    vim.fn.line("."),
                                    vim.fn.col("."),
                                }, ":")
                                return {
                                    hl = "MiniStatuslineLocation",
                                    strings = {
                                        location,
                                    },
                                }
                            end,
                        })
                    end,
                },
            })
        end,
    },
    {
        "https://github.com/nvim-mini/mini.surround",
        config = function()
            local surround = require("mini.surround")
            surround.setup()
        end,
    },
}
