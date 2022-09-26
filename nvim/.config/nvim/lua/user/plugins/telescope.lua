return {
    "nvim-telescope/telescope.nvim",
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim"
    },
    config = function ()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                border = true,
                borderchars = {
                    prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                    results = { "─", "│", "─", "│", "├", "┤", "┘", "└" }
                },
                hidden = true,
                layout_config = {
                    height = function (_, _, max_lines)
                        return math.min(max_lines, 15)
                    end,
                    width = function (_, max_columns, _)
                        return math.min(max_columns, 80)
                    end
                },
                layout_strategy = "center",
                preview = false,
                prompt_title = false,
                results_title = false,
                sorting_strategy = "ascending"
            },
            extensions = {
                file_browser = {
                    dir_icon = "",
                    hidden = true,
                    hijack_netrw = true
                }
            }
        })
        telescope.load_extension("file_browser")
        local opts = {
            noremap = true,
            silent = true
        }
        vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
        vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", opts)
        vim.keymap.set("n", "<leader>fc", ":Telescope current_buffer_fuzzy_find<CR>", opts)
        vim.keymap.set("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", opts)
    end
}

