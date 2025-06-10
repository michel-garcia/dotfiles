return {
    {
        "nvim-telescope/telescope.nvim",
        version = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            local builtin = require("telescope.builtin")
            local kopts = {
                noremap = true,
                silent = true,
            }
            vim.keymap.set("n", "<leader>ff", builtin.find_files, kopts)
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, kopts)
            vim.keymap.set("n", "<leader>fb", builtin.buffers, kopts)
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, kopts)
            vim.api.nvim_set_hl(0, "TelescopeNormal", {
                link = "NormalFloat",
            })
            vim.api.nvim_set_hl(0, "TelescopeBorder", {
                link = "FloatBorder",
            })
            vim.api.nvim_set_hl(0, "TelescopePromptTitle", {
                link = "lualine_a_insert",
            })
        end,
        opts = {
            defaults = {
                borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
                color_devicons = false,
                layout_config = {
                    height = function(_, _, lines)
                        return math.max(math.ceil(lines * 0.4), 15)
                    end,
                    width = function(_, columns)
                        return math.max(math.ceil(columns * 0.5), 70)
                    end,
                },
                layout_strategy = "center",
                preview = false,
                results_title = false,
                sorting_strategy = "ascending",
            },
            extensions = {
                file_browser = {
                    create_from_prompt = false,
                    display_stat = false,
                    git_status = false,
                    grouped = true,
                    hide_parent_dir = true,
                    hidden = true,
                    hijack_netrw = true,
                },
            },
            pickers = {
                find_files = {
                    file_ignore_patterns = {
                        ".git",
                        "node_modules",
                        "vendor",
                    },
                    hidden = true,
                },
                live_grep = {
                    additional_args = {
                        "--hidden",
                    },
                    file_ignore_patterns = {
                        ".git",
                        "node_modules",
                        "vendor",
                    },
                },
            },
        },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            local telescope = require("telescope")
            telescope.load_extension("fzf")
        end,
        enabled = vim.fn.executable("make") == 1,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local telescope = require("telescope")
            telescope.load_extension("file_browser")
            vim.keymap.set("n", "<leader>fe", function()
                telescope.extensions.file_browser.file_browser({
                    cwd = vim.fn.resolve(vim.fn.expand("%:p:h")),
                })
            end, { noremap = true, silent = true })
        end,
    },
}
