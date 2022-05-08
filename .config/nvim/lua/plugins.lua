require("packer").startup(function (use)
    use { "wbthomason/packer.nvim" }
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/nvim-lsp-installer"
        },
        config = function ()
            require("config/lsp")
        end
    }
    use {
        "hrsh7th/nvim-cmp",
        config = function ()
            require("config/cmp")
        end,
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "onsails/lspkind-nvim",
            "mortepau/codicons.nvim"
        }
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function ()
            require("config/treesitter")
        end,
        run = ":TSUpdate"
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            require("config/indent_blankline")
        end
    }
    use {
        "numToStr/Comment.nvim",
        config = function ()
            require("config/comment")
        end
    }
    use {
        "lewis6991/gitsigns.nvim",
        config = function ()
            require("config/gitsigns")
        end
    }
    use {
        "akinsho/nvim-toggleterm.lua",
        config = function ()
            require("config/toggleterm")
        end
    }
    use {
        "akinsho/bufferline.nvim",
        config = function ()
            require("config/bufferline")
        end
    }
    use {
        "nvim-lualine/lualine.nvim",
        config = function ()
            require("config/lualine")
        end
    }
    use {
        "gelguy/wilder.nvim",
        config = function ()
            require("config/wilder")
        end
    }
    use {
        "folke/trouble.nvim",
        config = function ()
            require("config/trouble")
        end
    }
    use {
        "norcalli/nvim-colorizer.lua",
        config = function ()
            require("config/colorizer")
        end
    }
    use {
        "windwp/nvim-ts-autotag",
        config = function ()
            require("config/autotag")
        end
    }
    use {
        "navarasu/onedark.nvim",
        config = function ()
            vim.cmd("colorscheme onedark")
        end
    }
end)

