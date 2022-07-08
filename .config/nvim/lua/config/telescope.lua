return {
    "nvim-telescope/telescope.nvim",
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim"
    },
    config = function ()
        local telescope = require("telescope")
        local borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
        telescope.setup({
            defaults = {
                borderchars = {
                    borderchars,
                    prompt = borderchars,
                    results = borderchars,
                    preview = borderchars,
                },
                layout_config = {
                    vertical = {
                        width = 0.5
                    }
                },
                layout_strategy = "vertical",
                preview = false
            }
        })
        telescope.load_extension("file_browser")
    end
}
