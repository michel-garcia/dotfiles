-- General --
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.encoding = "utf-8"
vim.opt.swapfile = false

-- Rendering --
vim.opt.mouse:append("a")
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 5
vim.opt.termguicolors = true

-- Appearance --
vim.opt.colorcolumn = { 80 }
vim.opt.cursorline = false
vim.opt.guicursor = "i:block"
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true
vim.opt.showmode = false

-- Indentation --
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = { space = "⋅", tab = "⋅⋅" }
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Panes --
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Commands --
vim.opt.inccommand = "nosplit"
vim.opt.pumheight = 10
vim.opt.showcmd = false

-- Search --
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Explorer --
vim.g.netrw_banner = 0

-- Keys --
vim.api.nvim_set_keymap("n", "<C-\\>", ":ToggleTerm<CR>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-\\>", "<C-\\><C-n>:ToggleTerm<CR>", { noremap = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true })

-- Plugins --
require("packer").startup(function (use)
    use { "wbthomason/packer.nvim" }
    use {
        "neovim/nvim-lspconfig",
        config = function ()
            vim.diagnostic.config({
                severity_sort = true,
                signs = true,
                underline = true,
                update_in_insert = true,
                virtual_text = false
            })
            local signs = {
                DiagnosticSignError = "",
                DiagnosticSignWarn = "",
                DiagnosticSignHint = "",
                DiagnosticSignInfo = ""
            }
            for name, icon in pairs(signs) do
                vim.fn.sign_define(name, {
                    numhl = "",
                    text = icon,
                    texthl = name
                })
            end
        end
    }
    use {
        "williamboman/nvim-lsp-installer",
        config = function ()
            require("nvim-lsp-installer").on_server_ready(function (server)
                local configs = {
                    ["sumneko_lua"] = {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    },
                    ["intelephense"] = {
                        root_dir = function (_)
                            return vim.loop.cwd()
                        end
                    }
                }
                local opts = configs[server.name] or {}
                server:setup(opts)
            end)
        end
    }
    use {
        "hrsh7th/nvim-cmp",
        config = function ()
            require("cmp").setup({
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "symbol"
                    })
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "nvim_lsp_signature_help" }
                }
            })
        end,
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "onsails/lspkind-nvim",
            "mortepau/codicons.nvim"
        }
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function ()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                highlight = { enable = true },
                indent = { enable = true }
            })
        end,
        run = ":TSUpdate"
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            require("indent_blankline").setup({
                space_char_blankline = " ",
                show_current_context =  true,
                shwo_current_context_start = true
            })
        end
    }
    use {
        "numToStr/Comment.nvim",
        config = function ()
            require("Comment").setup({})
        end
    }
    use {
        "navarasu/onedark.nvim",
        config = function ()
            vim.cmd("colorscheme onedark")
        end
    }
    use {
        "akinsho/nvim-toggleterm.lua",

        config = function ()
            require("toggleterm").setup()
        end
    }
    use {
        "nvim-lualine/lualine.nvim",
        config = function ()
            require("lualine").setup({
                --[[ options = {
                    component_separators = "",
                    section_separators = ""
                } ]]
            })
        end
    }
    use {
        "folke/trouble.nvim",
        config = function ()
            require("trouble").setup({
                icons = false,
                mode = "document_diagnostics",
                use_diagnostic_signs = true
            })
        end
    }
    use {
        "romgrk/barbar.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons"
        }
    }
    use {
        "norcalli/nvim-colorizer.lua",
        config = function ()
            require("colorizer").setup()
        end
    }
    use {
        "nacro90/numb.nvim",
        config = function ()
            require("numb").setup()
        end
    }
end)

