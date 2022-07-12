local install_path = string.format(
    "%s/site/pack/packer/start/packer.nvim",
    vim.fn.stdpath("data")
)

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
        use("wbthomason/packer.nvim")
        use(require("config.alpha"))
        use(require("config.bufferline"))
        use(require("config.cmp"))
        use(require("config.colorizer"))
        use(require("config.comment"))
        use(require("config.indent-blankline"))
        use(require("config.gitsigns"))
        use(require("config.lspconfig"))
        use(require("config.lualine"))
        use(require("config.notify"))
        use(require("config.telescope"))
        use(require("config.theme"))
        use(require("config.toggleterm"))
        use(require("config.treesitter"))
        use(require("config.trouble"))
        use(require("config.wilder"))
        if packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        display = {
            open_fn = function ()
                return require("packer.util").float({
                    border = "single"
                })
            end
        }
    }
})

