return {
    "rcarriga/nvim-notify",
    requires = {
        "nvim-telescope/telescope.nvim"
    },
    config = function ()
        local notify = require("notify")
        vim.notify = notify
        vim.api.nvim_create_autocmd("BufWritePost", {
            callback = function ()
                local filename = vim.fn.expand("%:t")
                vim.notify("File saved successfully!", "info", {
                    title = filename
                })
            end
        })
        local telescope = require("telescope")
        telescope.load_extension("notify")
    end
}
