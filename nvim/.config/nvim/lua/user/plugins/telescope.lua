return {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            enabled = vim.fn.executable("make") == 1
        },
        {
            "nvim-telescope/telescope-file-browser.nvim",
            dependencies = {
                "nvim-tree/nvim-web-devicons"
            },
            config = function ()
                local telescope = require("telescope")
                vim.keymap.set("n", "<leader>fe", function ()
                    telescope.extensions.file_browser.file_browser({
                        cwd = vim.fn.resolve(vim.fn.expand("%:p:h"))
                    })
                end, {
                    noremap = true,
                    silent = true
                })
                local group = vim.api.nvim_create_augroup("TelescopeFileBrowser", {
                    clear = true
                })
                vim.api.nvim_create_autocmd("VimEnter", {
                    callback = function (args)
                        if vim.fn.isdirectory(args.file) ~= 0 then
                            local name = vim.api.nvim_buf_get_name(0)
                            if name == args.file then
                                vim.api.nvim_buf_delete(0, {
                                    force = true
                                })
                            end
                            telescope.extensions.file_browser.file_browser({
                                cwd = vim.fn.resolve(args.file)
                            })
                        end
                    end,
                    group = group
                })
            end
        }
    },
    opts = {
        defaults = {
            borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
            color_devicons = false,
            layout_config = {
                height = function (_, _, lines)
                    return math.max(math.ceil(lines * .4), 15)
                end,
                width = function (_, columns)
                    return math.max(math.ceil(columns * .5), 70)
                end
            },
            layout_strategy = "center",
            preview = false,
            results_title = false,
            sorting_strategy = "ascending"
        },
        extensions = {
            file_browser = {
                create_from_prompt = false,
                display_stat = false,
                git_status = false,
                grouped = true,
                hide_parent_dir = true,
                hidden = true
            }
        },
        pickers = {
            find_files = {
                hidden = true
            }
        }
    },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("fzf")
        telescope.load_extension("file_browser")
        local builtin = require("telescope.builtin")
        local k_opts = {
            noremap = true,
            silent = true
        }
        vim.keymap.set("n", "<leader>ff", builtin.find_files, k_opts)
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, k_opts)
        vim.keymap.set("n", "<leader>fb", builtin.buffers, k_opts)
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, k_opts)
        vim.api.nvim_set_hl(0, "TelescopeNormal", {
            link = "NormalFloat"
        })
        vim.api.nvim_set_hl(0, "TelescopeBorder", {
            link = "FloatBorder"
        })
        vim.api.nvim_set_hl(0, "TelescopePromptTitle", {
            link = "lualine_a_insert"
        })
    end
}
