return {
    "goolord/alpha-nvim",
    config = function ()
        local alpha = require("alpha")
        local version = vim.version()
        local button = function (label, command, shortcut)
            return {
                type = "button",
                on_press = function ()
                    local keys = vim.api.nvim_replace_termcodes(command, true, false, true)
                    vim.api.nvim_feedkeys(keys, "t", false)
                end,
                opts = {
                    align_shortcut = "right",
                    hl_shortcut = "Keyword",
                    keymap = {
                        "n", shortcut, command, { noremap = true, silent = true }
                    },
                    position = "center",
                    shortcut = shortcut,
                    width = 50
                },
                val = label
            }
        end
        alpha.setup({
            layout = {
                {
                    type = "padding",
                    val = 3
                },
                {
                    type = "text",
                    val = {
                        " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                        " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                        " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                        " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                        " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                        " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝"
                    },
                    opts = {
                        hl = "@function",
                        position = "center"
                    }
                },
                {
                    type = "padding",
                    val = 1
                },
                {
                    type = "text",
                    val = string.format(
                        "Version %s.%s.%s",
                        version.major,
                        version.minor,
                        version.patch
                    ),
                    opts = {
                        hl = "@character",
                        position = "center",
                    }
                },
                {
                    type = "padding",
                    val = 3
                },
                {
                    opts = {
                        spacing = 1
                    },
                    type = "group",
                    val = {
                        button("New file", ":enew<CR>", "e"),
                        button("Sync plugins", ":Lazy sync<CR>", "s"),
                        button("Find files", ":FzfLua files<CR>", "ff"),
                        button("Old files", ":FzfLua oldfiles<CR>", "fo"),
                        button("Quit", ":quit<CR>", "q")
                    }
                }
            }
        })
    end
}

