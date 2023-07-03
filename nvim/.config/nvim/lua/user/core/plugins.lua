local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        path
    })
end
vim.opt.runtimepath:prepend(path)
local lazy = require("lazy")
lazy.setup("user.plugins", {
    dev = {
        fallback = true,
        path = "~/Projects/plugins"
    },
    install = {
        colorscheme = {
            "gruvbox-baby"
        }
    },
    ui = {
        border = vim.g.borders.frame
    }
})

