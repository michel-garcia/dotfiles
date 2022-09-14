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
            require("plugins.bufferline"),
            require("plugins.cmp"),
            require("plugins.colorizer"),
            require("plugins.colorscheme"),
            require("plugins.comment"),
            require("plugins.indent"),
            require("plugins.gitsigns"),
            require("plugins.lspconfig"),
            require("plugins.lualine"),
            require("plugins.nvimtree"),
            require("plugins.rest"),
            require("plugins.telescope"),
            require("plugins.toggleterm"),
            require("plugins.treesitter"),
            require("plugins.trouble"),
            require("plugins.wilder")
        })
        if packer_bootstrap then
            packer.sync()
        end
    end
})
