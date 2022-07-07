return {
    "nvim-telescope/telescope.nvim",
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim"
    },
    config = function ()
        local telescope = require("telescope")
        telescope.setup()
        telescope.load_extension("file_browser")
    end
}
