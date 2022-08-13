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
                        git = false
                    }
                }
            },
            view = {
                hide_root_folder = true
            }
        })
    end
}

