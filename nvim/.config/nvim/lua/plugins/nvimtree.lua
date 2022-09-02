return {
    "kyazdani42/nvim-tree.lua",
    requires = {
        "kyazdani42/nvim-web-devicons"
    },
    config = function ()
        local tree = require("nvim-tree")
        tree.setup({
            git = {
                enable = true,
                ignore = false
            },
            hijack_cursor = true,
            hijack_directories = {
                enable = true
            },
            renderer = {
                highlight_git = true,
                icons = {
                    show = {
                        file = false,
                        git = false
                    }
                }
            },
            update_focused_file = {
                enable = true
            }
        })
    end
}

