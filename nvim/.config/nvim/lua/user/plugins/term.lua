return {
    "waiting-for-dev/ergoterm.nvim",
    config = function()
        local ergoterm = require("ergoterm")
        ergoterm.setup()
        local pick = function()
            ergoterm.select({
                callbacks = {
                    default = {
                        desc = "Focus",
                        fn = function(selected)
                            local terms = ergoterm.filter_by_tag("bottom")
                            for _, term in ipairs(terms) do
                                if term ~= selected then
                                    term:close()
                                else
                                    term:focus()
                                end
                            end
                        end,
                    },
                    ["<C-w>"] = {
                        desc = "Kill",
                        fn = function(selected)
                            selected:cleanup()
                        end,
                    },
                },
                prompt = "> ",
            })
        end
        local spawn = function()
            local terms = ergoterm.filter_by_tag("bottom")
            for _, term in ipairs(terms) do
                term:close()
            end
            local count = vim.tbl_count(terms)
            local term = ergoterm:new({
                border = "single",
                name = string.format("Term %s", count + 1),
                on_stop = function()
                    vim.schedule(function()
                        terms = ergoterm.filter_by_tag("bottom")
                        for i, term in ipairs(terms) do
                            term:update({
                                name = string.format("Term %s", i),
                            })
                        end
                    end)
                end,
                size = {
                    below = 12,
                },
                tags = { "bottom" },
            })
            term:focus()
        end
        vim.keymap.set("n", "<leader>tt", function()
            pick()
        end)
        vim.keymap.set({ "n", "t" }, "<C-\\>", function()
            local last = ergoterm.get_state("last_focused")
            if last then
                last:toggle()
                return
            end
            spawn()
        end)
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local opts = {
                    buffer = args.buf,
                }
                vim.keymap.set("t", "<C-t>", function()
                    spawn()
                end, opts)
                vim.keymap.set("t", "<C-x>", function()
                    local term = ergoterm:get_focused()
                    if term then
                        term:cleanup()
                    end
                end, opts)
                vim.keymap.set("t", "<C-o>", function()
                    pick()
                end, opts)
                vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<CR>", opts)
            end,
            group = vim.api.nvim_create_augroup("TermKeys", {
                clear = true,
            }),
            pattern = "ergoterm"
        })
    end,
}
