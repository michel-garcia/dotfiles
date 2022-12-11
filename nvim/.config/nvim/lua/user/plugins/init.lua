local install_path = table.concat({
    vim.fn.stdpath("data"),
    "site/pack/packer/start/packer.nvim"
}, "/")

local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    })
end

local packer = require("packer")
packer.startup({
    function (use)
        use({
            "wbthomason/packer.nvim",
            require("user.plugins.cmp"),
            require("user.plugins.colorizer"),
            require("user.plugins.colorscheme"),
            require("user.plugins.comment"),
            require("user.plugins.dashboard"),
            require("user.plugins.diffview"),
            require("user.plugins.indent_blankline"),
            require("user.plugins.fzf"),
            require("user.plugins.gitsigns"),
            require("user.plugins.lspconfig"),
            require("user.plugins.lualine"),
            require("user.plugins.mason"),
            require("user.plugins.notify"),
            require("user.plugins.rest"),
            require("user.plugins.todo"),
            require("user.plugins.treesitter"),
            require("user.plugins.trouble"),
            require("user.plugins.ufo"),
            require("user.plugins.wilder")
        })
        if packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        display = {
            compact = true,
            done_sym = "",
            header_sym = "",
            error_sym = "",
            open_fn = function ()
                local columns = vim.api.nvim_get_option("columns")
                local lines = vim.api.nvim_get_option("lines")
                local util = require("packer.util")
                return util.float({
                    border = "single",
                    col = math.ceil(columns * .5 - 80 / 2),
                    height = 30,
                    row = math.ceil(lines * .5 - 30 / 2),
                    width = 80
                })
            end,
            prompt_border = "single",
            removed_sym = "",
            working_sym = ""
        }
    }
})

