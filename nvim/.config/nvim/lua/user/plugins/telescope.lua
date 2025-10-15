return {
    {
        "nvim-telescope/telescope.nvim",
        version = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-tree/nvim-web-devicons",
        },
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
                    dir_icon = "󰉋",
                    git_status = false,
                    grouped = true,
                    hide_parent_dir = true,
                    hidden = true,
                    select_buffer = true,
                    quiet = true,
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
        config = function(_, opts)
            local actions = require("telescope.actions")
            opts.defaults.mappings = {
                ["i"] = {
                    ["<CR>"] = actions.select_default,
                    ["<Esc>"] = actions.close,
                },
            }
            local telescope = require("telescope")
            telescope.setup(opts)
            telescope.load_extension("file_browser")
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    pcall(vim.api.nvim_clear_autocmds, {
                        group = "FileExplorer",
                    })
                end,
                once = true,
            })
            vim.api.nvim_create_autocmd("BufEnter", {
                callback = function()
                    vim.schedule(function()
                        local bufname = vim.api.nvim_buf_get_name(0)
                        if vim.fn.isdirectory(bufname) == 0 then
                            return
                        end
                        if bufname == vim.g.netrw_bufname then
                            return
                        end
                        vim.g.netrw_bufname = bufname
                        vim.api.nvim_set_option_value("bufhidden", "wipe", {
                            buf = 0,
                        })
                        telescope.extensions.file_browser.file_browser({
                            cwd = vim.fn.resolve(vim.fn.expand("%:p:h")),
                        })
                    end)
                end,
                group = vim.api.nvim_create_augroup("TelescopeFileBrowser", {
                    clear = true,
                }),
            })
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>fa", builtin.builtin)
            vim.keymap.set("n", "<leader>ff", builtin.find_files)
            vim.keymap.set("n", "<leader>fe", function()
                telescope.extensions.file_browser.file_browser({
                    cwd = vim.fn.resolve(vim.fn.expand("%:p:h")),
                })
            end)
            vim.keymap.set("n", "<leader>fg", builtin.live_grep)
            vim.keymap.set("n", "<leader>fb", builtin.buffers)
            vim.keymap.set("n", "<leader>fh", builtin.help_tags)
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
}
