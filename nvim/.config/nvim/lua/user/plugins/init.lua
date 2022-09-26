local install_path = table.concat({
    vim.fn.stdpath("data"),
    "site/pack/packer/start/packer.nvim"
}, "/")

local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    })
end

local packer = require("packer")
packer.startup({
    function (use)
        use({
            "wbthomason/packer.nvim",
            require("user.plugins.bufferline"),
            require("user.plugins.cmp"),
            require("user.plugins.colorizer"),
            require("user.plugins.colorscheme"),
            require("user.plugins.comment"),
            require("user.plugins.indent_blankline"),
            require("user.plugins.gitsigns"),
            require("user.plugins.lspconfig"),
            require("user.plugins.lualine"),
            require("user.plugins.rest"),
            require("user.plugins.telescope"),
            require("user.plugins.treesitter"),
            require("user.plugins.treesitter_context"),
            require("user.plugins.trouble"),
            require("user.plugins.wilder")
        })
        if packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        display = {
            open_fn = function ()
                local util = require("packer.util")
                return util.float({
                    border = "single"
                })
            end
        }
    }
})
