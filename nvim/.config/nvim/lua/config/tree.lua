return {
    "kyazdani42/nvim-tree.lua",
    requires = {
        "kyazdani42/nvim-web-devicons"
    },
    config = function ()
        local tree = require("nvim-tree")
        tree.setup({
            actions = {
                open_file = {
                    window_picker = {
                        enable = false
                    }
                }
            },
            hijack_directories = {
                enable = true
            }
        })
    end
}

